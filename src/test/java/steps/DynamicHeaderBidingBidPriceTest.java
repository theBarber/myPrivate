package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;

@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:DynamicHeaderBidingBidPrice.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/DynamicHeaderBidingBidPrice_$TIMESTAMP$.json"})
public class DynamicHeaderBidingBidPriceTest {
}
