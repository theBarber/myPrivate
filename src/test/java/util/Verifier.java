package util;

import co.unruly.matchers.OptionalMatchers;
import co.unruly.matchers.StreamMatchers;
import model.Country;
import org.hamcrest.Matchers;
import org.junit.Assert;
import ramp.lift.uas.automation.SystemUnderTest;
import ramp.lift.uas.automation.UASRequestModule;
import steps.UASIntegrationTest;

import java.util.Map;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

public class Verifier {

    private static SystemUnderTest sut = SystemUnderTest.getInstance();

    private static final String SCRIPT = "script";
    private static final String DELIVERY = "delivery";
    private static final String PASSBACK = "passback";
    private static final String GDPR_PASSBACK = "gdpr passback";
    private static final String UNSUPPORTED_RESPONSE_PREFIX = "Unsupported expected response type: expected delivery or passback, got: ";

    private Verifier() {
    }

    public static void verifyPassback() {
        final Map<Boolean, Long> countUrls =
                sut.getUASRquestModule().responses()
                        .map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join)
                        .collect(Collectors.groupingBy(Optional::isPresent, Collectors.counting()));

        assertThat(
                "all of the responses should not have an impression url", countUrls.getOrDefault(true, 0l),
                Matchers.is(0l));
    }

    public static void verifyImpressions() {
        Stream<Optional<String>> impressionURLResponses = Optional.ofNullable(sut.getUASRquestModule().responses()
                .map(UASIntegrationTest::getImpressionUrl).map(CompletableFuture::join)).orElse(sut.getUASRquestModule().getSynchronizedResponses().stream().map(UASRequestModule::getImpressionUrlFrom));
        assertThat(
                "all of the responses should have a url", impressionURLResponses,
                StreamMatchers.allMatch(is(not(OptionalMatchers.empty()))));
    }

    public static void verifyClicks() {
        assertTrue("all of the responses should have a url", sut.getUASRquestModule().responses()
                .map(UASIntegrationTest::getClickUrl).map(CompletableFuture::join).allMatch(Optional::isPresent));
    }

    public static void verifyContains(String something) {
        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            Assert.assertThat(content, Matchers.containsString(something));
        });
    }

    public static void resetHeaders() {
        sut.getUASRquestModule().emptyHttpHeaders();
    }

    /**
     * Adds X-Forwarded-For header whose value is the specified ip.
     *
     * @param ip X-Forwarded-For header value
     */
    public static void addCountryIpHeader(String ip) {
        sut.getUASRquestModule().addHttpHeader("X-Forwarded-For", ip);
    }

    public static void verifyResponseBody(String expectedResponseType) {
        if (expectedResponseType.equals(DELIVERY)) {
            verifyContains(SCRIPT);
            verifyImpressions();
            verifyClicks();
        } else if (expectedResponseType.equals(PASSBACK)) {
            verifyPassback();
        } else if (expectedResponseType.equals(GDPR_PASSBACK)) {
            verifyPassback();
            // todo: verify no logs
        } else {
            throw new IllegalArgumentException(UNSUPPORTED_RESPONSE_PREFIX + expectedResponseType);
        }
    }
}
