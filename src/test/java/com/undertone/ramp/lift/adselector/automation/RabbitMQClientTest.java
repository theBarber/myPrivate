package com.undertone.ramp.lift.adselector.automation;

import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.undertone.automation.utils.MsgProcess;
import com.undertone.automation.utils.RabbitMQConsumer;
import com.undertone.automation.utils.RabbitMQPublisher;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.Assert;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.io.IOException;
import java.util.concurrent.BlockingDeque;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.TimeoutException;

/**
 * Created by nive on 2016-09-28.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:RabbitMQ_integration.feature", plugin = { "pretty", "json:target/cucumber/s3" })
public class RabbitMQClientTest extends BaseTest implements MsgProcess {
    private static Logger logger = LoggerFactory.getLogger(RabbitMQClientTest.class);
    protected Connection conn;
    protected RabbitMQPublisher publisher;
    protected RabbitMQConsumer consumer;
    private BlockingDeque<String> returnQueue;
    private String messageReply;

    public RabbitMQClientTest() {
        super();
        init();
        When("When putting a (\\S+) on RMQ with banner ID BI  which satisfy criteria A", (String req) -> {
            String msg = "{\"metadata\":{\"callback_queue\":\"integration-test\",\"response_timeout\":10,\"server_name\":\"server1\",\"context_id\":\"abcd\"},\"body\":{\"features\":{\"zone_id\":1111111,\"brand_name\":\"\",\"mobile_browser\":\"\",\"user_agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393\",\"region\":\"nc\",\"city\":\"durham\",\"zip\":\"27707\",\"area_codes\":\"919/984\",\"gmt_offset\":\"-400\",\"latitude\":35,\"longitude\":-78,\"device\":\"\",\"os\":\"\",\"dma\":\"\",\"country\":\"us\"},\"eligible_ads\":[{\"id\":\"111111\"}]}}";
            publisher.put(msg, "in1");
        });

        Then("The RMQ should return reply with  banner id (\\d+)", (String id) -> {
            try {
                messageReply = returnQueue.take();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            Assert.assertTrue(messageReply.contains(id));
            try {
                consumer.close();
                conn.close();
            } catch (IOException e) {
                e.printStackTrace();

            }
        });
    }
    public void init(){
        //the consumer will wait on this queue
        returnQueue = new LinkedBlockingDeque<>();

        // will init all the values from the config map object
        ConnectionFactory fact = new ConnectionFactory();
//        fact.setUsername(config.get("de.rabbitmq.user"));
//        fact.setPassword(config.get("de.rabbitmq.password"));
//        fact.setHost(config.get("de.rabbitmq.host"));
//        fact.setPort(Integer.parseInt(config.get("de.rabbitmq.port")));

        fact.setUsername("noam");
        fact.setPassword("noam");
        fact.setHost("172.31.48.21");
        fact.setPort(5672);
        try {
            conn = fact.newConnection();
            //consumer_tag is basically thread num
            publisher = new RabbitMQPublisher("in",conn.createChannel());
            consumer = new RabbitMQConsumer(this, conn.createChannel(),"test",
                    "out", "integration-test",
                    "integration-test");
            consumer.start();
        } catch (IOException | TimeoutException  e) {
            logger.error(e.getMessage());
        }

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

