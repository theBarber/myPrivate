package com.undertone.ramp.lift.adselector.automation;

import cucumber.api.PendingException;
import cucumber.api.java8.En;
import org.junit.Assert;

import java.sql.*;

/**
 * Created by Itay.Pinhassi on 9/28/2016.
 */
public class cache_process extends  BaseTest {
    Connection conn = null;
    ResultSet  result = null;
    public cache_process() {
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

        Given("^limitations for zoneId (\\d+) is Firefox in Workflow DB$", (Integer zoneId) -> {
            try {
                Statement stmt = conn.createStatement();
                String sqlQuery = "SELECT limitation FROM adserver.zones where zoneid =" + zoneId;
                ResultSet rs = stmt.executeQuery(sqlQuery);
                System.out.print(rs);
            }
            catch (SQLException e) {
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


    }


}
