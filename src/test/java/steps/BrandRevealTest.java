package steps;


import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import entities.Campaign;
import entities.RampAppRequestModule;
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
