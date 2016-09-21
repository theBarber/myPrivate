package com.undertone.ramp.lift.adselector.automation;

import static org.junit.Assert.fail;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.java8.En;
import cucumber.api.junit.Cucumber;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:sanity.feature", plugin = { "pretty", "html:target/cucumber" }

)
public class TestSanity implements En {

    public TestSanity() {
	Given("I have (\\d+) cukes in my belly", (Integer cukes) -> {
	    System.out.format("Cukes: %n\n", cukes);
	});
    }

    @Test
    public void test() {
	fail("Not yet implemented");
    }

}
