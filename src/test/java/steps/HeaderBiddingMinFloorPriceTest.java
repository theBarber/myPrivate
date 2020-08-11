package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@CucumberOptions(features = "classpath:HeaderBiddingMinFloorPrice.feature", plugin = { "pretty"})
@RunWith(Cucumber.class)
public class HeaderBiddingMinFloorPriceTest extends  BaseTest {
    public HeaderBiddingMinFloorPriceTest() {
    }
}
