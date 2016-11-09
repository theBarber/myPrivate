package com.undertone.ramp.lift.adselector.automation;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;
import java.util.concurrent.TimeUnit;
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

    protected final String environmentName;
    protected final Map<String, String> config = Collections.synchronizedMap(new HashMap<>());


    protected ConnectionFactory connectionFactory = null;
    protected com.rabbitmq.client.Connection rabbitClientConnection;

    protected RabbitMQPublisher publisher;
    protected RabbitMQConsumer consumer;


    protected final String[] CLITESTS = new String[] { "@cli" };
    protected final String[] RABBITTESTS = new String[] { "@rabbitmq" };
    protected final String[] UASTESTS = new String[] { "@uas" };

    public BaseTest() {
	environmentName = Optional.ofNullable(System.getenv("ENVIRONMENT")).orElse("staging").toLowerCase();
	String environmentNameConfigPrefix = environmentName + ".";
	After(scenario -> {
	    sut.teardown(scenario.getSourceTagNames(), config);
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
	    sut.setup(scenario.getSourceTagNames(), config);
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
