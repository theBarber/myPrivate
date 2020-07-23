package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:HeaderBiddingVideo.feature", plugin = { "pretty"})
public class HeaderBiddingVideoTest extends BaseTest {
    public HeaderBiddingVideoTest() {
    }
}
