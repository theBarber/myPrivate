package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:DailyPacing.feature", plugin = {"pretty",})
//        "infra.RotatingJSONFormatter:target/cucumber/PacingHourly_$TIMESTAMP$.json"})
public class DailyPacing extends BaseTest  {
    public DailyPacing(){
        super();
    }
}
