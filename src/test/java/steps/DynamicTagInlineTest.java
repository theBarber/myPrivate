package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:DynamicTagInline.feature", plugin = {"pretty", "html:target/site/cucmber-pretty", "json:target/cucumber/cucumber.json","rerun:target/failed_scenarios.txt"})
//        "infra.RotatingJSONFormatter:target/cucumber/DynamicTagInline_$TIMESTAMP$.json"})
public class DynamicTagInlineTest {
}
