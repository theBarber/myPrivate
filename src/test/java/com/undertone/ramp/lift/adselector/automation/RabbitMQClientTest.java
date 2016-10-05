package com.undertone.ramp.lift.adselector.automation;

import java.util.concurrent.BlockingDeque;
import java.util.concurrent.LinkedBlockingDeque;

import org.junit.Assert;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.undertone.automation.utils.MsgProcess;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

/**
 * Created by nive on 2016-09-28.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:RabbitMQ_integration.feature", plugin = { "pretty", "json:target/cucumber/s3" })
public class RabbitMQClientTest extends BaseTest implements MsgProcess {
    private static Logger logger = LoggerFactory.getLogger(RabbitMQClientTest.class);
    private BlockingDeque<String> returnQueue;
    private String messageReply;

    public RabbitMQClientTest() {
	super();
	returnQueue = new LinkedBlockingDeque<>();
	When("When putting a (\\S+) on RMQ with banner ID BI  which satisfy criteria A", (String req) -> {
	    String msg = "{\"metadata\":{\"callback_queue\":\"integration-test\",\"response_timeout\":10,\"server_name\":\"server1\",\"context_id\":\"abcd\"},\"body\":{\"features\":{\"zone_id\":1111111,\"brand_name\":\"\",\"mobile_browser\":\"\",\"user_agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393\",\"region\":\"nc\",\"city\":\"durham\",\"zip\":\"27707\",\"area_codes\":\"919/984\",\"gmt_offset\":\"-400\",\"latitude\":35,\"longitude\":-78,\"device\":\"\",\"os\":\"\",\"dma\":\"\",\"country\":\"us\"},\"eligible_ads\":[{\"id\":\"111111\"}]}}";
	    publisher.put(msg, "in1");
	});

	Then("The RMQ should return reply with  banner id (\\d+)", (String id) -> {
	    try {
		messageReply = returnQueue.take();
	    } catch (InterruptedException e) {
		com.undertone.automation.assertion.Assert.fail("interrupted", e);
	    }
	    Assert.assertTrue(messageReply.contains(id));
	});
    }

    @Override
    public void processMsg(String msg, String routingKey) {
	try {
	    returnQueue.put(msg);
	} catch (InterruptedException e) {

	    logger.error("Got exception ", e);
	}
    }
}
