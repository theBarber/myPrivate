package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:StrategyServiceTest.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/StrategyServiceTest_$TIMESTAMP$.json"})
public class StrategyServiceTest extends BaseTest{

    public StrategyServiceTest() {
        super();
        }
    }

