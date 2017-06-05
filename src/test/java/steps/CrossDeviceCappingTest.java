package steps;

import java.net.URI;
import java.net.URISyntaxException;

import cucumber.api.CucumberOptions;
import cucumber.api.PendingException;
import cucumber.api.junit.Cucumber;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.config.SocketConfig;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.junit.Assert;
import org.junit.runner.RunWith;
import com.couchbase.client.java.error.DocumentDoesNotExistException;

/**
 * Created by kereng on 5/23/2017.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = {"classpath:CrossDeviceCappingExperiment.feature","classpath:CrossDeviceCappingNoExperiment.feature"}, plugin = { "pretty",
    "infra.RotatingJSONFormatter:target/cucumber/crossDevice_$TIMESTAMP$.json" })

public class CrossDeviceCappingTest extends BaseTest{

  public CrossDeviceCappingTest() {
    super();

    Given("I add device ([a-zA-Z0-9]*) with record <([^>]*)> to user info", (String paramName, String paramValue) -> {
      sut.getUserInfoBucket().insertDocument(paramName, paramValue);
    });

    Then("I delete the history of ([a-zA-Z0-9]*) from user history", (String paramName) -> {
      try{
        sut.getUserHistoryBucket().deleteDocument(paramName);
      } catch (DocumentDoesNotExistException e) {
        System.out.println(e.getMessage());
      }

    });

    Given("I delete user info record of ([a-zA-Z0-9]*) from user info", (String userInfoRecordKey) -> {
      try{
        sut.getUserInfoBucket().deleteDocument(userInfoRecordKey);
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
    Then("^I refresh staging delivery engine data cache$", () -> {
      // Write code here that turns the phrase above into concrete actions
      URIBuilder uriBuilderIad1 = new URIBuilder()
        .setScheme("http")
        .setParameter("action","start")
        .setPath("delivery_engine/refreshCache")
        .setPort(8877)
        .setHost("172.31.48.15");

      URIBuilder uriBuilderIad2 = new URIBuilder()
        .setScheme("http")
        .setParameter("action","start")
        .setPath("delivery_engine/refreshCache")
        .setPort(8877)
        .setHost("172.31.48.26");

      try {
        URI iad1 = uriBuilderIad1.build();
        URI iad2 = uriBuilderIad2.build();

        HttpPost postIad1 = new HttpPost(iad1);
        HttpPost postIad2 = new HttpPost(iad2);

        HttpClient httpclient = HttpClients.custom()
          .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(5000).build()).build();
        HttpResponse httpResponse1 = httpclient.execute(postIad1);
        HttpResponse httpResponse2 = httpclient.execute(postIad2);
        boolean code1 = httpResponse1.getStatusLine().getStatusCode() == 200;
        boolean code2 = httpResponse2.getStatusLine().getStatusCode() == 200;
        Assert.assertTrue("status code should be 200", code1);
        Assert.assertTrue("status code should be 200", code2);
        // TODO: 05/06/17 need to complete this issue

      } catch (Exception e) {
        System.out.println(e.getMessage());
      }






    });
  }

}
