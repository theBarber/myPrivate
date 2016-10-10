package com.undertone.ramp.lift.adselector.automation;

import static java.util.stream.Collectors.groupingBy;
import static java.util.stream.Collectors.mapping;
import static java.util.stream.Collectors.toList;
import static org.hamcrest.Matchers.everyItem;
import static org.hamcrest.Matchers.is;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.AbstractMap.SimpleImmutableEntry;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.Function;
import java.util.stream.Collectors;

import org.apache.http.HttpResponse;
import org.hamcrest.Condition;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;

import com.undertone.automation.module.WithId;
import com.undertone.automation.support.StringUtils;
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
    private AtomicReference<Banner> banner17 = new AtomicReference<>();
    private AtomicReference<ZoneSet> zoneSet719 = new AtomicReference<>();
    private AtomicReference<Zone> zone2 = new AtomicReference<>();
    private AtomicReference<Zone> zone3 = new AtomicReference<>();

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
	    
	    banner17.set(this.campaignManager.createBanner("Test Banner2", "15", campaign2.get().getId())
		    .orElseThrow(IllegalArgumentException::new));
	    zoneSet719.set(this.campaignManager.createZoneSet("hwu zonesets", "719", campaign2.get().getId())
		    .orElseThrow(IllegalArgumentException::new));
	    
	    zone2.set(campaignManager.createZone("qa.undertone.com - Full Banner", "2", zoneSet719.get().getId())
		    .orElseThrow(IllegalArgumentException::new));
	    zone3.set(campaignManager.createZone("qa.undertone.com - Half Banner", "3", zoneSet719.get().getId())
		    .orElseThrow(IllegalArgumentException::new));
	});
	Then("The responses has impression-urls", () -> {
	    Assert.assertTrue("all of the responses should have a url",
		    uas.get().responses().map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join)
			    .allMatch(Optional::isPresent));
	});

	Then("The impressionUrl have (\\w+) field matching the id of the (\\w+) named \\{([^}]+)\\} (\\d+)% of the times",
		(String fieldName, String entityType, String entityName, Double percent) -> {

		    Optional<? extends WithId> expectedEntity = null;
		    switch (entityType.toLowerCase()) {
		    case "campaign":
			// hardcoded:
			expectedEntity = // campaign2.get();
				campaignManager.getCampaign(entityName);
			break;
		    case "banner":
			// hardcoded:
			expectedEntity = Optional.of(banner15).map(AtomicReference::get);
			// campaignManager.getBanner(entityName);
			break;

		    case "zone":
			// hardcoded:
			expectedEntity = // zone2.get();
				campaignManager.getZone(entityName);
			break;
		    default:
			Assert.assertThat(entityType, Matchers.isOneOf("campaign", "bunner", "zone"));
		    }
		    Assert.assertTrue("Could not find " + entityType + " named " + entityName,
			    expectedEntity.isPresent());

		    Map<String, Long> theAmountOfTheOccurencesOfTheFieldValueById = uas.get().responses()
			    .map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join)
			    .map(UASIntegrationTest::toURL).filter(Optional::isPresent).map(Optional::get)
			    .map(UASIntegrationTest::splitQuery).flatMap(m -> m.entrySet().stream())
			    .filter(entry -> fieldName.equals(entry.getKey()))
			    .flatMap(entry -> entry.getValue().stream())
			    .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));
		    Assert.assertTrue(!theAmountOfTheOccurencesOfTheFieldValueById.isEmpty());
		    
		    double totalUrls = theAmountOfTheOccurencesOfTheFieldValueById.values().stream()
			    .mapToLong(Long::longValue).sum();
		    double actualRate = theAmountOfTheOccurencesOfTheFieldValueById.getOrDefault(expectedEntity.get().getId(),0L)
			    .doubleValue() / totalUrls;
		    Assert.assertEquals("rate of " + fieldName + " in impression urls", percent.doubleValue(),
			    actualRate * 100, 5d);

		});
    }

    private static Optional<URL> toURL(Optional<String> optionalurlstr) {
	if (optionalurlstr.isPresent()) {
	    try {
		return Optional.of(new URL(optionalurlstr.get()));
	    } catch (MalformedURLException e) {
		return Optional.empty();
	    }
	}
	return Optional.empty();
    }

    public static Map<String, List<String>> splitQuery(URL url) {
	if (StringUtils.nullOrEmpty.test(url.getQuery())) {
	    return Collections.emptyMap();
	}
	return Arrays.stream(url.getQuery().split("&")).map(UASIntegrationTest::splitQueryParameter).collect(
		groupingBy(SimpleImmutableEntry::getKey, LinkedHashMap::new, mapping(Map.Entry::getValue, toList())));
    }

    public static SimpleImmutableEntry<String, String> splitQueryParameter(String it) {
	final int idx = it.indexOf("=");
	final String key = idx > 0 ? it.substring(0, idx) : it;
	final String value = idx > 0 && it.length() > idx + 1 ? it.substring(idx + 1) : null;
	return new SimpleImmutableEntry<>(key, value);
    }

    private static CompletableFuture<Optional<String>> getImpressionUrl(CompletableFuture<HttpResponse> future) {
	return future.thenApply(UASRequestModule::getImpressionUrlFrom);
    }
}
