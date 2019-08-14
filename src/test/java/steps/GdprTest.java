package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = {"classpath:gdpr/NoParam.feature", "classpath:gdpr/SingleParam.feature"},
        plugin = {"pretty",})
public class GdprTest extends BaseTest {
    public GdprTest() {
        super();

        Given("I add UK ip header", () -> {
            sut.getUASRquestModule().addHttpHeader("X-Forwarded-For", "193.117.138.126");
        });
    }
}
