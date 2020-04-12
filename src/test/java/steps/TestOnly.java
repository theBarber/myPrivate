package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = {"classpath:unused/TestOnly.feature"}, plugin = { "pretty"})
public class TestOnly extends BaseTest {
    public TestOnly() {
    }
}
