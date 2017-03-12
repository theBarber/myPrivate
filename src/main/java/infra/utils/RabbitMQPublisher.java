package infra.utils;

import com.rabbitmq.client.AMQP;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.ConfirmListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.PriorityBlockingQueue;
import java.util.concurrent.TimeUnit;

/**
 * Created by noam on 01/05/16.
 */
public class RabbitMQPublisher {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    private String exchangeName;

    Channel channel;

    private volatile BlockingQueue<Long> unconfirmedSet = new PriorityBlockingQueue<>();

    private ConfirmListener confirmListener = new ConfirmListener() {
	@Override
	public void handleAck(long seqNo, boolean multiple) throws IOException {
	    try {
		unconfirmedSet.put(seqNo);
	    } catch (InterruptedException e) {
		logger.error("Faield to handleAck ", e);
		Thread.currentThread().interrupt();
	    }
	}

	@Override
	public void handleNack(long deliveryTag, boolean multiple) throws IOException {
	    // not need as we use auto ack
	}
    };

    public RabbitMQPublisher() {
	// used for Junit
    }

    public RabbitMQPublisher(String exchangeName, Channel channel) {
	this.exchangeName = exchangeName;
	this.channel = channel;
	try {
	    channel.addConfirmListener(confirmListener);
	    channel.confirmSelect();
	    channel.exchangeDeclare(exchangeName, "direct", false);
	} catch (IOException e) {
	    logger.error("Failed to created channel", e);
	}
    }

    public boolean put(String msg, String routingKey) {

	try {
	    channel.basicPublish(exchangeName, routingKey,
		    new AMQP.BasicProperties.Builder().contentType("text/plain").deliveryMode(1) // transient
			    .priority(1).build(),
		    msg.getBytes(StandardCharsets.US_ASCII));

	    // block until listener callback updated the set, or until timeout
	    // occurs
	    unconfirmedSet.poll(10, TimeUnit.MILLISECONDS);
	    return true;
	} catch (Exception e) {
	    logger.error("Failed to publish", e);
	    return false;
	}
    }

}
