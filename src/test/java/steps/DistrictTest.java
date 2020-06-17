package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:DistrictLimitation.feature", plugin = { "pretty"})

public class DistrictTest extends BaseTest {
    public DistrictTest() {
    }
}
