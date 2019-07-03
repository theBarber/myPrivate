package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:Geo.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/Geo_$TIMESTAMP$.json"})
public class GeoTest extends BaseTest{
    public GeoTest()
    {
        super();
    }
}
