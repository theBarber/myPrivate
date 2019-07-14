package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;

@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:DynamicTagInline.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/DynamicTagInline_$TIMESTAMP$.json"})
public class DynamicTagInlineTest {
}
