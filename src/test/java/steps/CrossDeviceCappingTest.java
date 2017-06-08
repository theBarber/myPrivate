package steps;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import gherkin.deps.com.google.gson.JsonArray;
import gherkin.deps.com.google.gson.JsonElement;
import gherkin.deps.com.google.gson.JsonParser;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
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

  public final String START_REFRESH_CACHE = "start refresh cache";

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
      JsonArray hostsArray = new JsonParser().parse(config.get("uas.cliconnection.hosts")).getAsJsonArray();
      CountDownLatch latch = new CountDownLatch(hostsArray.size());

      try {

        for (JsonElement el  : hostsArray) {
          URIBuilder uriBuilderIad1 = new URIBuilder()
            .setScheme("http")
            .setPath("/delivery_engine/refreshCache")
            .setPort(8877)
            .setHost(el.getAsString());

          StringEntity entity = new StringEntity("{\"action\":\"start\"}", ContentType.TEXT_PLAIN);
          URI iad1 = uriBuilderIad1.build();
          HttpPost postIad1 = new HttpPost(iad1);
          postIad1.setEntity(entity);

          HttpClient httpclient = HttpClients.custom()
            .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(5000).build()).build();

          CompletableFuture.runAsync(() -> {
            try {
              HttpResponse httpResponse1 = httpclient.execute(postIad1);
              Assert.assertEquals("status code should be 200", 200, httpResponse1.getStatusLine().getStatusCode());
              BufferedReader bufferedReader1 =
                new BufferedReader(new InputStreamReader(httpResponse1.getEntity().getContent()));
              boolean isRefresh1 = bufferedReader1.lines()
                .collect(Collectors.joining("\n"))
                .contains(START_REFRESH_CACHE);
              Assert.assertTrue("data cache should start refresh", isRefresh1);
              bufferedReader1.close();
              latch.countDown();
            } catch (Exception e) {
              System.out.println(e.getMessage());
              Assert.fail("http post fail");
            }
          });

        }
        latch.await(3, TimeUnit.SECONDS);
      } catch (Exception e) {
        System.out.println(e.getMessage());
      }
    });
  }

}
