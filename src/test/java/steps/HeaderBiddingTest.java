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
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

import static org.hamcrest.Matchers.isIn;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:HeaderBidding.feature", plugin = {"pretty",})
//        "infra.RotatingJSONFormatter:target/cucumber/HeaderBidding_$TIMESTAMP$.json"})
public class HeaderBiddingTest extends BaseTest {
    final private String HEADER_BIDDING_SOURCE_FILE_PATH = "/input_files/headerBiddingPostRequests.json";
    final private Integer NO_UT_INDEX = 3;
    private ObjectMapper mapper = new ObjectMapper();
    private JsonNode headerBiddingPostRequests;
    private List<JsonNode> responses;
    private Map<String,Map<Integer,AtomicInteger>> bidCounterMap;
    String mapByEntity;
    private  Integer Bidreq = 0;


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

        Given("i send (\\d+) headerBidding post request for scenario \\{(.*)\\} for publisher (\\d+) with domain \\{(.*)\\} with extra params \\{(.*)\\}",this::sendHeaderBiddingPostRequest);
        Given("i send (\\d+) headerBidding secure post request for scenario \\{(.*)\\} for publisher (\\d+) with domain \\{(.*)\\} with extra params \\{(.*)\\}",this::sendHeaderBiddingSecurePostRequest);
        And("all HB responses contains? (.*) with id (\\d+)",this::responsesContainEntityWithId);
        And("all HB responses contains (\\w+) with value \\{(.*)\\}",this::responsesContainEntityWithValue);
        And("all HB responses contains (campaignId|adId) with id of entity named? \\{(.*)\\}$",this::responsesContainEntityWithName);
        And("all HB responses contains ad impression with? (.*) of entity named? \\{(.*)\\}$",this::responsesAdsContainEntityWithName);
        And("all HB responses contains ad impression with? (.*) with value? \\{(.*)\\}$",this::responsesAdsContainEntityWithId);
        And("i read all HB responses and map their bidId by? (.*)$",this::setBidMapByEntity);
        And("in HB responses bidid (\\w+) has entity of (campaignId|adId) with name \\{(.*)\\} (\\d+)% of the times", this::responsesContainEntityByBidIdWithName);
        And("in HB responses bidid (\\w+) has entity of (campaignId|adId) with value (\\d+) (\\d+)% of the times", this::responsesContainEntityByBidIdWithValue);
        And("all HB responses contains (campaignId|adId) with one of: \\{(.*)\\}",this::HBResponsesContainOneOnOf);
        And("for all HB responses i simulate winning, and send their zone tag",this::sendZoneTagFromHBWithoutParam);
        And("for all HB responses i simulate winning, with extra param \\{(.*)\\}",this::sendZoneTagFromHBWithParam);
        Given("i send (\\d+) headerBidding secure post request for publisher (\\d+) with size1 = (\\d+) size2 = (\\d+), with domain \\{(.*)\\} and extra params \\{(.*)\\}",this::sendHBPostRequestBidIDcount);
        Given("i send (\\d+) headerBidding secure post request for publisher (\\d+) with size1 = (\\d+) size2 = (\\d+), bidreq = (\\d+), empty domain, and extra params \\{(.*)\\}",this::sendHBPostRequestBidIDcount);
        Given("i send 1 headerBidding secure post request for publisher (\\d+) with multi bids. first bid - bidreqID=\\{(.*)\\}, h:(\\d+) w:(\\d+), sec bid - bidreqID=\\{(.*)\\}, h:(\\d+) w:(\\d+) with domain \\{(.*)\\} and extra params \\{(.*)\\}",this::sendHBSecurePostRequestMultibid);
        Given("i send 1 headerBidding secure post request for publisher (\\d+) with multi sizes - h1:(\\d+) w1:(\\d+), h2:(\\d+) w2:(\\d+) with domain \\{(.*)\\} and placmentID group = \\{(.*)\\} and extra params  \\{(.*)\\}" ,this::sendHBSecurePostRequestMultiSized);
        Given("i send 1 basic headerBidding secure post request for publisher (\\d+) with size - h1:(\\d+) w1:(\\d+), with domain \\{(.*)\\}, placmentID group = \\{(.*)\\} and extra params  \\{(.*)\\}" ,this::sendBasicHBSecurePostRequest);

    }

    private void sendBasicHBSecurePostRequest (Integer publisherID, Integer h1, Integer w1, String domain, String placmentID, String extraParams){
        String body = getJsonForBasicReq(publisherID, h1,w1,domain, placmentID);
        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(1,body,publisherID,domain, extraParams,true,false);
    }



    private void sendHBSecurePostRequestMultiSized (Integer publisherID, Integer h1, Integer w1, Integer h2, Integer w2, String domain, String placmentID, String extraParams){
        String body = getJsonForMultisizes(publisherID, h1,w1, h2, w2,domain, placmentID);

        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(1,body,publisherID,domain, extraParams,true,false);
    }


    private void sendHBSecurePostRequestMultibid(Integer publisherID, String firstBidReqId, Integer h1, Integer w1, String secBidReqId, Integer h2, Integer w2, String domain, String extraParams){
        String body = getJsonForMultiJsonBidreqID(publisherID, firstBidReqId, h1,w1, secBidReqId, h2, w2,domain);
        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(1,body,publisherID,domain, extraParams,true,true);

    }

private void sendHBPostRequestBidIDcount(Integer times, Integer publisherID, Integer size1, Integer size2,String domain, String extraParams) {
//        if(headerBiddingPostRequests == null)
//        {
//            throw new AssumptionViolatedException("you must initialize the mapper, verify tag @headerBidding is in your feature file");
//        }
        if (domain.equals("empty")){
            domain = "";
        }
        String body = getJsonForPublisher3708WithBidID(domain,size1, size2, publisherID);
        sut.getUASRquestModule().sendMultipleHeaderBiddingPostRequests(times,body,publisherID,domain, extraParams,true,false);
    }

    private String getJsonForPublisher3708WithBidID(String domain,Integer size1,Integer size2, Integer pubID){
        Bidreq++;
        String body =
                "{\"x-ut-hb-params\":[\n" +
                        "  {\n" +
                        " \"bidRequestId\": \"" + Bidreq + "\",\n" +
                        " \"domain\": \""+ domain +"\",\n" +
                        " \"publisherId\":  \"" + pubID + "\",\n" +
                        " \"sizes\": [\n" +
                        "      [" + size1 + "," + size2 + "]\n" +
                        "    ],\n" +
                        " \"timeout\": 700,\n" +
                        " \"hbadaptor\": \"prebid\",\n" +
                        " \"publisherId\":  \"" + pubID + "\"\n" +
                        "  }]}";
        return  body;
    }

    private String getJsonForMultiJsonBidreqID(Integer publisherID, String firstBidReq, Integer h1, Integer w1, String secBidReq , Integer h2, Integer w2, String domain){
        String body =
        "{\"x-ut-hb-params\":[\n" +
                "  {\n" +
                " \"testRequestId\": \"" + firstBidReq + "\",\n" +
                " \"domain\": \""+ domain +"\",\n" +
                " \"placementId\": \"10433394\",\n" +
                " \"publisherId\":  \""+ publisherID +"\",\n" +
                " \"sizes\": [\n" +
                "      [" + h1 + "," + w1 + "]\n" +
                "    ],\n" +
                " \"timeout\": 700,\n" +
                " \"hbadaptor\": \"prebid\",\n" +
                " \"params\": {\"placementId\" : \"10433394\",\n" +
                " \"publisherId\" : \""+ publisherID +"\"\n" +
                " }\n" +
                "},";
                Bidreq++;
                body += "{\"testRequestId\": \"" + secBidReq + "\",\n" +
                        " \"domain\": \""+ domain +"\",\n" +
                        " \"placementId\": \"10433394\",\n" +
                        " \"publisherId\": \""+ publisherID +"\",\n" +
                        " \"sizes\": [\n" +
                        "      [" + h1 + "," + w1 + "]\n" +
                        "    ],\n" +
                        " \"timeout\": 700,\n" +
                        " \"hbadaptor\": \"prebid\",\n" +
                        " \"params\": {\"placementId\" : \"10433394\",\n" +
                        " \"publisherId\" : \""+ publisherID +"\"\n" +
                        "}\n" +
                        "}\n" +
                        "]}";
        return body;
    }


    private String getJsonForMultisizes(Integer publisherID, Integer h1, Integer w1, Integer h2, Integer w2, String domain,String placementId){
        String body =
                "{\"x-ut-hb-params\":[\n" +
                        "  {\n" +
                        " \"bidRequestId\": \"123\"," +"\n" +
                        " \"domain\": \""+ domain +"\",\n" +
                        " \"placementId\": \"" + placementId + "\",\n" +
                        " \"publisherId\":  \""+ publisherID +"\",\n" +
                        " \"sizes\": [\n" +
                        "[" + h1 + "," + w1 + "],["+ h2 + "," + w2  + "]],\n" +
                        " \"timeout\": 700,\n" +
                        " \"hbadaptor\": \"prebid\",\n" +
                        " \"params\": {\"placementId\" : \"10433394\",\n" +
                        " \"publisherId\" : \""+ publisherID +"\"\n" +
                        " }\n" +
                        "}]}";
        return  body;
    }


    private String getJsonForBasicReq(Integer publisherID, Integer h1, Integer w1, String domain,String placementId){
        String body =
                "{\"x-ut-hb-params\":[\n" +
                        "  {\n" +
                        " \"bidRequestId\": \"123\"," +"\n" +
                        " \"domain\": \""+ domain +"\",\n" +
                        " \"placementId\": \"" + placementId + "\",\n" +
                        " \"publisherId\":  \""+ publisherID +"\",\n" +
                        " \"sizes\": [\n" +
                        "      [" + h1 + "," + w1 + "]\n" +
                        "    ],\n" +
                        " \"timeout\": 700,\n" +
                        " \"hbadaptor\": \"prebid\",\n" +
                        " \"params\": {\"placementId\" : \"10433394\",\n" +
                        " \"publisherId\" : \""+ publisherID +"\"\n" +
                        "  }}]\n" +
                        "}" ;
        return  body;
    }






        private void setBidMapByEntity(String entity) {
        mapByEntity = entity;
        responses = new ArrayList<>();
        bidCounterMap = new HashMap<>();
        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            try
            {
                JsonNode contentAsJsonNode= mapper.readTree(content);
                responses.add(contentAsJsonNode);
            }catch (Exception e)
            {
                throw new AssertionError("error while parsing HB response");
            }
        });
        responses.forEach(response->
        {
            response.forEach(jsonNode ->
            {
                String key = jsonNode.get("bidRequestId").textValue();
                Integer key2 = jsonNode.get(mapByEntity).intValue();
                Map<Integer,AtomicInteger> innerMap = bidCounterMap.computeIfAbsent(key, (k) -> new HashMap<>());
                AtomicInteger counter = innerMap.computeIfAbsent(key2, (k) -> new AtomicInteger(0));
                counter.incrementAndGet();
            });
        });

        bidCounterMap.forEach((bid,map)->
        {
            sut.write("bid id: "+bid+ " has the values of:");
            map.forEach((k,v)->
            {
                sut.write(mapByEntity+ ": "+ k.toString() +", count: "+ v.toString());
            });
        });
    }

    private void responsesContainEntityByBidIdWithValue(String bidId, String entity, Integer value, Integer percent) {
        Assert.assertNotNull("bid mapper doesn't exist",bidCounterMap);
        Assert.assertEquals("inconsistent mapping..",mapByEntity,entity);
        Assert.assertTrue("bid id "+ bidId+ " doesn't exist", bidCounterMap.containsKey(bidId));
        Assert.assertTrue("entity with id: "+ value+ " doesn't exist in responses",bidCounterMap.get(bidId).containsKey(value));
        Assert.assertNotEquals("responses size are 0",responses.size(),0);
        double actualRate = bidCounterMap.get(bidId).get(value).doubleValue() / responses.size();
        assertEquals("rate of " + entity + " in responses urls", percent,
                actualRate * 100, 10d);
    }


    private void responsesContainEntityByBidIdWithName(String bidId, String entity, String name, Integer percent) {
        responsesContainEntityByBidIdWithValue(bidId,entity,getEntityId(entity,name),percent);
    }

    private Map<String,Integer> getBidMapperFromResponse(JsonNode responseInJson) {
        Map<String,Integer> bidIdMapper = new HashMap<>();
        Integer index = 0;
        for (JsonNode js:responseInJson) {
            bidIdMapper.put(js.get("bidRequestId").textValue(),index++);
        }
        return bidIdMapper;
    }

    private void responsesContainEntityWithValue(String entity, String value) {
        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            JsonNode responseInJson = null;
            try
            {
                responseInJson = mapper.readTree(content);
                System.out.println("response = " + responseInJson);
                Assert.assertNotNull("response not contains entity named: " + entity, responseInJson.get(0).get(entity));
                Assert.assertEquals(value,responseInJson.get(0).get(entity).toString());
            }catch (Exception e)
            {
                e.printStackTrace();
            }
        });
    }

    private void HBResponsesContainOneOnOf(String entity, String banners_names) {
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
        if(headerBiddingPostRequests == null)
        {
            throw new AssumptionViolatedException("you must initialize the mapper, verify tag @headerBidding is in your feature file");
        }
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


    public void sendZoneTagFromHBWithoutParam()
    {
        sendZoneTagFromHBWithParam(null);
    }

    public void sendZoneTagFromHBWithParam(String extraParam) {
        List<CompletableFuture<HttpResponse>> response = new ArrayList<>(sut.getUASRquestModule().responsesAsList());
        sut.getUASRquestModule().reset();
        response.stream().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            JsonNode responseInJson = null;
            try
            {
                responseInJson = mapper.readTree(content);
                String htmlWithQuery = responseInJson.get(0).get("ad").asText();
                String url = getUrlFromAd(htmlWithQuery) + Optional.ofNullable(extraParam).orElse("");
                System.out.println(url);
                sut.getUASRquestModule().sendGetRequestsAsync(1,url,false);
            }catch (Exception e)
            {
                e.printStackTrace();
            }
        });
    }


        private String getUrlFromAd(String htmlWithQuery) {
        Map<String, String> splitedQuery = splitHBQuery(htmlWithQuery);
        StringBuilder url = new StringBuilder();
        //put domain in url
        url.append(splitedQuery.entrySet().stream().findFirst().get().getValue()).append("?");

        //remove domain from map
        splitedQuery.remove(splitedQuery.entrySet().stream().findFirst().get().getKey());

        //iterate through rest of query params
        Iterator<Map.Entry<String, String>> itr = splitedQuery.entrySet().iterator();
        while(itr.hasNext())
        {
            Map.Entry<String, String> entry = itr.next();
            url.append("&" + entry.getKey().substring(entry.getKey().lastIndexOf('.') + 1)).append("=" + entry.getValue());
        }
        return url.toString();
    }

    public void responsesAdsContainEntityWithName(String entity, String name)
    {
        String value = String.valueOf(getEntityId(entity,name));
        responsesAdsContainEntityWithId(entity, value);

    }


    public void responsesAdsContainEntityWithId(String entity, String value) {
        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            JsonNode responseInJson = null;
            try
            {
                responseInJson = mapper.readTree(content);
                Assert.assertNotNull("response not contains entity named: " + entity, responseInJson.get(0).get("ad"));
                assertTrue("responses not contains "+entity+" with value: "+ value+", response has ad: "+responseInJson.get(0).get("ad").toString() ,
                        responseInJson.get(0).get("ad").toString().contains("ut."+entity.toLowerCase()+"="+value));
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

    public Integer getEntityId(String entity, String name)
    {
        String myEntity;
        switch (entity.toLowerCase()) {
            case "adid":
                myEntity = "banner";break;
            case "campaignid":
                myEntity = "campaign";break;
            case "zoneid":
                myEntity = "zone";break;
            default:
                myEntity = null;
        }
        return sut.getExecutorCampaignManager().getterFor(myEntity).apply(name).orElseThrow(() -> new AssertionError(name+" wasn't found")).getId();
    }

    public Map<String, String> splitHBQuery(String query){

        Map<String, String> query_pairs = new LinkedHashMap<String, String>();
        String[] pairs = query.split(";");
        pairs[0] = pairs[0].substring(pairs[0].indexOf("ut_ju")).trim();
        for (String pair : pairs) {
            int idx = pair.indexOf("=");
            try {
                if(pair.substring(0, idx).contains("ut") && !pair.substring(idx + 1).trim().contains(" "))
                    query_pairs.put(URLDecoder.decode(pair.substring(0, idx), "UTF-8"), URLDecoder.decode(pair.substring(idx + 1).trim().replace("'", ""), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return query_pairs;
    }
}
