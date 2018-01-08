package steps;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;
import ramp.lift.uas.automation.UASRequestModule;

import java.io.IOException;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;


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
        Before(HEADERBIDDINGSAHAR, (scenario) -> {
            try {
                headerBiddingPostRequests = mapper.readTree(this.getClass().getResourceAsStream(HEADER_BIDDING_SOURCE_FILE_PATH));
            } catch (Exception e) {
                e.printStackTrace();
            }
        });

        Given("i send (\\d+) headerBidding post request for scenario \\{([^}]+)\\} for publisher (\\d+) with domain \\{([^}]+)\\} with extra params \\{([^}]+)\\}",this::sendHeaderBiddingPostRequest);
//        Given("i send (\\d+) headerBidding post request for scenario \\{([^}]+)\\} for publisher (\\d+) with domain \\{([^}]+)\\}",this::sendHeaderBiddingPostRequestWithoutExtraParams);
        And("all responses contains (\\w+) with id (\\w+)",this::responsesContainEntityWithId);
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

    public void responsesContainEntityWithId(String entity, String id) {

        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            JsonNode responseInJson = null;
            try
            {
                responseInJson = mapper.readTree(content);
                Assert.assertNotNull("response not contains entity named: " + entity, responseInJson.get(0).get(entity));
                Assert.assertEquals(responseInJson.get(0).get(entity).toString(), id);
            }catch (Exception e)
            {
                e.printStackTrace();
            }
        });
    }
}
