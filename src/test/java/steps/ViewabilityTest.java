package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:Viewability.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/Viewability.feature_$TIMESTAMP$.json"})
public class ViewabilityTest extends BaseTest{
    public ViewabilityTest()
    {
        super();
    }
}
