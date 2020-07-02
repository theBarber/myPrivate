package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:VIdeoOutstreamLocation.feature", plugin = { "pretty"})
public class VIdeoOutstreamLocationTest extends BaseTest {
    public VIdeoOutstreamLocationTest() {
    }
}


