package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import model.Country;
import model.ResponseType;
import org.json.JSONObject;
import org.junit.runner.RunWith;
import util.TestsRoutines;
import util.api.UasApi;
import util.gdpr.ConsentStringBuilder;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = {
                "classpath:gdpr/zonereq/NoParam.feature",
                "classpath:gdpr/zonereq/SingleParam.feature",
                "classpath:gdpr/zonereq/Params.feature",
                "classpath:gdpr/dyntag/NoParam.feature",
                "classpath:gdpr/dyntag/SingleParam.feature",
                "classpath:gdpr/dyntag/Params.feature",
                "classpath:gdpr/hb/NoParam.feature",
                "classpath:gdpr/hb/SingleParam.feature",
                "classpath:gdpr/hb/Params.feature"
        },
        plugin = {"pretty",})
public class GdprTest extends BaseTest {
    private static final Integer ZONE_ID = 2;
    private static final Integer PUBLISHER_ID = 3711;
    private static final String PUBLISHER_PARAMS = "&domain=test.com&requestid=systemTestC&unlimited=1&optimize=0&tagid=198";

    private static final String HB_REQ_BODY = getGdprHbReqBody();
    private static final String HB_REQ_DOMAIN = "DynamicPricingWithMargin.com";
    private static final String HB_REQ_ADAPTOR = "prebid";
    private static final String HB_BID_REQ_ID = "21b46f0d859b35";
    private static final String HB_PUB_ID = "3836";
    private static final String HB_SIZES = "[[970,250]]";
    private static final String HB_EXTRA_URL_PARAMS = "&sim_geo=1&country=us";

    private static final String INCLUDES = "includes";

    private final StringBuilder sb = new StringBuilder();

    public GdprTest() {
        super();

        Given("I add \\{([^\"]*)\\} ip header", (Country country) -> {
            final String ip = country.getIps().iterator().next();
            TestsRoutines.addCountryIpHeader(ip);
        });

        /* zone reqs */
        Given("I send (\\d+) times an ad request for gdpr entities to UAS", (Integer times) -> {
            sendGdprZoneReq(times);
        });
        Given("^I send (\\d+) times an ad request for gdpr entities to UAS with gdpr=(0|1)$", (Integer times, Integer gdpr) -> {
            sendParameteredGdprZoneReq(times, "gdpr=" + gdpr);
        });
        Given("^I send (\\d+) times an ad request for gdpr entities to UAS with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids$", (Integer times, String utVendorIdInclusion, String utPurposeIdsInclusion) -> {
            final String gdprstr = "gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, gdprstr, ZONE_ID, true);
        });
        Given("I send (\\d+) times an ad request for gdpr entities to UAS with an empty gdprstr", (Integer times) -> {
            UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, "gdprstr=", ZONE_ID, true);
        });
        Given("^I send (\\d+) times an ad request for gdpr entities to UAS with gdpr=(0|1) and with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids$", (Integer times, Integer gdpr, String utVendorIdInclusion, String utPurposeIdsInclusion) -> {
            final String params = "gdpr=" + gdpr + "&gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            sendParameteredGdprZoneReq(times, params);
        });
        Given("^I send (\\d+) times an ad request for gdpr entities to UAS with gdpr=(0|1) and with an empty gdprstr$", (Integer times, Integer gdpr) -> {
            final String params = "gdpr=" + gdpr + "&gdprstr=";
            sendParameteredGdprZoneReq(times, params);
        });

        /* dynamic tag reqs */
        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities", (Integer times) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), PUBLISHER_PARAMS);
        });
        Given("^I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids$", (Integer times, String utVendorIdInclusion, String utPurposeIdsInclusion) -> {
            final String gdprstr = "gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams(gdprstr));
        });
        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with an empty gdprstr", (Integer times) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams("gdprstr="));
        });
        Given("^I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdpr=(0|1) and with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids$", (Integer times, Integer gdpr, String utVendorIdInclusion, String utPurposeIdsInclusion) -> {
            final String params = "gdpr=" + gdpr + "&gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams(params));
        });
        Given("^I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdpr=(0|1) and with an empty gdprstr$", (Integer times, Integer gdpr) -> {
            final String params = "gdpr=" + gdpr + "&gdprstr=";
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams(params));
        });
        Given("^I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdpr=(0|1)$", (Integer times, Integer gdpr) -> {
           final String gdprParam = "gdpr=" + gdpr;
           UasApi.sendDynamicTagRequestsToUAS(times, PUBLISHER_ID.toString(), getExtendedPubParams(gdprParam));
        });

        /* hb reqs */
        Given("I send (\\d+) times Header Bidding request for gdpr entities", (Integer times) -> {
            UasApi.sendHbPostReq(times, HB_REQ_BODY, Integer.valueOf(HB_PUB_ID), HB_REQ_DOMAIN, HB_EXTRA_URL_PARAMS, true, false);
        });
        Given("^I send (\\d+) times Header Bidding request for gdpr entities with gdpr=(0|1)$", (Integer times, Integer gdpr) -> {
            final String hbGdprParams = HB_EXTRA_URL_PARAMS + "&gdpr=" + gdpr;
            UasApi.sendHbPostReq(times, HB_REQ_BODY, Integer.valueOf(HB_PUB_ID), HB_REQ_DOMAIN, hbGdprParams, true, false);
        });
        Given("I send (\\d+) times Header Bidding request for gdpr entities with gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids", (Integer times, String utVendorIdInclusion, String utPurposeIdsInclusion) -> {
            final String gdprstr = "gdprstr=" + utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            final String hbGdprGdprstrParams = HB_EXTRA_URL_PARAMS + "&" + gdprstr;
            UasApi.sendHbPostReq(times, HB_REQ_BODY, Integer.valueOf(HB_PUB_ID), HB_REQ_DOMAIN, hbGdprGdprstrParams, true, false);
        });
        Given("I send (\\d+) times Header Bidding request for gdpr entities with an empty gdprstr", (Integer times) -> {
            final String hbGdprGdprstrParams = HB_EXTRA_URL_PARAMS + "&gdprstr=";
            UasApi.sendHbPostReq(times, HB_REQ_BODY, Integer.valueOf(HB_PUB_ID), HB_REQ_DOMAIN, hbGdprGdprstrParams, true, false);
        });
        Given("^I send (\\d+) times Header Bidding request for gdpr entities with gdpr=(0|1) and gdprstr which (includes|excludes) ut vendor id and (includes|excludes) ut purpose ids$", (Integer times, Integer gdpr, String utVendorIdInclusion, String utPurposeIdsInclusion) -> {
            final String gdprstr = utGdprStr(utVendorIdInclusion.equalsIgnoreCase(INCLUDES), utPurposeIdsInclusion.equalsIgnoreCase(INCLUDES));
            final String hbGdprGdprstrParams = HB_EXTRA_URL_PARAMS + "&gdpr=" + gdpr + "&gdprstr=" + gdprstr;
            UasApi.sendHbPostReq(times, HB_REQ_BODY, Integer.valueOf(HB_PUB_ID), HB_REQ_DOMAIN, hbGdprGdprstrParams, true, false);
        });
        Given("^I send (\\d+) times Header Bidding request for gdpr entities with gdpr=(0|1) and an empty gdprstr$", (Integer times, Integer gdpr) -> {
            final String hbGdprGdprstrParams = HB_EXTRA_URL_PARAMS + "&gdpr=" + gdpr + "&gdprstr=";
            UasApi.sendHbPostReq(times, HB_REQ_BODY, Integer.valueOf(HB_PUB_ID), HB_REQ_DOMAIN, hbGdprGdprstrParams, true, false);
        });

        Then("I expect delivery", () -> {
            TestsRoutines.verifyResponse(ResponseType.DELIVERY);
        });

        Then("^I expect (clk|imp|req|hbl|wel|evt|prf) gdpr passback$", (String logType) -> {
            TestsRoutines.verifyResponse(ResponseType.GDPR_PASSBACK);
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

    private void sendGdprZoneReq(Integer times) {
        UasApi.sendZoneReq(ZONE_ID, times, true);
    }

    private void sendParameteredGdprZoneReq(Integer times, String parameter) {
        UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, parameter, ZONE_ID, true);
    }

    private String utGdprStr(boolean isUtVendorIdIncluded, boolean isUtPurposeIdsIncluded) {
        return new ConsentStringBuilder(isUtVendorIdIncluded, isUtPurposeIdsIncluded).build();
    }
}
