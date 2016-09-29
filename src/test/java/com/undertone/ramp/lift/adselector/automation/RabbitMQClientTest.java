package com.undertone.ramp.lift.adselector.automation;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.ramp.lift.automation.util.MsgProcess;
import com.ramp.lift.automation.util.RabbitMQClientThread;
import com.ramp.lift.automation.util.RabbitMQConsumer;
import com.ramp.lift.automation.util.RabbitMQPublisher;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.BlockingDeque;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.TimeoutException;

/**
 * Created by nive on 2016-09-28.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:S3PlanLoader.feature", plugin = { "pretty", "json:target/cucumber/s3" })
public class RabbitMQClientTest extends BaseTest implements MsgProcess {
    private static Logger logger = LoggerFactory.getLogger(RabbitMQClientTest.class);
    protected Connection conn;
    protected RabbitMQPublisher publisher;
    protected RabbitMQConsumer consumer;
    private BlockingDeque<String> returnQueue;
    private Map<String, String> prop;

    public RabbitMQClientTest( Map<String, String> props){
        prop = props;
        init();
        When("When putting a (\\S+) on RMQ with banner ID BI  which satisfy criteria A",(String req) ->{

        });



        publisher.put(prop.get("de.rabbitmq.request_message"), prop.get("de.rabbitmq.rouring_key"));
        try {
            String internalMsg = returnQueue.take();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
    public void init(){
        //the consumer will wait on this queue
        returnQueue = new LinkedBlockingDeque<>();

        // will init all the values from the config map object
        ConnectionFactory fact = new ConnectionFactory();
        fact.setUsername(prop.get("de.rabbitmq.user"));
        fact.setPassword(prop.get("de.rabbitmq.password"));
        fact.setHost(prop.get("de.rabbitmq.host"));
        fact.setPort(Integer.parseInt(prop.get("de.rabbitmq.port")));
        try {
            conn = fact.newConnection();
            //consumer_tag is basically thread num
            publisher = new RabbitMQPublisher(prop.get("de.rabbitmq.exchange_name"),conn.createChannel());
            consumer = new RabbitMQConsumer(this, conn.createChannel(),"test",
                    prop.get("de.rabbitmq.exchange_name"), prop.get("de.rabbitmq.queue_name"),
                    prop.get("de.rabbitmq.rouring_key"));

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

