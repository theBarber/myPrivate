package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@CucumberOptions(features = {
        "classpath:BrandRevealMultipleSizes.feature"
}, plugin = {"pretty",})
@RunWith(Cucumber.class)
public class BrandRevealTest extends BaseTest {
    public BrandRevealTest() {
        super();
    }
}
