package com.undertone.ramp.lift.adselector.automation;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;

import org.junit.runner.RunWith;

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
	Given("Loading new (.+\\.json) to s3", (String s) -> {
	    assertThat("not same file", s, is("aaaa"));
	});
	When("the add selector check for new plan in s3", () -> {

	});
	Then("The ad selector new plan (\\S+) should be (\\S+\\.json)", (String fn, String efn) -> {

	});
    }
}
