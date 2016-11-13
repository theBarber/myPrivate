package com.undertone.ramp.lift.adselector.automation;

import static java.util.stream.Collectors.groupingBy;
import static java.util.stream.Collectors.mapping;
import static java.util.stream.Collectors.toList;
import static org.hamcrest.Matchers.empty;
import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.isOneOf;
import static org.hamcrest.Matchers.not;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.AbstractMap.SimpleImmutableEntry;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeUnit;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.impl.client.HttpClients;
import org.hamcrest.Matchers;
import org.junit.runner.RunWith;

import com.undertone.automation.cli.process.CliCommandExecution;
import com.undertone.automation.module.WithId;
import com.undertone.automation.support.StringUtils;
import com.undertone.qa.Zone;
import com.undertone.ramp.lift.uas.automation.UASRequestModule;

import co.unruly.matchers.OptionalMatchers;
import co.unruly.matchers.StreamMatchers;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

/**
 * Created by noam on 29/09/16.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:UASIntegration.feature", plugin = { "pretty",
	"com.undertone.automation.RotatingJSONFormatter:target/cucumber/uas-adselector-integration_$TIMESTAMP$.json" })
public class UASIntegrationTest extends BaseTest {
    // protected List<UASLogModule> logModules = new ArrayList<>();
    public final Stream<String> forLogs = Stream.of("clk", "imp");

    public UASIntegrationTest() {
	super();

	// Before(CLITESTS, 15000, 2, scenario -> {
	// forLogs.map(logname -> new
	// UASLogModule(super.uasCliConnections.values(), logname))
	// .collect(Collectors.toCollection(() -> logModules));
	// });
	// ThenResposeCodeIs();
	//
	// Given("^Campaign Manager with hardcoded campaign$", () -> {
	// load(getCampaignManager());
	// Assume.assumeThat(getCampaignManager().getZone("qa.undertone.com -
	// Full Banner"), Matchers.notNullValue());
	// });
	When("I send an ad request for zone named \\{([^}]+)\\} to UAS", (String zoneByName) -> {
	    Zone zone = sut.getCampaignManager().getZone(zoneByName)
		    .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
	    sut.getUASRquestModule().zoneRequest(zone.getId());
	});
	When("I send (\\d+) times an ad request for zone named \\{([^}]+)\\} to UAS",
		(Integer times, String zoneByName) -> {
		    Zone zone = sut.getCampaignManager().getZone(zoneByName)
			    .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
		    sut.getUASRquestModule().zoneRequests(zone.getId(), times);
		});

	Then("The responses? has impression-urls?", () -> {
	    assertThat(
		    "all of the responses should have a url", sut.getUASRquestModule().responses()
			    .map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join),
		    StreamMatchers.allMatch(is(not(OptionalMatchers.empty()))));
	});

	Then("The responses? has click-urls?", () -> {
	    assertTrue("all of the responses should have a url", sut.getUASRquestModule().responses()
		    .map(UASIntegrationTest::getClickUrl).map(CompletableFuture::join).allMatch(Optional::isPresent));
	});
	//
	// When("I send a request to the first the imperssion urls", ()->{
	// uas.get().responses()
	// .map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join)
	// .map(UASIntegrationTest::toURL).filter(Optional::isPresent).map(Optional::get).findFirst().
	//
	// });
	Then("The (\\w+)Url has (\\w+) field matching the id of the (\\w+) named \\{([^}]+)\\} (\\d+)% of the time",
		(String urlType, String fieldName, String entityType, String entityName, Double percent) -> {

		    Function<CompletableFuture<HttpResponse>, CompletableFuture<Optional<String>>> urlExtractor = null;
		    if (urlType.equalsIgnoreCase("impression")) {
			urlExtractor = UASIntegrationTest::getImpressionUrl;
		    } else if (urlType.equalsIgnoreCase("click")) {
			urlExtractor = UASIntegrationTest::getClickUrl;
			urlExtractor = urlExtractor.andThen(f -> f.thenApply(UASIntegrationTest::parsableClickUrl));
		    }

		    assertThat(entityType, isOneOf("campaign", "banner", "zone"));
		    Optional<? extends WithId> expectedEntity = sut.getCampaignManager().getterFor(entityType)
			    .apply(entityName);
		    assertThat("Could not find " + entityType + " named " + entityName, expectedEntity,
			    is(not(OptionalMatchers.empty())));

		    Map<String, Long> theAmountOfTheOccurencesOfTheFieldValueById = sut.getUASRquestModule().responses()
			    .map(urlExtractor).map(CompletableFuture::join).map(UASIntegrationTest::toURL)
			    .filter(Optional::isPresent).map(Optional::get).map(UASIntegrationTest::splitQuery)
			    .flatMap(m -> m.entrySet().stream()).filter(entry -> fieldName.equals(entry.getKey()))
			    .flatMap(entry -> entry.getValue().stream())
			    .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));

		    assertThat(urlType + " urls grouped by " + fieldName,
			    theAmountOfTheOccurencesOfTheFieldValueById.keySet(), is(not(empty())));

		    long totalResponses = sut.getUASRquestModule().responses().filter(succeededFuture).count();
		    assertThat("total responses", totalResponses, greaterThan(10l));

		    double actualRate = theAmountOfTheOccurencesOfTheFieldValueById
			    .getOrDefault(expectedEntity.get().getId(), 0L).doubleValue() / totalResponses;
		    assertEquals("rate of " + fieldName + " in impression urls", percent.doubleValue(),
			    actualRate * 100, 10d);

		});
	When("I read the latest (clk|imp) log file from uas", (String logType) -> {
	    assertThat(logType + "log file", sut.logFor(logType).readLogs().actual(), is(not(StreamMatchers.empty())));
	});

	Then("^I filter in the (clk|imp) log to the lines where id at column (\\d+) is the same as in impression-url$",
		(String logType, Integer column) -> {

		    URL impressionUrl = sut.getUASRquestModule().responses().map(UASIntegrationTest::getImpressionUrl)
			    .map(CompletableFuture::join).map(UASIntegrationTest::toURL).filter(Optional::isPresent)
			    .map(Optional::get).findFirst().get();

		    String idFieldValue = splitQuery(impressionUrl).get("id").get(0);
		    sut.logFor(logType).filter(raw -> idFieldValue.equals(raw.get(column)));
		    assertThat(sut.logFor(logType).actual(), is(not(StreamMatchers.empty())));
		});
	And("The field (\\w+) in the (\\d+) column of the (clk|imp) log is the same as in impression-url",
		(String fieldName, Integer column ,String logType) -> {
		    URL impressionUrl = sut.getUASRquestModule().responses().map(UASIntegrationTest::getImpressionUrl)
			    .map(CompletableFuture::join).map(UASIntegrationTest::toURL).filter(Optional::isPresent)
			    .map(Optional::get).findFirst().get();
		    String expectedFieldValue = splitQuery(impressionUrl).get(fieldName).get(0);
		    assertThat(sut.logFor(logType).actual(), StreamMatchers.allMatch(Matchers.));
		    
		});

	When("I want to use cli to execute \\{([^}]+)\\}", (String cmd) -> {
	    sut.uasCliConnections().forEach(conn -> {
		try {
		    new CliCommandExecution(conn, cmd).execute();
		} catch (IOException e) {
		    fail(e.getMessage());
		}
	    });
	});

	When("^I send impression requests to UAS$", () -> {
	    HttpClient httpclient = HttpClients.custom()
		    .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(1000).build()).build();
	    sut.getUASRquestModule().responses().map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join)
		    .map(UASIntegrationTest::toURL).filter(Optional::isPresent).map(Optional::get)
		    .map(impurl -> CompletableFuture.supplyAsync(() -> {
			try {
			    HttpResponse response = httpclient.execute(new HttpGet(impurl.toString()));
			    if (response.getEntity() != null) {
				response.setEntity(new BufferedHttpEntity(response.getEntity()));
			    }
			    return response;
			} catch (IOException e) {
			    throw new UncheckedIOException("failed to send request (" + impurl + ") ", e);
			}

		    })).map(CompletableFuture::join).map(HttpResponse::getStatusLine).map(StatusLine::getStatusCode)
		    .forEach(statusCode -> {
			assertThat("Status code of impression request", statusCode, is(204));
		    });
	});

	And("^sleep for (\\d+) seconds$", (Integer seconds) -> {
	    try {
		TimeUnit.SECONDS.sleep(seconds);
	    } catch (InterruptedException e) {
		fail(e.getMessage());
	    }
	});
    }

    private static Predicate<CompletableFuture<?>> succeededFuture = c -> !c.isCompletedExceptionally();

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

    private static Optional<String> parsableClickUrl(Optional<String> originalClickUrl) {
	return originalClickUrl.map(s -> s.replaceAll("__", "&"));
    }

    private static CompletableFuture<Optional<String>> getClickUrl(CompletableFuture<HttpResponse> future) {
	return future.thenApply(UASRequestModule::getClickUrlFrom);
    }

}
