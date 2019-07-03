package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;


@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:UDMP.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/UDMP_$TIMESTAMP$.json"})
public class UDMPTest extends BaseTest{
    public UDMPTest(){
        super();
    }
}


