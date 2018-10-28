package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:Gdpr.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/Gdpr_$TIMESTAMP$.json"})
public class GdprTest extends BaseTest {
    public GdprTest() {
        super();
    }
}
