package infra.cli.support;

import static java.time.temporal.ChronoUnit.MILLIS;
import static java.time.temporal.ChronoUnit.MINUTES;

import infra.cli.conn.CliConnection;
import infra.support.FluentWait;

public class CliConnectionWait extends FluentWait<CliConnection> {

    private static final int DEFAULT_POLLING_INTERVAL_IN_MILLISECONDS = 500;
    private static final int DEFAULT_TIMEOUT_IN_MINUTES = 2;

    public CliConnectionWait(CliConnection input) {
	super(input);
	withTimeout(DEFAULT_TIMEOUT_IN_MINUTES, MINUTES);
	pollingEvery(DEFAULT_POLLING_INTERVAL_IN_MILLISECONDS, MILLIS);
	ignoring(AssertionError.class);
    }

}
