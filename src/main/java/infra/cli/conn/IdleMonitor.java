/*
 * Copyright 2005-2010 Ignis Software Tools Ltd. All rights reserved.
 */
package infra.cli.conn;

import static java.lang.System.currentTimeMillis;
import static java.lang.System.out;

//import static org.apache.commons.io.output.NullOutputStream.NULL_OUTPUT_STREAM;
import java.io.PrintStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import infra.support.StringUtils;

/**
 * Monitors the allowed idle time of a machine. (Many devices forces log out in
 * case of the maximum idle time has passed) In order to activate this monitor
 * the maxIdleTime tag(in miliSeconds) should be added to the SUT file. under
 * conn / cli
 * 
 * Note that the actual keep alive 'Enter' will be done at idleTime * 0.9
 * 
 */
public class IdleMonitor extends Thread {
    static Logger Reporter = LoggerFactory.getLogger(IdleMonitor.class);
    CliConnectionImpl cli;
    final PrintStream silentPrintStream = null;
    long timeout;

    /**
     * @param cli
     *            CliConnection
     * @param timeout
     *            (miliSeconds) the maximum idleTime
     */
    public IdleMonitor(CliConnectionImpl cli, long timeout) {
	super("Idle monitor for " + cli.getName());
	setDaemon(true);
	this.cli = cli;
	this.timeout = timeout;
    }

    @Override
    public void run() {
	out.println(this.getName() + " started");
	String position = null;
	while (!isInterrupted()) {
	    try {
		synchronized (cli) {
		    if (!cli.terminal.isConnected()) {
			cli.connect();
		    }
		}
	    } catch (Exception e) {
		continue;
	    }
	    long lastCommandTime = cli.getLastCommandTime();
	    if (lastCommandTime == 0) {
		try {
		    sleep(timeout / 2);
		} catch (InterruptedException e) {
		    setStop();
		}
		continue;
	    }
	    if (currentTimeMillis() - lastCommandTime > (timeout * 0.9)) {
		synchronized (cli) {
		    CliCommand cmd = new CliCommand("");
		    if (StringUtils.nonEmpty.test(position)) {
			cmd.setPosition(position);
		    }
		    PrintStream stream = cli.terminal.getPrintStream();
		    cli.setPrintStream(silentPrintStream);
		    try {
			cli.command(cmd);
		    } catch (InterruptedException e) {
			setStop();
		    }
		    cli.setPrintStream(stream);
		    position = cmd.getPosition();
		    if (cmd.isFailed()) {
			Reporter.error(getName() + " keepalive failed");
		    } else {
			// System.out.println(getName() + " keepalive success");
		    }
		}
	    } else {
		try {
		    long toSleep = (long) (timeout * 0.9) - (currentTimeMillis() - lastCommandTime);
		    if (toSleep > 0) {
			sleep(toSleep);
		    }
		} catch (InterruptedException e) {
		    setStop();
		}
	    }
	}
    }

    public void setStop() {
	this.interrupt();
    }
}
