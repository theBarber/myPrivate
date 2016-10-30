package com.undertone.ramp.lift.adselector.automation;

import cucumber.api.CucumberOptions;
import cucumber.api.PendingException;
import cucumber.api.java8.En;
import cucumber.api.junit.Cucumber;
import org.hamcrest.CoreMatchers;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;



import java.sql.*;

/**
 * Created by Itay.Pinhassi on 9/28/2016.
 */
@CucumberOptions(features = "classpath:rbcache_process.feature", plugin = { "pretty",
        "com.undertone.automation.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)

public class CacheProcessTest extends  BaseTest {

    Connection conn = null;
    ResultSet  result = null;
    public CacheProcessTest() {
       // Class.forName("com.mysql.jdbc.Driver");
        com.mysql.jdbc.Driver.class.getCanonicalName();

        Given("^We have a connection to WF DB$", () -> {
            try {
                conn = DriverManager.getConnection(config.get("workflow.db.jdbc.connection"),
                                                    config.get("workflow.db.user"),
                                                    config.get("workflow.db.password"));
            }
            catch (SQLException e){
                conn = null;
                Assert.fail(e.getMessage());
            }
                });

        Given("^limitations for zoneId (\\d+) is (.*) in Workflow DB$", (Integer zoneId, String expectedLimitation) -> {
            try {
                Statement stmt = conn.createStatement();
                String sqlQuery = "SELECT limitation FROM adserver.zones where zoneid =" + zoneId;
                //System.out.println("1111111111111111111");
                ResultSet rs = stmt.executeQuery(sqlQuery);
                rs.next();
                System.out.println(rs.getString(1));
                String currentLimitation = rs.getString(1).toString();
                String[] parts = currentLimitation.split(",");
                currentLimitation = parts[2];
                System.out.println(currentLimitation);
                Assert.assertThat(currentLimitation, Matchers.containsString(expectedLimitation));
            }
            catch (SQLException e) {
                e.printStackTrace();
                Assert.fail(e.getMessage());
            }
        });

        After(scenario->{
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
                if (result != null && !result.isClosed()) {
                    result.close();
                }
            }
            catch (SQLException e)
            {
                Assert.fail(e.getMessage());
            }
        });
        And("^limitations for zoneId (\\d+) updated to (.*) in Workflow DB$", (Integer zoneId, String newLimitation) -> {
            try {
                Statement stmt = conn.createStatement();
                String limitation = "[[[41,\"=~\",\"" + newLimitation + "\"]]]";
                String query = "UPDATE adserver.zones SET limitation ='" + limitation + "' WHERE zoneid='" + zoneId + "';";
                System.out.println(query);
                stmt.executeUpdate(query);

            }
            catch (SQLException e) {
                e.printStackTrace();
                //Assert.fail(e.getMessage());
            }
        });
//        When("^zoneCache refreshed by cmd$", () -> {
//            String cmd = "docker exec ut-ramp-uas  adserver --cache zones";
//            this.uasCliConnections.forEach((connectionName, conn) -> {
//                try {
//                    new CliCommandExecution(conn, cmd).execute();
//
//                } catch (IOException e) {
//                    Assert.fail(e.getMessage());
//                }
//            });
//        });
    }


}
