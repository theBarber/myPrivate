package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:BlackWhiteList.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/BlackWhiteList_$TIMESTAMP$.json"})
public class BlackWhiteListTest extends BaseTest{
    public BlackWhiteListTest()
    {
        super();
    }
}
