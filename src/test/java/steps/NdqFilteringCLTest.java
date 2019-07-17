package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:NdqFilteringCL.feature", plugin = {"pretty",})
//        "infra.RotatingJSONFormatter:target/cucumber/NdqFilteringCL_$TIMESTAMP$.json"})
public class NdqFilteringCLTest extends BaseTest{
    public NdqFilteringCLTest(){
           super();
    }
}
