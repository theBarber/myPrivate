package infra.utils;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.TimeoutException;

import com.rabbitmq.client.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by noam on 01/05/16. Rabbit msg publisher
 */
public class RabbitMQConsumer {
    private static Logger logger = LoggerFactory.getLogger(RabbitMQConsumer.class);
    private Channel channel;
    private String queueName;
    private MsgProcess msgProcess;
    private String consumerTag;

    public RabbitMQConsumer(final MsgProcess msgProcess, Channel channel, String consumerTag, String exchangeName,
	    String queueName, String routingKey) throws IOException, TimeoutException {
	this.msgProcess = msgProcess;
	this.consumerTag = consumerTag;
	this.queueName = queueName;
	this.channel = channel;
	channel.basicQos(50);
	logger.info("Using queue=" + queueName);
	channel.exchangeDeclare(exchangeName, "direct", false);
	channel.queueDeclare(queueName, false, false, false, null);
	channel.queueBind(queueName, exchangeName, routingKey);
	logger.info("consumer thread " + consumerTag + " for " + queueName);
    }

    public void start() throws IOException {
	channel.basicConsume(queueName, true, consumerTag, new DefaultConsumer(channel) {
	    @Override
	    public void handleDelivery(String consumerTag, Envelope envelope, AMQP.BasicProperties properties,
		    byte[] body) throws IOException {
		String routeKey = envelope.getRoutingKey();
		String msg = new String(body, StandardCharsets.US_ASCII);
		msgProcess.processMsg(msg, routeKey);
	    }
	});
    }

    public void close() throws IOException {
	channel.queueDelete(queueName);
    }

}
