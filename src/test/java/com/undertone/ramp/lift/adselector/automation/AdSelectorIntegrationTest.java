package com.undertone.ramp.lift.adselector.automation;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

/**
 * Created by nive on 2016-10-30.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:AdSelectorIntegration.feature", plugin = { "pretty",
        "com.undertone.automation.RotatingJSONFormatter:target/cucumber/uas-adselector-integration_$TIMESTAMP$.json" })
public class AdSelectorIntegrationTest extends BaseTest {
    public AdSelectorIntegrationTest(){
        super();
        Given("^Loading test_plan (.*) to S3 directory (.*)",(String plan, String dir)-> {

        });
        Given("using zone id (\\d+) which includes in zone cache",(String zoneId) -> {

        });
        When("^sending request with new zone id (.*) to UAS", (String zoneId) ->{

        });
        Then("get valid response from UAS",() -> {

        });
    }
}
