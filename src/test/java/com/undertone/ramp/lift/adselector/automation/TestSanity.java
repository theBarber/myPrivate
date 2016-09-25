package com.undertone.ramp.lift.adselector.automation;

import static org.hamcrest.number.OrderingComparison.greaterThanOrEqualTo;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;

import org.junit.Test;
import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:sanity.feature",

	plugin = { "pretty", "json:target/cucumber/sanity" })

public class TestSanity extends BaseTest {

    public TestSanity() {
	super();
	Given("I have (\\d+) cukes in my belly", (Integer cukes) -> {
	    assertThat("too much cucumbers", cukes, greaterThanOrEqualTo(30));
	});
    }

    @Test
    public void test() {
	fail("Not yet implemented");
    }

}
