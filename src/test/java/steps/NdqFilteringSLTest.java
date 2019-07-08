package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:NdqFilteringSL.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/NdqFilteringSL_$TIMESTAMP$.json"})
public class NdqFilteringSLTest extends BaseTest  {
    public NdqFilteringSLTest(){
        super();
    }
}
