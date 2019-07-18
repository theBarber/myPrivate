package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:ZZ_Restart_Replay.feature", plugin = { "pretty",})
//        "infra.RotatingJSONFormatter:target/cucumber/ZZ_Restart_Replay_$TIMESTAMP$.json" })
public class restartReplayTest extends BaseTest {
    public restartReplayTest()
    {
        super();
    }
}
