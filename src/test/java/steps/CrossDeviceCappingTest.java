package steps;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;
import java.time.Instant;
import java.util.Random;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import cucumber.api.CucumberOptions;
import cucumber.api.PendingException;
import cucumber.api.junit.Cucumber;
import gherkin.deps.com.google.gson.JsonArray;
import gherkin.deps.com.google.gson.JsonElement;
import gherkin.deps.com.google.gson.JsonParser;
import infra.utils.SqlWorkflowUtils;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.joda.time.DateTime;
import org.joda.time.Days;
import org.joda.time.MutableDateTime;
import org.junit.Assert;
import org.junit.runner.RunWith;
import com.couchbase.client.java.error.DocumentDoesNotExistException;
import ramp.lift.uas.automation.CouchbaseBucketModule;

/**
 * Created by kereng on 5/23/2017.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = {"classpath:CrossDeviceCappingExperiment.feature","classpath:CrossDeviceCappingNoExperiment.feature"}, plugin = { "pretty",
    "infra.RotatingJSONFormatter:target/cucumber/crossDevice_$TIMESTAMP$.json" })

public class CrossDeviceCappingTest extends BaseTest{

  public final String START_REFRESH_CACHE = "start refresh cache";
  public  String jsonDocForMultipleProfiles;

  public CrossDeviceCappingTest() {
    super();

    Given("I add device ([a-zA-Z0-9]*) with record <([^>]*)> to user info", (String paramName, String paramValue) -> {
      sut.getUserInfoBucket().insertDocument(paramName, paramValue);
    });

    Then("i inject profile id (\\d+) to user \\{([^}]+)\\} on adserver bucket", (Integer profileId, String userID) -> {
      CouchbaseBucketModule adserverBucket = sut.getAdserverBucket();
      try{
        adserverBucket.deleteDocument(userID);
      } catch (DocumentDoesNotExistException e) {
        System.out.println(e.getMessage());
      }
        Integer epocDays = getEpocDays();
        String jsonDoc = "{\n" +
                "  \"profiles\": [\n" +
                "    [\n" +
                "      "+profileId+",\n" +
                "      [\n" +
                "        "+epocDays+",\n" +
                "        1\n" +
                "      ]\n" +
                "    ]\n" +
                "  ]\n" +
                "}\n";
        adserverBucket.insertDocument(userID,jsonDoc);
    });

//for single profile type, and single profile. optional epoc time for this single profile
    Then("i create new profile doc with udId \\{([^}]+)\\} on users bucket, where platform = \\{([^}]+)\\}, profile type = \\{([^}]+)\\}, profile num = (\\d+), and reduce (\\d+) days from epoc time stamp", (String udId,String platform ,String profileType ,Integer profileNum, Integer daysToReduce) -> {
      CouchbaseBucketModule usersBucket = sut.getUsersBucket();
      try{
        usersBucket.deleteDocument(udId);
      } catch (DocumentDoesNotExistException e) {
        System.out.println(e.getMessage());
      }
        long epocTimeInDays = getEpocTimeInDays();
      String jsonDoc = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
              "\"platform\": " + "\"" +platform + "\"" + ",\n" +
              "\"" + profileType + "\": [{" + "\"p\": " + "\"" + profileNum + "\"" + "," + "\"e\": " + (epocTimeInDays-daysToReduce) + "}]," +
              "\"user-graph\": {\"upid\": \"10.1.22b46d3d9ce4015fa47f2076c315ea23\", \"devices\": [{\"udid\": \"" + udId + "\"}]}\n}";
        usersBucket.insertDocument(udId, jsonDoc);
      System.out.println("doc injected to users bucket");
    });


    Then("i inject new profile doc with udId \\{([^}]+)\\} on users bucket, where platform = \\{([^}]+)\\}, profile type = \\{([^}]+)\\}, profile num = (\\d+), and reduce (\\d+) days from epoc time stamp and extra devices string = (.*)$", (String udId, String platform,String profileType,Integer profileNum ,Integer daysToReduce, String otherDevices) -> {
      CouchbaseBucketModule usersBucket = sut.getUsersBucket();
      try{
        usersBucket.deleteDocument(udId);
      } catch (DocumentDoesNotExistException e) {
        System.out.println(e.getMessage());
      }
      long epocTimeInDays = getEpocTimeInDays();
      String jsonDoc = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
              "\"platform\": " + "\"" +platform + "\"" + ",\n" +
              "\"" + profileType + "\": [{" + "\"p\": " + "\"" + profileNum + "\"" + "," + "\"e\": " + epocTimeInDays + "}]," +
              "\"user-graph\": {" + otherDevices + "}}";
      System.out.println("\n jason Doc to inject!! \n " + jsonDoc);
      if (platform.equals("desktop")) {
        usersBucket.insertDocument(udId, jsonDoc);
        System.out.println("\n jason Doc injected successfully as web! \n " + jsonDoc);
      } else {
        usersBucket.insertDocument(udId, jsonDoc);
        System.out.println("\n jason Doc injected successfully as app! \n " + jsonDoc);
      }
    });


      //one user with one empty optional profile type filed
      Then("i inject new profile doc with udId \\{([^}]+)\\} on users bucket, where platform = \\{([^}]+)\\}, empty profile type = \\{([^}]+)\\}, non-empty profile type = \\{([^}]+)\\}", (String udId, String platform, String emptyProfileType, String nonEmptyProfileType) -> {
          CouchbaseBucketModule usersBucket = sut.getUsersBucket();
      try{
        usersBucket.deleteDocument(udId);
      } catch (DocumentDoesNotExistException e) {
        System.out.println(e.getMessage());
      }
          long epocTimeInDays = getEpocTimeInDays();
          String jsonDoc = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
                  "\"platform\": " + "\"" +platform + "\"" + ",\n" +
                  "\"" + emptyProfileType+ "\": []," +
                  "\"" + nonEmptyProfileType + "\": [{\"p\":\"123\", \"e\": " + epocTimeInDays + "}]," +
                  "\"user-graph\": {\"upid\": \"10.1.22b46d3d9ce4015fa47f2076c315ea23\", \"devices\": [{\"udid\": \"" + udId + "\"}]}\n}";
          usersBucket.insertDocument(udId, jsonDoc);
        System.out.println("doc injected to users bucket");
      });




//    //for both profile types. udmp profile with optional time. sqmsg with auto current time stamp
//    Then("i inject new profile doc with udId \\{([^}]+)\\} on users bucket, where platform = \\{([^}]+)\\}, udmp_p profile with time stamp  = \\{([^}]+)\\}, sqmsg_p profile with auto time stamp = \\{([^}]+)\\}",  (String udId,String platform ,String udmp_pFull,String sqmsg_p) -> {
//      CouchbaseBucketModule usersBucket = sut.getUsersBucket();
//      try{
//        usersBucket.deleteDocument(udId);
//      } catch (DocumentDoesNotExistException e) {
//        System.out.println(e.getMessage());
//      }
//      Integer epocTimeInDays = getEpocTimeInDays();
//      String jsonDoc = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
//              "\"platform\": " + platform + ",\n" +
//              "\"imp\":[]" + "\n" +
//              "\"udmp_p\":" + udmp_pFull +
//              "\"sqmp_p\":" + sqmsg_p +  "\"e:\" " + epocTimeInDays + "}]" +
//              "\"user-graph\": {\"upid\": \"10.1.22b46d3d9ce4015fa47f2076c315ea23\", \"devices\": [{\"udid\": \"" + udId + "\"}]}\n}";
//      usersBucket.insertDocument(udId,jsonDoc);
//    });










//one profile for each profile type. optional days reduce from epoch time for both profiles types.
    Then("i inject new profile for udId \\{([^}]+)\\} on users bucket, platform = \\{([^}]+)\\}, single udmp_p profile is \\{([^}]+)\\} with (\\d+) days reduce and one sqmsg_p profile = \\{([^}]+)\\} with (\\d+) days reduce ", (String udId, String platform, String udmp_pString, Integer daysToReduceFromUdmp ,String sqmsg_pString, Integer daysToReduceFromSqmg) -> {
      CouchbaseBucketModule usersBucket = sut.getUsersBucket();
      try{
        usersBucket.deleteDocument(udId);
      } catch (DocumentDoesNotExistException e) {
        System.out.println(e.getMessage());
      }
        long epocTimeInDays = getEpocTimeInDays();
      String jsonDoc = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
              "\"platform\": " + "\"" +platform + "\"" + ",\n" +
              "\"udmp_p\":" + udmp_pString + "\"e:\" " + (epocTimeInDays-daysToReduceFromUdmp) + "}]" +
              "\"sqmp_p\":" + sqmsg_pString +  "\"e:\" " + (epocTimeInDays-daysToReduceFromSqmg) + "}]" +
              "\"user-graph\": {\"upid\": \"10.1.22b46d3d9ce4015fa47f2076c315ea23\", \"devices\": [{\"udid\": \"" + udId + "\"}]}\n}";
        usersBucket.insertDocument( udId, jsonDoc);
      System.out.println("doc injected to users bucket");
    });




//one profile for each profile type. optional days reduce from epoch time for both profiles types.
    Then("i inject new profile doc with udId \\{([^}]+)\\} on users bucket, where platform = \\{([^}]+)\\}, with one udmp_p profile = \\{([^}]+)\\} with (\\d+) days reduce and one sqmsg_p profile = \\{([^}]+)\\} with (\\d+) days reduce", (String udId, String platform, String udmp_pString, Integer daysToReduceFromUdmp ,String sqmsg_pString, Integer daysToReduceFromSqmg) -> {
      CouchbaseBucketModule usersBucket = sut.getUsersBucket();
      try{
        usersBucket.deleteDocument(udId);
      } catch (DocumentDoesNotExistException e) {
        System.out.println(e.getMessage());
      }
        long epocTimeInDays = getEpocTimeInDays();
      String jsonDoc = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
              "\"platform\": " + "\"" +platform + "\"" + ",\n" +
              "\"udmp_p\": [{\"p\": " + "\"" + udmp_pString + "\"," + "\"e\": " + (epocTimeInDays-daysToReduceFromUdmp) + "}]," +
              "\"sqmp_p\": [{\"p\": " + "\"" + sqmsg_pString + "\"," + "\"e\": " + (epocTimeInDays-daysToReduceFromSqmg) + "}]," +
              "\"user-graph\": {\"upid\": \"10.1.22b46d3d9ce4015fa47f2076c315ea23\", \"devices\": [{\"udid\": \"" + udId + "\"}]}\n}";
      System.out.print("\n \n json to check: \n " + jsonDoc);
        usersBucket.insertDocument(udId, jsonDoc);
    });






// for multiple profiles, start, optional profile type
    Then("i start injecting new profile doc with udId \\{([^}]+)\\} on users bucket, where platform = \\{([^}]+)\\}, profile type = \\{([^}]+)\\}, profile num = (\\d+), and reduce (\\d+) days from epoc time stamp", (String udId,String platform,String profileType, Integer profileNum, Integer daysToReduceFromProfile)-> {
        long epocTimeInDays = getEpocTimeInDays();
      jsonDocForMultipleProfiles = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
              "\"platform\": " + platform + ",\n" +
         "\"" + profileType + "\": [{" + "\"p\": " + "\"" + profileNum + "\"" + "," + "\"e\": " + (epocTimeInDays-daysToReduceFromProfile) + "}";
    });





// for multiple profiles, adding profile

      Then("i add profile number (\\d+) to user on users bucket, where profile = (\\d+) ,and reduce (\\d+) days from epoc time stamp",(Integer profileNum, Integer daysToReduceFromProfile)-> {
        long epocTimeInDays = getEpocTimeInDays();
        jsonDocForMultipleProfiles+= ",{" + "\"p\": " + "\"" + profileNum + "\"" + ", " + "\"e\": " + (epocTimeInDays-daysToReduceFromProfile) + "}";
      });


    // for multiple profiles, end
    Then("i end adding profiles to user with udId  \\{([^}]+)\\}  on users bucket, platform was = \\{([^}]+)\\},and finally inject it",(String udId, String platform)-> {
      CouchbaseBucketModule usersBucket = sut.getUsersBucket();
      try{
        usersBucket.deleteDocument(udId);
      } catch (DocumentDoesNotExistException e) {
        System.out.println(e.getMessage());
      }
      jsonDocForMultipleProfiles += "],\n" +
      "\"user-graph\": {\"upid\": \"10.1.22b46d3d9ce4015fa47f2076c315ea23\", \"devices\": [{\"udid\": \"" + udId + "\"}]}\n}";
        usersBucket.insertDocument(udId, jsonDocForMultipleProfiles);
    });



    Then("I delete the history of ([a-zA-Z0-9]*) from users bucket", (String udId) -> {
      try{

        sut.getUsersBucket().deleteDocument(udId);

      } catch (DocumentDoesNotExistException e) {
        System.out.println(e.getMessage());
      }
    });

    Then("I delete the history of \\{([^}]+)\\} from users bucket with prefix = \\{([^}]+)\\}", (String udId, String prefix) -> {
      try{
        sut.getUsersBucket().deleteDocument(prefix+udId);

      } catch (DocumentDoesNotExistException e) {
        System.out.println(e.getMessage());
      }
    });

    Given("I delete user info record of ([a-zA-Z0-9]*) from user info", (String userInfoRecordKey) -> {
      try{
        sut.getUserInfoBucket().deleteDocument(userInfoRecordKey);
      } catch (DocumentDoesNotExistException e) {
        System.out.println(e.getMessage());
      }
    });

    Given("I add cookie (\\w+) with value \\{([^}]+)\\} to my requests to uas", (String paramName, String paramValue) -> {
      sut.getUASRquestModule().addCookie(paramName, paramValue);
    });



    Given("I clear all cookies from uas requests", () -> {
      sut.getUASRquestModule().clearCookies();
    });

    Given("I clear all headers from uas requests", () -> {
      sut.getUASRquestModule().emptyHttpHeaders();
    });
    Then("^I refresh staging delivery engine data cache$", () -> {
      JsonArray hostsArray = new JsonParser().parse(config.get("uas.cliconnection.hosts")).getAsJsonArray();
      CountDownLatch latch = new CountDownLatch(hostsArray.size());

      try {

        for (JsonElement el  : hostsArray) {
          URIBuilder uriBuilderIad1 = new URIBuilder()
            .setScheme("http")
            .setPath("/delivery_engine/refreshCache")
            .setPort(8877)
            .setHost(el.getAsString());

          StringEntity entity = new StringEntity("{\"action\":\"start\"}", ContentType.TEXT_PLAIN);
          URI iad1 = uriBuilderIad1.build();
          HttpPost postIad1 = new HttpPost(iad1);
          postIad1.setEntity(entity);

          HttpClient httpclient = HttpClients.custom()
            .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(5000).build()).build();

          CompletableFuture.runAsync(() -> {
            try {
              HttpResponse httpResponse1 = httpclient.execute(postIad1);
              Assert.assertEquals("status code should be 200", 200, httpResponse1.getStatusLine().getStatusCode());
              BufferedReader bufferedReader1 =
                new BufferedReader(new InputStreamReader(httpResponse1.getEntity().getContent()));
              boolean isRefresh1 = bufferedReader1.lines()
                .collect(Collectors.joining("\n"))
                .contains(START_REFRESH_CACHE);
              Assert.assertTrue("data cache should start refresh", isRefresh1);
              bufferedReader1.close();
              latch.countDown();
            } catch (Exception e) {
              System.out.println(e.getMessage());
              Assert.fail("http post fail");
            }
          });

        }
        latch.await(3, TimeUnit.SECONDS);
      } catch (Exception e) {
        System.out.println(e.getMessage());
      }
    });
    Given("^I change IO id \\{(\\d+)\\} cross device Capping to \\{([^}]+)\\}$", (String ioId, String cappingState) -> {

      String crossCapping = "1";
      if (cappingState.equalsIgnoreCase("inactive")) {
        crossCapping = "0";
      }

      SqlWorkflowUtils.setColumnInWorkflow("ios","id",ioId,
        "cap_across_devices", crossCapping);

    });
  }

  public long getEpocTimeInDays(){
   long epochInMilli = Instant.now().toEpochMilli();
 //  System.out.println("in mili = " + epochInMilli);
    long epochInDays = epochInMilli/86400000;
  //  System.out.println("in days = " + epochInDays);
      return epochInDays ;
  }

  long a = getEpocTimeInDays();

  private Integer getEpocDays() {
    MutableDateTime epoch = new MutableDateTime();
    epoch.setDate(0); //Set to Epoch time
    DateTime now = new DateTime();
    Days days = Days.daysBetween(epoch, now);
    return days.getDays();
  }

}
