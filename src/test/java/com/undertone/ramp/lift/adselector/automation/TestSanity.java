package com.undertone.ramp.lift.adselector.automation;

import static org.hamcrest.number.OrderingComparison.greaterThanOrEqualTo;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;

import cucumber.api.PendingException;
import org.junit.Test;
import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:sanity.feature",

	plugin = { "pretty", "json:target/cucumber/sanity" })

public class TestSanity extends BaseTest {
int cakesSome =0;
    public TestSanity() {

	super();
	Given("I have (\\d+) cakes in my belly but my capacity is (\\d+)", (Integer cakes, Integer capacity ) -> {
	    cakesSome = cakesSome + cakes;
		assertThat("too much cucumbers", capacity, greaterThanOrEqualTo(cakes));
		System.out.println("total cakes :"+ cakesSome);
	});

	Then("^I eat more (\\d+) cakes$", (Integer cakes) -> {
		cakesSome = cakesSome + cakes;
		System.out.println("total cakes :"+ cakesSome);
		});
	}


    @Test
    public void test() {
	fail("Not yet implemented");
    }

}
