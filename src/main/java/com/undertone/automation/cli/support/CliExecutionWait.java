package com.undertone.automation.cli.support;

import static java.time.temporal.ChronoUnit.MILLIS;
import static java.time.temporal.ChronoUnit.MINUTES;

import com.undertone.automation.cli.conn.CliConnection;
import com.undertone.automation.cli.process.CliCommandExecution;
import com.undertone.automation.support.FluentWait;

public class CliExecutionWait extends FluentWait<CliCommandExecution> {

    private static final int DEFAULT_POLLING_INTERVAL_IN_MILLISECONDS = 500;
    private static final int DEFAULT_TIMEOUT_IN_MINUTES = 2;

    public CliExecutionWait(CliCommandExecution execution) {
	super(execution);
	withTimeout(DEFAULT_TIMEOUT_IN_MINUTES, MINUTES);
	pollingEvery(DEFAULT_POLLING_INTERVAL_IN_MILLISECONDS, MILLIS);
	ignoring(AssertionError.class);
    }

    public CliExecutionWait(CliConnection cliConnection, String command) {
	this(new CliCommandExecution(cliConnection, command));
    }

}
