package com.undertone.ramp.lift.adselector.automation;

import java.util.concurrent.CompletableFuture;

import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

@CucumberOptions(features = "classpath:uas_healthcheck.feature", plugin = { "pretty",
	"com.undertone.automation.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)
public class UASHealthCheckTest extends BaseTest {

    public UASHealthCheckTest() {
	super();
	When("^Sending a healthceck request of (RabbitMQ|Couchbase|Redis|Workflow) to UAS$",
		this::healthCheckRequestSkip);
	When("^Sending a healthceck request to UAS$", this::healthCheckRequest);
	Then("^The response code is (\\d+)$", this::allResponsesHaveCode);
    }

    public void healthCheckRequestSkip(String servicenameToSkip) {
	this.uas.get().healthCheckRequestSkip(servicenameToSkip);
    }

    public void healthCheckRequest() {
	this.uas.get().healthCheckRequest();
    }

    public void allResponsesHaveCode(Integer expectedResponseCode) {
	uas.get().responses().map(f -> f.thenApply(response -> response.getStatusLine().getStatusCode())
		.whenComplete((statuscode, failure) -> {
		    if (failure != null) {
			com.undertone.automation.assertion.Assert.fail("unable to get response", failure);
			return;
		    }
		    Assert.assertThat(statuscode, Matchers.is(expectedResponseCode));

		})).forEach(CompletableFuture::join);
    }

}
