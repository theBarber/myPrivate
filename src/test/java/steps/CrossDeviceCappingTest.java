package steps;

import com.couchbase.client.java.error.DocumentDoesNotExistException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import gherkin.deps.com.google.gson.JsonArray;
import gherkin.deps.com.google.gson.JsonElement;
import gherkin.deps.com.google.gson.JsonParser;
import infra.cli.conn.LinuxDefaultCliConnection;
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
import ramp.lift.uas.automation.CouchbaseBucketModule;

import java.time.Instant;

import static steps.HeaderBiddingTest.*;

/**
 * Created by kereng on 5/23/2017.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = {"classpath:CrossDeviceCappingExperiment.feature"}, plugin = {"pretty",})
//    "infra.RotatingJSONFormatter:target/cucumber/crossDevice_$TIMESTAMP$.json" })

public class CrossDeviceCappingTest extends BaseTest {


    private static final String COUCH_DOCS_FILE_PATH = "/input_files/cb_documents.json";
    public String jsonDocForMultipleProfiles;
    private JsonNode couchDocs;
    private ObjectMapper mapper = new ObjectMapper();

    public CrossDeviceCappingTest() {
        super();

        Given("I add device ([0-9][.][a-zA-Z0-9]*) with record <([^>]*)> to user info", (String paramName, String paramValue) -> {
            sut.getUsersBucket().insertDocument(paramName, paramValue);
        });

        Then("i inject profile id (\\d+) to user \\{(.*)\\} on adserver bucket", (Integer profileId, String userID) -> {
            CouchbaseBucketModule adserverBucket = sut.getAdserverBucket();
            try {
                adserverBucket.deleteDocument(userID);
            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
            Integer epocDays = getEpocDays();
            String jsonDoc = "{\n" +
                    "  \"profiles\": [\n" +
                    "    [\n" +
                    "      " + profileId + ",\n" +
                    "      [\n" +
                    "        " + epocDays + ",\n" +
                    "        1\n" +
                    "      ]\n" +
                    "    ]\n" +
                    "  ]\n" +
                    "}\n";
            adserverBucket.insertDocument(userID, jsonDoc);
        });

        Then("I inject profile doc for scenario \\{(.*)\\} to users bucket$", (String scenario) -> {
            CouchbaseBucketModule usersBucket = sut.getUsersBucket();
            JsonNode jsonDoc = fetchDoc(scenario);
            String udId = jsonDoc.get("udid").asText();
            try {
                usersBucket.deleteDocument(udId);
            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
            usersBucket.insertDocument(udId, jsonDoc.toString());
            sut.write("doc \n" + jsonDoc + "\ninjected to users bucket");
        });

        Then("i create new profile doc with udId \\{(.*)\\} on users bucket, where platform = \\{(.*)\\}, profile type = \\{(.*)\\}, profile num = (\\d+), and reduce (\\d+) days from epoc time stamp", (String udId, String platform, String profileType, Integer profileNum, Integer daysToReduce) -> {
            CouchbaseBucketModule usersBucket = sut.getUsersBucket();
            CouchbaseBucketModule usersLogBucket = sut.getUsersLogsBucket();
            try {
                usersBucket.deleteDocument(udId);
                usersLogBucket.deleteDocument(udId);
            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
            long epocTimeInDays = getEpocTimeInDays();
            long e = epocTimeInDays - daysToReduce;

            String profileStructure = "";
            if (!profileType.equals("sqmsg_p")) {
                profileStructure = "\":{\"" + e + "\":[" + profileNum + "]},";
            } else {
                profileStructure = "\":[{\"p\":\"" + profileNum + "\",\"e\":" + e + "}],";
            }

            String jsonDoc = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
                    "\"platform\": " + "\"" + platform + "\"" + ",\n" +
                    "\"" + profileType + profileStructure +
                    "\"user-graph\": {\"upid\": \"10.1.22b46d3d9ce4015fa47f2076c315ea23\", \"devices\": [{\"udid\": \"" + udId + "\"}]}\n}";

            System.out.println("\nJson Doc to inject!!\n " + jsonDoc);
            usersBucket.insertDocument(udId, jsonDoc);
            sut.write("doc \n" + jsonDoc + "\ninjected to users bucket");
        });


        Then("i inject new profile doc with udId \\{(.*)\\} on users bucket, where platform = \\{(.*)\\}, profile type = \\{(.*)\\}, profile num = (\\d+), and reduce (\\d+) days from epoc time stamp and extra devices string = (.*)$", (String udId, String platform, String profileType, Integer profileNum, Integer daysToReduce, String otherDevices) -> {
            CouchbaseBucketModule usersBucket = sut.getUsersBucket();
            CouchbaseBucketModule usersLogBucket = sut.getUsersLogsBucket();
            try {
                usersBucket.deleteDocument(udId);
                usersLogBucket.deleteDocument(udId);
            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
            long epocTimeInDays = getEpocTimeInDays();

            String jsonDoc = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
                    "\"platform\": " + "\"" + platform + "\"" + ",\n" +
                    "\"" + profileType + "\":{\"" + epocTimeInDays + "\":[" + profileNum + "]}," +
                    "\"user-graph\": {" + otherDevices + "}}";

            System.out.println("\nJson Doc to inject!!\n " + jsonDoc);

            if (platform.equals("desktop")) {
                usersBucket.insertDocument(udId, jsonDoc);
            } else {
                usersBucket.insertDocument(udId, jsonDoc);
            }
            sut.write("doc \n" + jsonDoc + "\ninjected to users bucket");
        });


        //one user with one empty optional profile type filed
        Then("i inject new profile doc with udId \\{(.*)\\} on users bucket, where platform = \\{(.*)\\}, empty profile type = \\{(.*)\\}, non-empty profile type = \\{(.*)\\}", (String udId, String platform, String emptyProfileType, String nonEmptyProfileType) -> {
            CouchbaseBucketModule usersBucket = sut.getUsersBucket();
            CouchbaseBucketModule usersLogBucket = sut.getUsersLogsBucket();
            try {
                usersBucket.deleteDocument(udId);
                usersLogBucket.deleteDocument(udId);
            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
            long epocTimeInDays = getEpocTimeInDays();
            String jsonDoc = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
                    "\"platform\": " + "\"" + platform + "\"" + ",\n" +
                    "\"" + emptyProfileType + "\": []," +
                    "\"" + nonEmptyProfileType + "\":{\"" + epocTimeInDays + "\":[123]}," +
                    "\"user-graph\": {\"upid\": \"10.1.22b46d3d9ce4015fa47f2076c315ea23\", \"devices\": [{\"udid\": \"" + udId + "\"}]}\n}";

            System.out.println("\nJson Doc to inject!!\n " + jsonDoc);
            usersBucket.insertDocument(udId, jsonDoc);
            sut.write("doc \n" + jsonDoc + "\ninjected to users bucket");
        });

//one profile for each profile type. optional days reduce from epoch time for both profiles types.
        Then("i inject new profile for udId \\{(.*)\\} on users bucket, platform = \\{(.*)\\}, single udmp_p profile is \\{(.*)\\} with (\\d+) days reduce and one sqmsg_p profile = \\{(.*)\\} with (\\d+) days reduce ", (String udId, String platform, String udmp_pString, Integer daysToReduceFromUdmp, String sqmsg_pString, Integer daysToReduceFromSqmg) -> {
            CouchbaseBucketModule usersBucket = sut.getUsersBucket();
            CouchbaseBucketModule usersLogBucket = sut.getUsersLogsBucket();
            try {
                usersBucket.deleteDocument(udId);
                usersLogBucket.deleteDocument(udId);
            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
            long epocTimeInDays = getEpocTimeInDays();
            String jsonDoc = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
                    "\"platform\": " + "\"" + platform + "\"" + ",\n" +
                    "\"udmp_p\":" + udmp_pString + "\"e:\" " + (epocTimeInDays - daysToReduceFromUdmp) + "}]" +
                    "\"sqmp_p\":" + sqmsg_pString + "\"e:\" " + (epocTimeInDays - daysToReduceFromSqmg) + "}]" +
                    "\"user-graph\": {\"upid\": \"10.1.22b46d3d9ce4015fa47f2076c315ea23\", \"devices\": [{\"udid\": \"" + udId + "\"}]}\n}";
            System.out.println("\nJson Doc to inject!!\n " + jsonDoc);
            usersBucket.insertDocument(udId, jsonDoc);
            sut.write("doc \n" + jsonDoc + "\ninjected to users bucket");
        });


//one profile for each profile type. optional days reduce from epoch time for both profiles types.
        Then("i inject new profile doc with udId \\{(.*)\\} on users bucket, where platform = \\{(.*)\\}, with one udmp_p profile = \\{(.*)\\} with (\\d+) days reduce and one sqmsg_p profile = \\{(.*)\\} with (\\d+) days reduce", (String udId, String platform, String udmp_pString, Integer daysToReduceFromUdmp, String sqmsg_pString, Integer daysToReduceFromSqmg) -> {
            CouchbaseBucketModule usersBucket = sut.getUsersBucket();
            CouchbaseBucketModule usersLogBucket = sut.getUsersLogsBucket();
            try {
                usersBucket.deleteDocument(udId);
                usersLogBucket.deleteDocument(udId);
            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
            long epocTimeInDays = getEpocTimeInDays();
            long e = epocTimeInDays - daysToReduceFromUdmp;

            String jsonDoc = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
                    "\"platform\": " + "\"" + platform + "\"" + ",\n" +
                    "\"u_p\":{\"" + e + "\":[" + udmp_pString + "]}," +
                    "\"sqmp_p\": [{\"p\": " + "\"" + sqmsg_pString + "\"," + "\"e\": " + (epocTimeInDays - daysToReduceFromSqmg) + "}]," +
                    "\"user-graph\": {\"upid\": \"10.1.22b46d3d9ce4015fa47f2076c315ea23\", \"devices\": [{\"udid\": \"" + udId + "\"}]}\n}";

            System.out.println("\nJson Doc to inject!!\n " + jsonDoc);
            usersBucket.insertDocument(udId, jsonDoc);
            sut.write("doc \n" + jsonDoc + "\ninjected to users bucket");
        });


//one profile for each profile type. optional days reduce from epoch time for both profiles types.
        Then("i inject new profile doc with two udmp_p profiles with udId \\{(.*)\\} on users bucket, where platform = \\{(.*)\\}. First p = (\\d+) with (\\d+) days reduce. Second profile = (\\d+) with (\\d+) days reduce", (String udId, String platform, Integer profile1, Integer daysToReduceFromProfile1, Integer profile2, Integer daysToReduceFromProfile2) -> {
            CouchbaseBucketModule usersBucket = sut.getUsersBucket();
            CouchbaseBucketModule usersLogBucket = sut.getUsersLogsBucket();
            try {
                usersBucket.deleteDocument(udId);
                usersLogBucket.deleteDocument(udId);
            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
            long epocTimeInDays = getEpocTimeInDays();
            String jsonDoc = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
                    "\"platform\": " + "\"" + platform + "\"" + ",\n" +
                    "\"udmp_p\": [{\"p\": " + "\"" + profile1 + "\"," + "\"e\": " + (epocTimeInDays - daysToReduceFromProfile1) + "}," +
                    "{\"p\": " + "\"" + profile2 + "\"," + "\"e\": " + (epocTimeInDays - daysToReduceFromProfile2) + "}]," +
                    "\"user-graph\": {\"upid\": \"\", \"devices\": [{\"udid\": \"" + udId + "\"}]}\n}";
            System.out.println("\nJson Doc to inject!!\n " + jsonDoc);
            usersBucket.insertDocument(udId, jsonDoc);
            sut.write("doc \n" + jsonDoc + "\ninjected to users bucket");
        });


// for multiple profiles, start, optional profile type
        Then("i start injecting new profile doc with udId \\{(.*)\\} on users bucket, where platform = \\{(.*)\\}, profile type = \\{(.*)\\}, profile num = (\\d+), and reduce (\\d+) days from epoc time stamp", (String udId, String platform, String profileType, Integer profileNum, Integer daysToReduceFromProfile) -> {
            long epocTimeInDays = getEpocTimeInDays();
            jsonDocForMultipleProfiles = "{" + "\"udid\": \"" + udId + "\"," + "\n" +
                    "\"platform\": " + platform + ",\n" +
                    "\"" + profileType + "\": [{" + "\"p\": " + "\"" + profileNum + "\"" + "," + "\"e\": " + (epocTimeInDays - daysToReduceFromProfile) + "}";
        });


// for multiple profiles, adding profile

        Then("i add profile number (\\d+) to user on users bucket, where profile = (\\d+) ,and reduce (\\d+) days from epoc time stamp", (Integer profileNum, Integer daysToReduceFromProfile) -> {
            long epocTimeInDays = getEpocTimeInDays();
            jsonDocForMultipleProfiles += ",{" + "\"p\": " + "\"" + profileNum + "\"" + ", " + "\"e\": " + (epocTimeInDays - daysToReduceFromProfile) + "}";
        });


        // for multiple profiles, end
        Then("i end adding profiles to user with udId  \\{(.*)\\}  on users bucket, platform was = \\{(.*)\\},and finally inject it", (String udId, String platform) -> {
            CouchbaseBucketModule usersBucket = sut.getUsersBucket();
            CouchbaseBucketModule usersLogBucket = sut.getUsersLogsBucket();
            try {
                usersBucket.deleteDocument(udId);
                usersLogBucket.deleteDocument(udId);
            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
            jsonDocForMultipleProfiles += "],\n" +
                    "\"user-graph\": {\"upid\": \"10.1.22b46d3d9ce4015fa47f2076c315ea23\", \"devices\": [{\"udid\": \"" + udId + "\"}]}\n}";
            usersBucket.insertDocument(udId, jsonDocForMultipleProfiles);
            sut.write("doc \n" + jsonDocForMultipleProfiles + "\ninjected to users bucket");
        });


        Then("I delete the history of ([0-9][.][a-zA-Z0-9-]*) from users bucket", (String udId) -> {
            try {
                sut.getUsersBucket().deleteDocument(udId);
            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
        });

        Then("I delete the history of ([0-9][.][a-zA-Z0-9-]*) from user logs bucket", (String udId) -> {
            try {
                sut.getUsersLogsBucket().deleteDocument(udId);

            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
        });


        Then("I delete the history of \\{(.*)\\} from users bucket with prefix = \\{(.*)\\}", (String udId, String prefix) -> {
            try {
                sut.getUsersBucket().deleteDocument(prefix + udId);

            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
        });

        Then("I delete the history of \\{(.*)\\} from user logs bucket with prefix = \\{(.*)\\}", (String udId, String prefix) -> {
            try {
                sut.getUsersLogsBucket().deleteDocument(prefix + udId);

            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
        });

        Given("I delete user info record of ([0-9][.][a-zA-Z0-9]*) from user info", (String userInfoRecordKey) -> {
            try {
                sut.getUserInfoBucket().deleteDocument(userInfoRecordKey);
            } catch (DocumentDoesNotExistException e) {
                System.out.println(e.getMessage());
            }
        });

        Given("I add cookie (\\w+) with value \\{(.*)\\} to my requests to uas", (String paramName, String paramValue) -> {
            sut.getUASRquestModule().addCookie(paramName, paramValue);
        });


        Given("I clear all cookies from uas requests", () -> {
            sut.getUASRquestModule().clearCookies();
        });

        Given("I clear all headers from uas requests", () -> {
            sut.getUASRquestModule().emptyHttpHeaders();
        });
        Then("^I refresh staging delivery engine data cache$", () -> {

        });
        Given("^I change IO id \\{(\\d+)\\} cross device Capping to \\{(active|inactive)\\}$", (Integer ioId, String cappingState) -> {
            String crossCapping = "1";
            if (cappingState.equalsIgnoreCase("inactive")) {
                crossCapping = "0";
            }

            SqlWorkflowUtils.setColumnInWorkflow("ios", "id", ioId.toString(),
                    "cap_across_devices", crossCapping);

        });
    }

    public long getEpocTimeInDays() {
        long epochInMilli = Instant.now().toEpochMilli();
        //  System.out.println("in mili = " + epochInMilli);
        long epochInDays = epochInMilli / 86400000;
        //  System.out.println("in days = " + epochInDays);
        return epochInDays;
    }

    long a = getEpocTimeInDays();

    private Integer getEpocDays() {
        MutableDateTime epoch = new MutableDateTime();
        epoch.setDate(0); //Set to Epoch time
        DateTime now = new DateTime();
        Days days = Days.daysBetween(epoch, now);
        return days.getDays();
    }


    private JsonNode fetchDoc(String scenario) {
        if (couchDocs == null) {
            try {
                couchDocs = mapper.readTree(this.getClass().getResourceAsStream(COUCH_DOCS_FILE_PATH));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        JsonNode jsonNode = couchDocs.get(scenario);
        Assert.assertNotNull("There is no suitable doc for scenario: " + scenario, jsonNode);
        return jsonNode;
    }
}
