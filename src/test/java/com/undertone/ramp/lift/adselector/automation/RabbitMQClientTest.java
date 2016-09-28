package com.undertone.ramp.lift.adselector.automation;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.ramp.lift.automation.util.MsgProcess;
import com.ramp.lift.automation.util.RabbitMQConsumer;
import com.ramp.lift.automation.util.RabbitMQPublisher;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

import java.io.IOException;
import java.util.concurrent.BlockingDeque;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.TimeoutException;

/**
 * Created by nive on 2016-09-28.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:S3PlanLoader.feature", plugin = { "pretty", "json:target/cucumber/s3" })
public class RabbitMQClientTest extends BaseTest implements MsgProcess {
    protected Connection conn;
    protected RabbitMQPublisher publisher;
    protected RabbitMQConsumer consumer;
    private BlockingDeque<String> returnQueue;

    public void RabbitMQClientTest(){
            init();
    }
    public void init(){
        //the consumer will wait on this queue
        returnQueue = new LinkedBlockingDeque<>();

        // will init all the values from the config map object
        ConnectionFactory fact = new ConnectionFactory();
        fact.setUsername("");
        fact.setPassword("");
        fact.setHost("");
        fact.setPort(0);
        try {
            conn = fact.newConnection();
            //consumer_tag is basically thread num
            consumer = new RabbitMQConsumer(this, conn.createChannel(),"consumer_tag",
                    "exchangeName", "queue","routhigKey");
            //// TODO: 2016-09-28
//            publisher =
        } catch (IOException | TimeoutException e) {
            System.out.println(e.getMessage());
        }

    }


    @Override
    public void processMsg(String msg, String routingKey) {

    }
}

