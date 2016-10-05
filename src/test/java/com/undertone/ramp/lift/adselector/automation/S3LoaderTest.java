package com.undertone.ramp.lift.adselector.automation;

import com.amazonaws.services.s3.model.PutObjectResult;
import com.undertone.automation.utils.S3Client;
import com.undertone.automation.utils.SshAgent;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.apache.commons.lang.StringEscapeUtils;
import org.junit.runner.RunWith;

import java.io.File;

import static org.junit.Assert.assertNotNull;

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
	    try {
		// because of timing issue of the ad selector 5 minute interval
		Thread.sleep(1 * 60 * 1000);
	    } catch (InterruptedException e) {
		System.out.println(e.getMessage());
	    }

	});
	Then("The ad selector new plan should be (\\S+\\.json)", (String json) -> {

//	    CliConnectionImpl cliConnection = uasCliConnections.get(0);
//	    try {
//		cliConnection.init();
//		cliConnection.connect();
//		cliConnection.handleCliCommand("command1", new CliCommand(command1));
//		cliConnection.handleCliCommand("command2", new CliCommand(command2));

		SshAgent sshAgent = new SshAgent("src\\test\\resources\\user_info.properties");
		String command1 = StringEscapeUtils.
				escapeJava("cat /var/log/ramp-lift-ad-selector/ad-selector.log.1 /var/log/ramp-lift-ad-selector/ad-selector.log > temp_logs");
		String command2 = StringEscapeUtils.escapeJava("tac temp_logs | egrep  -m1 Loaded | egrep -o  solver_plan_[_[:alnum:]]+\\.json > res_log.txt");
		sshAgent.enterSshCommand(command1,1);
		sshAgent.enterSshCommand(command2,1);
		File f = sshAgent.copyFileFromRemote("res_log.txt", 1);
		sshAgent.enterSshCommand("rm temp_logs", 1);
		sshAgent.enterSshCommand("rm res_log.txt", 1);
		sshAgent.compareContent(f, json);
		sshAgent.close();



//		File f = sshAgent.copyFileFromRemote("res_log.txt", 2);
//		sshAgent.enterSshCommand("rm temp_logs", 1);
//
//		sshAgent.enterSshCommand("rm res_log.txt", 1);
//		boolean res = sshAgent.compareContent(f, json);
//		sshAgent.close();
//		Assert.assertTrue(res);
//	    } catch (InterruptedException | IOException e) {
//		Assert.fail("test failed", e);
//	    }
	});
    }
}
