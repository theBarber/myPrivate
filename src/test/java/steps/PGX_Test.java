package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:PGXTest.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/PGX_$TIMESTAMP$.json"})
public class PGX_Test extends BaseTest{
    public PGX_Test()
    {
        super();
    }
}
