package com.undertone.ramp.lift.adselector.automation;

import static org.junit.Assert.assertNotNull;

import java.io.IOException;

import org.apache.commons.lang.StringEscapeUtils;
import org.junit.runner.RunWith;

import com.amazonaws.services.s3.model.PutObjectResult;
import com.undertone.automation.assertion.Assert;
import com.undertone.automation.cli.conn.CliCommand;
import com.undertone.automation.cli.process.CliCommandExecution;
import com.undertone.automation.utils.S3Client;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

/**
 * Created by nive on 2016-09-22.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:S3PlanLoader.feature", plugin = { "pretty", "json:target/cucumber/s3" })
public class S3LoaderTest extends BaseTest {

    public S3LoaderTest() {
	super();

	Given("Loading new (\\S+\\.json) to (\\S+\\.json) s3", (String from, String to) -> {
	    PutObjectResult res = S3Client.getInstance().uploadFile(from, to);
	    assertNotNull(res);
	});
	When("the add selector check for new plan in s3", () -> {
	    // try {
	    // because of timing issue of the ad selector 5 minute interval
	    // Thread.sleep(1 * 60 * 1000);
	    // } catch (InterruptedException e) {
	    // System.out.println(e.getMessage());
	    // }

	});
	Then("The ad selector new plan should be (\\S+\\.json)", (String json) -> {

	    String command1 = StringEscapeUtils.escapeJava(
		    "cat /var/log/ramp-lift-ad-selector/ad-selector.log.1 /var/log/ramp-lift-ad-selector/ad-selector.log > temp_logs");
	    String command2 = StringEscapeUtils.escapeJava(
		    "tac temp_logs | egrep  -m1 Loaded | egrep -o  solver_plan_[_[:alnum:]]+\\.json > res_log.txt");
	    CliCommand concatLogs = new CliCommand(command1);
	    CliCommand extractLine = new CliCommand(command2);

	    uasCliConnections.forEach((host, cliConnection) -> {
		try {
		    cliConnection.init();
		    cliConnection.connect();

		    cliConnection.handleCliCommand("concat logs", concatLogs);
		    cliConnection.handleCliCommand("extract last line", extractLine);
		    CliCommandExecution cat = new CliCommandExecution(cliConnection);
		    cat.mustHaveResponse(json);
		    cat.execute("cat res_log.txt");

		} catch (InterruptedException | IOException e) {
		    Assert.fail("test failed", e);
		}
	    });
	});
    }
}
