package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:HeaderBidding.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/HeaderBiddingOptimize_$TIMESTAMP$.json"},tags ={"@optimize"})
public class HeaderBiddingOptimize {
}
