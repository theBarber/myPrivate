package steps;

import co.unruly.matchers.OptionalMatchers;
import co.unruly.matchers.StreamMatchers;
import com.google.common.util.concurrent.ThreadFactoryBuilder;
import cucumber.api.CucumberOptions;
import cucumber.api.PendingException;
import cucumber.api.junit.Cucumber;
import entities.Banner;
import entities.Campaign;
import entities.Zone;
import infra.assertion.ListItemAt;
import infra.cli.process.CliCommandExecution;
import infra.module.WithId;
import infra.support.StringUtils;
import infra.utils.HttpContentTest;
import model.Country;
import model.ResponseType;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;
import ramp.lift.uas.automation.UASRequestModule;
import util.api.UasApi;
import util.TestsRoutines;

import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.AbstractMap.SimpleImmutableEntry;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.LongAdder;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static java.util.stream.Collectors.*;
import static org.hamcrest.Matchers.*;
import static org.junit.Assert.*;


/**
 * Created by noam on 29/09/16.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:UASIntegration.feature", plugin = {"pretty",})
//    "infra.RotatingJSONFormatter:target/cucumber/uas-adselector-integration_$TIMESTAMP$.json"})
public class UASIntegrationTest extends BaseTest {

    public UASIntegrationTest() {
        super();
        final Integer BID_ID_COLUMN = 30;
        When("I send an ad request for zone named \\{(.*)\\} to UAS", (String zoneByName) -> {
            Zone zone = sut.getExecutorCampaignManager().getZone(zoneByName)
                    .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
            sut.getUASRquestModule().zoneRequest(zone.getId());
        });


        And("The response has a moat wrapper with params advanced string with advertiserid = (\\d+), ioid = (\\d+), iolineitemid = (\\d+), bannername = \\{(.*)\\}, campaignname = \\{(.*)\\}, zonename = \\{(.*)\\}, MoatWEBID = (\\d+)",
                this::healthCheckResponseContainsParams);


        When("I send (\\d+) times an ad request for zone named \\{(.*)\\} to UAS",
                (Integer times, String zoneByName) -> {
                    sendMultipleAdRequests(times, zoneByName, true);
                });

        When("I send (\\d+) times an ad request with parameter \\{(.*)\\} for zone id \\{(\\d+)\\} to UAS",
                (Integer times, String parameter, Integer zoneId) -> {
                    sendMultipleZoneIDAdRequestsWithParameter(times, parameter, zoneId, true);
                });

        When("I send (\\d+) times an ad request with parameter? \\{(.*)\\} for zone named? \\{(.*)\\} to UAS$",
                (Integer times, String parameter, String zoneByName) -> {
                    sendMultipleAdRequestsWithParameter(times, parameter, zoneByName, true);
                });

        When("I send (\\d+) times an ad video request with parameter? \\{(.*)\\} for zone named? \\{(.*)\\} to UAS$",
                (Integer times, String parameter, String zoneByName) -> {
                    sendMultipleAdRequestsWithParameterAndRoute(times, parameter, zoneByName, "ax", true);
                });

        When("I send a req to ramp api for creating a placment group for publisher \\{(\\d+)\\} with ad units = \\{(.*)\\} where placement ID = \\{(.*)\\}",
                this::sendPlacementGroupReqToRampAPI);

        When("I send (\\d+) times a (wel|prfLog|eve) request with parameters \\{(.*)\\} to UAS",
                (Integer times, String requestType, String parameters) -> {
                    sut.getUASRquestModule().sendMultipleTypeGetRequestWithParameter(requestType, times, parameters, true, false);
                });

        When("I send (\\d+) times a (profile) post request with parameters \\{(.*)\\} to UAS with body: (.*)$",
                (Integer times, String requestType, String parameters, String body) -> {
                    sut.getUASRquestModule().sendMultipleTypePostRequestWithParameter(requestType, body, times, parameters, true, false, false);
                });

        When("I send (\\d+) times an ad request with query parameters for zone named \\{(.*)\\} to UAS",
                (Integer times, String zoneByName) -> {
                    sendMultipleAdRequestsWithParams(times, zoneByName, true);
                });

        When("I send (\\d+) times an ad request with query parameters for zone id \\{(.*)\\} to UAS",
                (Integer times, Integer zoneId) -> {
                    sut.getUASRquestModule().zoneRequestsWithParams(zoneId, times, true);
                });


        And("i set new generic cookie", () ->
                sut.getUASRquestModule().setGenericCookie());

        When("I send ad requests I sleep (\\d+) millis",
                (Long millis) -> {
                    sut.getUASRquestModule().thatSleeps(millis);
                });
        When("I send (\\d+) times an ad request for zone id (\\d+) to UAS",
                (Integer times, Integer zoneId) -> {
                    sendMultipleAdRequests(times, zoneId, true);
                });

        //%%%%%%%%%%%%%%%%%   Testing %%%%%%%%%%%%%%%%
        When("I send (\\d+) times video ad request with parameter? \\{(.*)\\} for zone id (\\d+) to UAS",
                (Integer times,String parameter, Integer zoneId) -> {
            //(Integer times,String parameter, Integer zoneId,String route, boolean toReset)
                    sendMultipleAdRequestsWithRoute(times, parameter, zoneId,"ax", true);
                });


        When("I send (\\d+) times display ad request with parameter? \\{(.*)\\} for zone id (\\d+) to UAS",
                (Integer times,String parameter, Integer zoneId) -> {
                    //(Integer times,String parameter, Integer zoneId,String route, boolean toReset)
                    sendMultipleAdRequestsWithRoute(times, parameter, zoneId,"af", true);
                });
        //%%%%%%%%%%%%%%%%%   Testing %%%%%%%%%%%%%%%%


        When("I send (\\d+) additional ad requests for zone named \\{(.*)\\} to UAS",
                (Integer times, String zoneByName) -> {
                    sendMultipleAdRequests(times, zoneByName, false);
                });

        When("I send (\\d+) additional ad requests with query parameters for zone named \\{(.*)\\} to UAS",
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
        Then("The response(s) has impression-url(s)", () -> {
            TestsRoutines.verifyResponse(ResponseType.IMPRESSIONS);
        });

        Then("The response(s) has click-url(s)", () -> {
            TestsRoutines.verifyResponse(ResponseType.CLICKS);
        });

        Then("The response(s) has complete-url(s)", () -> {
            assertTrue("all of the responses should have a url", sut.getUASRquestModule().responses()
                    .map(UASIntegrationTest::getCompleteUrl).map(CompletableFuture::join).allMatch(Optional::isPresent));
        });

        Then("The responses(s) has mute-urls(s)", () -> {
            assertTrue("all of the responses should have a url", sut.getUASRquestModule().responses()
                    .map(UASIntegrationTest::getMuteUrl).map(CompletableFuture::join).allMatch(Optional::isPresent));
        });

        Then("The response(s) has dsp-url(s)", () -> {
            assertTrue("all of the responses should have a url", sut.getUASRquestModule().responses()
                    .map(UASIntegrationTest::getDspUrl).map(CompletableFuture::join).allMatch(Optional::isPresent));
        });

        Then("The response(s) are passback", () -> {
            TestsRoutines.verifyResponse(ResponseType.PASSBACK);
        });


        Then("The synchronized responses are passback", () -> {

            Map<Boolean, Long> countUrls =
                    sut.getUASRquestModule().getSynchronizedResponses()
                            .stream().map(UASRequestModule::getImpressionUrlFrom).collect(Collectors.groupingBy(Optional::isPresent, Collectors.counting()));

            assertThat(
                    "all of the synchronized responses should not have an impression url", countUrls.getOrDefault(true, 0l),
                    Matchers.is(0l));
        });

        //
        // When("I send a request to the first the imperssion urls", ()->{
        // uas.get().responses()
        // .map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join)
        // .map(UASIntegrationTest::toURL).filter(Optional::isPresent).map(Optional::get).findFirst().
        //
        // });
        Then("The (\\w+)Url has (\\w+) field matching the id of the (\\w+) named \\{(.*)\\} (\\d+)% of the time", this::checkTheNumberOfSelectedEntity);
        When("^I read the latest (clk|imp|req|hbl|wel|evt|prf) log file from uas$", (String logType) -> {
            //---------------------checks-------------------------
//        sut.logFor(logType).readLogs().actual().forEach(m->{
//            StringBuilder stringBuilder = new StringBuilder();
//            for (int i = 0; i < m.size(); i++) {
//                stringBuilder.append(m.get(i)).append("\t");
//            }
//            sut.write(stringBuilder.toString());
//        } );
            //---------------------checks-------------------------
            assertThat(logType + "log file", sut.logFor(logType).readLogs().actual(), is(not(StreamMatchers.empty())));
        });
        When("For bidID (\\w+) The field (\\w+) in the (\\d+) column of the (hbl) log is: (.*)$", (String bidId, String fieldName, Integer column, String logType, String value) -> {
            sut.logFor(logType).filter(raw -> bidId.equals(raw.get(BID_ID_COLUMN)));
            //for debug
            sut.logFor(logType).actual().filter(raw -> bidId.equals(raw.get(BID_ID_COLUMN))).forEach(m -> sut.write("value of " + fieldName + " selected is: " + m.get(column)));

            assertThat("the log " + logType + " should contain a line with bidid" + bidId + " at column "
                    + BID_ID_COLUMN, sut.logFor(logType).actual(), is(not(StreamMatchers.empty())));
            assertThat(sut.logFor(logType).actual(),
                    StreamMatchers.allMatch(ListItemAt.theItemAt(column, is(value))));
        });

        Then("^I filter in the (clk|imp|req|hbl|wel|evt|prf) log to the lines where id at column (\\d+) is the same as in impression-url$",
                (String logType, Integer column) -> {
                    // for checks only
            /*sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
                sut.write(content);
            });*/
                    // for checks only
                    Optional<URL> impressionUrl = sut.getUASRquestModule().responses().map(UASIntegrationTest::getImpressionUrl)
                            .map(CompletableFuture::join).map(UASIntegrationTest::toURL).filter(Optional::isPresent)
                            .map(Optional::get).findFirst();

                    if (impressionUrl.isPresent()) {
                        //sut.write(impressionUrl.toString());
                        String idFieldValue = splitQuery(impressionUrl.get()).get("id").get(0);
                        //---------------------checks-------------------------------------------------------------------------------------------
                        //            Stream<List<String>> steamList = sut.logFor(logType).actual();
                        //            sut.write("The expected field value of the logType "+logType+" is: " +  idFieldValue);
                        //            steamList.forEach(m-> sut.write("The actual field value of the logType "+logType+" is: "+ m.get(column)));
                        //---------------------checks--------------------------------------------------------------------------------------------
                        sut.logFor(logType).filter(raw -> idFieldValue.equals(raw.get(column)));
                        assertThat("the log " + logType + " should contain a line with " + idFieldValue + " at column "
                                + column, sut.logFor(logType).actual(), is(not(StreamMatchers.empty())));
                    } else {
                        throw new AssertionError("impression url wasn't found");
                    }
                });


        And("The field (\\w+) in the (\\d+) column of the (clk|imp|req|hbl) log is the same as in impression-url",
                (String fieldName, Integer column, String logType) -> {
                    URL impressionUrl = sut.getUASRquestModule().responses().map(UASIntegrationTest::getImpressionUrl)
                            .map(CompletableFuture::join).map(UASIntegrationTest::toURL).filter(Optional::isPresent)
                            .map(Optional::get).findFirst().get();
                    String expectedFieldValue = splitQuery(impressionUrl).get(fieldName).get(0);

                    //---------------------checks-------------------------
                    Stream<List<String>> steamList = sut.logFor(logType).actual();
                    sut.write("The expected field value of the logType " + logType + " is: " + expectedFieldValue);
                    steamList.forEach(m -> sut.write("The actual field value of the logType " + logType + " is: " + m.get(column)));
                    //---------------------checks-------------------------

                    assertThat(sut.logFor(logType).actual(),
                            StreamMatchers.allMatch(ListItemAt.theItemAt(column, is(expectedFieldValue))));
                });

        And("The field (\\w+) in the (\\d+) column of the (clk|imp|req|hbl|wel|evt|prf) log is: (.*)$",
                (String fieldName, Integer column, String logType, String value) -> {
                    sut.logFor(logType).actual().forEach(m -> sut.write("value of " + fieldName + " selected is: " + m.get(column)));
                    assertThat(sut.logFor(logType).actual(),
                            StreamMatchers.allMatch(ListItemAt.theItemAt(column, is(value))));

                });


        And("The field (\\w+) in the (\\d+) column of the (clk|imp|req|hbl|wel|evt|prf) log is not: (.*)$",
                (String fieldName, Integer column, String logType, String value) -> {

                    sut.logFor(logType).actual().forEach(m -> sut.write("value of " + fieldName + " selected is: " + m.get(column)));
                    assertThat(sut.logFor(logType).actual(),
                            StreamMatchers.allMatch(ListItemAt.theItemAt(column, not(value))));

                });

        When("I want to use cli to execute \\{(.*)\\}", (String cmd) -> {
            sut.uasCliConnections().forEach(conn -> {
                try {
                    new CliCommandExecution(conn, cmd).execute();
                } catch (IOException e) {
                    fail(e.getMessage());
                }
            });
        });

        When("^I send impression requests to UAS$", () -> {
            final HttpClientContext ctx = sut.getContext();
            System.out.println(ctx.getCookieStore());
            HttpClient httpclient = HttpClients.custom().setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(1000).build()).build();
            sut.getUASRquestModule().responses().map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join)
                    .map(UASIntegrationTest::toURL).filter(Optional::isPresent).map(Optional::get)
                    .map(impurl -> CompletableFuture.supplyAsync(() -> {
                        try {
                            sut.write("impression to send = " + impurl.toString());
                            HttpGet httpGet = new HttpGet(impurl.toString());
                            List<Header> httpHeaders = sut.getUASRquestModule().getHttpHeaders();
                            httpGet.setHeaders(httpHeaders.toArray(new Header[httpHeaders.size()]));
                            HttpResponse response = httpclient.execute(httpGet, ctx);
                            try {
                                TimeUnit.SECONDS.sleep(1);
                            } catch (InterruptedException e) {
                                fail(e.getMessage());
                            }
                            if (response.getEntity() != null) {
                                response.setEntity(new BufferedHttpEntity(response.getEntity()));
                                InputStream is = response.getEntity().getContent();
                                BufferedReader buffer = new BufferedReader(new InputStreamReader(is));
                                String str = buffer.lines().collect(Collectors.joining("\n"));
                                sut.write("req: " + impurl.toString() + " response : \n" + str);
                            }
                            return response;
                        } catch (IOException e) {
                            throw new UncheckedIOException("failed to send request (" + impurl.toString() + ") ", e);
                        }

                    })).map(CompletableFuture::join).map(HttpResponse::getStatusLine).map(StatusLine::getStatusCode)
                    .forEach(statusCode -> {
                        System.out.println("the status code is ---> " + statusCode);
                        assertThat("Status code of impression request", statusCode, is(204));
                    });
        });

        When("^I send click requests to UAS$", () -> {
            final HttpClientContext ctx = sut.getContext();
            HttpClient httpclient = HttpClients.custom()
                    .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(60000).build()).build();
            sut.getUASRquestModule().responses().map(UASIntegrationTest::getClickUrl).map(CompletableFuture::join)
                    .map(UASIntegrationTest::toURL).filter(Optional::isPresent).map(Optional::get)
                    .map(click -> CompletableFuture.supplyAsync(() -> {
                        try {
                            System.out.println(click);
                            HttpGet httpGet = new HttpGet(click.toString());
                            List<Header> httpHeaders = sut.getUASRquestModule().getHttpHeaders();
                            httpGet.setHeaders(httpHeaders.toArray(new Header[httpHeaders.size()]));
                            HttpResponse response = httpclient.execute(httpGet, ctx);
                            if (response.getEntity() != null) {
                                response.setEntity(new BufferedHttpEntity(response.getEntity()));
                            } else {
                                response.setEntity(new StringEntity(""));
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

        When("^I send complete requests to UAS$", () -> {
            final HttpClientContext ctx = sut.getContext();
            HttpClient httpclient = HttpClients.custom()
                    .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(60000).build()).build();
            sut.getUASRquestModule().responses().map(UASIntegrationTest::getCompleteUrl).map(CompletableFuture::join)
                    .map(UASIntegrationTest::toURL).filter(Optional::isPresent).map(Optional::get)
                    .map(click -> CompletableFuture.supplyAsync(() -> {
                        try {
                            System.out.println(click);
                            HttpGet httpGet = new HttpGet(click.toString());
                            List<Header> httpHeaders = sut.getUASRquestModule().getHttpHeaders();
                            httpGet.setHeaders(httpHeaders.toArray(new Header[httpHeaders.size()]));
                            HttpResponse response = httpclient.execute(httpGet, ctx);
                            if (response.getEntity() != null) {
                                response.setEntity(new BufferedHttpEntity(response.getEntity()));
                            } else {
                                response.setEntity(new StringEntity(""));
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

        When("^I send mute requests to UAS$", () -> {
            final HttpClientContext ctx = sut.getContext();
            HttpClient httpclient = HttpClients.custom()
                    .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(60000).build()).build();
            sut.getUASRquestModule().responses().map(UASIntegrationTest::getMuteUrl).map(CompletableFuture::join)
                    .map(UASIntegrationTest::toURL).filter(Optional::isPresent).map(Optional::get)
                    .map(click -> CompletableFuture.supplyAsync(() -> {
                        try {
                            System.out.println(click);
                            HttpGet httpGet = new HttpGet(click.toString());
                            List<Header> httpHeaders = sut.getUASRquestModule().getHttpHeaders();
                            httpGet.setHeaders(httpHeaders.toArray(new Header[httpHeaders.size()]));
                            HttpResponse response = httpclient.execute(httpGet, ctx);
                            if (response.getEntity() != null) {
                                response.setEntity(new BufferedHttpEntity(response.getEntity()));
                            } else {
                                response.setEntity(new StringEntity(""));
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

        Given("I use \\{(.*)\\} as user-agent string to send my requests to uas", (String userAgentStr) -> {
            sut.getUASRquestModule().addHttpHeader("User-Agent", userAgentStr);
        });

        Given("I add header of \\{(.*)\\} with value \\{(.*)\\}", (String key, String value) -> {
            sut.getUASRquestModule().addHttpHeader(key, value);
        });

        Given("I use \\{(.*)\\} as referer string to send my requests to uas", (String referer) -> {
            sut.getUASRquestModule().emptyHttpHeaders();
            sut.getUASRquestModule().addHttpHeader("referer", referer);
        });

        Given("I add (\\w+) query parameter with value \\{(.*)\\} to send my requests to uas",
                (String paramName, String paramValue) -> {
                    sut.getUASRquestModule().addQueryParam(paramName, paramValue);
                });

        Then("^I reset the http headers sent to uas$", () -> {
            TestsRoutines.resetHeaders();
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
        Then("^i simulate appnexus passback response from the responses and send them to the UAS$", () -> {
            List<CompletableFuture<HttpResponse>> response = new ArrayList<>(sut.getUASRquestModule().responsesAsList());
            response.stream().map(UASIntegrationTest::getDspUrl).map(CompletableFuture::join).map(UASIntegrationTest::toURL).filter(Optional::isPresent)
                    .map(Optional::get).map(UASIntegrationTest::getAppnexusPassbackURL).forEach(url -> {
                        System.out.println(url);
                        sut.getUASRquestModule().sendGetRequestsAsync(1, url, false);
                    }
            );
        });
        Given("^i reset responses in the UAS$", () -> {
            sut.getUASRquestModule().reset();
        });
        And("^i print the responses$", () -> {
            sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
                System.out.println(content);
            });
        });

    }

    private static String getAppnexusPassbackURL(URL dspURL) {
        Map<String, List<String>> splitedQuery = splitQuery(dspURL);
        return new StringBuilder().append("http://").append(sut.getUASRquestModule().getDomain())
                .append(Optional.ofNullable(sut.getUASRquestModule().getPort()).filter(s -> !s.isEmpty()).map(s -> ":" + s).orElse(""))
                .append("/aj?").append("zoneid=").append(splitedQuery.get("pt5").get(0)).append("&pb_id=").append(splitedQuery.get("pt2").get(0))
                .append("&pb_bannerid=").append(splitedQuery.get("pt3").get(0)).append("&pb_bk=").append(splitedQuery.get("pt4").get(0))
                .append("&pb_campaignid=").append(splitedQuery.get("pt1").get(0)).append("&pb_ca=").append(splitedQuery.get("pt6").get(0))
                .append("&pb_ctried=").append(splitedQuery.get("pt8").get(0)).append("&pb_stid=").append(splitedQuery.get("pt9").get(0)).append("&link=1&pg=1").toString();
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
            //System.out.println("query is null");
            return Collections.emptyMap();
        }
        // System.out.println("query is ok");
        return Arrays.stream(url.getQuery().split("&")).map(UASIntegrationTest::splitQueryParameter).collect(
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

    public static CompletableFuture<Optional<String>> getRenderUrl(CompletableFuture<HttpResponse> future) {
        return future.thenApply(UASRequestModule::getRenderUrlFrom);
    }

    private static Optional<String> parsableClickUrl(Optional<String> originalClickUrl) {
        return originalClickUrl.map(s -> s.replaceAll("__", "&"));
    }

    public static CompletableFuture<Optional<String>> getClickUrl(CompletableFuture<HttpResponse> future) {
        return future.thenApply(UASRequestModule::getClickUrlFrom);
    }

    private static CompletableFuture<Optional<String>> getFirstQuartileUrl(CompletableFuture<HttpResponse> future) {
        return future.thenApply(UASRequestModule::getFirstQuartileUrlFrom);
    }

    private static CompletableFuture<Optional<String>> getMidpointUrl(CompletableFuture<HttpResponse> future) {
        return future.thenApply(UASRequestModule::getMidpointUrlFrom);
    }

    private static CompletableFuture<Optional<String>> getThirdQuartileUrl(CompletableFuture<HttpResponse> future) {
        return future.thenApply(UASRequestModule::getThirdQuartileUrlFrom);
    }

    private static CompletableFuture<Optional<String>> getCompleteUrl(CompletableFuture<HttpResponse> future) {
        return future.thenApply(UASRequestModule::getCompleteUrlFrom);
    }

    private static CompletableFuture<Optional<String>> getPauseUrl(CompletableFuture<HttpResponse> future) {
        return future.thenApply(UASRequestModule::getPauseUrlFrom);
    }

    private static CompletableFuture<Optional<String>> getMuteUrl(CompletableFuture<HttpResponse> future) {
        return future.thenApply(UASRequestModule::getMuteUrlFrom);
    }

    private static CompletableFuture<Optional<String>> getCloseUrl(CompletableFuture<HttpResponse> future) {
        return future.thenApply(UASRequestModule::getCloseUrlFrom);
    }

    private static CompletableFuture<Optional<String>> getStartUrl(CompletableFuture<HttpResponse> future) {
        return future.thenApply(UASRequestModule::getStartUrlFrom);
    }

    private static CompletableFuture<Optional<String>> getUnMuteUrl(CompletableFuture<HttpResponse> future) {
        return future.thenApply(UASRequestModule::getUnMuteUrlFrom);
    }

    private static CompletableFuture<Optional<String>> getDspUrl(CompletableFuture<HttpResponse> future) {
        return future.thenApply(UASRequestModule::getdspUrlFrom);
    }

    private void sendMultipleAdRequests(Integer times, String zoneByName, boolean toReset) {
        Zone zone = sut.getExecutorCampaignManager().getZone(zoneByName)
                .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
        sut.getUASRquestModule().zoneRequests(zone.getId(), times, toReset);
    }

    private void sendMultipleAdRequestsWithParameter(Integer times, String parameter, String zoneByName, boolean toReset) {
        Zone zone = sut.getExecutorCampaignManager().getZone(zoneByName)
                .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
        sut.getUASRquestModule().zoneRequestsWithParameter(zone.getId(), parameter, times, toReset);
    }

    private void sendMultipleAdRequestsWithParameterAndRoute(Integer times, String parameter, String zoneByName, String route, boolean toReset) {
        Zone zone = sut.getExecutorCampaignManager().getZone(zoneByName)
                .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
        sut.getUASRquestModule().zoneRequestsWithParameterAndRoute(zone.getId(), parameter, route, times, toReset);
    }

    private void sendPlacementGroupReqToRampAPI(Integer publisher, String aduits, String placementID) {
        String url = placementID + publisher + aduits;
        sut.getUASRquestModule().getRequest(url);
    }


    private void sendMultipleZoneIDAdRequestsWithParameter(Integer times, String parameter, Integer zoneID, boolean toReset) {
        UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, parameter, zoneID, toReset);
    }


    private void sendMultipleAdRequestsWithParams(Integer times, String zoneByName, boolean toReset) {
        Zone zone = sut.getExecutorCampaignManager().getZone(zoneByName)
                .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
        sut.getUASRquestModule().zoneRequestsWithParams(zone.getId(), times, toReset);
    }

    private void sendMultipleAdRequests(Integer times, Integer zoneId, boolean toReset) {
        sut.getUASRquestModule().zoneRequests(zoneId, times, toReset);
    }

    private void sendMultipleAdRequestsWithRoute(Integer times,String parameter, Integer zoneId,String route, boolean toReset) {
        sut.getUASRquestModule().zoneRequestsWithParameterAndRoute(zoneId,parameter, route, times, toReset);
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
                                //sut.write("the impression url sent is: " + url);
                                HttpGet httpGet = new HttpGet(url);
                                HttpResponse response = httpclient.execute(httpGet, ctx);
                                int sc = response.getStatusLine().getStatusCode();
                                if (sc == 204) {
                                    impressionsSent.increment();
                                }
                                if (response.getEntity() != null) {
                                    response.setEntity(new BufferedHttpEntity(response.getEntity()));
                                } else {
                                    response.setEntity(new StringEntity(""));
                                }
                            } catch (IOException e) {
                                throw new UncheckedIOException("failed to send request (" + url + ") ", e);
                            }
                        });
                    }
                }, impExecutorService).join());
        return impressionsSent;
    }

    public void checkTheNumberOfSelectedEntity(String urlType, String fieldName, String entityType, String entityName, Integer percent) {
        if (sut.getUASRquestModule().getSynchronizedResponses().size() == 0)
            checkTheNumberOfSelectedEntityOfAsyncResponses(urlType, fieldName, entityType, entityName, percent);
        else
            checkTheNumberOfSelectedEntityOfSyncronizedResponses(urlType, fieldName, entityType, entityName, percent);
    }

    private void checkTheNumberOfSelectedEntityOfSyncronizedResponses(String urlType, String fieldName, String entityType, String entityName, Integer percent) {
        assertThat(entityType, isOneOf("campaign", "banner", "zone"));
        assertThat(urlType, is("impression"));
        Optional<? extends WithId<Integer>> expectedEntity = sut.getExecutorCampaignManager().getterFor(entityType)
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
        theAmountOfTheOccurencesOfTheFieldValueById.forEach((k, v) -> sut.write("Item : " + k + " Count : " + v));
        assertEquals("rate of " + fieldName + " in impression urls", percent.doubleValue(),
                actualRate * 100, 10d);

    }


    private synchronized void checkTheNumberOfSelectedEntityOfAsyncResponses(String urlType, String fieldName, String entityType, String entityName, Integer percent) {
        Function<CompletableFuture<HttpResponse>, CompletableFuture<Optional<String>>> urlExtractor = null;
        if (urlType.equalsIgnoreCase("impression")) {
            urlExtractor = UASIntegrationTest::getImpressionUrl;
        }
        else if (urlType.equalsIgnoreCase("render")){
            urlExtractor = UASIntegrationTest::getRenderUrl;
        }
        else if (urlType.equalsIgnoreCase("click")) {
            urlExtractor = UASIntegrationTest::getClickUrl;
            urlExtractor = urlExtractor.andThen(cf -> {
                CompletableFuture<Optional<String>> fixedOptionalUrlCF = cf
                        .thenApply(UASIntegrationTest::parsableClickUrl);
                return fixedOptionalUrlCF;
            });
        }
        else if (urlType.equalsIgnoreCase("firstQuartile")) {
            urlExtractor = UASIntegrationTest::getFirstQuartileUrl;
        }
        else if (urlType.equalsIgnoreCase("midpoint")) {
            urlExtractor = UASIntegrationTest::getMidpointUrl;
        }
        else if (urlType.equalsIgnoreCase("thirdQuartile")) {
            urlExtractor = UASIntegrationTest::getThirdQuartileUrl;
        }
        else if (urlType.equalsIgnoreCase("complete")) {
            urlExtractor = UASIntegrationTest::getCompleteUrl;
        } else if (urlType.equalsIgnoreCase("pause")) {
            urlExtractor = UASIntegrationTest::getPauseUrl;
        }
        else if (urlType.equalsIgnoreCase("mute")) {
            urlExtractor = UASIntegrationTest::getMuteUrl;
        }
        else if (urlType.equalsIgnoreCase("close")) {
            urlExtractor = UASIntegrationTest::getCloseUrl;
        }
        else if (urlType.equalsIgnoreCase("start")) {
            urlExtractor = UASIntegrationTest::getStartUrl;
        }
        else if (urlType.equalsIgnoreCase("unmute")) {
            urlExtractor = UASIntegrationTest::getUnMuteUrl;
        }


        assertThat(entityType, isOneOf("campaign", "banner", "zone"));
        Optional<? extends WithId<Integer>> expectedEntity = sut.getExecutorCampaignManager().getterFor(entityType)
                .apply(entityName);
        assertThat("Could not find " + entityType + " named " + entityName, expectedEntity,
                is(not(OptionalMatchers.empty())));
        Map<Integer, Long> theAmountOfTheOccurencesOfTheFieldValueById;
        theAmountOfTheOccurencesOfTheFieldValueById = sut.getUASRquestModule().responses()
                .map(urlExtractor)
                .map(CompletableFuture::join)
                .map(UASIntegrationTest::toURL)
                .filter(Optional::isPresent)
                .map(Optional::get)
                .map(UASIntegrationTest::splitQuery)
                .flatMap(m -> m.entrySet().stream())
                .filter(entry -> fieldName.equals(entry.getKey()))
                .flatMap(entry -> entry.getValue().stream())
                .collect(Collectors.groupingBy(Integer::parseInt, Collectors.counting()));

        assertThat(urlType + " urls grouped by " + fieldName,
                theAmountOfTheOccurencesOfTheFieldValueById.keySet(), is(not(empty())));

        long totalResponses = sut.getUASRquestModule().responses().filter(succeededFuture).count();
        assertThat("total responses", totalResponses, greaterThan(0L));

        double actualRate = theAmountOfTheOccurencesOfTheFieldValueById
                .getOrDefault(expectedEntity.get().getId(), 0L).doubleValue() / totalResponses;

        //*sahar: printing the map
        theAmountOfTheOccurencesOfTheFieldValueById.forEach((k, v) -> sut.write("Item : " + k + " Count : " + v));
        assertEquals("rate of " + fieldName + " in impression urls", percent.doubleValue(),
                actualRate * 100, 10d);
    }


    public void healthCheckResponseContainsParams(Integer advertiserid, Integer ioid, Integer iolineitemid, String bannername, String campaignname, String zoneByName, Integer publisherid) {
        String toCheck;
        Banner banner = sut.getExecutorCampaignManager().getBanner(bannername).orElseThrow(() -> new AssertionError("The banner " + bannername + " does not exist!"));
        Zone zone = sut.getExecutorCampaignManager().getZone(zoneByName).orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
        Campaign campaign = sut.getExecutorCampaignManager().getCampaign(campaignname).orElseThrow(() -> new AssertionError("The campaign " + campaignname + " does not exist!"));
        toCheck = "https://svastx.moatads.com/undertonevpaid8571606/template.xml";
        System.out.print("String expected string is =" + toCheck);
        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            Assert.assertThat(content, Matchers.containsString(toCheck));

        });
    }
}

