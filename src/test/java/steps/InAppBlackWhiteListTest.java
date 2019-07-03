package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;

@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:InAppBlackWhiteList.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/InAppBlackWhiteList_$TIMESTAMP$.json"})
public class InAppBlackWhiteListTest extends BaseTest{
    public InAppBlackWhiteListTest(){
        super();
    }
}
