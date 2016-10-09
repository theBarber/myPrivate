package com.undertone.ramp.lift.adselector.automation;

import com.undertone.automation.assertion.Assert;
import com.undertone.qa.Banner;
import com.undertone.qa.Campaign;
import com.undertone.qa.Zone;
import com.undertone.qa.ZoneSet;

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
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;

/**
 * Created by noam on 29/09/16.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:UASIntegration.feature", plugin = { "pretty",
	"com.undertone.automation.RotatingJSONFormatter:target/cucumber/uas-adselector-integration_$TIMESTAMP$.json" })
public class UASIntegrationTest extends BaseTest {

    private String url;
    private int responseStatus;
    private AtomicReference<Campaign> campaign2 = new AtomicReference<>();
    private AtomicReference<Banner> banner15 = new AtomicReference<>();
    private AtomicReference<ZoneSet> zoneSet719 = new AtomicReference<>();
    private AtomicReference<Zone> zone2 = new AtomicReference<>();

    public UASIntegrationTest() {
	super();
	When("I send an ad request for zone \\{([^}]+)\\} to UAS", (String zoneByName) -> {
	    Zone zone = this.campaignManager.getZone(zoneByName)
		    .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
	    this.uas.get().zoneRequest(zone.getId());
	});
	When("I send (\\d+) times an ad-request for zone \\{([^}]+)\\} to UAS", (Integer times, String zoneByName) -> {
	    Zone zone = this.campaignManager.getZone(zoneByName)
		    .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
	    this.uas.get().zoneRequests(zoneByName, times);
	});

	Given("Campaign Manager with hardcoded campaign", () -> {
	    campaign2.set(this.campaignManager.createCampaign("999-undefined-undefined-NaN", "2"));
	    banner15.set(this.campaignManager.createBanner("Test Banner1", "15", campaign2.get().getId())
		    .orElseThrow(IllegalArgumentException::new));
	    zoneSet719.set(this.campaignManager.createZoneSet("hwu zonesets", "719", campaign2.get().getId())
		    .orElseThrow(IllegalArgumentException::new));
	    zone2.set(campaignManager.createZone("qa.undertone.com - Full Banner", "2", zoneSet719.get().getId())
		    .orElseThrow(IllegalArgumentException::new));
	});
	When("ad selected", () -> {
	});
	Then("The response is correct", () -> {

	    Assert.assertEquals(200, responseStatus);

	});
    }

    private static String getContent(HttpResponse response) throws IOException {
	BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));

	StringBuilder result = new StringBuilder();
	String line;
	while ((line = rd.readLine()) != null) {
	    result.append(line);
	}
	return result.toString();
    }
}
