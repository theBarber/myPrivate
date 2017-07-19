package steps;

import cucumber.api.PendingException;
import cucumber.api.java8.En;
import infra.utils.MsgProcess;
import infra.utils.RabbitMQConsumer;
import infra.utils.RabbitMQPublisher;
import infra.utils.SqlRampAdminUtils;
import infra.utils.SqlWorkflowUtils;
import ramp.lift.uas.automation.SystemUnderTest;

import com.rabbitmq.client.ConnectionFactory;

import org.junit.Assert;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

public class BaseTest implements En {

  protected static SystemUnderTest sut = SystemUnderTest.getInstance();

  protected final String environmentName;
  protected final Map<String, String> config = Collections.synchronizedMap(new HashMap<>());

  protected ConnectionFactory connectionFactory = null;
  protected com.rabbitmq.client.Connection rabbitClientConnection;

  protected RabbitMQPublisher publisher;
  protected RabbitMQConsumer consumer;

  protected final String[] CLITESTS = new String[] {"@cli"};
  protected final String[] RABBITTESTS = new String[] {"@rabbitmq"};
  protected final String[] UASTESTS = new String[] {"@uas"};
  protected final String[] CAMPAIGNTESTS = new String[] {"@campaign"};

  public BaseTest() {
    environmentName = Optional.ofNullable(System.getenv("ENVIRONMENT")).orElse("staging").toLowerCase();
    String environmentNameConfigPrefix = environmentName + ".";
    String allEnvironmentsNameDefaultConfigPrefix = "*.";
    String allEnvironmentsNameOverrideConfigPrefix = "-.";

    Properties properties = new Properties();
    try {
      properties.load(this.getClass().getClassLoader().getResourceAsStream("environments"));
    } catch (IOException ioException) {
      Assert.fail("load configuration failed: " + ioException.getMessage());
    }
    properties.forEach((k, v) -> {
      String configurationKey = k.toString(), value = v.toString();
      if (configurationKey.startsWith(allEnvironmentsNameDefaultConfigPrefix)) {
        config.put(configurationKey.substring(allEnvironmentsNameDefaultConfigPrefix.length()), value);
      }
    });
    properties.forEach((k, v) -> {
      String configurationKey = k.toString(), value = v.toString();
      if (configurationKey.startsWith(environmentNameConfigPrefix)) {
        config.put(configurationKey.substring(environmentNameConfigPrefix.length()), value);
      }
    });
    properties.forEach((k, v) -> {
      String configurationKey = k.toString(), value = v.toString();
      if (configurationKey.startsWith(allEnvironmentsNameOverrideConfigPrefix)) {
        config.put(configurationKey.substring(allEnvironmentsNameOverrideConfigPrefix.length()), value);
      }
    });

    After(scenario -> {
      sut.teardown(scenario.getSourceTagNames(), config);
    });

    Before(scenario -> {
      String userName = System.getProperty("user.name");
      boolean onlyForUser = Boolean.getBoolean("for.user");
      if (!"jenkins".equals(userName) && onlyForUser
          && scenario.getSourceTagNames().stream().noneMatch(s -> s.equals("@" + userName))) {
        Exception notTaggedForYou = new Exception(
            "the scenario " + scenario.getName() + " is not tagged for " + userName);
        PendingException pex = new cucumber.api.PendingException();
        StackTraceElement[] trace = new StackTraceElement[1];
        trace[0] = Thread.currentThread().getStackTrace()[1];
        pex.setStackTrace(trace);
        notTaggedForYou.setStackTrace(trace);
        pex.addSuppressed(notTaggedForYou);
        throw pex;
      }

      sut.setup(scenario, config);
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
        infra.assertion.Assert.fail("unable to initialize rabbitmq connection", e);
        e.printStackTrace();
      }

    });
  }

  public void setupDB(){
    // clean db
    SqlRampAdminUtils.unableAllExperimentGroups();
    SqlWorkflowUtils.setLimitationForZone(155605, "[]");
    SqlWorkflowUtils.setLimitationForZone(156242, "[]");
    SqlWorkflowUtils.setColumnInWorkflow("campaigns", "campaignname", "ramp-lift-auto-campaign1-test", "units", "-1");
    CacheProcessTest.refreshZoneCache("http");
    
    try {
      TimeUnit.SECONDS.sleep(100);
    } catch (InterruptedException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }

}
