package com.undertone.ramp.lift.adselector.automation;

import static org.junit.Assert.fail;

import org.hamcrest.BaseMatcher;
import org.hamcrest.CoreMatchers;
import org.hamcrest.Description;
import org.junit.Assert;
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
	    Assert.assertThat("too much", cukes, CoreMatchers.is(30));
	});

    }

    @Test
    public void test() {
	fail("Not yet implemented");
    }

}
