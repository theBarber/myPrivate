package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:NdqFilteringTL.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/NdqFilteringTL_$TIMESTAMP$.json"})

public class NdqFilteringTLTest extends BaseTest{
    public NdqFilteringTLTest(){
        super();
    }
}
