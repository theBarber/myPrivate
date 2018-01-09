package steps;

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

import com.google.common.util.concurrent.ThreadFactoryBuilder;
import java.io.IOException;
import java.io.UncheckedIOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;
import java.util.AbstractMap.SimpleImmutableEntry;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.LongAdder;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import com.sun.org.apache.xpath.internal.SourceTreeManager;
import com.sun.scenario.effect.impl.sw.sse.SSEBlend_SRC_OUTPeer;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.config.SocketConfig;
import org.apache.http.cookie.Cookie;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.impl.client.HttpClients;
import org.hamcrest.CoreMatchers;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;

import co.unruly.matchers.OptionalMatchers;
import co.unruly.matchers.StreamMatchers;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import entities.Zone;
import infra.assertion.ListItemAt;
import infra.cli.process.CliCommandExecution;
import infra.module.WithId;
import infra.support.StringUtils;
import infra.utils.HttpContentTest;
import ramp.lift.uas.automation.UASRequestModule;

import javax.swing.plaf.synth.SynthOptionPaneUI;

/**
 * Created by noam on 29/09/16.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:UASIntegration.feature", plugin = {"pretty",
    "infra.RotatingJSONFormatter:target/cucumber/uas-adselector-integration_$TIMESTAMP$.json"})
public class UASIntegrationTest extends BaseTest {

  public UASIntegrationTest() {
    super();
    When("I send an ad request for zone named \\{([^}]+)\\} to UAS", (String zoneByName) -> {
      Zone zone = sut.getCampaignManager().getZone(zoneByName)
          .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
      sut.getUASRquestModule().zoneRequest(zone.getId());
    });

    When("I send (\\d+) times an ad request for zone named \\{([^}]+)\\} to UAS",
        (Integer times, String zoneByName) -> {
          sendMultipleAdRequests(times, zoneByName, true);
        });

      When("I send (\\d+) times an ad request with parameter \\{([^}]+)\\} for zone id \\{(\\d+)\\} to UAS",
              (Integer times,String parameter, Integer zoneId) -> {
                  sendMultipleZoneIDAdRequestsWithParameter(times,parameter, zoneId, true);
              });

      When("I send (\\d+) times an ad request with parameter \\{([^}]+)\\} for zone named \\{([^}]+)\\} to UAS",
              (Integer times,String parameter, String zoneByName) -> {
                  sendMultipleAdRequestsWithParameter(times,parameter, zoneByName, true);
              });

    When("I send (\\d+) times an ad request with query parameters for zone named \\{([^}]+)\\} to UAS",
        (Integer times, String zoneByName) -> {
          sendMultipleAdRequestsWithParams(times, zoneByName, true);
        });

    And("i set new generic cookie",() ->
        sut.getUASRquestModule().setGenericCookie());

    When("I send ad requests I sleep (\\d+) millis",
              (Long millis) -> {
                  sut.getUASRquestModule().thatSleeps(millis);
              });
    When("I send (\\d+) times an ad request for zone id \\{(\\d+)\\} to UAS",
        (Integer times, Integer zoneId) -> {
          sendMultipleAdRequests(times, zoneId, true);
        });
    When("I send (\\d+) additional ad requests for zone named \\{([^}]+)\\} to UAS",
        (Integer times, String zoneByName) -> {
          sendMultipleAdRequests(times, zoneByName, false);
        });

    When("I send (\\d+) additional ad requests with query parameters for zone named \\{([^}]+)\\} to UAS",
        (Integer times, String zoneByName) -> {
          sendMultipleAdRequestsWithParams(times, zoneByName, false);
        });

    When("^I send impression requests to UAS immediately(!)?$", (String exclamationMark) -> {
      LongAdder impressionsSent = sendImpressionRequestsToUASImmediately();

      if (null != exclamationMark) {
        assertEquals("Number of impression urls sent", sut.getUASRquestModule().responses().count(),
          impressionsSent.longValue(), 10d);
      }
    });
    When("^I send impression requests to UAS immediately with delta \\{(\\d+)\\}$", (Integer delta) -> {
      LongAdder impressionsSent = sendImpressionRequestsToUASImmediately();


        assertEquals("Number of impression urls sent", sut.getUASRquestModule().responses().count(),
          impressionsSent.longValue(), delta);

    });
    Then("The responses? has impression-urls?", () -> {
        Stream<Optional<String>> impressionURLResponses = Optional.ofNullable(sut.getUASRquestModule().responses()
                .map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join)).orElse(sut.getUASRquestModule().getSynchronizedResponses().stream().map(UASRequestModule::getImpressionUrlFrom));
        assertThat(
          "all of the responses should have a url", impressionURLResponses,
          StreamMatchers.allMatch(is(not(OptionalMatchers.empty()))));
        //print check
       /* sut.getUASRquestModule().responses()
                .map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join).forEach(response->System.out.println("the request was: "+ response.get()));
    */});

    Then("The responses? has click-urls?", () -> {
      assertTrue("all of the responses should have a url", sut.getUASRquestModule().responses()
          .map(UASIntegrationTest::getClickUrl).map(CompletableFuture::join).allMatch(Optional::isPresent));
    });

    Then("The responses? are passback?", () -> {

      Map<Boolean, Long> countUrls =
          sut.getUASRquestModule().responses()
              .map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join)
              .collect(Collectors.groupingBy(Optional::isPresent, Collectors.counting()));

      assertThat(
          "all of the responses should not have an impression url", countUrls.getOrDefault(true, 0l),
          Matchers.is(0l));
    });

    //
    // When("I send a request to the first the imperssion urls", ()->{
    // uas.get().responses()
    // .map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join)
    // .map(UASIntegrationTest::toURL).filter(Optional::isPresent).map(Optional::get).findFirst().
    //
    // });
    Then("The (\\w+)Url has (\\w+) field matching the id of the (\\w+) named \\{([^}]+)\\} (\\d+)% of the time",this::checkTheNumberOfSelectedEntity);
    When("^I read the latest (clk|imp|req) log file from uas$", (String logType) -> {
        //---------------------checks-------------------------
      /*  sut.logFor(logType).readLogs().actual().forEach(m->{
            StringBuilder stringBuilder = new StringBuilder();
            for (int i = 0; i < m.size(); i++) {
                stringBuilder.append(m.get(i)).append("\t");
            }
            sut.write(stringBuilder.toString());
        } );*/
        //---------------------checks-------------------------
      assertThat(logType + "log file", sut.logFor(logType).readLogs().actual(), is(not(StreamMatchers.empty())));
    });

    Then("^I filter in the (clk|imp|req) log to the lines where id at column (\\d+) is the same as in impression-url$",
        (String logType, Integer column) -> {

          URL impressionUrl = sut.getUASRquestModule().responses().map(UASIntegrationTest::getImpressionUrl)
              .map(CompletableFuture::join).map(UASIntegrationTest::toURL).filter(Optional::isPresent)
              .map(Optional::get).findFirst().get();

          String idFieldValue = splitQuery(impressionUrl).get("id").get(0);
            //---------------------checks-------------------------
            Stream<List<String>> steamList = sut.logFor(logType).actual();
            sut.write("The expected field value of the logType "+logType+" is: " +  idFieldValue);
            steamList.forEach(m-> sut.write("The actual field value of the logType "+logType+" is: "+ m.get(column)));
            //---------------------checks-------------------------
          sut.logFor(logType).filter(raw -> idFieldValue.equals(raw.get(column)));
          assertThat("the log " + logType + " should contain a line with " + idFieldValue + " at column "
              + column, sut.logFor(logType).actual(), is(not(StreamMatchers.empty())));
        });


    And("The field (\\w+) in the (\\d+) column of the (clk|imp|req) log is the same as in impression-url",
        (String fieldName, Integer column, String logType) -> {
          URL impressionUrl = sut.getUASRquestModule().responses().map(UASIntegrationTest::getImpressionUrl)
              .map(CompletableFuture::join).map(UASIntegrationTest::toURL).filter(Optional::isPresent)
              .map(Optional::get).findFirst().get();
          String expectedFieldValue = splitQuery(impressionUrl).get(fieldName).get(0);

          //---------------------checks-------------------------
            Stream<List<String>> steamList = sut.logFor(logType).actual();
            sut.write("The expected field value of the logType "+logType+" is: " + expectedFieldValue);
            steamList.forEach(m-> sut.write("The actual field value of the logType "+logType+" is: "+ m.get(column)));
          //---------------------checks-------------------------

          assertThat(sut.logFor(logType).actual(),
              StreamMatchers.allMatch(ListItemAt.theItemAt(column, is(expectedFieldValue))));
        });
      And("The field (\\w+) in the (\\d+) column of the (clk|imp|req) log is \\{([^}]+)\\}",
              (String fieldName, Integer column, String logType, String value) -> {
                  sut.logFor(logType).actual().forEach(m-> sut.write("value of experiment selected is: "+m.get(column)));
                  assertThat(sut.logFor(logType).actual(),
                          StreamMatchers.allMatch(ListItemAt.theItemAt(column, is(value))));

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

    When("^I send click requests to UAS$", () -> {
      HttpClient httpclient = HttpClients.custom()
          .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(60000).build()).build();
      sut.getUASRquestModule().responses().map(UASIntegrationTest::getClickUrl).map(CompletableFuture::join)
          .map(UASIntegrationTest::toURL).filter(Optional::isPresent).map(Optional::get)
          .map(click -> CompletableFuture.supplyAsync(() -> {
            try {
              HttpResponse response = httpclient.execute(new HttpGet(click.toString()));
              if (response.getEntity() != null) {
                response.setEntity(new BufferedHttpEntity(response.getEntity()));
              }
              return response;
            } catch (IOException e) {
              throw new UncheckedIOException("failed to send request (" + click + ") ", e);
            }

          })).map(CompletableFuture::join).map(HttpResponse::getStatusLine).map(StatusLine::getStatusCode)
          .forEach(statusCode -> {
            assertThat("Status code of impression request", statusCode, is(200));
          });
    });

    Given("I use \\{([^}]+)\\} as user-agent string to send my requests to uas", (String userAgentStr) -> {
      sut.getUASRquestModule().addHttpHeader("User-Agent", userAgentStr);
    });

    Given("I add (\\w+) query parameter with value \\{([^}]+)\\} to send my requests to uas",
        (String paramName, String paramValue) -> {
          sut.getUASRquestModule().addQueryParam(paramName, paramValue);
        });

    Then("I reset the http headers sent to uas$", () -> {
      sut.getUASRquestModule().emptyHttpHeaders();
    });

    Then("The passback ratio should be (\\d+)%", (Integer percentage) -> {
      long total = sut.getUASRquestModule().responses().count();
      long numOfPassbacks = sut.getUASRquestModule().responses()
          .filter(fh -> (!(HttpContentTest.getContent(fh.join()).contains("/l?bannerid=")))).count();
      double actualRatio = numOfPassbacks / (double) total;
      final double neededRatio = percentage / 100.0;
      assertEquals("Total passbacks is: " + numOfPassbacks + " out of " + total + " responses", neededRatio,
          actualRatio, 0.1);
    });

    And("^I sleep for (\\d+) seconds$", (Integer seconds) -> {
      sut.write("sleeping " + seconds + " seconds");
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
      return  Arrays.stream(url.getQuery().split("&")).map(UASIntegrationTest::splitQueryParameter).collect(
        groupingBy(SimpleImmutableEntry::getKey, LinkedHashMap::new, mapping(Map.Entry::getValue, toList())));
  }

  public static SimpleImmutableEntry<String, String> splitQueryParameter(String it) {
    final int idx = it.indexOf("=");
    final String key = idx > 0 ? it.substring(0, idx) : it;
    final String value = idx > 0 && it.length() > idx + 1 ? it.substring(idx + 1) : null;
    return new SimpleImmutableEntry<>(key, value);
  }
//Sahar's checks (was private)
  public static CompletableFuture<Optional<String>> getImpressionUrl(CompletableFuture<HttpResponse> future) {
    return future.thenApply(UASRequestModule::getImpressionUrlFrom);
  }

   private static Optional<String> parsableClickUrl(Optional<String> originalClickUrl) {
    return originalClickUrl.map(s -> s.replaceAll("__", "&"));
  }

  private static CompletableFuture<Optional<String>> getClickUrl(CompletableFuture<HttpResponse> future) {
    return future.thenApply(UASRequestModule::getClickUrlFrom);
  }

  private void sendMultipleAdRequests(Integer times, String zoneByName, boolean toReset) {
    Zone zone = sut.getCampaignManager().getZone(zoneByName)
        .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
    sut.getUASRquestModule().zoneRequests(zone.getId(), times, toReset);
  }

    private void sendMultipleAdRequestsWithParameter(Integer times,String parameter, String zoneByName, boolean toReset) {
        Zone zone = sut.getCampaignManager().getZone(zoneByName)
                .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
        sut.getUASRquestModule().zoneRequestsWithParameter(zone.getId(),parameter, times, toReset);
    }

    private void sendMultipleZoneIDAdRequestsWithParameter(Integer times,String parameter, Integer zoneID, boolean toReset)
    {
        sut.getUASRquestModule().zoneRequestsWithParameter(zoneID,parameter, times, toReset);
    }


  private void sendMultipleAdRequestsWithParams(Integer times, String zoneByName, boolean toReset) {
    Zone zone = sut.getCampaignManager().getZone(zoneByName)
        .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
    sut.getUASRquestModule().zoneRequestsWithParams(zone.getId(), times, toReset);
  }

  private void sendMultipleAdRequests(Integer times, Integer zoneId, boolean toReset) {
    sut.getUASRquestModule().zoneRequests(zoneId, times, toReset);
  }

  public static LongAdder sendImpressionRequestsToUASImmediately() {
    ExecutorService impExecutorService =
        Executors.newFixedThreadPool(5, new ThreadFactoryBuilder().setNameFormat("Impression Sender").build());
    HttpClient httpclient = HttpClients.custom()
        .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(5000).build()).build();
    LongAdder impressionsSent = new LongAdder();
    final HttpClientContext ctx = sut.getContext();
    sut.getUASRquestModule().responses().parallel().map(UASIntegrationTest::getImpressionUrl)
        .forEach(cf -> cf.whenCompleteAsync((impurl, th) -> {
          if (th == null) {
            impurl.flatMap(sut.getUASRquestModule()::getImpressionUrl).ifPresent(url -> {
              url = (url.contains("stid=")) ? url.replaceAll("&stid=0", "&stid=999") : url.concat("&stid=999");
              try {
                HttpResponse response = httpclient.execute(new HttpGet(url),ctx);
                int sc = response.getStatusLine().getStatusCode();
                if (sc == 204) {
                  impressionsSent.increment();
                }
                if (response.getEntity() != null) {
                  response.setEntity(new BufferedHttpEntity(response.getEntity()));
                }
              } catch (IOException e) {
                throw new UncheckedIOException("failed to send request (" + url + ") ", e);
              }
            });
          }
        }, impExecutorService).join());
    return impressionsSent;
  }
    public void checkTheNumberOfSelectedEntity(String urlType, String fieldName, String entityType, String entityName, Double percent)
    {
        if(sut.getUASRquestModule().getSynchronizedResponses().size()==0)
            checkTheNumberOfSelectedEntityOfAsyncResponses(urlType,fieldName,entityType,entityName,percent);
        else
            checkTheNumberOfSelectedEntityOfSyncronizedResponses(urlType,fieldName,entityType,entityName,percent);
    }

    private void checkTheNumberOfSelectedEntityOfSyncronizedResponses(String urlType, String fieldName, String entityType, String entityName, Double percent) {
        assertThat(entityType, isOneOf("campaign", "banner", "zone"));
        assertThat(urlType, is("impression"));
        Optional<? extends WithId<Integer>> expectedEntity = sut.getCampaignManager().getterFor(entityType)
                .apply(entityName);
        assertThat("Could not find " + entityType + " named " + entityName, expectedEntity,
                is(not(OptionalMatchers.empty())));
        Map<Integer, Long> theAmountOfTheOccurencesOfTheFieldValueById;
        theAmountOfTheOccurencesOfTheFieldValueById = sut.getUASRquestModule().getSynchronizedResponses().stream()
                .map(UASRequestModule::getImpressionUrlFrom).map(UASIntegrationTest::toURL)
                .filter(Optional::isPresent).map(Optional::get).map(UASIntegrationTest::splitQuery)
                .flatMap(m -> m.entrySet().stream()).filter(entry -> fieldName.equals(entry.getKey()))
                .flatMap(entry -> entry.getValue().stream())
                .collect(Collectors.groupingBy(Integer::parseInt, Collectors.counting()));

        assertThat(urlType + " urls grouped by " + fieldName,
                theAmountOfTheOccurencesOfTheFieldValueById.keySet(), is(not(empty())));

        long totalResponses = sut.getUASRquestModule().getSynchronizedResponses().stream().count();
        assertThat("total responses", totalResponses, greaterThan(0L));

        double actualRate = theAmountOfTheOccurencesOfTheFieldValueById
                .getOrDefault(expectedEntity.get().getId(), 0L).doubleValue() / totalResponses;

        //*sahar: printing the map
        theAmountOfTheOccurencesOfTheFieldValueById.forEach((k,v)->sut.write("Item : " + k + " Count : " + v));
        assertEquals("rate of " + fieldName + " in impression urls", percent.doubleValue(),
                actualRate * 100, 10d);

    }

    private void checkTheNumberOfSelectedEntityOfAsyncResponses(String urlType, String fieldName, String entityType, String entityName, Double percent) {
        Function<CompletableFuture<HttpResponse>, CompletableFuture<Optional<String>>> urlExtractor = null;
        if (urlType.equalsIgnoreCase("impression")) {
            urlExtractor = UASIntegrationTest::getImpressionUrl;
        } else if (urlType.equalsIgnoreCase("click")) {
            urlExtractor = UASIntegrationTest::getClickUrl;
            urlExtractor = urlExtractor.andThen(cf -> {
                CompletableFuture<Optional<String>> fixedOptionalUrlCF = cf
                        .thenApply(UASIntegrationTest::parsableClickUrl);
                return fixedOptionalUrlCF;
            });
        }

        assertThat(entityType, isOneOf("campaign", "banner", "zone"));
        Optional<? extends WithId<Integer>> expectedEntity = sut.getCampaignManager().getterFor(entityType)
                .apply(entityName);
        assertThat("Could not find " + entityType + " named " + entityName, expectedEntity,
                is(not(OptionalMatchers.empty())));
        Map<Integer, Long> theAmountOfTheOccurencesOfTheFieldValueById;
        theAmountOfTheOccurencesOfTheFieldValueById = sut.getUASRquestModule().responses()
                .map(urlExtractor).map(CompletableFuture::join).map(UASIntegrationTest::toURL)
                .filter(Optional::isPresent).map(Optional::get).map(UASIntegrationTest::splitQuery)
                .flatMap(m -> m.entrySet().stream()).filter(entry -> fieldName.equals(entry.getKey()))
                .flatMap(entry -> entry.getValue().stream())
                .collect(Collectors.groupingBy(Integer::parseInt, Collectors.counting()));

        assertThat(urlType + " urls grouped by " + fieldName,
                theAmountOfTheOccurencesOfTheFieldValueById.keySet(), is(not(empty())));

        long totalResponses = sut.getUASRquestModule().responses().filter(succeededFuture).count();
        assertThat("total responses", totalResponses, greaterThan(0L));

        double actualRate = theAmountOfTheOccurencesOfTheFieldValueById
                .getOrDefault(expectedEntity.get().getId(), 0L).doubleValue() / totalResponses;

        //*sahar: printing the map
        theAmountOfTheOccurencesOfTheFieldValueById.forEach((k,v)->sut.write("Item : " + k + " Count : " + v));
        assertEquals("rate of " + fieldName + " in impression urls", percent.doubleValue(),
                actualRate * 100, 10d);
    }
}

