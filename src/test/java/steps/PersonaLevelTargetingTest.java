package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:PersonaLevelTargeting.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/PersonaLevelTargeting_$TIMESTAMP$.json"})
public class PersonaLevelTargetingTest {


}
