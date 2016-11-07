package com.undertone.ramp.lift.uas.automation;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Stream;

import com.undertone.automation.cli.conn.CliConnection;
import com.undertone.automation.cli.conn.CliConnectionImpl.EnumConnectionType;
import com.undertone.automation.cli.conn.LinuxDefaultCliConnection;
import com.undertone.automation.cli.conn.RootLinuxCliConnection;
import com.undertone.automation.module.AbstractModuleImpl;
import com.undertone.automation.support.StringUtils;
import com.undertone.qa.CampaignManager;
import com.undertone.qa.HardCodedCampaignManager;

import gherkin.deps.com.google.gson.JsonArray;
import gherkin.deps.com.google.gson.JsonParser;

public class SystemUnderTest extends AbstractModuleImpl<SystemUnderTest> {
    final int _o;
    protected final Map<String, LinuxDefaultCliConnection> uasCliConnections = new HashMap<>();
    protected final Map<String, UASLogModule> uasLogModulesByLogType = new HashMap<>();
    protected UASRequestModule uas;
    protected CampaignManager campaignManager;
    private static SystemUnderTest instance = null;

    private SystemUnderTest() {
	_o = 0;
    }

    public void setup(Collection<String> forTags, Map<String, String> config) {
	AtomicReference<RuntimeException> exception = new AtomicReference<>();
	forTags.stream().forEach(tag -> {
	    switch (tag) {
	    case "@cli":
		if (!uasCliConnections.isEmpty()) {
		    setupCli(config, exception);
		}
		break;
	    case "@uas":
		if (uas == null) {
		    try {
			uas = new UASRequestModule();
			uas.setHost(config.get("uas.host"));
			uas.setPort(config.get("uas.port"));
			uas.init();
		    } catch (Exception e) {
			delegate(exception, e);
		    }
		}
		break;
	    case "@campaign":
		if (forTags.contains("@hardcoded")) {
		    campaignManager = new HardCodedCampaignManager();
		} else {
		    // XXX TODO figure out what and how to select and create
		    // campaign manager
		}
		break;
	    default:
		break;
	    }
	});

	throwIfNeeded(exception);
    }

    public void teardown(Collection<String> forTags, Map<String, String> config) {
	AtomicReference<RuntimeException> exception = new AtomicReference<>();
	forTags.stream().forEach(tag -> {
	    switch (tag) {
	    case "@cli":
		if (!uasCliConnections.isEmpty()) {
		    teardownCli();
		}
		break;
	    case "@uas":
		if (uas != null) {
		    try {
			uas.close();
		    } catch (Exception e) {
			delegate(exception, e);
		    }
		}
	    default:
		break;
	    }

	});

	throwIfNeeded(exception);
	config.clear();
    }

    public Stream<LinuxDefaultCliConnection> uasCliConnections() {
	return this.uasCliConnections.values().stream();
    }

    protected void setupCli(Map<String, String> config, AtomicReference<RuntimeException> exception) {
	String uasCliConnectionUser = config.get("uas.cliconnection.user");
	String uasCliConnectionPassword = config.getOrDefault("uas.cliconnection.password", null);
	String cliConnectionsHostsParam = config.get("uas.cliconnection.hosts");
	String cliconnectionKeyname = config.getOrDefault("uas.cliconnection.keyname", "");
	JsonArray hostsConfig = new JsonParser().parse(cliConnectionsHostsParam).getAsJsonArray();
	File keyFile = Optional.of(cliconnectionKeyname).filter(StringUtils.nonEmpty)
		.map(filename -> new File(new File(System.getProperty("user.home"), ".ssh"), filename))
		.filter(File::exists).filter(File::canRead).orElse(null);

	hostsConfig.forEach(jsonElement -> {
	    String host = jsonElement.getAsString();
	    LinuxDefaultCliConnection conn;

	    if (uasCliConnectionUser.equals("root")) {
		conn = new RootLinuxCliConnection();
	    } else {
		conn = new LinuxDefaultCliConnection();
	    }

	    conn.setHost(host);
	    conn.setUser(uasCliConnectionUser);
	    conn.setPassword(uasCliConnectionPassword);
	    conn.setConnectOnInit(false);
	    conn.setUseThreads(true);

	    if (keyFile != null) {
		conn.setPrivateKey(keyFile);
		conn.setProtocol(EnumConnectionType.SSH_RSA.value());
	    }

	    uasCliConnections.put(host, conn);
	});
	uasCliConnections.values().forEach(conn -> {
	    try {
		conn.init();
	    } catch (IOException cause) {
		delegate(exception, cause);
	    }
	});

    }

    protected void teardownCli() {
	uasCliConnections.values().forEach(CliConnection::disconnect);
	uasCliConnections.clear();
	uasLogModulesByLogType.forEach((log, module) -> module.close());
	uasLogModulesByLogType.clear();
    }

    public UASRequestModule getUASRquestModule() {
	return this.uas;
    }

    public UASLogModule logFor(String logType) {
	return uasLogModulesByLogType.computeIfAbsent(logType,
		logname -> new UASLogModule(uasCliConnections.values(), logname));
    }

    public CampaignManager getCampaignManager() {
	return campaignManager;
    }

    @Override
    public void init() throws Exception {
	super.init();
    }

    public SystemUnderTest actual() {
	return this;
    };

    public static SystemUnderTest getInstance() {
	if (instance == null) {
	    // Thread Safe. Might be costly operation in some case
	    synchronized (SystemUnderTest.class) {
		if (instance == null) {
		    instance = new SystemUnderTest();
		}
	    }
	}
	return instance;
    }

    public static <E extends Exception> void delegate(AtomicReference<RuntimeException> ref, E cause) {
	synchronized (ref) {
	    if (ref.compareAndSet(null, new RuntimeException(cause))) {
		// the reference was empty
		// now it has one from this line above
		// remove this frame of this method of the stacktrace
		ref.updateAndGet(newEx -> {
		    newEx.setStackTrace(Arrays.copyOfRange(newEx.getStackTrace(), 1, newEx.getStackTrace().length));
		    return newEx;
		});
	    } else {
		ref.updateAndGet(newEx -> {
		    newEx.addSuppressed(cause);
		    return newEx;
		});
	    }
	}
    }

    public static <E extends Exception> void throwIfNeeded(AtomicReference<? extends E> ref) throws E {
	synchronized (ref) {
	    if (ref.get() != null) {
		throw ref.get();
	    }
	}
    }
}