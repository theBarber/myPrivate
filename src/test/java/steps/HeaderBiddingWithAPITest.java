package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:HeaderBiddingWithAPI.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/HeaderBidding_$TIMESTAMP$.json"})
public class HeaderBiddingWithAPITest extends BaseTest{

    public HeaderBiddingWithAPITest()
    {
        super();

    }
}
