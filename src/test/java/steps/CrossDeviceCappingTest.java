package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

/**
 * Created by kereng on 5/23/2017.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:CrossDeviceCapping.feature", plugin = { "pretty",
    "infra.RotatingJSONFormatter:target/cucumber/crossDevice_$TIMESTAMP$.json" })

public class CrossDeviceCappingTest extends BaseTest{

  public CrossDeviceCappingTest() {
    super();

    Given("I add device ([a-zA-Z0-9]*) with record <([^>]*)> to user info graph", (String paramName, String paramValue) -> {
      sut.getUserinfoBucket().insertDocument(paramName, paramValue);
    });

  }


}
