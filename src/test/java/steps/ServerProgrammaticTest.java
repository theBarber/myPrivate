package steps;

import cucumber.api.CucumberOptions;
        import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:ServerProgrammatic.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/ServerProgrammatic_$TIMESTAMP$.json"})
public class ServerProgrammaticTest extends BaseTest{
    public ServerProgrammaticTest() {
        super();
    }
}
