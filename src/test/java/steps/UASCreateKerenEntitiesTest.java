package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:UASCreateKerenEntitiesDT.feature", plugin = { "pretty",
        "infra.RotatingJSONFormatter:target/cucumber/UASCreateKerensEntities_$TIMESTAMP$.json" })
public class UASCreateKerenEntitiesTest extends BaseTest{

    public UASCreateKerenEntitiesTest() {
        super();
    }
}
