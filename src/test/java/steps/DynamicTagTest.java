package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

import java.util.Random;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:DynamicTag.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/DynamicTag_$TIMESTAMP$.json"})
public class DynamicTagTest extends BaseTest{
    public DynamicTagTest()
    {
        super();
        Given("I add cookie (\\w+) with random value to my requests to uas", (String paramName) -> {
            sut.getUASRquestModule().addCookie(paramName, String.valueOf(new Random().nextInt()));
        });
    }
}
