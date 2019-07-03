package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:Viewability.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/Viewability.feature_$TIMESTAMP$.json"})
public class ViewabilityTest extends BaseTest{
    public ViewabilityTest()
    {
        super();
    }
}
