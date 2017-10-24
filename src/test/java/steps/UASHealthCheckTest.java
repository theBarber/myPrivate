package steps;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.function.BiConsumer;


import com.google.common.io.Files;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import ramp.lift.uas.automation.UASRequestModule;

@CucumberOptions(features = "classpath:UASHealthcheck.feature", plugin = { "pretty",
		"infra.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)
public class UASHealthCheckTest extends BaseTest {

	public UASHealthCheckTest() {
		super();
		// ThenResposeCodeIs();
		When("^Sending a healthcheck request of (RabbitMQ|Couchbase|Redis|Workflow) to UAS$",
				this::healthCheckRequestSkip);
		When("^Sending a healthcheck request to UAS$", this::healthCheckRequest);
		Then("^The response code is (\\d+)$", this::allResponsesHaveCode);
		Then("^All requests are sent$", this::allResponsesFinished);
		Then("^The response contains (.*)$", this::healthCheckResponseContains);
	}

	public void healthCheckResponseContains(String something) {
		sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
//			System.out.println(content); // for checks only
			Assert.assertThat(content, Matchers.containsString(something));
		});
	}

	public void healthCheckRequestSkip(String servicenameToSkip) {
		sut.getUASRquestModule().healthCheckRequestSkip(servicenameToSkip);
	}

	public void healthCheckRequest() {
		sut.getUASRquestModule().healthCheckRequest();
	}

	public void allResponsesHaveCode(Integer expectedResponseCode) {
		sut.getUASRquestModule().responses().map(f -> f.thenApply(HttpResponse::getStatusLine)
				.thenApply(StatusLine::getStatusCode).whenComplete(assertThatResponseCodeIs(expectedResponseCode)))
				.forEach(CompletableFuture::join);
	}

	public void allResponsesFinished() {
		sut.getUASRquestModule().responses().forEach(CompletableFuture::join);
	}

	public BiConsumer<Integer, Throwable> assertThatResponseCodeIs(int expected) {
		return (statuscode, failure) -> {
			if (failure != null) {
				Assert.fail("unable to get response");
				return;
			}
			Assert.assertThat(statuscode, Matchers.is(expected));
		};
	}
}
