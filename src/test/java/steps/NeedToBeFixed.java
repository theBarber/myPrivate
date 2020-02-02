package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(features = {
        "classpath:unused/NeedToBeFixed.feature",
}, plugin = {"pretty",})
public class NeedToBeFixed extends BaseTest {
    public NeedToBeFixed() {
        super();
    }

}




