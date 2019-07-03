package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;

@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:InAppTest.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/InAppTest_$TIMESTAMP$.json"})
public class InAppTest extends BaseTest{
    public InAppTest()
    {
        super();
    }
}
