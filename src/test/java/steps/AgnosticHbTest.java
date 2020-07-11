package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:AgnosticHB.feature", plugin = { "pretty"})
public class AgnosticHbTest extends BaseTest {
    public AgnosticHbTest() {
    }
}
