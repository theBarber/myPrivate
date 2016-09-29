package com.ramp.lift.automation.util;

import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.BlockingDeque;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.TimeoutException;

/**
 * Created by nive on 2016-09-29.
 */
public class RabbitMQClientThread implements MsgProcess, Runnable {

    private static Logger logger = LoggerFactory.getLogger(RabbitMQClientThread.class);
    protected Connection conn;
    protected RabbitMQPublisher publisher;
    protected RabbitMQConsumer consumer;
    private BlockingDeque<String> returnQueue;
    private  Map<String, String> prop;

    public void RabbitMQClientThread(Map<String, String> props) {
        prop = props;
        init();
    }

    public void init() {
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
            consumer = new RabbitMQConsumer(this, conn.createChannel(), "consumer_tag",
                    "exchangeName", "queue", "routhigKey");
            //// TODO: 2016-09-28
//            publisher =
        } catch (IOException | TimeoutException e) {
            System.out.println(e.getMessage());
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

    @Override
    public void run() {

    }
}