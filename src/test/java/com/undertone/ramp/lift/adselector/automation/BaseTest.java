package com.undertone.ramp.lift.adselector.automation;

import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;
import java.util.concurrent.TimeoutException;

import org.junit.Assert;
import org.junit.runner.RunWith;

import com.rabbitmq.client.ConnectionFactory;
import com.undertone.automation.cli.conn.CliConnection;
import com.undertone.automation.cli.conn.CliConnectionImpl;
import com.undertone.automation.cli.conn.CliConnectionImpl.EnumConnectionType;
import com.undertone.automation.cli.conn.LinuxDefaultCliConnection;
import com.undertone.automation.cli.conn.RootLinuxCliConnection;
import com.undertone.automation.support.StringUtils;
import com.undertone.automation.utils.MsgProcess;
import com.undertone.automation.utils.RabbitMQConsumer;
import com.undertone.automation.utils.RabbitMQPublisher;

import cucumber.api.java8.En;
import cucumber.api.java8.GlueBase;
import gherkin.deps.com.google.gson.JsonArray;
import gherkin.deps.com.google.gson.JsonParser;

public class BaseTest implements En, GlueBase {

    protected final String environmentName;
    protected final Map<String, String> config = Collections.synchronizedMap(new HashMap<>());
    protected final Map<String, CliConnectionImpl> uasCliConnections = new HashMap<>();

    protected ConnectionFactory connectionFactory = null;
    protected com.rabbitmq.client.Connection rabbitClientConnection;

    protected RabbitMQPublisher publisher;
    protected RabbitMQConsumer consumer;
    // protected final Reporter reporter;
    // protected final List<UAS> uas_instances;

    protected final String[] CLITESTS = new String[] { "@cli" };
    protected final String[] RABBITTESTS = new String[] { "@rabbitmq" };

    public BaseTest() {
	environmentName = Optional.ofNullable(System.getenv("ENVIRONMENT")).orElse("staging").toLowerCase();
	String environmentNameConfigPrefix = environmentName + ".";
	After(scenario -> {
	    config.clear();
	});

	After(CLITESTS, scenario -> {
	    uasCliConnections.values().forEach(CliConnection::disconnect);
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

	});

	Before(CLITESTS, scenario -> {
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
		uasCliConnections.put(host, conn);
	    });

	});

	Before(RABBITTESTS, scenario -> {

	    // the consumer will wait on this queue

	    // will init all the values from the config map object
	    connectionFactory = new ConnectionFactory();
	    connectionFactory.setUsername(config.get("de.rabbitmq.user"));
	    connectionFactory.setPassword(config.get("de.rabbitmq.password"));
	    connectionFactory.setHost(config.get("de.rabbitmq.host"));
	    connectionFactory.setPort(Integer.parseInt(config.get("de.rabbitmq.port")));

	    try {
		rabbitClientConnection = connectionFactory.newConnection();
		// consumer_tag is basically thread num
		publisher = new RabbitMQPublisher("in", rabbitClientConnection.createChannel());
		if (this instanceof MsgProcess) {
		    MsgProcess thisAsMsgProcess = (MsgProcess) this;
		    consumer = new RabbitMQConsumer(thisAsMsgProcess, rabbitClientConnection.createChannel(), "test",
			    "out", "integration-test", "integration-test");
		    consumer.start();
		}
	    } catch (IOException | TimeoutException e) {
		com.undertone.automation.assertion.Assert.fail("unable to initialize rabbitmq connection", e);
		e.printStackTrace();
	    }

	});
    }

}
