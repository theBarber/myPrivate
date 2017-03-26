package steps;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.concurrent.TimeUnit;
import java.util.stream.Stream;

import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.cli.process.CliCommandExecution;
import infra.utils.SqlWorkflowUtils;

/**
 * Created by Itay.Pinhassi on 9/28/2016.
 */
@CucumberOptions(features = "classpath:rbcache_process.feature", plugin = { "pretty",
		"infra.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)

public class CacheProcessTest extends BaseTest {

	ResultSet result = null;

	public CacheProcessTest() {
		super();
		Given("^limitations for zoneId (\\d+) is \\{([^}]+)\\} in Workflow DB$",
				(Integer zoneId, String expectedLimitation) -> {
					String currentLimitation = SqlWorkflowUtils.getLimitationForZone(zoneId);
					sut.write(currentLimitation);
					Assert.assertThat(currentLimitation, Matchers.containsString(expectedLimitation));
				});
		And("^limitations for zoneId (\\d+) updated to \\{([^}]+)\\} in Workflow DB$",
				(Integer zoneId, String newLimitation) -> {
					SqlWorkflowUtils.setLimitationForZone(zoneId, newLimitation);
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
		When("limitation for zone (.*) in zoneCache contains \\{([^}]+)\\}",
				(String zoneId, String expectedLimitation) -> {
					String zoneInfoCmd = "docker exec ut-ramp-uas  adserver --zone " + zoneId;
					sut.write(zoneInfoCmd);

					String actualLimitation = sut.uasCliConnections().flatMap(conn -> {
						try {
							sut.write("Executing " + zoneInfoCmd + " on " + conn.getName());
							CliCommandExecution zoneCacheExecution = new CliCommandExecution(conn, zoneInfoCmd)
									.withTimeout(2, TimeUnit.MINUTES);
							zoneCacheExecution.execute();

							sut.write(Stream.of(zoneCacheExecution.getResult().split("\n"))
									.filter(s -> s.startsWith("limitation")).findFirst().get());
							return Stream.of(zoneCacheExecution.getResult().split("\n"))
									.filter(s -> s.startsWith("limitation"));
						} catch (IOException e) {
							Assert.fail(e.getMessage());
							throw new UncheckedIOException(e);
						}
					}).findFirst().get();

					Assert.assertThat("limitation result", actualLimitation,
							Matchers.containsString(expectedLimitation));
				});

	}
}