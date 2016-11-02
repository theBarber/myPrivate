package com.undertone.ramp.lift.adselector.automation;

import static java.util.stream.Collectors.groupingBy;
import static java.util.stream.Collectors.mapping;
import static java.util.stream.Collectors.toList;
import static org.hamcrest.Matchers.empty;
import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.isOneOf;
import static org.hamcrest.Matchers.not;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.AbstractMap.SimpleImmutableEntry;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import com.undertone.automation.utils.HttpContentTest;
import cucumber.api.PendingException;
import org.apache.http.HttpResponse;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.Assume;
import org.junit.runner.RunWith;

import com.undertone.automation.cli.process.CliCommandExecution;
import com.undertone.automation.module.WithId;
import com.undertone.automation.support.StringUtils;
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
public class UASIntegrationHandler extends BaseTest implements CampaignManaging , ResponseCodes  {
    /*
     * for hard coded campaign manager
     */

	public UASIntegrationHandler() {
		super();
		ThenResposeCodeIs();
		Given("^Campaign Manager with hardcoded campaign and zone name \\{(.*)\\}$" ,(String zoneName)-> {
			load(getCampaignManager());
			Assume.assumeThat(getCampaignManager().getZone(zoneName) , Matchers.notNullValue() );
		});
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


		Then("The responses has impression-urls", () -> {
			Assert.assertTrue("all of the responses should have a url",
					uas.get().responses().map(UASIntegrationHandler::getImpressionUrl).map(CompletableFuture::join)
							.allMatch(Optional::isPresent));
		});

		Then("The responses has click-urls", () -> {
			Assert.assertTrue("all of the responses should have a url", uas.get().responses()
					.map(UASIntegrationHandler::getClickUrl).map(CompletableFuture::join).allMatch(Optional::isPresent));
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
						urlExtractor = UASIntegrationHandler::getImpressionUrl;
					} else if (urlType.equalsIgnoreCase("click")) {
						urlExtractor = UASIntegrationHandler::getClickUrl;
						urlExtractor = urlExtractor.andThen(f -> f.thenApply(UASIntegrationHandler::parsableClickUrl));
					}

					Assert.assertThat(entityType, isOneOf("campaign", "banner", "zone"));
					Optional<? extends WithId> expectedEntity = campaignManager.getterFor(entityType).apply(entityName);
					Assert.assertTrue("Could not find " + entityType + " named " + entityName,
							expectedEntity.isPresent());

					Map<String, Long> theAmountOfTheOccurencesOfTheFieldValueById = uas.get().responses()
							.map(urlExtractor).map(CompletableFuture::join).map(UASIntegrationHandler::toURL)
							.filter(Optional::isPresent).map(Optional::get).map(UASIntegrationHandler::splitQuery)
							.flatMap(m -> m.entrySet().stream()).filter(entry -> fieldName.equals(entry.getKey()))
							.flatMap(entry -> entry.getValue().stream())
							.collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));

					Assert.assertThat(urlType + " urls grouped by " + fieldName,
							theAmountOfTheOccurencesOfTheFieldValueById.keySet(), is(not(empty())));

					long totalResponses = uas.get().responses().filter(succeededFuture).count();
					Assert.assertThat("total responses", totalResponses, greaterThan(10l));

					double actualRate = theAmountOfTheOccurencesOfTheFieldValueById
							.getOrDefault(expectedEntity.get().getId(), 0L).doubleValue() / totalResponses;
					Assert.assertEquals("rate of " + fieldName + " in impression urls", percent.doubleValue(),
							actualRate * 100, 10d);

				});
		When("I read the latest (clk|imp) log file from uas", (String logType) -> {
			String directory = "/var/log/ut-ramp-uas/";
			List<String> allLines = new ArrayList<>();
			this.uasCliConnections.forEach((connectionName, conn) -> {
				try {
					Optional<String> remoteFile = conn.fileList(directory)
							.filter(s -> logType.equals(s.substring(directory.length(), logType.length())))
							.sorted(String.CASE_INSENSITIVE_ORDER.reversed()).findFirst();

					File tempFile = File.createTempFile("tmp", remoteFile.get());
					conn.get(remoteFile.get(), tempFile);

					Files.lines(Paths.get(tempFile.toURI())).collect(Collectors.toCollection(() -> allLines));
					tempFile.delete();
				} catch (IOException e) {
					Assert.fail(e.getMessage());
				}

			});

		});
		When("I want to use cli to execute \\{([^}]+)\\}", (String cmd) -> {

			this.uasCliConnections.forEach((connectionName, conn) -> {
				try {
					new CliCommandExecution(conn, cmd).execute();

				} catch (IOException e) {
					Assert.fail(e.getMessage());
				}
			});
		});
		Then("The passback ratio should be (\\d+)%",(String percentage) -> {
			double ratio = Double.parseDouble(percentage)/100.0;
			long count = uas.get().responses().map(f -> f.join()).map(http -> HttpContentTest.getContent(http))
					.filter(content -> (!content.contains("/l?bannerid=968381"))).count();
			long totalResponses = uas.get().responses().filter(succeededFuture).count();
			double actualRatio = count/(double)totalResponses;
			Assert.assertTrue("count was "+count +" out of "+ totalResponses, actualRatio == ratio);
		});
		Given("^Campaign Manager with hardcoded campaign$", () -> {
			load(getCampaignManager());
			Assume.assumeThat(getCampaignManager().getZone("qa.undertone.com - Full Banner") , Matchers.notNullValue() );
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
		return Arrays.stream(url.getQuery().split("&")).map(UASIntegrationHandler::splitQueryParameter).collect(
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
