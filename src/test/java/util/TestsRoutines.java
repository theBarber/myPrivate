package util;

import model.ResponseType;
import ramp.lift.uas.automation.SystemUnderTest;

public class TestsRoutines {

    private static SystemUnderTest sut = SystemUnderTest.getInstance();

    private TestsRoutines() {
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
        ResponseVerifier.getInstance().verifyResponse(ResponseType.textToResponseType(expectedResponseType));
    }

    public static void verifyResponseBody(ResponseType responseType) {
        ResponseVerifier.getInstance().verifyResponse(responseType);
    }
}
