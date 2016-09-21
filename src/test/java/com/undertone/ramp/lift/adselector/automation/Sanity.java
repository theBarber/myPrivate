package com.undertone.ramp.lift.adselector.automation;

import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.java8.En;
import cucumber.api.junit.Cucumber;

@RunWith(Cucumber.class)
@CucumberOptions(plugin = { "pretty", "html:target/cucumber" })
public class Sanity implements En {
    public Sanity() {
	Given("I have (\\d+) cukes in my belly", (Integer cukes) -> {
	    System.out.format("Cukes: %n\n", cukes);
	});
    }
}
