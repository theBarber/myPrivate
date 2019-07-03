package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:SupplyType.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/SupplyType.feature_$TIMESTAMP$.json"})
public class SupplyTypeTest extends BaseTest{

    public SupplyTypeTest()
    {
        super();
    }
}
