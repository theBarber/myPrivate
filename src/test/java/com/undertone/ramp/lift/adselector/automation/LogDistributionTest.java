package com.undertone.ramp.lift.adselector.automation;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

import java.util.HashMap;

/**
 * Created by nive on 2017-01-12.
 */

@CucumberOptions(features = "classpath:LogDistribution.feature", plugin = { "pretty",
        "com.undertone.automation.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)

public class LogDistributionTest extends BaseTest {
    private HashMap<String, Double> distributionInLog = new HashMap<>();
    private double sumOfRequestsInLog;
    public LogDistributionTest(){
        super();
        When("^I read (req) logs distribution at column (\\d+)$", (String req, Integer index) -> {
            sut.logFor(req).readLogs().actual().map(l -> l.get(index)).forEach(s -> {
                distributionInLog.computeIfAbsent(s, key -> 1.0);
                distributionInLog.computeIfPresent(s,(k, v) -> v+1);
                sumOfRequestsInLog++;
            });

            System.out.println("map: "+ distributionInLog +" count: "+ sumOfRequestsInLog);
        });
        Given("^Delete (req|test_file) logs$",(String file)->{
            sut.logFor(file).deleteLogFiles(file,true).actual();
        });

    }

}
