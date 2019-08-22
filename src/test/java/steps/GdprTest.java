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
                "classpath:gdpr/hb/NoParam.feature"
        },
        plugin = {"pretty",})
public class GdprTest extends BaseTest {
    private static final Integer ZONE_ID = 2;
    private static final Integer PUBLISHER_ID = 3711;
    private static final Integer HB_PUBLISHER_ID = 3708;

    private static final String HB_REQ_DOMAIN = "HB-FC-PL.com";
    private static final String HB_BID_REQ_ID = "GDPR-HB-Testing";
    private static final String HB_GDPR_REQ_BODY_STR = getGdprHbReqBody();
//    private static final String HB_GDPR_EXPECTED_BODY_RESPONSE = getGdprHbExpectedResponse();
    private static final String PUBLISHER_PARAMS = "&domain=test.com&requestid=systemTestC&unlimited=1&optimize=0&tagid=198";

    private final StringBuilder sb = new StringBuilder();

    public GdprTest() {
        super();

        Given("I add \\{([^\"]*)\\} ip header", (Country country) -> {
            final String ip = country.getIps().iterator().next();
            TestsRoutines.addCountryIpHeader(ip);
        });

        Given("I send (\\d+) times an ad request for gdpr entities to UAS", (Integer times) -> {
            sendGdprZoneReq(times);
        });

        Given("I send (\\d+) times an ad request with parameter \\{(.*)\\} for gdpr entities to UAS", (Integer times, String paramater) -> {
            sendParameteredGdprZoneReq(times, paramater);
        });

        Given("I send (\\d+) times an ad request with parameter \\{(.*)\\} for gdpr entities to UAS and with gdprstr which includes ut vendor id and includes ut purpose ids", (Integer times, String paramater) -> {
            sendParameteredGdprZoneReq(times, paramater + "&gdprstr=" + utIdIncludedUtPurposesIncludedGdprStr());
        });

        Given("I send (\\d+) times an ad request with parameter \\{(.*)\\} for gdpr entities to UAS and with gdprstr which includes ut vendor id and excludes ut purpose ids", (Integer times, String paramater) -> {
            sendParameteredGdprZoneReq(times, paramater + "&gdprstr=" + utIdIncludedUtPurposesExcludedGdprStr());
        });

        Given("I send (\\d+) times an ad request with parameter \\{(.*)\\} for gdpr entities to UAS and with gdprstr which excludes ut vendor id and includes ut purpose ids", (Integer times, String paramater) -> {
            sendParameteredGdprZoneReq(times, paramater + "&gdprstr=" + utIdExcludedUtPurposesIncludedGdprStr());
        });

        Given("I send (\\d+) times an ad request with parameter \\{(.*)\\} for gdpr entities to UAS and with gdprstr which excludes ut vendor id and excludes ut purpose ids", (Integer times, String paramater) -> {
            sendParameteredGdprZoneReq(times, paramater + "&gdprstr=" + utIdExcludedUtPurposesExcludedGdprStr());
        });

        Given("I send (\\d+) times an ad request with parameter \\{(.*)\\} for gdpr entities to UAS with gdprstr which includes ut vendor id and includes ut purpose ids", (Integer times, String paramater) -> {
            UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, "gdprstr=" + utIdIncludedUtPurposesIncludedGdprStr(), ZONE_ID, true);
        });

        Given("I send (\\d+) times an ad request with parameter \\{(.*)\\} for gdpr entities to UAS with an empty gdprstr", (Integer times, String paramater) -> {
            UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, paramater + "&gdprstr=", ZONE_ID, true);
        });

        Given("I send (\\d+) times an ad request for gdpr entities to UAS with gdprstr which includes ut vendor id and includes ut purpose ids", (Integer times) -> {
            UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, "gdprstr=" + utIdIncludedUtPurposesIncludedGdprStr(), ZONE_ID, true);
        });

        Given("I send (\\d+) times an ad request for gdpr entities to UAS with gdprstr which includes ut vendor id and excludes ut purpose ids", (Integer times) -> {
            UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, "gdprstr=" + utIdIncludedUtPurposesExcludedGdprStr(), ZONE_ID, true);
        });

        Given("I send (\\d+) times an ad request for gdpr entities to UAS with gdprstr which excludes ut vendor id and includes ut purpose ids", (Integer times) -> {
            UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, "gdprstr=" + utIdExcludedUtPurposesIncludedGdprStr(), ZONE_ID, true);
        });

        Given("I send (\\d+) times an ad request for gdpr entities to UAS with gdprstr which excludes ut vendor id and excludes ut purpose ids", (Integer times) -> {
            UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, "gdprstr=" + utIdExcludedUtPurposesExcludedGdprStr(), ZONE_ID, true);
        });

        Given("I send (\\d+) times an ad request for gdpr entities to UAS with an empty gdprstr", (Integer times) -> {
            UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, "gdprstr=", ZONE_ID, true);
        });

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities", (Integer times) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), PUBLISHER_PARAMS);
        });

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with parameter \\{(.*)\\}", (Integer times, String parameter) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams(parameter));
        });

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdprstr which includes ut vendor id and includes ut purpose ids", (Integer times) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams("gdprstr=" + utIdIncludedUtPurposesIncludedGdprStr()));
        });

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdprstr which includes ut vendor id and excludes ut purpose ids", (Integer times) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams("gdprstr=" + utIdIncludedUtPurposesExcludedGdprStr()));
        });

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdprstr which excludes ut vendor id and includes ut purpose ids", (Integer times) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams("gdprstr=" + utIdExcludedUtPurposesIncludedGdprStr()));
        });

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdprstr which excludes ut vendor id and excludes ut purpose ids", (Integer times) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams("gdprstr=" + utIdExcludedUtPurposesExcludedGdprStr()));
        });

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with an empty gdprstr", (Integer times) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams("gdprstr="));
        });

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with parameter \\{(.*)\\} and with gdprstr which includes ut vendor id and includes ut purpose ids", (Integer times, String parameter) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams(parameter + "&gdprstr=" + utIdIncludedUtPurposesIncludedGdprStr()));
        });

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with parameter \\{(.*)\\} and with gdprstr which includes ut vendor id and excludes ut purpose ids", (Integer times, String parameter) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams(parameter + "&gdprstr=" + utIdIncludedUtPurposesExcludedGdprStr()));
        });

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with parameter \\{(.*)\\} and with gdprstr which excludes ut vendor id and includes ut purpose ids", (Integer times, String parameter) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams(parameter + "&gdprstr=" + utIdExcludedUtPurposesIncludedGdprStr()));
        });

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with parameter \\{(.*)\\} and with gdprstr which excludes ut vendor id and excludes ut purpose ids", (Integer times, String parameter) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams(parameter + "&gdprstr=" + utIdExcludedUtPurposesExcludedGdprStr()));
        });

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with parameter \\{(.*)\\} and with an empty gdprstr", (Integer times, String parameter) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams(parameter + "&gdprstr="));
        });

        Given("I send (\\d+) times Header Bidding request to UAS for gdpr entities", (Integer times) -> {
            UasApi.sendHbReq(times, HB_GDPR_REQ_BODY_STR, HB_PUBLISHER_ID, HB_REQ_DOMAIN, null);
        });

        Then("I expect delivery", () -> {
            TestsRoutines.verifyResponseBody(ResponseType.DELIVERY);
        });

        Then("I expect gdpr hb ad response", () -> {

        });

        Then("^I expect (clk|imp|req|hbl|wel|evt|prf) gdpr passback$", (String logType) -> {
            TestsRoutines.verifyResponseBody(ResponseType.GDPR_PASSBACK);
            TestsRoutines.verifyEmptyLog(logType);
        });
    }

//    private static String getGdprHbExpectedResponse() {
//
//        final String hbBody
//
//        {
//            "ad": "<html><body><script type=\"text/javascript\">var ut_ju = 'http://ads-s-us-east-1.undertone.com/aj';ut = new Object();ut.bidid='GDPR-HB-Testing';ut.bannerid=1400821;ut.zoneid=190740;ut.hbprice=0.01;ut.fallbackbannerid='';ut.fallbackzoneid='';ut.width=1;ut.height=1;ut.adaptor='prebid';ut.pid=3708;ut.extpid='';ut.domain='HB-FC-PL.com';ut.id='9t3tbqopc084lfzgbjehsz3jp';ut.stid=149;</script><script type=\"text/javascript\" src=\"http://cdn.undertone.com/js/ajs.js\"></script></body></html>",
//                "publisherId": 3708,
//                "bidRequestId": "GDPR-HB-Testing",
//                "placementId": "",
//                "adId": 1400821,
//                "campaignId": 348106,
//                "height": 1,
//                "width": 1,
//                "ttl": 720,
//                "currency": "USD",
//                "cpm": 0.01,
//                "adaptor": "prebid",
//                "netRevenue": "true"
//        }
//    }

    private static String getGdprHbReqBody() {
        final String hbInnerBody = new JSONObject()
                .put("publisherId", HB_PUBLISHER_ID)
                .put("sizes", "[1,1]")
                .put("hbadaptor", "prebid")
                .put("bidRequestId", HB_BID_REQ_ID)
                .toString();
        final String hbBody = new JSONObject()
                .put("x-ut-hb-params", "[" + hbInnerBody + "]")
                .toString();

        return hbBody;
    }

    private String getExtendedPubParams(String params) {
        sb.setLength(0);
        sb.append(PUBLISHER_PARAMS).append("&").append(params);
        return sb.toString();
    }

    private void sendGdprZoneReq(Integer times) {
        UasApi.sendZoneReq(ZONE_ID, times, true);
    }

    private void sendParameteredGdprZoneReq(Integer times, String parameter) {
        UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, parameter, ZONE_ID, true);
    }

    private String utIdIncludedUtPurposesIncludedGdprStr() {
        return new ConsentStringBuilder(true, true).build();
    }

    private String utIdIncludedUtPurposesExcludedGdprStr() {
        return new ConsentStringBuilder(true, false).build();
    }

    private String utIdExcludedUtPurposesIncludedGdprStr() {
        return new ConsentStringBuilder(false, true).build();
    }

    private String utIdExcludedUtPurposesExcludedGdprStr() {
        return new ConsentStringBuilder(false, false).build();
    }
}
