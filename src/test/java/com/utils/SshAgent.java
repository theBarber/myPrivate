package com.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Scanner;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.Consumer;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

import rx.Observable;
import rx.Subscription;
import rx.functions.Action1;

public class SshAgent implements Cloneable {

    private Session session;

    public SshAgent(String proFile) {

	final String PROP_NAME = proFile;
	try {
	    Properties prop = new Properties();
	    FileInputStream inProp = new FileInputStream(PROP_NAME);
	    prop.load(inProp);
	    inProp.close();

	    JSch jsch = new JSch();
	    jsch.addIdentity(prop.getProperty("pem_key"));

	    String host = prop.getProperty("host");
	    String user = prop.getProperty("user");
	    int port = Integer.parseInt(prop.getProperty("port"));
	    session = jsch.getSession(user, host, port);
	    session.setConfig(prop);
	    session.connect();

	} catch (Exception e) {
	    System.out.println(e.getMessage());
	}
    }

    public SshAgent(String host, String user, String prvkey, int port) throws JSchException {
	JSch jsch = new JSch();
	jsch.addIdentity(prvkey);
	Properties properties = new Properties();
	properties.put("StrictHostKeyChecking", "no");
	session = jsch.getSession(user, host, port);
	session.setConfig(properties);
	session.connect();
    }

    public List<String> enterSshCommand(String comm, int waitSeconds) {
	Channel channel = null;

	try {
	    channel = session.openChannel("shell");
	    try (PrintWriter keyboard = new PrintWriter(channel.getOutputStream())) {
		try (BufferedReader screen = new BufferedReader(new InputStreamReader(channel.getInputStream()))) {
		    Observable<String> screenObservingLines = Observable.fromCallable(screen::readLine);
		    List<String> result = new ArrayList<>();
		    
		    channel.connect();
		    keyboard.println(comm);
		    keyboard.flush();
		    
		    Subscription linesFromScreen;
		    AtomicReference<Subscription> linesFromScreenRef = new AtomicReference<>();
		    linesFromScreenRef
			    .set(linesFromScreen = screenObservingLines.subscribe(promptLineReader("$ ", line -> {
				linesFromScreenRef.get().unsubscribe();
			    }, result)));

		    Thread.sleep(1000);
		    for (; linesFromScreen.isUnsubscribed(); Thread.sleep(1000)) {
			if (--waitSeconds == 0) {
			    throw new RuntimeException("Timeout waiting for prompt");
			}
		    }
		    return result;
		}
	    }
	} catch (InterruptedException | JSchException | IOException e) {
	    System.out.println(e.getMessage());
	} finally {
	    channel.disconnect();
	}
	return null;

    }

    static final Action1<String> promptLineReader(String prompt, Consumer<String> onPrompt, List<String> agg) {
	return line -> {
	    if (line.endsWith(prompt)) {
		onPrompt.accept(line);// linesFromScreen.unsubscribe();
	    } else {
		agg.add(line);
	    }
	};
    }

    public File copyFileFromRemote(String fileToDownload, int sec) {
	ChannelSftp channel = null;
	File f = null;
	try {
	    channel = (ChannelSftp) session.openChannel("sftp");
	    channel.connect();

	    f = File.createTempFile("trrrrrr", ".txt");

	    FileOutputStream out = new FileOutputStream(f);
	    channel.get(fileToDownload, out);
	    Thread.sleep(1000 * sec);

	} catch (SftpException | JSchException | IOException | InterruptedException e) {
	    System.out.println(e.getMessage());
	} finally {
	    channel.disconnect();
	}
	return f;
    }

    public boolean compareContent(File f, String s) {
	StringBuilder sb = new StringBuilder();
	try {
	    Scanner scn = new Scanner(f);
	    while (scn.hasNext()) {
		sb.append(scn.nextLine() + "\n");
	    }

	} catch (FileNotFoundException e) {
	    System.out.println(e.getMessage());
	}
	System.out.println(sb);
	return sb.toString().contains(s);
    }

    public void close() {
	session.disconnect();
    }
}