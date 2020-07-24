package steps;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.Assert;
import org.junit.runner.RunWith;
import ramp.lift.uas.automation.UASRequestModule;

import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

import static org.hamcrest.Matchers.isIn;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;


@RunWith(Cucumber.class)
@CucumberOptions(features = {
        "classpath:HeaderBidding.feature"}, plugin = {"pretty",})

public class HeaderBiddingTest extends BaseTest {
    final private String HEADER_BIDDING_SOURCE_FILE_PATH = "/input_files/requestBodies.json";
    private ObjectMapper mapper = new ObjectMapper();
    private JsonNode headerBiddingPostRequests;
    private List<JsonNode> responses;
    private Map<String, Map<Integer, AtomicInteger>> bidCounterMap;
    String mapByEntity;
    private Integer Bidreq = 0;


    public HeaderBiddingTest() {
        super();
        Before(HEADERBIDDING, (scenario) -> {
            try {
                headerBiddingPostRequests = mapper.readTree(this.getClass().getResourceAsStream(HEADER_BIDDING_SOURCE_FILE_PATH));
            } catch (Exception e) {
                e.printStackTrace();
            }
        });

        Given("i send (\\d+) headerBidding post request for scenario \\{(.*)\\} for publisher (\\d+) with domain \\{(.*)\\} with extra params \\{(.*)\\}", this::sendHeaderBiddingPostRequest);
        Given("i send (\\d+) headerBidding secure post request for scenario \\{(.*)\\} for publisher (\\d+) with domain \\{(.*)\\} with extra params \\{(.*)\\}", this::sendHeaderBiddingSecurePostRequest);
        And("all HB responses contains? (.*) with id (\\d+)", this::responsesContainEntityWithId);
        And("all HB responses contains (\\w+) with value \\{(.*)\\}", this::responsesContainEntityWithValue);
        And("all HB responses contains (campaignId|adId) with id of entity named? \\{(.*)\\}$", this::responsesContainEntityWithName);
        And("all HB responses contains ad impression with? (.*) of entity named? \\{(.*)\\}$", this::responsesAdsContainEntityWithName);
        And("all HB responses contains ad impression with? (.*) with value? \\{(.*)\\}$", this::responsesAdsContainEntityWithId);
        And("i read all HB responses and map their bidId by? (.*)$", this::setBidMapByEntity);
        And("in HB responses bidid (\\w+) has entity of (campaignId|adId) with name \\{(.*)\\} (\\d+)% of the times", this::responsesContainEntityByBidIdWithName);
        And("in HB responses bidid (\\w+) has entity of (campaignId|adId) with value (\\d+) (\\d+)% of the times", this::responsesContainEntityByBidIdWithValue);
        And("all HB responses contains (campaignId|adId) with one of: \\{(.*)\\}", this::HBResponsesContainOneOnOf);
        Given("i send (\\d+) headerBidding secure post request for publisher (\\d+) with size1 = (\\d+) size2 = (\\d+), with domain \\{(.*)\\} and extra params \\{(.*)\\}", this::sendHBPostRequestBidIDcount);
        Given("i send (\\d+) headerBidding secure post request for publisher (\\d+) with size1 = (\\d+) size2 = (\\d+), bidreq = (\\d+), empty domain, and extra params \\{(.*)\\}", this::sendHBPostRequestBidIDcount);
        Given("i send 1 headerBidding secure post request for publisher (\\d+) with multi bids. first bid - bidreqID=\\{(.*)\\}, h:(\\d+) w:(\\d+), sec bid - bidreqID=\\{(.*)\\}, h:(\\d+) w:(\\d+) with domain \\{(.*)\\} and extra params \\{(.*)\\}", this::sendHBSecurePostRequestMultibid);
        Given("i send 1 headerBidding secure post request for publisher (\\d+) with multi sizes - h1:(\\d+) w1:(\\d+), h2:(\\d+) w2:(\\d+) with domain \\{(.*)\\} and placmentID group = \\{(.*)\\} and extra params \\{(.*)\\}", this::sendHBSecurePostRequestMultiSized);
        Given("i send synchronized (\\d+) basic headerBidding secure post request for publisher (\\d+) with size - h1:(\\d+) w1:(\\d+), with domain \\{(.*)\\}, placmentID group = \\{(.*)\\} and extra params \\{(.*)\\} cookies (true|false)", this::sendBasicHBSecurePostRequest);
        And("^I setup throttling for publisher (\\d+) by scenario \\{(.*)\\}$", (Integer publisherId, String scenario) -> {
            sut.getRampAppPublisherRequestModule().setupThrottling(publisherId, scenario);
        });
        Given("^i send instream video HB post request skip & duration for publisher (.+) with domain (.+), placementID group (.+), maxDuration = (.+) and skippable = (.+)$", this::sendHBVideoPostRequestOnlyDurationAndSkip);

    }


    private void sendHBVideoPostRequestOnlyDurationAndSkip(Integer publisherID,
                                                           String domain,
                                                           String placementId,
                                                           Integer maxDuration,
                                                           String skippable) {
        String extraParams = "&optimize=1";
        Integer w1 = 1111;
        Integer h1 = 2222;
        Integer playerWidth = 0;
        Integer playerHeight = 0;
        String streamType = "instream";
        Integer times = 1;
        Integer playbackMethod = -1;
        Character skipTmp = skippable.charAt(0);
        Boolean skip =  ( (skipTmp != 'Y') && (skipTmp !='N')  ) ? null : skipTmp == 'Y';
        String body = getJsonForHbVideo(publisherID, w1, h1, domain, placementId, playerWidth, playerHeight, streamType, playbackMethod, maxDuration, skip);
        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(times, body, publisherID, domain, extraParams, false, false, false);
    }

    private void sendHBVideoPostRequestOnlyPlayerSizeAndMethod(Integer publisherID,
                                                               String domain,
                                                               String placementId,
                                                               Integer playbackMethod,
                                                               Integer playerWidth,
                                                               Integer playerHeight,
                                                               Character skippable) {
        String extraParams = "&optimize=1";
        Integer w1 = 1111;
        Integer h1 = 2222;
        String streamType = "instream";
        Integer times = 1;
        Integer maxDuration = -1;
        Boolean skip = true ? skippable == 'Y' : false;
        String body = getJsonForHbVideo(publisherID, w1, h1, domain, placementId, playerWidth, playerHeight, streamType, playbackMethod, maxDuration, skip);
        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(times, body, publisherID, domain, extraParams, false, false, false);
    }


    private void sendBasicHBSecurePostRequest(Integer times, Integer publisherID, Integer h1, Integer w1, String domain, String placmentID, String extraParams, String sendCookies) {
        String body = getJsonForBasicReq(publisherID, h1, w1, domain, placmentID);
        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(times, body, publisherID, domain, extraParams, false, false, Boolean.parseBoolean(sendCookies));
    }


    private void sendHBSecurePostRequestMultiSized(Integer publisherID, Integer h1, Integer w1, Integer h2, Integer w2, String domain, String placmentID, String extraParams) {
        String body = getJsonForMultisizes(publisherID, h1, w1, h2, w2, domain, placmentID);

        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(1, body, publisherID, domain, extraParams, true, false, false);
    }


    private void sendHBSecurePostRequestMultibid(Integer publisherID, String firstBidReqId, Integer h1, Integer w1, String secBidReqId, Integer h2, Integer w2, String domain, String extraParams) {
        String body = getJsonForMultiJsonBidreqID(publisherID, firstBidReqId, h1, w1, secBidReqId, h2, w2, domain);
        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(1, body, publisherID, domain, extraParams, true, true, false);

    }

    private void sendHBPostRequestBidIDcount(Integer times, Integer publisherID, Integer size1, Integer size2, String domain, String extraParams) {
//        if(headerBiddingPostRequests == null)
//        {
//            throw new AssumptionViolatedException("you must initialize the mapper, verify tag @headerBidding is in your feature file");
//        }
        if (domain.equals("empty")) {
            domain = "";
        }
        String body = getJsonForPublisher3708WithBidID(domain, size1, size2, publisherID);
        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(times, body, publisherID, domain, extraParams, true, false, false);
    }

    private String getJsonForPublisher3708WithBidID(String domain, Integer size1, Integer size2, Integer pubID) {
        Bidreq++;
        String body =
                "{\"x-ut-hb-params\":[\n" +
                        "  {\n" +
                        " \"bidRequestId\": \"" + Bidreq + "\",\n" +
                        " \"domain\": \"" + domain + "\",\n" +
                        " \"publisherId\":  \"" + pubID + "\",\n" +
                        " \"sizes\": [\n" +
                        "      [" + size1 + "," + size2 + "]\n" +
                        "    ],\n" +
                        " \"timeout\": 700,\n" +
                        " \"hbadaptor\": \"prebid\",\n" +
                        " \"publisherId\":  \"" + pubID + "\"\n" +
                        "  }]}";
        return body;
    }

    private String getJsonForMultiJsonBidreqID(Integer publisherID, String firstBidReq, Integer h1, Integer w1, String secBidReq, Integer h2, Integer w2, String domain) {
        String body =
                "{\"x-ut-hb-params\":[\n" +
                        "  {\n" +
                        " \"testRequestId\": \"" + firstBidReq + "\",\n" +
                        " \"domain\": \"" + domain + "\",\n" +
                        " \"placementId\": \"10433394\",\n" +
                        " \"publisherId\":  \"" + publisherID + "\",\n" +
                        " \"sizes\": [\n" +
                        "      [" + h1 + "," + w1 + "]\n" +
                        "    ],\n" +
                        " \"timeout\": 700,\n" +
                        " \"hbadaptor\": \"prebid\",\n" +
                        " \"params\": {\"placementId\" : \"10433394\",\n" +
                        " \"publisherId\" : \"" + publisherID + "\"\n" +
                        " }\n" +
                        "},";
        Bidreq++;
        body += "{\"testRequestId\": \"" + secBidReq + "\",\n" +
                " \"domain\": \"" + domain + "\",\n" +
                " \"placementId\": \"10433394\",\n" +
                " \"publisherId\": \"" + publisherID + "\",\n" +
                " \"sizes\": [\n" +
                "      [" + h1 + "," + w1 + "]\n" +
                "    ],\n" +
                " \"timeout\": 700,\n" +
                " \"hbadaptor\": \"prebid\",\n" +
                " \"params\": {\"placementId\" : \"10433394\",\n" +
                " \"publisherId\" : \"" + publisherID + "\"\n" +
                "}\n" +
                "}\n" +
                "]}";
        return body;
    }


    private String getJsonForMultisizes(Integer publisherID, Integer h1, Integer w1, Integer h2, Integer w2, String domain, String placementId) {
        String body =
                "{\"x-ut-hb-params\":[\n" +
                        "  {\n" +
                        " \"bidRequestId\": \"123\"," + "\n" +
                        " \"domain\": \"" + domain + "\",\n" +
                        " \"placementId\": \"" + placementId + "\",\n" +
                        " \"publisherId\":  \"" + publisherID + "\",\n" +
                        " \"sizes\": [\n" +
                        "[" + h1 + "," + w1 + "],[" + h2 + "," + w2 + "]],\n" +
                        " \"timeout\": 700,\n" +
                        " \"hbadaptor\": \"prebid\",\n" +
                        " \"params\": {\"placementId\" : \"" + placementId + "\",\n" +
                        " \"publisherId\" : \"" + publisherID + "\"\n" +
                        " }\n" +
                        "}]}";
        return body;
    }


    private String getJsonForBasicReq(Integer publisherID, Integer h1, Integer w1, String domain, String placementId) {
        String body =
                "{\"x-ut-hb-params\":[\n" +
                        "  {\n" +
                        " \"bidRequestId\": \"123\"," + "\n" +
                        " \"domain\": \"" + domain + "\",\n" +
                        " \"placementId\": \"" + placementId + "\",\n" +
                        " \"publisherId\":  \"" + publisherID + "\",\n" +
                        " \"sizes\": [\n" +
                        "      [" + h1 + "," + w1 + "]\n" +
                        "    ],\n" +
                        " \"timeout\": 700,\n" +
                        " \"hbadaptor\": \"prebid\",\n" +
                        " \"params\": {\"placementId\": \"" + placementId + "\",\n" +
                        " \"publisherId\" : \"" + publisherID + "\"\n" +
                        "  }}]\n" +
                        "}";
        return body;
    }

    //&&&&&&&&&&&&&&&&  FOR VIDEO HB  &&&&&&&&&&&&&&&&&&

    private String getJsonForHbVideo(Integer publisherID,
                                     Integer w1, Integer h1,
                                     String domain,
                                     String placementId,
                                     Integer playerWidth, Integer playerHeight,
                                     String streamType,
                                     Integer playbackMethod,
                                     Integer maxDuration,
                                     Boolean skippable) {
        String body = "{\n" +
                "  \"x-ut-hb-params\": [\n" +
                "    {\n" +
                "      \"bidRequestId\": \"2a06ed752de49f\",\n" +
                "      \"hbadaptor\": \"prebid\",\n" +
                "      \"domain\": \"" + domain + "\",\n" +
                "      \"placementId\":" + placementId + ",\n" +
                "      \"publisherId\":" + publisherID + ",\n" +
                "      \"sizes\": [\n" +
                "        [" + w1 + "," + h1 + "]\n" +
                "      ],\n" +
                "      \"params\": {\n" +
                "        \"publisherId\":" + publisherID + "\n" +
                "      },\n" +
                "      \"video\": {\n" +
                "        \"playerSize\": [\n" +
                "          [" + playerWidth + "," + playerHeight + "]\n" +
                "        ],\n" +
                "        \"streamType\": \"" + streamType + "\",\n" +
                "        \"playbackMethod\": " + playbackMethod + ",\n" +
                "        \"maxDuration\": " + maxDuration + ",\n" +
                "        \"skippable\": " + skippable + "\n" +
                "      },\n" +
                "      \"mediaType\": \"video\"\n" +
                "    }\n" +
                "  ]\n" +
                "}";
        return body;
    }
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    private void setBidMapByEntity(String entity) {
        mapByEntity = entity;
        responses = new ArrayList<>();
        bidCounterMap = new HashMap<>();
        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            try {
                JsonNode contentAsJsonNode = mapper.readTree(content);
                responses.add(contentAsJsonNode);
            } catch (Exception e) {
                throw new AssertionError("error while parsing HB response");
            }
        });
        responses.forEach(response ->
        {
            response.forEach(jsonNode ->
            {
                String key = jsonNode.get("bidRequestId").textValue();
                Integer key2 = jsonNode.get(mapByEntity).intValue();
                Map<Integer, AtomicInteger> innerMap = bidCounterMap.computeIfAbsent(key, (k) -> new HashMap<>());
                AtomicInteger counter = innerMap.computeIfAbsent(key2, (k) -> new AtomicInteger(0));
                counter.incrementAndGet();
            });
        });

        bidCounterMap.forEach((bid, map) ->
        {
            sut.write("bid id: " + bid + " has the values of:");
            map.forEach((k, v) ->
            {
                sut.write(mapByEntity + ": " + k.toString() + ", count: " + v.toString());
            });
        });
    }

    private void responsesContainEntityByBidIdWithValue(String bidId, String entity, Integer value, Integer percent) {
        Assert.assertNotNull("bid mapper doesn't exist", bidCounterMap);
        Assert.assertEquals("inconsistent mapping..", mapByEntity, entity);
        Assert.assertTrue("bid id " + bidId + " doesn't exist", bidCounterMap.containsKey(bidId));
        Assert.assertTrue("entity with id: " + value + " doesn't exist in responses", bidCounterMap.get(bidId).containsKey(value));
        Assert.assertNotEquals("responses size are 0", responses.size(), 0);
        double actualRate = bidCounterMap.get(bidId).get(value).doubleValue() / responses.size();
        assertEquals("rate of " + entity + " in responses urls", percent,
                actualRate * 100, 10d);
    }


    private void responsesContainEntityByBidIdWithName(String bidId, String entity, String name, Integer percent) {
        responsesContainEntityByBidIdWithValue(bidId, entity, getEntityId(entity, name), percent);
    }

    private Map<String, Integer> getBidMapperFromResponse(JsonNode responseInJson) {
        Map<String, Integer> bidIdMapper = new HashMap<>();
        Integer index = 0;
        for (JsonNode js : responseInJson) {
            bidIdMapper.put(js.get("bidRequestId").textValue(), index++);
        }
        return bidIdMapper;
    }

    private void responsesContainEntityWithValue(String entity, String value) {
        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            JsonNode responseInJson = null;
            try {
                responseInJson = mapper.readTree(content);
                System.out.println("response = " + responseInJson);
                Assert.assertNotNull("response not contains entity named: " + entity, responseInJson.get(0).get(entity));
                Assert.assertEquals(value, responseInJson.get(0).get(entity).toString());
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }

    private void HBResponsesContainOneOnOf(String entity, String banners_names) {
        List<Integer> bannersIds = Arrays.stream(banners_names.split(",")).map(name -> getEntityId(entity, name)).collect(Collectors.toList());

        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            JsonNode responseInJson = null;
            try {
                responseInJson = mapper.readTree(content);
                Assert.assertNotNull("response not contains entity named: " + entity, responseInJson.get(0).get(entity));
                Assert.assertThat(responseInJson.get(0).get(entity).intValue(), isIn(bannersIds));
            } catch (Exception e) {
                e.printStackTrace();
            }
        });

    }

    private void sendHeaderBiddingSecurePostRequest(Integer times, String scenario, Integer publisherID, String domain, String extraParams) {
        if (headerBiddingPostRequests == null) {
            try {
                headerBiddingPostRequests = mapper.readTree(this.getClass().getResourceAsStream(HEADER_BIDDING_SOURCE_FILE_PATH));
            } catch (Exception e) {
                e.printStackTrace();
            }
            //throw new AssumptionViolatedException("you must initialize the mapper, verify tag @headerBidding is in your feature file");
        }
        JsonNode jsonNode = headerBiddingPostRequests.get(scenario);
        Assert.assertNotNull("There is no suitable scenario for scenario: " + scenario, jsonNode);
        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(times, jsonNode.toString(), publisherID, domain, extraParams, true, true, false);
    }


    public void sendHeaderBiddingPostRequest(Integer times, String scenario, Integer publisherID, String domain, String extraParams) {
        if (headerBiddingPostRequests == null) {
            try {
                headerBiddingPostRequests = mapper.readTree(this.getClass().getResourceAsStream(HEADER_BIDDING_SOURCE_FILE_PATH));
            } catch (Exception e) {
                e.printStackTrace();
            }
            //throw new AssumptionViolatedException("you must initialize the mapper, verify tag @headerBidding is in your feature file");
        }
        JsonNode jsonNode = headerBiddingPostRequests.get(scenario);
        Assert.assertNotNull("There is no suitable scenario for scenario: " + scenario, jsonNode);
        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(times, jsonNode.toString(), publisherID, domain, extraParams, true, false, false);
    }

    public void responsesContainEntityWithId(String entity, Integer id) {

        responsesContainEntityWithValue(entity, String.valueOf(id));
    }

    public void responsesAdsContainEntityWithName(String entity, String name) {
        String value = String.valueOf(getEntityId(entity, name));
        responsesAdsContainEntityWithId(entity, value);

    }


    public void responsesAdsContainEntityWithId(String entity, String value) {
        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            try {
                Assert.assertNotNull("response not contains entity named: " + entity.toLowerCase(), content);
                assertTrue("responses not contains " + entity + " with value: " + value + ", response has ad: " + content,
                        content.contains(entity.toLowerCase() + "=" + value));
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }


    private void responsesContainEntityWithName(String entity, String name) {
        responsesContainEntityWithId(entity, getEntityId(entity, name));
    }

    public Integer getEntityId(String entity, String name) {
        String myEntity;
        switch (entity.toLowerCase()) {
            case "adid":
                myEntity = "banner";
                break;
            case "campaignid":
                myEntity = "campaign";
                break;
            case "zoneid":
                myEntity = "zone";
                break;
            default:
                myEntity = null;
        }
        return sut.getExecutorCampaignManager().getterFor(myEntity).apply(name).orElseThrow(() -> new AssertionError(name + " wasn't found")).getId();
    }
}
