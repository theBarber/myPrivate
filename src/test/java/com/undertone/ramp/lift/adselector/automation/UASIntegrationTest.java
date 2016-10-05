package com.undertone.ramp.lift.adselector.automation;

import com.undertone.automation.assertion.Assert;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.junit.runner.RunWith;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Created by noam on 29/09/16.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:UASIntegration.feature", plugin = { "pretty", "com.undertone.automation.RotatingJSONFormatter:target/cucumber/uas-adselector-integration_$TIMESTAMP$.json" })
public class UASIntegrationTest extends BaseTest {

    private String url;
    private int responseStatus;
    public UASIntegrationTest() {
        super();
        Given("new request (\\S+\\.json) with zone (\\S+) to UASEndPoint" ,(String requestJson, String zoneId )->{
            CloseableHttpClient httpclient = HttpClients.createDefault();
            String host= config.get("uas.host");
            String port= config.get("uas.port");
            url = "http://" + host + ":"+port + "/af?zoneid=" + zoneId + "&ct=1";
            HttpPost httpPost = new HttpPost(url);
            CloseableHttpResponse response = null;
            StringEntity entity = new StringEntity(requestJson, ContentType.APPLICATION_JSON);
            httpPost.setEntity(entity);
            try {
                response = httpclient.execute(httpPost);
                responseStatus = response.getStatusLine().getStatusCode();
            } catch (IOException e) {
                Assert.fail(e.getMessage());
            }
        });
        When("ad selected", () -> {  });
        Then("The response is correct", () -> {

            Assert.assertEquals(200, responseStatus);

        });
    }

    private static String getContent(HttpResponse response) throws IOException {
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuilder result = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        return result.toString();
    }
}
