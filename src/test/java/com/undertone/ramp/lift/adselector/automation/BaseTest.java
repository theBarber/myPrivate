package com.undertone.ramp.lift.adselector.automation;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.junit.Assert;
import org.junit.runner.RunWith;

import cucumber.api.java8.En;
import cucumber.api.java8.GlueBase;
import cucumber.api.junit.Cucumber;
import cucumber.runtime.junit.Assertions;

@RunWith(Cucumber.class)
public

class BaseTest implements En, GlueBase {

    protected final String environmentName;
    protected final Map<String, String> config = new HashMap<>();

    // protected final List<UAS> uas_instances;
    public BaseTest() {
	environmentName = System.getenv("ENVIRONMENT").toLowerCase();
	String environmentNameConfigPrefix = environmentName + ".";
	Before(scenario -> {
	    Properties properties = new Properties();
	    try {
		properties.load(this.getClass().getClassLoader().getResourceAsStream("environments"));
	    } catch (IOException ioException) {
		Assert.fail("load configuration of " + scenario.getName() + " failed: " + ioException.getMessage());
	    }
	    System.getenv().forEach((configurationKey, value) -> {
		if (configurationKey.startsWith(environmentNameConfigPrefix)) {
		    config.put(configurationKey.substring(environmentNameConfigPrefix.length()), value);
		}
	    });

	    // scenario.write(scenario.getName() + ": configuration loaded");
	});

    }

}
