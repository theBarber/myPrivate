package com.undertone.ramp.lift.adselector.automation;

import com.undertone.automation.assertion.Assert;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

import java.util.HashMap;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Created by nive on 2017-01-12.
 */

@CucumberOptions(features = "classpath:ABTesting.feature", plugin = { "pretty",
        "com.undertone.automation.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)

public class LogDistributionTest extends BaseTest {
    private HashMap<Integer, HashMap<String, Double>> dist = new HashMap<>();
    public LogDistributionTest(){
        super();
        Given("^I calculate the values distribution from log (req|imp|clk) and column (\\d+)$", (String logFile, Integer index) -> {
            HashMap<String, Double> table = new HashMap<String, Double>();
            sut.logFor(logFile).readLogs().actual().map(l -> l.get(index)).forEach(s -> {
                table.computeIfAbsent(s, key -> 1.0);
                table.computeIfPresent(s,(k, v) -> v+1);
            });
            dist.put(index, table);
            System.out.println("map: "+ table);
        });
        Given("^I Delete (req|imp|clk|test_file) logs$",(String file)->{
            sut.logFor(file).deleteLogFiles(file,true).actual();
        });
        And("^Then value \\{([^}]+)\\} from column \\{(\\d+)\\} appears \\{(\\d+)\\} percent of the time$", (String value, Integer column, Integer percentage) -> {
            Double numOfAppearances = dist.get(column).values().stream().reduce((a,b)-> a+b).orElse(0.0);
            Double percent = (numOfAppearances == 0.0)? 0.0 : (dist.get(column).get(value)/numOfAppearances) * 100;
            Assert.assertEquals("Column value distribution not accurate", percentage * 1.0, percent, 5.0);
        });
        After(scenario -> {
            dist.clear();
        });

    }

}
