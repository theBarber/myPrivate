package com.undertone.automation.support;

import java.time.Duration;
import java.time.temporal.ChronoUnit;

public interface Sleeper {
    public static final Sleeper SYSTEM_SLEEPER = new Sleeper() {
	public void sleep(Duration duration) throws InterruptedException {
	    Thread.sleep(duration.get(ChronoUnit.MILLIS));
	}
    };

    /**
     * Sleeps for the specified duration of time.
     *
     * @param duration
     *            How long to sleep.
     * @throws InterruptedException
     *             If hte thread is interrupted while sleeping.
     */
    void sleep(Duration duration) throws InterruptedException;
}
