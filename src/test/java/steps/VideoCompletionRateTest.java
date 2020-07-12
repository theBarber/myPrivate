package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:VideoCompletionRate.feature", plugin = { "pretty"})
public class VideoCompletionRateTest extends BaseTest {
    public VideoCompletionRateTest() {
    }
}
