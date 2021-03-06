package infra.cli.process;

import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.TimeUnit;

import org.hamcrest.Matchers;
import org.junit.Assert;

import infra.assertion.AbstractAssertionLogic;
import infra.assertion.DefaultAssertionListener;
import infra.assertion.IAssertionLogic;
import infra.cli.conn.CliCommand;
import infra.cli.conn.CliConnection;
import infra.module.AbstractModule;
import infra.module.Named;
import infra.support.StringUtils;

public class CliCommandExecution {
    private final CliConnection cliConnection;
    // setting default timeout to 1 minute.
    private long timeout = TimeUnit.MINUTES.toMillis(1);
    private String title = "";
    protected String cmd = "";
    private List<String> musts, errors;
    protected String result;
    private boolean silently = false;
    protected final List<IAssertionLogic<String>> assrtions;
    final PrintStream silentPrintStream = null;

    public CliCommandExecution(CliConnection cliConnection) {
	this(cliConnection, "");
    }

    public CliCommandExecution(CliConnection cliConnection, String command) {
	this.cliConnection = cliConnection;
	this.cmd = command;
	assrtions = new ArrayList<>();
    }

    public CliCommandExecution withTimeout(long timeout) {
	this.timeout = timeout;
	return this;
    }

    public CliCommandExecution withTimeout(long duration, TimeUnit timeUnit) {
	this.timeout = timeUnit.toMillis(duration);
	return this;
    }

    public CliCommandExecution withTitle(String title) {
	this.title = title;
	return this;
    }

    public CliCommandExecution mustHaveResponse(String... strings) {
	if (musts == null) {
	    musts = new ArrayList<>(strings.length);
	}
	musts.addAll(Arrays.asList(strings));
	return this;
    }

    public void execute(String command) throws IOException {
	this.cmd = command;
	execute();
    }

    /**
     * execute the command on the {@link CliConnection}. you can gain the result
     * by {@link #getResult()}. if any error string was provided in
     * {@link #error(String...)}, the result will <b>be</b> the error string
     * instance<br>
     * note that the actual result will be set to the {@link CliConnection}'s
     * actual, if it is an {@link AbstractModule}, accessible by
     * {@link AbstractModule#getActual()}. the value could contain either the
     * first or last prompt.
     * 
     * @throws Exception
     */
    public void execute() throws IOException {
	if (!Optional.ofNullable(cmd).filter(StringUtils.nonEmpty).isPresent()) {
	    throw new NullPointerException("command is not set");
	}

	CliCommand cliCommand = new CliCommand(cmd);
	if (!(cliConnection instanceof AbstractModule)) {
	    if (musts != null && !musts.isEmpty()) {
		cliCommand.addMusts(musts);
	    }
	    if (errors != null && !errors.isEmpty()) {
		for (String error : errors) {
		    cliCommand.addErrors(error);
		}
	    }
	}
	cliCommand.setTimeout(timeout);
	cliCommand.setSilent(silently);
	synchronized (cliConnection) {
	    if (!cliConnection
		    .isConnected() /* && !cliConnection.isConnectOnInit() */) {
		cliConnection.connect();
	    }
	    if (silently) {
		cliConnection.setPrintStream(silentPrintStream);
	    }
	    try {
		this.cliConnection.handleCliCommand(title, cliCommand);
	    } catch (IOException | InterruptedException e) {
		String on = cliConnection.toString();
		if (cliConnection instanceof Named) {
		    on = ((Named) cliConnection).getName();
		}
		throw new IOException("Execution of " + title + " failed on " + on, e);
	    }

	    if (cliConnection instanceof AbstractModule) {
		AbstractModule cliModule = (AbstractModule) cliConnection;
		String result = cliModule.getActual(String.class);
		//String commandLine = cmd + this.cliConnection.getEnterStr();
		result = StringUtils.getFirstSubStringSuffix(result, cmd, true);
		if (result.contains(this.cliConnection.getEnterStr())) {
		    result = StringUtils.getPrefix(result, this.cliConnection.getEnterStr());
		}
		setResult(result.trim());
		cliModule.setActual(this.result);
		if (musts != null && !musts.isEmpty()) {
		    for (String must : musts) {
			Assert.assertThat(cliModule.getActual(String.class), Matchers.containsString(must));
		    }
		}
		if (errors != null && !errors.isEmpty()) {
		    for (final String error : errors) {
			Assert.assertThat(cliModule.getActual(String.class),
				Matchers.not(Matchers.containsString(error)));
		    }
		}
	    }
	}
    }

    private final class setResultOnError extends DefaultAssertionListener<String> {

	private final String error;

	public setResultOnError(String error) {
	    this.error = error;
	}

	@Override
	public void assertionFailed(String actual, AbstractAssertionLogic<String> logic) {
	    setResult(error);
	    super.assertionFailed(actual, logic);
	}
    }

    public String getResult() {
	return result;
    }

    protected void setResult(String result) {
	this.result = result;
    }

    // public String untilResponse(final AbstractAssertionLogic<String> logic) {
    // CliConnectionWait wait = new CliConnectionWait(cliConnection);
    //
    // return wait.until(new CliExpectedCondition<String>() {
    // @Override
    // public String apply(CliConnection input) {
    // try {
    // execute();
    // Assert.assertLogic(getResult(), logic);
    // return getResult();
    //
    // } catch (Exception e) {
    // throw new RuntimeException(e);
    // }
    // }
    // });
    //
    //
    // }

    public CliCommandExecution error(String... errors) {
	if (this.errors == null) {
	    this.errors = new ArrayList<>(errors.length);
	}
	this.errors.addAll(Arrays.asList(errors));
	return this;
    }

    public CliCommandExecution silently() {
	this.silently = true;
	return this;
    }
}
