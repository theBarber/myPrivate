package util.api;

import ramp.lift.uas.automation.SystemUnderTest;

public class UasApi {
    private static SystemUnderTest sut = SystemUnderTest.getInstance();

    private UasApi() {
    }

    public static void sendZoneReq(Integer zoneId, Integer times, boolean toReset) {
        sut.getUASRquestModule().zoneRequests(zoneId, times, toReset);
    }

    public static void sendMultipleZoneIdAdRequestsWithParameter(Integer times,String parameter, Integer zoneId, boolean toReset) {
        sut.getUASRquestModule().zoneRequestsWithParameter(zoneId, parameter, times, toReset);
    }

    public static void sendDynamicTagRequestsToUAS(Integer times, String publisherId, String domain) {
        sut.getUASRquestModule().sendMultipleDynamicTagGetRequests(times,null, publisherId, domain,null,true,false);
    }

    public static void sendDynamicTagRequestsToUASWithParams(Integer times, String publisherId, String extraParams) {
        sut.getUASRquestModule().sendMultipleDynamicTagGetRequests(times,null,publisherId, null,extraParams,true,false);
    }
}
