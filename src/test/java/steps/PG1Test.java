package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:PG1Test.feature", plugin = {"pretty",})
//        "infra.RotatingJSONFormatter:target/cucumber/NDQ_Filtering_$TIMESTAMP$.json"})
public class PG1Test extends BaseTest {

    public PG1Test()
    {
        super();
    }
}
