package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;

@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:Gdpr.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/Gdpr_$TIMESTAMP$.json"})
public class GdprTest extends BaseTest {
    public GdprTest() {
        super();
    }
}
