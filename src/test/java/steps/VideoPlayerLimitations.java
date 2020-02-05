package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(features = {
        "classpath:VideoPlayerPlaybackLimitations.feature",
}, plugin = {"pretty",})
public class VideoPlayerLimitations extends BaseTest {
    public VideoPlayerLimitations() {
        super();
    }

}




