package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:DomainTargeting.feature", plugin = {"pretty",})
//        "infra.RotatingJSONFormatter:target/cucumber/DomainTargeting_$TIMESTAMP$.json"})
public class DomainTargetingTest extends BaseTest{
    public DomainTargetingTest()
    {
        super();
    }
}
