package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import model.Country;
import org.junit.runner.RunWith;
import util.api.UasApi;
import util.TestsRoutines;
import util.gdpr.ConsentStringBuilder;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = {
                "classpath:gdpr/zonereq/NoParam.feature",
                "classpath:gdpr/zonereq/SingleParam.feature",
                "classpath:gdpr/dyntag/NoParam.feature",
                "classpath:gdpr/dyntag/SingleParam.feature",
        },
        plugin = {"pretty",})
public class GdprTest extends BaseTest {
    private static final Integer ZONE_ID = 2;
    private static final Integer CAMPAIGN_ID = 2;
    private static final Integer BANNER_ID = 15;
    private static final Integer PUBLISHER_ID = 3711;
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

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities", (Integer times) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), PUBLISHER_PARAMS);
        });

        Given("I send (\\d+) times Dynamic Tag ad request to UAS for gdpr publisher's entities with parameter \\{(.*)\\}", (Integer times, String parameter) -> {
            UasApi.sendDynamicTagRequestsToUASWithParams(times, PUBLISHER_ID.toString(), getExtendedPubParams(parameter));
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

        Given("I send (\\d) times an ad request for gdpr entities to UAS with an empty gdprstr", (Integer times) -> {
            UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, "gdprstr=", ZONE_ID, true);
        });

        Then("^I expect (delivery|gdpr passback)$", (String expectedResponseType) -> {
            TestsRoutines.verifyResponseBody(expectedResponseType);
        });
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
