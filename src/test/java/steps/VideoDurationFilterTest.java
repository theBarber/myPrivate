package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:VideoDurationFilter.feature", plugin = { "pretty"})
public class VideoDurationFilterTest extends BaseTest {
    public VideoDurationFilterTest() {
    }
}



//@RunWith(Cucumber.class)
//@CucumberOptions(features = "classpath:DailyPacing.feature", plugin = {"pretty",})
////        "infra.RotatingJSONFormatter:target/cucumber/DailyPacing_$TIMESTAMP$.json"})
//public class DailyPacing {
//}
