package com.undertone.ramp.lift.adselector.automation;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;

import org.junit.Assert;
import org.junit.runner.RunWith;

import com.undertone.automation.cli.conn.CliConnection;
import com.undertone.automation.cli.conn.CliConnectionImpl;
import com.undertone.automation.cli.conn.CliConnectionImpl.EnumConnectionType;
import com.undertone.automation.cli.conn.LinuxDefaultCliConnection;
import com.undertone.automation.cli.conn.RootLinuxCliConnection;
import com.undertone.automation.support.StringUtils;

import cucumber.api.java8.En;
import cucumber.api.java8.GlueBase;
import cucumber.api.junit.Cucumber;
import gherkin.deps.com.google.gson.JsonArray;
import gherkin.deps.com.google.gson.JsonParser;

@RunWith(Cucumber.class)
public

class BaseTest implements En, GlueBase {

    protected final String environmentName;
    protected final Map<String, String> config = Collections.synchronizedMap(new HashMap<>());
    protected final List<CliConnectionImpl> uasCliConnections = new ArrayList<>();

    // protected final Reporter reporter;
    // protected final List<UAS> uas_instances;
    public BaseTest() {
	environmentName = Optional.ofNullable(System.getenv("ENVIRONMENT")).orElse("ci").toLowerCase();
	String environmentNameConfigPrefix = environmentName + ".";
	After(scenario -> {
	    config.clear();
	    uasCliConnections.forEach(CliConnection::disconnect);
	    uasCliConnections.clear();
	});

	Before(scenario -> {

	    Properties properties = new Properties();
	    try {
		properties.load(this.getClass().getClassLoader().getResourceAsStream("environments"));
	    } catch (IOException ioException) {
		Assert.fail("load configuration of " + scenario.getName() + " failed: " + ioException.getMessage());
	    }
	    properties.forEach((k, v) -> {
		String configurationKey = k.toString(), value = v.toString();
		if (configurationKey.startsWith(environmentNameConfigPrefix)) {
		    config.put(configurationKey.substring(environmentNameConfigPrefix.length()), value);
		}
	    });
	    boolean isUasTest = scenario.getSourceTagNames().stream().map(String::toLowerCase)
		    .anyMatch(tag -> tag.equals("@uas"));
	    if (isUasTest) {
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
		    CliConnectionImpl conn;

		    if (uasCliConnectionUser.equals("root")) {
			conn = new RootLinuxCliConnection();
		    } else {
			conn = new LinuxDefaultCliConnection();
		    }

		    conn.setHost(host);
		    conn.setUser(uasCliConnectionUser);
		    conn.setPassword(uasCliConnectionPassword);
		    conn.setConnectOnInit(true);

		    if (keyFile != null) {
			conn.setPrivateKey(keyFile);
			conn.setProtocol(EnumConnectionType.SSH_RSA.value());
		    }

		    uasCliConnections.add(conn);
		});
	    }
	});

    }

}
