package steps;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.DataTable;
import cucumber.api.junit.Cucumber;
import entities.Zone;
import infra.module.WithId;
import org.hamcrest.Matchers;
import org.hamcrest.core.IsNull;
import org.junit.Assert;
import org.junit.AssumptionViolatedException;
import org.junit.runner.RunWith;
import ramp.lift.uas.automation.UASRequestModule;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

import static org.hamcrest.Matchers.isIn;
import static org.hamcrest.Matchers.isOneOf;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:HeaderBidding.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/HeaderBidding_$TIMESTAMP$.json"})
public class HeaderBiddingTest extends BaseTest {
    final private String HEADER_BIDDING_SOURCE_FILE_PATH = "/input_files/headerBiddingPostRequests.json";
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
        And("all HB responses contains (campaignId|adId) with id of entity named \\{([^}]+)\\}",this::responsesContainEntityWithName);
        And("all HB responses contains (campaignId|adId) with one of: \\{([^}]+)\\}",this::responsesContainOneOnOf);

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

        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            JsonNode responseInJson = null;
            try
            {
                responseInJson = mapper.readTree(content);
                Assert.assertNotNull("response not contains entity named: " + entity, responseInJson.get(0).get(entity));
                Assert.assertEquals(id.intValue(),responseInJson.get(0).get(entity).intValue());
            }catch (Exception e)
            {
                e.printStackTrace();
            }
        });
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
}
