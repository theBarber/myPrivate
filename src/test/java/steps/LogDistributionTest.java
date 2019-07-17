package steps;

import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import infra.assertion.Assert;
import org.junit.runner.RunWith;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import static org.junit.Assert.fail;

/**
 * Created by nive on 2017-01-12.
 */

//@CucumberOptions(features = {"classpath:LogDistribution.feature","classpath:StrategyServiceTest.feature"}, plugin = { "pretty",})
//        "infra.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)

public class LogDistributionTest extends BaseTest {
    HashMap<Integer, Map<String, Long>> dist = new HashMap<>();
    public LogDistributionTest(){
        super();
        Given("^I calculate the values distribution from log (req|imp|clk) and column (\\d+).*$", (String logFile, Integer index) -> {
            dist.clear();

            Map<String, Long> table = sut.logFor(logFile).readLogs()
                .actual().filter(line -> line.size() >= index)
                .collect(Collectors.groupingBy(l->l.get(index),Collectors.counting()));
            dist.put(index, table);
            System.out.println("Log distribution map for column " + index + " is: " + table);
        });
        
//        Given("^I calculate the values distribution from log (req|imp|clk) group by column (\\d+) {[^}]} where coloumn (\\d+) = (\\d+)$", (String logFile, Integer c1, Integer c2,Integer v) -> {
////            dist.clear();
//            
//            Map<String, Long> table = sut.logFor(logFile).readLogs().actual().filter(ls->ls.get(c2).equals(v)).collect(Collectors.groupingBy(l->l.get(c1),Collectors.counting()));
//
////            dist.put(index, table);
//            System.out.println("Log distribution map for column " + c1 + " is: " + table);
//        });
        
        
        Given("^I Delete (req|imp|clk|test_file|wel|evt|prf|hbl) logs$",(String file)->{
            sut.logFor(file).deleteLogFiles(file,true).actual();
        });
        Then("^value \\{(\\d+)\\} from column \\{(\\d+)\\} appears \\{(\\d+)\\} percent of the time$", (String value, Integer column, Integer percentage) -> {
            Long numOfAppearances = dist.get(column).values().stream().reduce(Long::sum).orElse(0l);
            Double percent = (numOfAppearances == 0.0)? 0.0 : (dist.get(column).get(value)/numOfAppearances) * 100;
            Assert.assertEquals("Column value distribution not accurate for value=" + value, percentage * 1.0, percent, 10.0);
        });
        Then("^Experiment named \\{(.*)\\} was selected \\{(\\d+)\\} percent of the time$", (String experimentName, Integer percentage) -> {
            try {
                Connection dbConnection = sut.getRampAdminDbConnector().actual();
                Statement stmt = dbConnection.createStatement();
                String findExperimentQuery =
                                "SELECT id FROM staging_ramp_admin.experiment where name='" + experimentName + "'";
                ResultSet rs = stmt.executeQuery(findExperimentQuery);
                rs.next();
                int experimentId = rs.getInt(1);
                validateExperimentDistribution(experimentId, percentage);
            }catch (SQLException e) {
                fail(e.getMessage());
            }
        });
        Then("^Default experiment was selected \\{(\\d+)\\} percent of the time$", (Integer percentage) -> {
            try {
                Connection dbConnection = sut.getRampAdminDbConnector().actual();
                Statement stmt = dbConnection.createStatement();
                String findExperimentQuery =
                                "SELECT id FROM staging_ramp_admin.experiment where is_default=1";
                ResultSet rs = stmt.executeQuery(findExperimentQuery);
                rs.next();
                int experimentId = rs.getInt(1);
                validateExperimentDistribution(experimentId, percentage);
            }catch (SQLException e) {
                fail(e.getMessage());
            }
        });

        Then("I get for column (\\d+) id \\{(\\d+)\\} \\{(\\d+)%\\}", (Integer distributionColumnId, String id, Integer percent) -> {
            dist.get(distributionColumnId).remove("0"); // remove starategy equals 0
            long sum = dist.get(distributionColumnId).values().stream().mapToLong(Long::longValue).sum();
            Long numOfAppearance = dist.get(distributionColumnId).get(id);
            int expectedDist = (int)(percent * 0.01 * sum);
            double deltaPercent = 0.1;

            int delta  = (int)(expectedDist * deltaPercent) + 7;
            System.out.println("delta= "+delta);
            Assert.assertEquals("for column "+distributionColumnId+" with id "+id+" the distribution should be "+expectedDist, expectedDist, numOfAppearance, delta);
        });

    }

    private void validateExperimentDistribution(int experimentId, Integer percentage){
        Integer experimentIdColumnNumber = 47;
        Long numOfAppearances = dist.get(experimentIdColumnNumber).values().stream().reduce(Long::sum).orElse(0l);
        Double percent = (numOfAppearances == 0.0) ?
                        0.0 :
                        (Optional.ofNullable(dist.get(experimentIdColumnNumber).get(String.valueOf(experimentId))).orElse(0l) * 100) / numOfAppearances;
        Assert.assertEquals("Column value distribution not accurate for experiment=" + experimentId, percentage * 1.0,
                        percent, 30.0);

    }

}
