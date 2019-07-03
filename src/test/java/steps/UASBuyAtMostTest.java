package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

/**
 * Created by kereng on 3/27/2017.
 */
@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:UASBuyAtMost.feature", plugin = { "pretty",
    "infra.RotatingJSONFormatter:target/cucumber/uas-buyAtMost_$TIMESTAMP$.json" })
public class UASBuyAtMostTest extends BaseTest{

  public UASBuyAtMostTest() {
    super();

  }
}
