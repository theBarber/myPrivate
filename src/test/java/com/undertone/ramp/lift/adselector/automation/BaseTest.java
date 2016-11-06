package com.undertone.ramp.lift.adselector.automation;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;
import java.util.concurrent.TimeoutException;

import org.junit.Assert;

import com.rabbitmq.client.ConnectionFactory;
import com.undertone.automation.utils.MsgProcess;
import com.undertone.automation.utils.RabbitMQConsumer;
import com.undertone.automation.utils.RabbitMQPublisher;
import com.undertone.qa.CampaignManager;
import com.undertone.ramp.lift.uas.automation.SystemUnderTest;

import cucumber.api.java8.En;
import cucumber.api.java8.GlueBase;

public class BaseTest implements En, GlueBase {

    protected SystemUnderTest sut = SystemUnderTest.getInstance();

//    protected final CampaignManager campaignManager = new CampaignManager();
    protected final String environmentName;
    protected final Map<String, String> config = Collections.synchronizedMap(new HashMap<>());
    // protected final Map<String, LinuxDefaultCliConnection> uasCliConnections
    // = new HashMap<>();

    protected ConnectionFactory connectionFactory = null;
    protected com.rabbitmq.client.Connection rabbitClientConnection;

    protected RabbitMQPublisher publisher;
    protected RabbitMQConsumer consumer;
    // protected final Reporter reporter;
//    protected AtomicReference<UASRequestModule> uas = new AtomicReference<>();

    protected final String[] CLITESTS = new String[] { "@cli" };
    protected final String[] RABBITTESTS = new String[] { "@rabbitmq" };
    protected final String[] UASTESTS = new String[] { "@uas" };

    public BaseTest() {
	environmentName = Optional.ofNullable(System.getenv("ENVIRONMENT")).orElse("staging").toLowerCase();
	String environmentNameConfigPrefix = environmentName + ".";
	After(scenario -> {
	    sut.teardown(scenario.getSourceTagNames(), config);
	});

	// After(CLITESTS, scenario -> {
	// uasCliConnections.values().forEach(CliConnection::disconnect);
	// uasCliConnections.clear();
	// });
//	After(UASTESTS, scenario -> {
//	    uas.set(null);
//	});

	Before(scenario -> {
	    // String userName = System.getProperty("user.name");
	    // if (!"jenkins".equals(userName)
	    // && scenario.getSourceTagNames().stream().noneMatch(s ->
	    // s.equals("@" + userName))) {
	    // Exception notTaggedForYou = new Exception(
	    // "the scenario " + scenario.getName() + " is not tagged for " +
	    // userName);
	    // PendingException pex = new cucumber.api.PendingException();
	    // StackTraceElement[] trace = new StackTraceElement[1];
	    // trace[0] = Thread.currentThread().getStackTrace()[1];
	    // pex.setStackTrace(trace);
	    // notTaggedForYou.setStackTrace(trace);
	    // pex.addSuppressed(notTaggedForYou);
	    // throw pex;
	    // }
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
	    sut.setup(scenario.getSourceTagNames(), config);
	});

//	Before(CLITESTS, scenario -> {
//	    String uasCliConnectionUser = config.get("uas.cliconnection.user");
//	    String uasCliConnectionPassword = config.getOrDefault("uas.cliconnection.password", null);
//	    String cliConnectionsHostsParam = config.get("uas.cliconnection.hosts");
//	    String cliconnectionKeyname = config.getOrDefault("uas.cliconnection.keyname", "");
//	    JsonArray hostsConfig = new JsonParser().parse(cliConnectionsHostsParam).getAsJsonArray();
//	    File keyFile = Optional.of(cliconnectionKeyname).filter(StringUtils.nonEmpty)
//		    .map(filename -> new File(new File(System.getProperty("user.home"), ".ssh"), filename))
//		    .filter(File::exists).filter(File::canRead).orElse(null);
//
//	    hostsConfig.forEach(jsonElement -> {
//		String host = jsonElement.getAsString();
//		LinuxDefaultCliConnection conn;
//
//		if (uasCliConnectionUser.equals("root")) {
//		    conn = new RootLinuxCliConnection();
//		} else {
//		    conn = new LinuxDefaultCliConnection();
//		}
//
//		conn.setHost(host);
//		conn.setUser(uasCliConnectionUser);
//		conn.setPassword(uasCliConnectionPassword);
//		conn.setConnectOnInit(false);
//		conn.setUseThreads(true);
//
//		if (keyFile != null) {
//		    conn.setPrivateKey(keyFile);
//		    conn.setProtocol(EnumConnectionType.SSH_RSA.value());
//		}
//
//		uasCliConnections.put(host, conn);
//	    });
//	    uasCliConnections.values().forEach(conn -> {
//		try {
//		    conn.init();
//		} catch (IOException e) {
//		    throw new UncheckedIOException(e);
//		}
//	    });
//
//	});

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

	// Before(UASTESTS, scenario -> {
	// UASRequestModule uas_ = new UASRequestModule();
	// this.uas.set(uas_);
	// uas_.setHost(config.get("uas.host"));
	// uas_.setPort(config.get("uas.port"));
	// try {
	// uas_.init();
	//
	// } catch (Exception e) {
	// com.undertone.automation.assertion.Assert.fail("unable to initialize
	// UAS connection", e);
	// e.printStackTrace();
	// }
	// });

    }

}
