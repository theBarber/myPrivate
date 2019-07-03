package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;

@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:DailyPacing.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/DailyPacing_$TIMESTAMP$.json"})
public class DailyPacing {
}
