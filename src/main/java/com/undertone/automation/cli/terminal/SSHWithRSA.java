/*
 * Copyright 2005-2010 Ignis Software Tools Ltd. All rights reserved.
 */
package com.undertone.automation.cli.terminal;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ch.ethz.ssh2.Connection;

/**
 * A terminal used for SSH Connection
 */
public class SSHWithRSA extends SSH {

    Logger Reporter = LoggerFactory.getLogger(SSHWithRSA.class);
    private File privateKeyFile;

    public SSHWithRSA(String hostnameP, String usernameP, String passwordP, File privateKey) {
	super(hostnameP, usernameP, passwordP);
	privateKeyFile = privateKey;

    }

    @Override
    public void connect() throws IOException {
	boolean isAuthenticated = false;
	/* Create a connection instance */
	Reporter.info("Connecting to " + hostname + " via " + getConnectionName());
	conn = new Connection(hostname, getPort());

	/* Now connect */
	try {
	    conn.connect();
	} catch (IOException e) {
	    Reporter.error("Connection to " + hostname + " Failed", e);
	    throw e;
	}

	String[] authMethods = conn.getRemainingAuthMethods(username);
	// Check what connection options are available to us
	synchronized (System.out) {
	    System.out.println("The supported auth Methods are:");
	    for (String method : authMethods) {
		System.out.println(method);
	    }
	}
	boolean privateKeyAuthentication = false;
	boolean passAuthentication = false;
	for (int i = 0; i < authMethods.length; i++) {
	    if (authMethods[i].equalsIgnoreCase("password")) {
		// we can authenticate with a password
		passAuthentication = true;
	    }
	}
	if (Arrays.asList(authMethods).contains("publickey")) {
	    // we can authenticate with a RSA public/private key
	    privateKeyAuthentication = true;
	}

	/* Authenticate */
	if (passAuthentication && password != null) {
	    super.connect();
	} else if (privateKeyAuthentication) {
	    try {
		if (privateKeyFile != null && privateKeyFile.isFile()) {
		    isAuthenticated = conn.authenticateWithPublicKey(username, privateKeyFile, "");
		} else {
		    Reporter.error("Connection to " + hostname
			    + " Failed: Auth Error - The privateKeyFile should be init from the SUT with a valid path to ppk/pem RSA private key");
		    System.out.println(privateKeyFile);
		}
	    } catch (Exception e) {
		Reporter.error("Connection to " + hostname + " Failed", e);
		isAuthenticated = false;
	    }
	}
	if (isAuthenticated == false) {
	    // we're still not authenticated - try keyboard interactive
	    conn.authenticateWithKeyboardInteractive(username, new InteractiveLogic());
	}

	if (sourcePort > -1 && destinationPort > -1) {
	    lpf = conn.createLocalPortForwarder(sourcePort, "localhost", destinationPort);
	}

	/* Create a session */
	sess = conn.openSession();

	if (xtermTerminal) {
	    sess.requestPTY("xterm", 80, 24, 640, 480, null);
	} else {
	    sess.requestPTY("dumb", 200, 50, 0, 0, null);
	}

	sess.startShell();

	in = sess.getStdout();
	out = sess.getStdin();
    }

    @Override
    public void disconnect() {
	super.disconnect();
    }

    @Override
    public boolean isConnected() {
	return super.isConnected();
    }

    @Override
    public String getConnectionName() {
	return "SSH_RSA";
    }

    public File getPrivateKeyFile() {
	return privateKeyFile;
    }

    public void setPrivateKeyFile(File privateKeyFile) {
	this.privateKeyFile = privateKeyFile;
    }

}
