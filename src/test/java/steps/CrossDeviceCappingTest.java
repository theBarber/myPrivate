package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;
import com.couchbase.client.java.error.DocumentDoesNotExistException;

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
      sut.getUserInfoBucket().insertDocument(paramName, paramValue);
    });

    Then("I delete the history of ([a-zA-Z0-9]*) from user history", (String paramName) -> {
      try{
        sut.getUserHistoryBucket().deleteDocument(paramName);
      } catch (DocumentDoesNotExistException e) {
        System.out.println(e.getMessage());
      }

    });


    Given("I add cookie (\\w+) with value \\{([^}]+)\\} to my requests to uas", (String paramName, String paramValue) -> {
      sut.getUASRquestModule().addCookie(paramName, paramValue);
    });

    Given("I clear all cookies from uas requests", () -> {
      sut.getUASRquestModule().clearCookies();
    });
  }

}
