package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.java8.En;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@CucumberOptions(features = "classpath:EitanTest.feature", plugin = { "pretty"})
@RunWith(Cucumber.class)
public class EitanTest extends BaseTest {
    public EitanTest() {
//        Given("my name is Eitan", () -> {
//            System.out.println("this is Eitan Test feature");
//        });
    }
}
