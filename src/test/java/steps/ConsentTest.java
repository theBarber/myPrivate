package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import entities.Zone;
import model.Country;
import model.ResponseType;
import org.junit.runner.RunWith;
import util.TestsRoutines;
import util.api.UasApi;
import util.consent.CcpaCharacter;
import util.consent.GdprConsentStringBuilder;
import util.consent.UtCcpaGenerator;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = {
                "classpath:consent/gdpr/zonereq/NoParam.feature",
                "classpath:consent/gdpr/zonereq/SingleParam.feature",
                "classpath:consent/gdpr/zonereq/Params.feature",
                "classpath:consent/gdpr/dyntag/NoParam.feature",
                "classpath:consent/gdpr/dyntag/SingleParam.feature",
                "classpath:consent/gdpr/dyntag/Params.feature",
                "classpath:consent/gdpr/hb/NoParam.feature",
                "classpath:consent/gdpr/hb/SingleParam.feature",
                "classpath:consent/gdpr/hb/Params.feature",
                "classpath:consent/ccpa/zonereq/NoParam.feature",
                "classpath:consent/ccpa/zonereq/SingleParam.feature",
                "classpath:consent/ccpa/hb/NoParam.feature",
                "classpath:consent/ccpa/hb/SingleParam.feature",
                "classpath:consent/ccpa/dynTag/ccpaDynamicTag.feature"
        },
        plugin = {"pretty",})
public class ConsentTest extends BaseTest {
    private static final Integer ZONE_ID = 2;
    private static final Integer PUBLISHER_ID = 3711;
    private static final String PUBLISHER_PARAMS = "&domain=test.com&requestid=newGDPR&unlimited=1&optimize=1&tagid=198";

    private static final String HB_REQ_BODY = getGdprHbReqBody();
    private static final String HB_REQ_DOMAIN = "DynamicPricingWithMargin.com";
    private static final String HB_REQ_ADAPTOR = "prebid";
    private static final String HB_BID_REQ_ID = "21b46f0d859b35";
    private static final String HB_PUB_ID = "3836";
    private static final String HB_SIZES = "[[970,250]]";
    private static final String HB_EXTRA_URL_PARAMS = "&sim_geo=1&country=us";

    private static final String INCLUDES = "includes";

    private static final String NOT_APPLICABLE_CCPA_STR = UtCcpaGenerator.getInstance().getNotApplicableUsPrivacyString();

    private final StringBuilder sb = new StringBuilder();

    public ConsentTest() {
        super();

        Given("I add \\{([^\"]*)\\} ip header", (Country country) -> {
            final String ip = country.getIps().iterator().next();
            TestsRoutines.addCountryIpHeader(ip);
        });

        /* zone reqs */
        Given("I send (\\d+) times an ad request for consent entities to UAS", this::sendConsentZoneReq);
        Given("^I send (\\d+) times an ad request for consent entities to UAS with us privacy string containing opt-out=(Y|N|NOT_APPLICABLE)$", (Integer times, CcpaCharacter optOutChr) -> {
            sendParameteredConsentZoneReq(times, "ccpa=" + utCcpaStr(optOutChr));
        });


        // sending zone request by zone name - CCPA
        Given("^I send (\\d+) times an ad request for consent entities to UAS with us privacy string containing opt-out=(Y|N|NOT_APPLICABLE) for zone named? \\{(.*)\\} to UAS$", (Integer times, CcpaCharacter optOutChr, String zoneByName) -> {
            //sendMultipleAdRequestsWithParameter(times, "ccpa=" + utCcpaStr(optOutChr), zoneName);
            String parameter = "ccpa=" + utCcpaStr(optOutChr);
            Zone zone = sut.getExecutorCampaignManager().getZone(zoneByName)
                    .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
            sut.getUASRquestModule().zoneRequestsWithParameter(zone.getId(), parameter, times, true);
        });



        Given("^I send (\\d+) times an ad request for consent entities to UAS with gdpr=(0|1)$", (Integer times, Integer gdpr) -> {
            sendParameteredConsentZoneReq(times, "gdpr=" + gdpr);
        });
        Given("^I send (\\d+) times an ad request for consent entities to UAS with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids$", (Integer times, String utVendorIdInclusion, String utPurposeIdsInclusion) -> {
            final String gdprstr = "gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, gdprstr, ZONE_ID, true);
        });


        // sending zone request by with gdprstr & zone name
        Given("^I send (\\d+) times an ad request for consent entities to UAS with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids for zone named? \\{(.*)\\} to UAS$", (Integer times, String utVendorIdInclusion, String utPurposeIdsInclusion, String zoneByName ) -> {
            final String gdprstr = "gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            //UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, gdprstr, ZONE_ID, true);
            Zone zone = sut.getExecutorCampaignManager().getZone(zoneByName)
                    .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
            sut.getUASRquestModule().zoneRequestsWithParameter(zone.getId(), gdprstr, times, true);
        });



        Given("I send (\\d+) times an ad request for consent entities to UAS with an empty gdprstr", (Integer times) -> {
            UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, "gdprstr=", ZONE_ID, true);
        });


        // sending zone request by with empty gdprstr & zone name
        Given("I send (\\d+) times an ad request for consent entities to UAS with an empty gdprstr for zone named? \\{(.*)\\} to UAS$", (Integer times,String zoneByName) -> {
            //UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, "gdprstr=", ZONE_ID, true);
            String param = "gdprstr=";
            Zone zone = sut.getExecutorCampaignManager().getZone(zoneByName)
                    .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
            sut.getUASRquestModule().zoneRequestsWithParameter(zone.getId(), param, times, true);
        });


        Given("^I send (\\d+) times an ad request for consent entities to UAS with gdpr=(0|1) and with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids$", (Integer times, Integer gdpr, String utVendorIdInclusion, String utPurposeIdsInclusion) -> {
            final String params = "gdpr=" + gdpr + "&gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            sendParameteredConsentZoneReq(times, params);
        });


        // sending zone request by zone name - GDPR
        Given("^I send (\\d+) times an ad request for consent entities to UAS with gdpr=(0|1) and with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids for zone named? \\{(.*)\\} to UAS$", (Integer times, Integer gdpr, String utVendorIdInclusion, String utPurposeIdsInclusion, String zoneByName) -> {
            final String params = "gdpr=" + gdpr + "&gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            //sendParameteredConsentZoneReq(times, params);
            Zone zone = sut.getExecutorCampaignManager().getZone(zoneByName)
                    .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
            sut.getUASRquestModule().zoneRequestsWithParameter(zone.getId(), params, times, true);
        });



        Given("^I send (\\d+) times an ad request for consent entities to UAS with gdpr=(0|1) and with an empty gdprstr$", (Integer times, Integer gdpr) -> {
            final String params = "gdpr=" + gdpr + "&gdprstr=";
            sendParameteredConsentZoneReq(times, params);
        });


    // empty string by zone name - GDPR
        Given("^I send (\\d+) times an ad request for consent entities to UAS with gdpr=(0|1) and with an empty gdprstr for zone named? \\{(.*)\\} to UAS$$", (Integer times, Integer gdpr, String zoneByName) -> {
            final String params = "gdpr=" + gdpr + "&gdprstr=";
            //sendParameteredConsentZoneReq(times, params);
            Zone zone = sut.getExecutorCampaignManager().getZone(zoneByName)
                    .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
            sut.getUASRquestModule().zoneRequestsWithParameter(zone.getId(), params, times, true);
        });




        /* dynamic tag reqs */
        Given("I send (\\d+) times Dynamic Tag ad request to UAS for consent publisher's entities", (Integer times) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), PUBLISHER_PARAMS);
        });
        Given("^I send (\\d+) times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids$", (Integer times, String utVendorIdInclusion, String utPurposeIdsInclusion) -> {
            final String gdprstr = "gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams(gdprstr));
        });


        //@@@@@@@@@@@@@@@@  sending DT request with gdprstr - GDPR
        Given("^I send (\\d+) times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids for publisher (\\d+) with extra params \\{(.*)\\}$", (
                Integer times,
                String utVendorIdInclusion,
                String utPurposeIdsInclusion,
                Integer publisherID,
                String params) -> {
            final String gdprstr = "&gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            String allParams = "&domain=" + params + gdprstr;
            UasApi.sendDynamicTagRequestsToUASWithParams(times, publisherID.toString(), allParams);
        });



        Given("I send (\\d+) times Dynamic Tag ad request to UAS for consent publisher's entities with an empty gdprstr", (Integer times) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams("gdprstr="));
        });

        //@@@@@@@@@@@@@@@@  sending DT request with empty gdprstr - GDPR
        Given("I send (\\d+) times Dynamic Tag ad request to UAS for consent publisher's entities with an empty gdprstr for publisher (\\d+) with extra params \\{(.*)\\}$", (
                Integer times,
                Integer publisherID,
                String params) -> {
            String allParams = "&domain=" + params + "&gdprstr=";
            UasApi.sendDynamicTagRequestsToUASWithParams(times, publisherID.toString(), allParams);
        });

        Given("^I send (\\d+) times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=(0|1) and with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids$", (Integer times, Integer gdpr, String utVendorIdInclusion, String utPurposeIdsInclusion) -> {
            final String params = "gdpr=" + gdpr + "&gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams(params));
        });


        //@@@@@@@@@@@@@@@@  sending DT request with gdprstr - GDPR and params included/excluded + gdpr
        Given("^I send (\\d+) times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=(0|1) and with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids for publisher (\\d+) with extra params \\{(.*)\\}$", (
                Integer times,
                Integer gdpr,
                String utVendorIdInclusion,
                String utPurposeIdsInclusion,
                Integer publisherID,
                String params) -> {
            final String extraParams = "&gdpr=" + gdpr + "&gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            String allParams = "&domain=" + params + extraParams;
            UasApi.sendDynamicTagRequestsToUASWithParams(times, publisherID.toString(), allParams);
        });




        Given("^I send (\\d+) times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=(0|1) and with an empty gdprstr$", (Integer times, Integer gdpr) -> {
            final String params = "gdpr=" + gdpr + "&gdprstr=";
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams(params));
        });

        //@@@@@@@@@@@@@@@@  sending DT request with empty gdprstr - GDPR and params included/excluded + gdpr
        Given("I send (\\d+) times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=(0|1) and with an empty gdprstr for publisher (\\d+) with extra params \\{(.*)\\}$", (
                Integer times,
                Integer gdpr,
                Integer publisherID,
                String params) -> {
            String allParams = "&domain=" + params + "&gdpr=" + gdpr + "&gdprstr=";
            UasApi.sendDynamicTagRequestsToUASWithParams(times, publisherID.toString(), allParams);
        });

        Given("^I send (\\d+) times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=(0|1)$", (Integer times, Integer gdpr) -> {
           final String gdprParam = "gdpr=" + gdpr;
           UasApi.sendDynamicTagRequestsToUAS(times, PUBLISHER_ID.toString(), getExtendedPubParams(gdprParam));
        });

        /* hb reqs */
        Given("I send (\\d+) times Header Bidding request for consent entities", (Integer times) -> {
            UasApi.sendHbPostReq(times, HB_REQ_BODY, Integer.valueOf(HB_PUB_ID), HB_REQ_DOMAIN, HB_EXTRA_URL_PARAMS, true, false,false);
        });
        Given("^I send (\\d+) times Header Bidding request for consent entities with us privacy string containing opt-out=(Y|N|NOT_APPLICABLE)$", (Integer times, CcpaCharacter optOut) -> {
            final String hbCcpaParams = HB_EXTRA_URL_PARAMS + "&ccpa=" + utCcpaStr(optOut);
            UasApi.sendHbPostReq(times, HB_REQ_BODY, Integer.valueOf(HB_PUB_ID), HB_REQ_DOMAIN, hbCcpaParams, true, false,false);
        });

        //&&&&  sending HB request with body parameters  - CCPA
        Given("I send (\\d+) times Header Bidding request for consent entities for publisher (\\d+) with size - h1:(\\d+) w1:(\\d+), with domain \\{(.*)\\} with us privacy string containing opt-out=(Y|N|NOT_APPLICABLE)$",(
                Integer times,
                Integer publisherID,
                Integer h1,
                Integer w1,
                String domain,
                CcpaCharacter optOut)  -> {
            final String hbCcpaParams = "&ccpa=" + utCcpaStr(optOut);
            String body = getJsonBody(publisherID, h1, w1, domain);
            UasApi.sendHbPostReq(times, body, Integer.valueOf(publisherID), domain, hbCcpaParams, true, false,false);
        });

        Given("^I send (\\d+) times Header Bidding request for consent entities with gdpr=(0|1)$", (Integer times, Integer gdpr) -> {
            final String hbGdprParams = HB_EXTRA_URL_PARAMS + "&gdpr=" + gdpr;
            UasApi.sendHbPostReq(times, HB_REQ_BODY, Integer.valueOf(HB_PUB_ID), HB_REQ_DOMAIN, hbGdprParams, true, false,false);
        });
        Given("I send (\\d+) times Header Bidding request for consent entities with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids" ,(Integer times, String utVendorIdInclusion, String utPurposeIdsInclusion) -> {

            final String gdprstr = "gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            final String hbGdprGdprstrParams = HB_EXTRA_URL_PARAMS + "&" + gdprstr;
            UasApi.sendHbPostReq(times, HB_REQ_BODY, Integer.valueOf(HB_PUB_ID), HB_REQ_DOMAIN, hbGdprGdprstrParams, true, false,false);
        });

        //&&&&  sending HB request with body parameters  - GDPR
        Given("I send (\\d+) times Header Bidding request for consent entities with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids for publisher (\\d+) with size - h1:(\\d+) w1:(\\d+), with domain \\{(.*)\\}",(
                        Integer times,
                        String utVendorIdInclusion,
                        String utPurposeIdsInclusion,
                        Integer publisherID,
                        Integer h1,
                        Integer w1,
                        String domain)  -> {
            final String gdprstr = "gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            final String hbGdprGdprstrParams = "&" + gdprstr;
            String body = getJsonBody(publisherID, h1, w1, domain);
            UasApi.sendHbPostReq(times, body, Integer.valueOf(publisherID), domain, hbGdprGdprstrParams, true, false,false);
        });


        Given("I send (\\d+) times Header Bidding request for consent entities with an empty gdprstr", (Integer times) -> {
            final String hbGdprGdprstrParams = HB_EXTRA_URL_PARAMS + "&gdprstr=";
            UasApi.sendHbPostReq(times, HB_REQ_BODY, Integer.valueOf(HB_PUB_ID), HB_REQ_DOMAIN, hbGdprGdprstrParams, true, false,false);
        });

        //%%%% sending HB request with body parameters - empty gdprstr
        Given("I send (\\d+) times Header Bidding request for consent entities with an empty gdprstr for publisher (\\d+) with size - h1:(\\d+) w1:(\\d+), with domain \\{(.*)\\}", (
                Integer times,
                Integer publisherID,
                Integer h1,
                Integer w1,
                String domain)  -> {
            final String hbGdprGdprstrParams = "&gdprstr=";
            String body = getJsonBody(publisherID, h1, w1, domain);
            UasApi.sendHbPostReq(times, body, Integer.valueOf(publisherID), domain, hbGdprGdprstrParams, true, false,false);
        });


        Given("^I send (\\d+) times Header Bidding request for consent entities with gdpr=(0|1) and gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids$", (Integer times, Integer gdpr, String utVendorIdInclusion, String utPurposeIdsInclusion) -> {
            final String gdprstr = utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            final String hbGdprGdprstrParams = HB_EXTRA_URL_PARAMS + "&gdpr=" + gdpr + "&gdprstr=" + gdprstr;
            UasApi.sendHbPostReq(times, HB_REQ_BODY, Integer.valueOf(HB_PUB_ID), HB_REQ_DOMAIN, hbGdprGdprstrParams, true, false,false);
        });
        Given("^I send (\\d+) times Header Bidding request for consent entities with gdpr=(0|1) and an empty gdprstr$", (Integer times, Integer gdpr) -> {
            final String hbGdprGdprstrParams = HB_EXTRA_URL_PARAMS + "&gdpr=" + gdpr + "&gdprstr=";
            UasApi.sendHbPostReq(times, HB_REQ_BODY, Integer.valueOf(HB_PUB_ID), HB_REQ_DOMAIN, hbGdprGdprstrParams, true, false,false);
        });

        Then("I expect delivery", () -> {
            TestsRoutines.verifyResponse(ResponseType.DELIVERY);
        });

        Then("^I expect (clk|imp|req|hbl|wel|evt|prf) consent passback$", (String logType) -> {
            TestsRoutines.verifyResponse(ResponseType.CONSENT_PASSBACK);
        });
    }

    private String getExtendedPubParams(String params) {
        sb.setLength(0);
        sb.append(PUBLISHER_PARAMS).append("&").append(params);
        return sb.toString();
    }

    private static String getGdprHbReqBody() {
        final String gdprHbBody = "{\n" +
                "    \"x-ut-hb-params\": [\n" +
                "        {\n" +
                "            \"bidRequestId\": \"" + HB_BID_REQ_ID + "\",\n" +
                "            \"domain\": \"" + HB_REQ_DOMAIN + "\",\n" +
                "            \"publisherId\": \"" + HB_PUB_ID + "\",\n" +
                "            \"sizes\": " + HB_SIZES + ",\n" +
                "            \"hbadaptor\": \"" + HB_REQ_ADAPTOR + "\"\n" +
                "        }\n" +
                "    ]\n" +
                "}\n";
        return gdprHbBody;
    }

    private void sendConsentZoneReq(Integer times) {
        UasApi.sendZoneReq(ZONE_ID, times, true);
    }

    private void sendParameteredConsentZoneReq(Integer times, String parameter) {
        UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, parameter, ZONE_ID, true);
    }

    private String utGdprStr(boolean isUtVendorIdIncluded, boolean isUtPurposeIdsIncluded) {
        return new GdprConsentStringBuilder(isUtVendorIdIncluded, isUtPurposeIdsIncluded).build();
    }

    private String utCcpaStr(CcpaCharacter optoutChr) {
        return UtCcpaGenerator.getInstance().getUtDefaultUsPrivacyString(optoutChr);
    }

    private String getJsonBody(Integer publisherID, Integer h1, Integer w1, String domain) {
            String body =
                    "{\"x-ut-hb-params\":[\n" +
                            "  {\n" +
                            " \"bidRequestId\": \"123\"," + "\n" +
                            " \"domain\": \"" + domain + "\",\n" +
                            " \"publisher_id\":  \"" + publisherID + "\",\n" +
                            " \"sizes\":[" + h1 + "," + w1 + "],\n" +
                            " \"timeout\": 700,\n" +
                            " \"hbadaptor\": \"prebid\",\n" +
                            " \"publisherId\" : \"" + publisherID + "\"\n" +
                            " }\n" +
                            "]}";
            return body;
        }
}
