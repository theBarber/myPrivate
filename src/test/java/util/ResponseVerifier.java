package util;

import co.unruly.matchers.OptionalMatchers;
import co.unruly.matchers.StreamMatchers;
import model.ResponseType;
import org.apache.http.Header;
import org.apache.http.HeaderElement;
import org.apache.http.HttpResponse;
import org.hamcrest.Matchers;
import org.junit.Assert;
import ramp.lift.uas.automation.SystemUnderTest;
import ramp.lift.uas.automation.UASRequestModule;
import steps.UASIntegrationTest;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;
import static org.junit.Assert.*;

public class ResponseVerifier {

    private static ResponseVerifier instance;

    private static SystemUnderTest sut = SystemUnderTest.getInstance();

    private static final String UNSUPPORTED_RESPONSE_PREFIX = "Unsupported expected response type: expected delivery or passback, got: ";

    private ResponseVerifier() {
    }

    public static ResponseVerifier getInstance() {
        if (instance == null) {
            instance = new ResponseVerifier();
        }
        return instance;
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

    public static void verifyNoHeaders(String... headersNames) {
        List<HttpResponse> responses = sut.getUASRquestModule().responses().map(CompletableFuture::join).collect(Collectors.toList());
        for (HttpResponse response : responses) {
            for (Header responseHeader : response.getAllHeaders()) {
                for (HeaderElement responseHeaderElement : responseHeader.getElements()) {
                    for (String header : headersNames) {
                        assertNotEquals("response must not contain " + header + " header", header, responseHeaderElement.getName());
                    }
                }
            }
        }
    }

    public static void verifyGdprPassback() {
        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            assertEquals("response should be an empty string", "", content);
        });
        verifyNoHeaders("Set-Cookie");

        // todo: verify no sensitive data is written to logs
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

    public static void verifyDelivery() {
        verifyContains("script");
        verifyImpressions();
        verifyClicks();
    }

    public void verifyResponse(ResponseType responseType) {
        switch (responseType) {
            case DELIVERY:
                verifyDelivery();
                break;
            case PASSBACK:
                verifyPassback();
                break;
            case GDPR_PASSBACK:
                verifyGdprPassback();
                break;
            default:
                throw new IllegalArgumentException(UNSUPPORTED_RESPONSE_PREFIX + responseType);
        }
    }
}
