package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;

@CucumberOptions(features = "classpath:AA_Entities.feature", plugin = { "pretty",
        "infra.RotatingJSONFormatter:target/cucumber/AA_Entities_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)
public class AA_EntitiesTest extends BaseTest {

    public AA_EntitiesTest()
    {
        super();
    }
}
