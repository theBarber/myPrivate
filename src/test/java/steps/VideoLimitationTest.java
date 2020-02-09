package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.java8.En;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@CucumberOptions(features = "classpath:VideoLimitation.feature", plugin = { "pretty"})
@RunWith(Cucumber.class)
public class VideoLimitationTest extends BaseTest {
    public VideoLimitationTest() {
    }
}
