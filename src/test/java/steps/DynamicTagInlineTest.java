package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:DynamicTagInline.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/DynamicTagInline_$TIMESTAMP$.json"})
public class DynamicTagInlineTest {
}
