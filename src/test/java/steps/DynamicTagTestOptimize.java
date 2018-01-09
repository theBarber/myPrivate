package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:DynamicTag.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/DynamicTag_$TIMESTAMP$.json"},tags ={"@optimize"})
public class DynamicTagTestOptimize {
}
