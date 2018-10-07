package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:InAppBlackWhiteList.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/InAppBlackWhiteList_$TIMESTAMP$.json"})

public class NdqFilteringCLTest extends BaseTest{
    public NdqFilteringCLTest(){
        super();
    }
}
