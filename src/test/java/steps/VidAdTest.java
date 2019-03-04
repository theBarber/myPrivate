package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:VidAd.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/VidAd_$TIMESTAMP$.json"})
public class VidAdTest extends BaseTest {
    public VidAdTest(){
        super();
    }
}

