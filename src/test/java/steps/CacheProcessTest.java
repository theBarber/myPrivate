package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import gherkin.deps.com.google.gson.JsonArray;
import gherkin.deps.com.google.gson.JsonElement;
import gherkin.deps.com.google.gson.JsonParser;
import infra.cli.process.CliCommandExecution;
import infra.utils.JenkinsClient;
import infra.utils.SqlWorkflowUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.glassfish.jersey.client.ClientConfig;
import org.glassfish.jersey.client.ClientProperties;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UncheckedIOException;
import java.net.URI;
import java.util.Calendar;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static java.lang.Math.max;
import static org.hamcrest.Matchers.isOneOf;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;
//import static sun.swing.MenuItemLayoutHelper.max;



@CucumberOptions(features = "classpath:ZoneCacheProcess.feature", plugin = {"pretty",})
//    "infra.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json"})
@RunWith(Cucumber.class)

public class CacheProcessTest extends BaseTest {
    private final String BANNER_CACHE_NAME = "banners_cache_refresh_";
    public final String START_REFRESH_CACHE = "start refresh cache";
    private final static Integer LASTING_TIME_CACHE = 7;
  public CacheProcessTest() {
    super();


    And("I refresh? (.*) cache",this::refreshCache);
    And("I flush bucket name \\{(.*)\\} on couchbase", this::flushBucket);
    Given("^limitations for zoneId (\\d+) is \\{(.*)\\} in Workflow DB$",
        (Integer zoneId, String expectedLimitation) -> {
          String currentLimitation = SqlWorkflowUtils.getLimitationForZone(zoneId);
          sut.write(currentLimitation);
          Assert.assertThat(currentLimitation, Matchers.containsString(expectedLimitation));
        });
    And("^limitations for zoneId (\\d+) updated to \\{(.*)\\} in Workflow DB$",
        (Integer zoneId, String newLimitation) -> {
          SqlWorkflowUtils.setLimitationForZone(zoneId, newLimitation);
        });
    When("^zoneCache refreshed by cmd$", () -> {
      refreshZoneCache("cmd");
    });
    When("^zoneCache refreshed by http$", () -> {
      refreshZoneCache("http");
    });
    When("limitation for zone (.*) in zoneCache contains \\{(.*)\\}",
        (String zoneId, String expectedLimitation) -> {
          String zoneInfoCmd = "docker exec ut-ramp-uas  adserver --zone " + zoneId;
          sut.write(zoneInfoCmd);

          String actualLimitation = sut.uasCliConnections().flatMap(conn -> {
            try {
              sut.write("Executing " + zoneInfoCmd + " on " + conn.getName());
              CliCommandExecution zoneCacheExecution = new CliCommandExecution(conn, zoneInfoCmd)
                  .withTimeout(2, TimeUnit.MINUTES);
              zoneCacheExecution.execute();

              sut.write(Stream.of(zoneCacheExecution.getResult().split("\n"))
                  .filter(s -> s.startsWith("limitation")).findFirst().get());
              return Stream.of(zoneCacheExecution.getResult().split("\n"))
                  .filter(s -> s.startsWith("limitation"));
            } catch (IOException e) {
              Assert.fail(e.getMessage());
              throw new UncheckedIOException(e);
            }
          }).findFirst().get();

          Assert.assertThat("limitation result", actualLimitation,
              Matchers.containsString(expectedLimitation));
        });
      Given("^i restart replay on the servers$", () -> {
         cmd("sudo rm -f /var/www/adserver/replay_running","error");
      });
      Given("^i kill replay on the machines$", () -> {
          cmd("sudo pkill -9 replay","error");
      });

  }

    private void flushBucket(String bucketName) {
          sut.getCouchBaseUtils().flushBucket(bucketName);
    }

    public static void refreshZoneCache(String action) {
        String cron_ip = sut.getConfigFile().get("uas.cliconnection.cron");
        String pushCacheToS3Command = "sudo bash -c \"/var/www/adserver/pushCacheToS3\"";
        String pullZoneCacheCmd = "sudo docker exec ut-ramp-uas /var/www/adserver/scripts/aws_cache_sync.sh AWS_CACHE_SYNC PULL_LATEST";
        if (action.equals("cmd")) {

            //push zone.tch to s3 from the machine
            sut.getCronCliConnection().forEach((host, conn) -> {
                int count = 0;
                int maxTries = 5;
                while (true) {
                    try {
                        new CliCommandExecution(conn, pushCacheToS3Command)
                                .error("Couldn't sync").error("trace").withTimeout(10, TimeUnit.MINUTES).execute();
                        break;
                    } catch (IOException e) {
                        e.printStackTrace();
                        break;
                    } catch (AssertionError e) {
                        if (count++ == maxTries) {
                            System.out.println("Couldn't refresh zone cache, assuming cache is already updated. if its not the case check upgrade.lock");
                            break;
                        }
                        System.out.println("Couldn't push cache trying again...num_try: " + count);
                        Calendar now = Calendar.getInstance();
                        int minutes = now.get(Calendar.MINUTE);
                        int timeToSleep = max((LASTING_TIME_CACHE - (minutes % 10)) * 60,60);
                        sleepFor(timeToSleep);
                    }
                }
            });

//
//            public static void refreshZoneCacheNEW(String action) {
//                String cron_ip = sut.getConfigFile().get("uas.cliconnection.cron");
//                String pushCacheToS3Command = "sudo bash -c \"/var/www/adserver/pushCacheToS3\"";
//                String pullZoneCacheCmd = "sudo docker exec ut-ramp-uas /var/www/adserver/scripts/aws_cache_sync.sh AWS_CACHE_SYNC PULL_LATEST";
//                if (action.equals("cmd")) {
//
//                    //push zone.tch to s3 from the machine
//                    sut.getCronCliConnection().forEach((host, conn) -> {
//                            try {
//                                new CliCommandExecution(conn, pushCacheToS3Command)
//                                        .error("Couldn't sync").error("trace").withTimeout(10, TimeUnit.MINUTES).execute();
//                            } catch (IOException e) {
//                                e.printStackTrace();
//                            } catch (AssertionError e) {
//                                while (true){

//                                    try {
//                                        new CliCommandExecution(conn, pushCacheToS3Command)
//                                                .error("Couldn't sync").error("trace").withTimeout(10, TimeUnit.MINUTES).execute();
//                                    } catch (IOException e) {
//                                        e.printStackTrace();
//                                    } catch (AssertionError e) {
//                                        System.out.println("Still refreshing..waiting for the process to finish");
//                                        continue;
//                                    }
//
//                                }
//
//                            }
//
//
//
//
//            }
//


            //download the zone.tch from s3 rto all machines, except cron
            //   ******** REMOVED - NO NEED TO PULL FROM S3 ANYMORE ****************
//            sut.getHostsConnection().forEach((host, conn) -> {
//                if (!host.equals(cron_ip)) { //need to remove
//                    System.out.println("pulling zone.tch "+host);
//                    try {
//                        CliCommandExecution pullCommand = new CliCommandExecution(conn, pullZoneCacheCmd)
//                                .error("doesn't exist").withTimeout(3, TimeUnit.MINUTES);
//                        pullCommand.execute();
//                    } catch (Exception e) {
//                        throw new AssertionError(e);
//                    }
//                }
//            });
        }
    }

    public static void refreshZoneCacheOld(String action) {
        if (action.equals("http")) {
            sut.getUASRquestModule().zoneCacheRequest("refresh");
            // sut.getUASRquestModule().zoneCacheRequest("query_status");
            //
            // sut.getUASRquestModule().responses().filter(fh -> HttpContentTest.getContent(fh.join()).contains("ready"));
        } else if (action.equals("cmd")) {
            String cacheZonesCmd = "sudo docker exec ut-ramp-uas adserver --cache=zones";
//            String restartUASServerCmd = "sudo docker-compose -f /opt/docker-compose.yml restart ut-ramp-uas";
//             String restartUASServerCmd = "docker-compose restart ut-ramp-uas"; // for dev env
            sut.getHostsConnection().forEach((host, conn) -> {
                int count = 1;
                int maxTries = 3;
                while (true) {
                    try {
                        sut.write("Executing " + cacheZonesCmd + " on " + conn.getName() + "["
                                + Thread.currentThread().getName());
                        sut.write("********************************************************************");
                        CliCommandExecution zoneCacheExecution = new CliCommandExecution(conn, cacheZonesCmd)
                                .error("Couldn't run query").withTimeout(10, TimeUnit.MINUTES);
                        zoneCacheExecution.execute();
//                        CliCommandExecution restartUASServer = new CliCommandExecution(conn, restartUASServerCmd)
//                                .error("Couldn't restart").withTimeout(3, TimeUnit.MINUTES);
//                        restartUASServer.execute();
                        break;
                    } catch (Exception e) {
                        throw new AssertionError(e);
                    } catch (AssertionError e) {
                        System.out.println("Couldn't run query trying again...num_try: " + count);
                        if (++count == maxTries) {
                            throw new AssertionError(e);
                        } else {
                            sleepFor(60);
                        }
                    }
                }
            });
        }
    }

  private static void sleepFor(Integer seconds)
  {
      try {
          TimeUnit.SECONDS.sleep(seconds);
          System.out.println("sleeping for "+ seconds +" sec");
      } catch (InterruptedException e) {
          fail(e.getMessage());
      }
  }

    private void refreshCache(String typeOfCache) {
      assertThat(typeOfCache, isOneOf("campaign", "banner", "zone", "delivery-engine"));

      switch (typeOfCache.toLowerCase())
      {
          case "zone": refreshZoneCache("cmd");break;
          case "campaign":refreshCampaignCache();break;
          case "banner": refreshBannerCache();break;
          case "delivery-engine": refreshDeliveryEngineCache();break;
      }
    }

    private void refreshDeliveryEngineCache() {
      //*********** REMOVE ******** NO REFRESH FOR DELIVER CACHE
//        JsonArray hostsArray = new JsonParser().parse(config.get("uas.cliconnection.hosts")).getAsJsonArray();
//        CountDownLatch latch = new CountDownLatch(hostsArray.size());
//
//        try {
//
//            for (JsonElement el  : hostsArray) {
//                URIBuilder uriBuilderIad1 = new URIBuilder()
//                        .setScheme("http")
//                        .setPath("/delivery_engine/refreshCache")
//                        .setPort(8877)
//                        .setHost(el.getAsString());
//
//                StringEntity entity = new StringEntity("{\"action\":\"start\"}", ContentType.TEXT_PLAIN);
//                URI iad1 = uriBuilderIad1.build();
//                HttpPost postIad1 = new HttpPost(iad1);
//                postIad1.setEntity(entity);
//
//                HttpClient httpclient = HttpClients.custom()
//                        .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(5000).build()).build();
//
//                CompletableFuture.runAsync(() -> {
//                    try {
//                        HttpResponse httpResponse1 = httpclient.execute(postIad1);
//                        Assert.assertEquals("status code should be 200", 200, httpResponse1.getStatusLine().getStatusCode());
//                        BufferedReader bufferedReader1 =
//                                new BufferedReader(new InputStreamReader(httpResponse1.getEntity().getContent()));
//                        boolean isRefresh1 = bufferedReader1.lines()
//                                .collect(Collectors.joining("\n"))
//                                .contains(START_REFRESH_CACHE);
//                        Assert.assertTrue("data cache should start refresh", isRefresh1);
//                        bufferedReader1.close();
//                        latch.countDown();
//                    } catch (Exception e) {
//                        System.out.println(e.getMessage());
//                        Assert.fail("http post fail");
//                    }
//                });
//
//            }
//            latch.await(3, TimeUnit.SECONDS);
//        } catch (Exception e) {
//            System.out.println(e.getMessage());
//        }
    }

    private void refreshCampaignCache() {
        throw new Error("refresh campaign cache is not implemented yet");
    }

    private void refreshBannerCache() {
        String jobName = BANNER_CACHE_NAME + this.environmentName;
        int count = 0;
        int maxTries = 2;
        while (true) {
            try {
                JenkinsClient jenkins = new JenkinsClient();
                Assert.assertTrue("status: Failed:" + jobName, jenkins.executeJob(BANNER_CACHE_NAME + this.environmentName));
                break;
            } catch (Exception e) {
                throw new Error("Error in jenkins client");
            } catch (AssertionError e) {
                System.out.println("banner cache failed trying again...num_try: " + count);
                if (++count == maxTries) {
                    throw new AssertionError(e);
                } else {
                    sleepFor(60);
                }
            }
        }
    }

    private String getBannerCacheFromRampApp()
    {
        ClientConfig clientConfig = new ClientConfig();
        Client client = ClientBuilder.newClient(clientConfig);
        client.property(ClientProperties.CONNECT_TIMEOUT, 600000);
        client.property(ClientProperties.READ_TIMEOUT,    600000);
        WebTarget webTarget = client.target("https://" + config.get("ramp.performance.host")); //TODO: need to be generic

        Response response = webTarget
                .path("/api/v1/io/banners/extended")
                .request(MediaType.APPLICATION_JSON).header("rampInternal","true")
                .get();
        Assert.assertNotNull(response);
        String responseStr = response.readEntity(String.class);
        Assert.assertEquals(200, response.getStatus());
        Assert.assertNotNull(responseStr);
        return responseStr;
    }

}


//simple jenkins api request
 /* String encoding = Base64.getEncoder().encodeToString(("saharn:1q2w3e4r5t%^").getBytes());
        HttpPost httppost = new HttpPost("http://jenkins.ramp-ut.io/job/banners_cache_refresh/build");
        httppost.setHeader("Authorization", "Basic " + encoding);
        HttpClient httpClient = HttpClients.custom().setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(600000).build())
        .setDefaultCookieStore(new BasicCookieStore()).build();
        System.out.println("executing request " + httppost.getRequestLine());
        HttpResponse response = null;
        try {
            response = httpClient.execute(httppost);
        } catch (IOException e) {
            e.printStackTrace();
        }
        Assert.assertNotNull(response);
        Assert.assertEquals(response.getStatusLine().getStatusCode(),201);
        try {
            TimeUnit.SECONDS.sleep(100);
        } catch (InterruptedException e) {
            fail(e.getMessage());
        }*/
