package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:consent/Pii.feature", plugin = {"pretty",})
//        "infra.RotatingJSONFormatter:target/cucumber/NDQ_Filtering_$TIMESTAMP$.json"})
public class PiiTest extends BaseTest {

  public PiiTest()
  {
    super();
  }
}

