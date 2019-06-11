package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:DynamicPricing.feature", plugin = {"pretty", "html:target/site/cucmber-pretty", "json:target/cucumber/cucumber.json","rerun:target/failed_scenarios.txt",
        "infra.RotatingJSONFormatter:target/cucumber/DynamicPricing_$TIMESTAMP$.json"})
public class DynamicPricingTest extends BaseTest {
    public DynamicPricingTest(){
        super();
    }
}
