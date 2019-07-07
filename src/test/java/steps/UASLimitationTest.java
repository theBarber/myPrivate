package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

import infra.RerunningCucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:UASLimitations.feature", plugin = {"pretty",
    "infra.RotatingJSONFormatter:target/cucumber/UAS_Limitations_$TIMESTAMP$.json"})
public class UASLimitationTest extends BaseTest {

  public UASLimitationTest() {
    super();
  }
}