package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = {
        "classpath:HeaderBiddingThrottling.feature"}, plugin = {"pretty",})
public class HeaderBiddingThrottling extends BaseTest {
    public HeaderBiddingThrottling() {

    }
}
