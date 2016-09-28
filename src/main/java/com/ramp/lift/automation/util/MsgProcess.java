package com.ramp.lift.automation.util;

/**
 * Created by noam on 28/09/16.
 */
@FunctionalInterface
public interface MsgProcess {
    void processMsg(String msg, String routingKey);
}