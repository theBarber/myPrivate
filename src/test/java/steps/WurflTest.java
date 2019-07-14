package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;


    @RunWith(RerunningCucumber.class)
    @CucumberOptions(features = "classpath:Wurfl.feature", plugin = {"pretty",
            "infra.RotatingJSONFormatter:target/cucumber/Wurfl_$TIMESTAMP$.json"})
    public class WurflTest extends BaseTest {
        public WurflTest(){
            super();
        }
    }




