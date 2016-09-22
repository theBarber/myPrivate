package com.undertone.ramp.lift.adselector.automation;

import static org.hamcrest.CoreMatchers.*;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;
import cucumber.api.java8.En;
/**
 * Created by nive on 2016-09-22.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:S3PlanLoader.feature", plugin = { "pretty", "html:target/cucumber" })
public class S3LoaderTest implements En {

    public S3LoaderTest() {
        Given("Loading new (.+) to s3", (String s) -> {
            assertThat("not same file", s, is("aaaa") );
        });
        When("the add selector check for new plan in s3", ()-> {

        });
        Then("The ad selector new plan (\\S+) should be (\\S+\\.json)",(String fn, String efn) -> {
                assertEquals(fn,efn);
        });
    }

}
