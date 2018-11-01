package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

public class UDMPTest {
    @RunWith(Cucumber.class)
    @CucumberOptions(features = "classpath:UDMP.feature", plugin = {"pretty",
            "infra.RotatingJSONFormatter:target/cucumber/UDMP_$TIMESTAMP$.json"})
    public class UDMP extends BaseTest{
        public UDMP(){
            super();
        }
    }

}
