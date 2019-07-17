package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:RunOnFalseDomain.feature", plugin = {"pretty",})
//        "infra.RotatingJSONFormatter:target/cucumber/RunOnFalseDomain_$TIMESTAMP$.json"})

public class RunOnFalseDomainTest extends BaseTest{
    public RunOnFalseDomainTest(){
        super();
    }
}
