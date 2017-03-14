package steps;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.concurrent.TimeUnit;
import java.util.stream.Stream;

import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;

import co.unruly.matchers.StreamMatchers;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.cli.process.CliCommandExecution;

/**
 * Created by Itay.Pinhassi on 9/28/2016.
 */
@CucumberOptions(features = "classpath:rbcache_process.feature", plugin = { "pretty",
	"infra.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)

public class CacheProcessTest extends BaseTest {

    Connection conn = null;
    ResultSet result = null;

    public CacheProcessTest() {
	super();
	// Class.forName("com.mysql.jdbc.Driver");
	com.mysql.jdbc.Driver.class.getCanonicalName();

	Given("^We have a connection to WF DB$", () -> {
	    try {
		conn = DriverManager.getConnection(config.get("workflow.db.jdbc.connection"),
			config.get("workflow.db.user"), config.get("workflow.db.password"));
	    } catch (SQLException e) {
		conn = null;
		Assert.fail(e.getMessage());
	    }
	});

	Given("^limitations for zoneId (\\d+) is (.*) in Workflow DB$", (Integer zoneId, String expectedLimitation) -> {
	    try {
		Statement stmt = conn.createStatement();
		String sqlQuery = "SELECT limitation FROM adserver.zones where zoneid =" + zoneId;
		// sut.write("1111111111111111111");
		ResultSet rs = stmt.executeQuery(sqlQuery);
		rs.next();
		sut.write(rs.getString(1));
		String currentLimitation = rs.getString(1).toString();
		String[] parts = currentLimitation.split(",");
		currentLimitation = parts[2];
		sut.write(currentLimitation);
		Assert.assertThat(currentLimitation, Matchers.containsString(expectedLimitation));
	    } catch (SQLException e) {
		e.printStackTrace();
		Assert.fail(e.getMessage());
	    }
	});

	After(scenario -> {
	    try {
		if (conn != null && !conn.isClosed()) {
		    conn.close();
		}
		if (result != null && !result.isClosed()) {
		    result.close();
		}
	    } catch (SQLException e) {
		Assert.fail(e.getMessage());
	    }
	});
	And("^limitations for zoneId (\\d+) updated to (.*) in Workflow DB$",
		(Integer zoneId, String newLimitation) -> {
		    try {
			Statement stmt = conn.createStatement();
			String limitation = "[[[41,\"=~\",\"" + newLimitation + "\"]]]";
			String query = "UPDATE adserver.zones SET limitation ='" + limitation + "' WHERE zoneid='"
				+ zoneId + "';";
			sut.write(query);
			stmt.executeUpdate(query);

		    } catch (SQLException e) {
			e.printStackTrace();
			// Assert.fail(e.getMessage());
		    }
		});
	When("^zoneCache refreshed by cmd$", () -> {
	    String cacheZonesCmd = "docker exec ut-ramp-uas adserver --cache zones";

	    sut.uasCliConnections().parallel().forEach(conn -> {
		try {
		    sut.write("Executing " + cacheZonesCmd + " on " + conn.getName() + "["
			    + Thread.currentThread().getName());
		    sut.write("********************************************************************");
		    CliCommandExecution zoneCacheExecution = new CliCommandExecution(conn, cacheZonesCmd)
			    .error("Couldn't run query").withTimeout(3, TimeUnit.MINUTES);
		    zoneCacheExecution.execute();
		} catch (IOException e) {
		    throw new UncheckedIOException(e);
		}
	    });

	});
		When("limitation for zone (.*) in zoneCache is (.*)", (String zoneId, String expectedLimitation) -> {
			String zoneInfoCmd = "docker exec ut-ramp-uas  adserver --zone " + zoneId;
			sut.write(zoneInfoCmd);

			Assert.assertThat("limitation results", sut.uasCliConnections().flatMap(conn -> {
				try {
					sut.write("Executing " + zoneInfoCmd + " on " + conn.getName());
					CliCommandExecution zoneCacheExecution = new CliCommandExecution(conn, zoneInfoCmd).withTimeout(2,
							TimeUnit.MINUTES);
					zoneCacheExecution.execute();
					return Stream.of(zoneCacheExecution.getResult().split("\n")).filter(s->s.startsWith("limitation"));
				} catch (IOException e) {
					Assert.fail(e.getMessage());
					throw new UncheckedIOException(e);
				}
			}), StreamMatchers.allMatch(Matchers.startsWith(expectedLimitation)));
		});

    }
}
