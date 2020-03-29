package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@CucumberOptions(features = "classpath:Contextual.feature", plugin = { "pretty"})
@RunWith(Cucumber.class)
public class ContextualTest extends BaseTest {
    public ContextualTest() {
    }
}
