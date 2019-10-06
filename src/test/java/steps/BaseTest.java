package steps;

import cucumber.api.PendingException;
import cucumber.api.java8.En;
import infra.cli.process.CliCommandExecution;
import infra.utils.SqlWorkflowUtils;
import org.junit.Rule;
import org.junit.rules.Timeout;
import ramp.lift.uas.automation.SystemUnderTest;

import java.io.*;
import java.util.*;
import java.util.concurrent.TimeUnit;

public class BaseTest implements En {


  @Rule
  public Timeout globalTimeout = Timeout.seconds(600); // 10 minutes max per method tested

  protected static SystemUnderTest sut = SystemUnderTest.getInstance();

  protected String environmentName;
  protected final Map<String, String> config = Collections.synchronizedMap(new HashMap<>());
  protected final String[] CAMPAIGNTESTS = new String[] {"@campaign"};
  protected final String[] PROGRAMMATIC = new String[] {"@programmatic"};
  protected final String[] DYNAMICTAG = new String[] {"@DinamicTag"};
  protected final String[] HEADERBIDDING = new String[] {"@HeaderBidding"};
  protected final String[] API = new String[] {"@API"};
  protected final String[] CI = new String[] {"@CI"};
  private Set<String> failed_scenarios = Collections.synchronizedSet(new TreeSet<>());
  String failed_scenarios_file = "target/rerun.txt";


  //protected com.rabbitmq.client.Connection rabbitClientConnection;
  //protected ConnectionFactory connectionFactory = null;

  // protected RabbitMQConsumer consumer;
  // protected RabbitMQPublisher publisher;

  //protected final String[] RABBITTESTS = new String[] {"@rabbitmq"};
  //protected final String[] UASTESTS = new String[] {"@uas"};
  //protected final String[] CLITESTS = new String[] {"@cli"};

  public BaseTest() {
    Properties properties;
    properties = loadPropertiesFile("config.properties");
    properties.forEach((k, v) -> {
      config.put(k.toString(), v.toString());
    });

    After(scenario -> {
//      if(scenario.isFailed()){
//         writeToFile(scenario.getId(),failed_scenarios_file);
//      }
      sut.teardown(scenario.getSourceTagNames(), config);
    });

    Before(scenario -> {
      environmentName = config.get("env.name");
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


  }

  public synchronized void writeToFile(String str, String filepath) {
    File f = new File(filepath);
    FileWriter writer = null;
    try {
      writer = new FileWriter(f, true);
    } catch (IOException e) {
      e.printStackTrace();
    }
    try {
        boolean condition = failed_scenarios.add(str);
        if(condition) {
            writer.write(str);
            writer.write(System.lineSeparator());
            writer.flush();
            writer.close();
        }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }


  public Properties loadPropertiesFile(String filePath) {

    Properties prop = new Properties();

    try (InputStream resourceAsStream = getClass().getClassLoader().getResourceAsStream(filePath)) {
      prop.load(resourceAsStream);
    } catch (IOException e) {
      System.err.println("Unable to load properties file : " + filePath);
    }

    return prop;

  }


  protected void restartServerNamed(String serverName)
  {
    String restartServerCmd = "sudo docker-compose -f /opt/docker-compose.yml restart "+ serverName;
    cmd(restartServerCmd,"Couldn't run query");
  }

  protected void cmd(String cmd, String error)
  {
    sut.cmd(cmd, error);
  }

  public void setupDB(){

    SqlWorkflowUtils.setLimitationForZone(161482, "[]");
    SqlWorkflowUtils.WorkflowQuery("UPDATE `undertone`.`zones` SET `status`='0' WHERE `zoneid`='161482'");
    SqlWorkflowUtils.WorkflowQuery("UPDATE `undertone`.`campaigns` SET `capping`='0', `session_capping`='0', `units`='-1', `status`='0' WHERE `campaignid`='278956';");
    SqlWorkflowUtils.WorkflowQuery("UPDATE `undertone`.`tags` SET `is_migrated`='1' WHERE `tagid`='176';");
    SqlWorkflowUtils.WorkflowQuery("UPDATE `undertone`.`publishers` SET `publisher_status_cd`='ACTIVE' WHERE `id` in (3674,3666,3675,3690,3697,2546);");
    CacheProcessTest.refreshZoneCache("cmd");
    try {
      TimeUnit.SECONDS.sleep(35);
      sut.write("sleeping 10 seconds");
    } catch (InterruptedException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }

}
