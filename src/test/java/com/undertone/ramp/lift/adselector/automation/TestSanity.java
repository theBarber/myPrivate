package com.undertone.ramp.lift.adselector.automation;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.java8.En;
import cucumber.api.junit.Cucumber;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:sanity.feature", plugin = { "pretty", "json:target/cucumber/sanity" })
public class TestSanity implements En {

    public TestSanity() {
	Given("I have (\\d+) cukes in my belly", (Integer cukes) -> {
	    assertThat("too much cucumbers", cukes, is(30));
	});
    }

    @Test
    public void test() {
	fail("Not yet implemented");
    }
    

}
