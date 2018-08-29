package steps;


import cucumber.api.CucumberOptions;
import cucumber.api.PendingException;
import cucumber.api.junit.Cucumber;
import infra.cli.conn.LinuxDefaultCliConnection;
import infra.cli.process.CliCommandExecution;
import infra.utils.CouchBaseUtils;
import infra.utils.JenkinsClient;
import infra.utils.SqlWorkflowUtils;

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
import java.io.*;
import java.util.Calendar;
import java.util.concurrent.TimeUnit;
import java.util.stream.Stream;
import static org.hamcrest.Matchers.isOneOf;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;


@CucumberOptions(features = "classpath:ZoneCacheProcess.feature", plugin = {"pretty",
    "infra.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json"})
@RunWith(Cucumber.class)

public class CacheProcessTest extends BaseTest {
    private final String BANNER_CACHE_NAME = "banners_cache_refresh_";
    private final static Integer LASTING_TIME_CACHE = 7;
  public CacheProcessTest() {
    super();


    And("I refresh (zone|campaign|banner) cache",this::refreshCache);
    And("I flush bucket name \\{([^}]+)\\} on couchbase", this::flushBucket);
    Given("^limitations for zoneId (\\d+) is \\{([^}]+)\\} in Workflow DB$",
        (Integer zoneId, String expectedLimitation) -> {
          String currentLimitation = SqlWorkflowUtils.getLimitationForZone(zoneId);
          sut.write(currentLimitation);
          Assert.assertThat(currentLimitation, Matchers.containsString(expectedLimitation));
        });
    And("^limitations for zoneId (\\d+) updated to \\{([^}]+)\\} in Workflow DB$",
        (Integer zoneId, String newLimitation) -> {
          SqlWorkflowUtils.setLimitationForZone(zoneId, newLimitation);
        });
    When("^zoneCache refreshed by cmd$", () -> {
      refreshZoneCache("cmd");
    });
    When("^zoneCache refreshed by http$", () -> {
      refreshZoneCache("http");
    });
    When("limitation for zone (.*) in zoneCache contains \\{([^}]+)\\}",
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
        LinuxDefaultCliConnection cronServerConnection = sut.getUasCliConnections().get(cron_ip);
        String pullZoneCacheCmd = "sudo docker exec ut-ramp-uas /var/www/adserver/scripts/aws_cache_sync.sh AWS_CACHE_SYNC PULL_LATEST";
        String pushCacheToS3Command = "sudo bash -c \"/var/www/adserver/pushCacheToS3\"";
        if (action.equals("cmd")) {

            //push zone.tch to s3 from the machine
            sut.getCronCliConnection().forEach((host, conn) -> {
                int count = 0;
                int maxTries = 3;
                while (true) {
                    try {
                        new CliCommandExecution(conn, pushCacheToS3Command)
                                .error("Couldn't sync").error("trace").withTimeout(10, TimeUnit.MINUTES).execute();
                        break;
                    } catch (IOException e) {
                        e.printStackTrace();
                    } catch (AssertionError e) {
                        System.out.println("Couldn't push cache trying again...num_try: " + count);
                        Calendar now = Calendar.getInstance();
                        int minutes = now.get(Calendar.MINUTE);
                        int timeToSleep = (LASTING_TIME_CACHE - (minutes % 10)) * 60;
                        if (timeToSleep < 60)
                            timeToSleep = 60;
                        sleepFor(timeToSleep);
                        if (++count == maxTries) {
                            throw new AssertionError(e);
                        }
                    }
                }
            });

            //download the zone.tch from s3 rto all machines, except cron
            sut.getHostsConnection().forEach((host, conn) -> {
                if (!host.equals(cron_ip)) { //need to remove
                    System.out.println("pulling zone.tch "+host);
                    try {
                        CliCommandExecution pullCommand = new CliCommandExecution(conn, pullZoneCacheCmd)
                                .error("doesn't exist").withTimeout(3, TimeUnit.MINUTES);
                        pullCommand.execute();
                    } catch (Exception e) {
                        throw new AssertionError(e);
                    }
                }
            });
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
      assertThat(typeOfCache, isOneOf("campaign", "banner", "zone"));

      switch (typeOfCache.toLowerCase())
      {
          case "zone": refreshZoneCache("cmd");break;
          case "campaign":refreshCampaignCache();break;
          case "banner": refreshBannerCache();break;
      }
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
        WebTarget webTarget = client.target("http://services-ramp-staging.ramp-ut.io:3008"); //TODO: need to be generic

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
