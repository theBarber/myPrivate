package steps;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.apache.http.HttpResponse;
import org.junit.Assert;
import org.junit.AssumptionViolatedException;
import org.junit.runner.RunWith;
import ramp.lift.uas.automation.UASRequestModule;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;
import static org.hamcrest.Matchers.isIn;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:HeaderBidding.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/HeaderBidding_$TIMESTAMP$.json"})
public class HeaderBiddingTest extends BaseTest {
    final private String HEADER_BIDDING_SOURCE_FILE_PATH = "/input_files/headerBiddingPostRequests.json";
    final private Integer NO_UT_INDEX = 3;
    private ObjectMapper mapper = new ObjectMapper();
    private JsonNode headerBiddingPostRequests;

    public HeaderBiddingTest()
    {
        super();
        Before(HEADERBIDDING, (scenario) -> {
            try {
                headerBiddingPostRequests = mapper.readTree(this.getClass().getResourceAsStream(HEADER_BIDDING_SOURCE_FILE_PATH));
            } catch (Exception e) {
                e.printStackTrace();
            }
        });

        Given("i send (\\d+) headerBidding post request for scenario \\{([^}]+)\\} for publisher (\\d+) with domain \\{([^}]+)\\} with extra params \\{([^}]+)\\}",this::sendHeaderBiddingPostRequest);        Given("i send (\\d+) headerBidding secure post request for scenario \\{([^}]+)\\} for publisher (\\d+) with domain \\{([^}]+)\\} with extra params \\{([^}]+)\\}",this::sendHeaderBiddingSecurePostRequest);
        And("all HB responses contains (campaignId|adId|cpm) with id (\\d+)",this::responsesContainEntityWithId);
        And("all HB responses contains (\\w+) with value \\{([^}]+)\\}",this::responsesContainEntityWithValue);
        And("all HB responses contains (campaignId|adId) with id of entity named \\{([^}]+)\\}",this::responsesContainEntityWithName);
        And("all HB responses contains (campaignId|adId) with one of: \\{([^}]+)\\}",this::responsesContainOneOnOf);
        And("for all HB responses i simulate winning, and send their zone tag",this::sendZoneTagFromHBResponses);

    }

    private void responsesContainEntityWithValue(String entity, String value) {
        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            JsonNode responseInJson = null;
            try
            {
                responseInJson = mapper.readTree(content);
                Assert.assertNotNull("response not contains entity named: " + entity, responseInJson.get(0).get(entity));
                Assert.assertEquals(value,responseInJson.get(0).get(entity).toString());
            }catch (Exception e)
            {
                e.printStackTrace();
            }
        });
    }

    private void responsesContainOneOnOf(String entity, String banners_names) {
        List<Integer> bannersIds = Arrays.stream(banners_names.split(",")).map(name -> getEntityId(entity, name)).collect(Collectors.toList());

        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            JsonNode responseInJson = null;
            try
            {
                responseInJson = mapper.readTree(content);
                Assert.assertNotNull("response not contains entity named: " + entity, responseInJson.get(0).get(entity));
                Assert.assertThat(responseInJson.get(0).get(entity).intValue(),isIn(bannersIds));
            }catch (Exception e)
            {
                e.printStackTrace();
            }
        });

    }

    private void sendHeaderBiddingSecurePostRequest(Integer times, String scenario, Integer publisherID, String domain,String extraParams) {
        if(headerBiddingPostRequests == null)
        {
            throw new AssumptionViolatedException("you must initialize the mapper, verify tag @headerBidding is in your feature file");
        }
        JsonNode jsonNode = headerBiddingPostRequests.get(scenario);
        Assert.assertNotNull( "There is no suitable scenario for scenario: "+scenario, jsonNode);
        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(times,jsonNode.toString(),publisherID,domain, extraParams,true,true);
    }

    public void sendHeaderBiddingPostRequest(Integer times, String scenario, Integer publisherID, String domain,String extraParams)
    {
        JsonNode jsonNode = headerBiddingPostRequests.get(scenario);
        Assert.assertNotNull( "There is no suitable scenario for scenario: "+scenario, jsonNode);
        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(times,jsonNode.toString(),publisherID,domain, extraParams,true,false);
    }

    private void sendHeaderBiddingPostRequestWithoutExtraParams(Integer times, String scenario, Integer publisherID, String domain)
    {
        sendHeaderBiddingPostRequest(times,scenario,publisherID,domain,null);
    }

    public void responsesContainEntityWithId(String entity, Integer id) {

        responsesContainEntityWithValue(entity,String.valueOf(id));
    }

    public void sendZoneTagFromHBResponses() {
        List<CompletableFuture<HttpResponse>> response = new ArrayList<>(sut.getUASRquestModule().responsesAsList());
        sut.getUASRquestModule().reset();
        response.stream().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            JsonNode responseInJson = null;
            try
            {
                responseInJson = mapper.readTree(content);
                String htmlWithQuery = responseInJson.get(0).get("ad").asText();
                String url = getUrlFromAd(htmlWithQuery);
                sut.getUASRquestModule().sendGetRequestsAsync(1,url,false);
            }catch (Exception e)
            {
                e.printStackTrace();
            }
        });
    }

    private String getUrlFromAd(String htmlWithQuery) {
        Map<String, String> splitedQuery = splitHBQuery(htmlWithQuery);

        return new StringBuilder().append(splitedQuery.get("ut_ju ").substring(2,splitedQuery.get("ut_ju ").length()-1)).append("?").
                append("&bidid=").append(splitedQuery.get("ut.bidid").substring(1,splitedQuery.get("ut.bidid").length()-1)).
                append("&bannerid=").append(splitedQuery.get("ut.bannerid")).
                append("&zoneid=").append(splitedQuery.get("ut.zoneid")).
                append("&hbprice=").append(splitedQuery.get("ut.hbprice")).
                append("&fallbackbannerid=").append(splitedQuery.get("ut.fallbackbannerid")).
                append("&fallbackzoneid=").append(splitedQuery.get("ut.fallbackzoneid")).
                append("&width=").append(splitedQuery.get("ut.width")).
                append("&height=").append(splitedQuery.get("ut.height")).
                append("&adaptor=").append(splitedQuery.get("ut.adaptor")).
                append("&pid=").append(splitedQuery.get("ut.pid")).
                append("&extpid=").append(splitedQuery.get("ut.extpid")).
                append("&domain=").append(splitedQuery.get("ut.domain")).
                append("&ct=1").toString();
    }


    private void responsesContainEntityWithName(String entity, String name)
    {
       responsesContainEntityWithId(entity, getEntityId(entity,name));
    }

    private Integer getEntityId(String entity, String name)
    {
        String myEntity;
        switch (entity.toLowerCase()) {
            case "adid":
                myEntity = "banner";break;
            case "campaignid":
                myEntity = "campaign";break;
            default:
                myEntity = null;
        }
        return sut.getCampaignManager().getterFor(myEntity).apply(name).orElseThrow(() -> new AssertionError(name+" wasn't found")).getId();
    }

    public Map<String, String> splitHBQuery(String query){

        Map<String, String> query_pairs = new LinkedHashMap<String, String>();
        String[] pairs = query.split(";");
        pairs[0] = pairs[0].substring(pairs[0].indexOf("ut_ju")).trim();
        for (String pair : pairs) {
            int idx = pair.indexOf("=");
            try {
                query_pairs.put(URLDecoder.decode(pair.substring(0, idx), "UTF-8"), URLDecoder.decode(pair.substring(idx + 1), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return query_pairs;
    }
}
