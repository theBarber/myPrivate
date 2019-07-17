package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:PacingHourly.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/PacingHourly_$TIMESTAMP$.json"})
public class PacingHourlyTest extends BaseTest  {
    public PacingHourlyTest(){
        super();
    }
}
