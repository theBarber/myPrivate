package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)

@CucumberOptions(features = "classpath:OpenMarket.feature", plugin = { "pretty"})
public class OpenMarketTest extends BaseTest {
    public OpenMarketTest() {
    }
}
