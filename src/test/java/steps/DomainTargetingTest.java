package steps;

import cucumber.api.CucumberOptions;

@CucumberOptions(features = "classpath:DomainTargeting.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/DomainTargeting_$TIMESTAMP$.json"})
public class DomainTargetingTest extends BaseTest{
    public DomainTargetingTest()
    {
        super();
    }
}
