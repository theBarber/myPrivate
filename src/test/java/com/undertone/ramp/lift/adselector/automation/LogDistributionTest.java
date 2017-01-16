package com.undertone.ramp.lift.adselector.automation;

import com.undertone.automation.assertion.Assert;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Optional;
import java.util.stream.Collectors;

import static org.junit.Assert.fail;

/**
 * Created by nive on 2017-01-12.
 */

@CucumberOptions(features = "classpath:ABTesting.feature", plugin = { "pretty",
        "com.undertone.automation.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)

public class LogDistributionTest extends BaseTest {
    private HashMap<Integer, HashMap<String, Double>> dist = new HashMap<>();
    public LogDistributionTest(){
        super();
        Given("^I calculate the values distribution from log (req|imp|clk) and column (\\d+)$", (String logFile, Integer index) -> {
            dist.clear();
            HashMap<String, Double> table = new HashMap<String, Double>();
            sut.logFor(logFile).readLogs().actual().map(l -> l.get(index)).forEach(s -> {
                table.computeIfAbsent(s, key -> 1.0);
                table.computeIfPresent(s,(k, v) -> v+1);
            });
            dist.put(index, table);
            System.out.println("Log distribution map for column " + index + " is: " + table);
        });
        Given("^I Delete (req|imp|clk|test_file) logs$",(String file)->{
            sut.logFor(file).deleteLogFiles(file,true).actual();
        });
        Then("^value \\{(\\d+)\\} from column \\{(\\d+)\\} appears \\{(\\d+)\\} percent of the time$", (String value, Integer column, Integer percentage) -> {
            Double numOfAppearances = dist.get(column).values().stream().reduce((a,b)-> a+b).orElse(0.0);
            Double percent = (numOfAppearances == 0.0)? 0.0 : (dist.get(column).get(value)/numOfAppearances) * 100;
            Assert.assertEquals("Column value distribution not accurate for value=" + value, percentage * 1.0, percent, 10.0);
        });
        Then("^Experiment named \\{([^}]+)\\} was selected \\{(\\d+)\\} percent of the time$", (String experimentName, Integer percentage) -> {
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
    }

    private void validateExperimentDistribution(int experimentId, Integer percentage){
        Integer experimentIdColumnNumber = 47;
        Double numOfAppearances = dist.get(experimentIdColumnNumber).values().stream().reduce((a, b) -> a + b).orElse(0.0);
        Double percent = (numOfAppearances == 0.0) ?
                        0.0 :
                        (Optional.ofNullable(dist.get(experimentIdColumnNumber).get(String.valueOf(experimentId))).orElse(0.0) / numOfAppearances) * 100;
        Assert.assertEquals("Column value distribution not accurate for experiment=" + experimentId, percentage * 1.0,
                        percent, 10.0);

    }

}
