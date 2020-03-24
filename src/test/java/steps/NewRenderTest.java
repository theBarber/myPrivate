package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@CucumberOptions(features = "classpath:NewRenderTest.feature", plugin = { "pretty"})
@RunWith(Cucumber.class)

public class NewRenderTest {
}
