package com.undertone.ramp.lift.adselector.automation;

import static org.hamcrest.Matchers.everyItem;
import static org.hamcrest.Matchers.is;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

import org.apache.http.HttpResponse;
import org.hamcrest.Condition;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;

import com.undertone.qa.Banner;
import com.undertone.qa.Campaign;
import com.undertone.qa.Zone;
import com.undertone.qa.ZoneSet;
import com.undertone.ramp.lift.uas.automation.UASRequestModule;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

/**
 * Created by noam on 29/09/16.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:UASIntegration.feature", plugin = { "pretty",
	"com.undertone.automation.RotatingJSONFormatter:target/cucumber/uas-adselector-integration_$TIMESTAMP$.json" })
public class UASIntegrationTest extends BaseTest {
    /*
     * for hard coded campaign manager
     */
    private AtomicReference<Campaign> campaign2 = new AtomicReference<>();
    private AtomicReference<Banner> banner15 = new AtomicReference<>();
    private AtomicReference<ZoneSet> zoneSet719 = new AtomicReference<>();
    private AtomicReference<Zone> zone2 = new AtomicReference<>();

    public UASIntegrationTest() {
	super();
	When("I send an ad request for zone named \\{([^}]+)\\} to UAS", (String zoneByName) -> {
	    Zone zone = this.campaignManager.getZone(zoneByName)
		    .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
	    this.uas.get().zoneRequest(zone.getId());
	});
	When("I send (\\d+) times an ad request for zone named \\{([^}]+)\\} to UAS",
		(Integer times, String zoneByName) -> {
		    Zone zone = this.campaignManager.getZone(zoneByName)
			    .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
		    this.uas.get().zoneRequests(zone.getId(), times);
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
	Then("The responses has impression-urls", () -> {
	    Assert.assertTrue("all of the responses should have a url",
		    uas.get().responses().map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join)
			    .allMatch(Optional::isPresent));
	});

    }

    private static CompletableFuture<Optional<String>> getImpressionUrl(CompletableFuture<HttpResponse> future) {
	return future.thenApply(UASRequestModule::getImpressionUrlFrom);
    }
}
