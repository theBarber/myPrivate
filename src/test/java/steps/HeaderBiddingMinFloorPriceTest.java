package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:HeaderBiddingMinFloorPrice.feature", plugin = { "pretty"})
public class HeaderBiddingMinFloorPriceTest extends  BaseTest {
    public HeaderBiddingMinFloorPriceTest() {
    }
}
