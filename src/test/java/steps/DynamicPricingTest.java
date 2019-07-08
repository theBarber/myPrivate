package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:DynamicPricing.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/DynamicPricing_$TIMESTAMP$.json"})
public class DynamicPricingTest extends BaseTest {
    public DynamicPricingTest(){
        super();
    }
}
