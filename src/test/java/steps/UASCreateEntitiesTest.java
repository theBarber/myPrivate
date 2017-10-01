package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:UASCreateEntitiesTest.feature", plugin = { "pretty",
        "infra.RotatingJSONFormatter:target/cucumber/UASCreateEntitiesTest_$TIMESTAMP$.json" })
public class UASCreateEntitiesTest extends BaseTest{

    public UASCreateEntitiesTest() {
        super();
    }
}
