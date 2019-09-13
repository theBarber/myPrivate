package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.utils.AthenaClient.AthenaUtils;
import infra.utils.SqlWorkflowUtils;
import org.junit.runner.RunWith;
import util.api.UasApi;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.LongAdder;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;
import static steps.UASIntegrationTest.sendImpressionRequestsToUASImmediately;

@RunWith(Cucumber.class)
@CucumberOptions(features = {
//        "classpath:NDQFiltering.feature",
        "classpath:NdqFilteringCL.feature",
//        "classpath:NdqFilteringSL.feature",
//        "classpath:NdqFilteringTL.feature",
}, plugin = {"pretty",})
public class NDQFilteringTest extends BaseTest {

    double experimentNdq;
    private static DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
    private static Date date = new Date();
    public static final String ATHENA_SAMPLE_QUERY = "select request_id,experiment_id FROM dl_raw_data.fact_dam_requests";

    public NDQFilteringTest() {
        super();

        Given("^I set the \\{(.*)\\} of campaign name \\{(.*)\\} to \\{(.*)\\}$",
                (String columnNameToChange, String columnValue, String columnValueToChange) -> {
                    SqlWorkflowUtils.setColumnInWorkflow("campaigns", "campaignname", columnValue, columnNameToChange,
                            columnValueToChange);
                });

        Given("^I set the \\{(.*)\\} in \\{(.*)\\} of campaign name \\{(.*)\\} to \\{(.*)\\}$",
                (String columnNameToChange, String tableName, String campaignName, String columnValueToChange) -> {
                    try {
                        ResultSet campaign = SqlWorkflowUtils.getEntityByName("campaigns", "campaignname", campaignName);
                        String campaignId = campaign.getString("campaignid");
                        SqlWorkflowUtils.setColumnInWorkflow(tableName, "campaign_id", campaignId, columnNameToChange,
                                columnValueToChange);
                    } catch (SQLException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                });

        Given("^I compute the NDQ of campaign name \\{(.*)\\}$", (String campaignName) -> {
            ResultSet campaign = SqlWorkflowUtils.getEntityByName("campaigns", "campaignname", campaignName);
            try {
                long lastDay = campaign.getDate("expire").getTime();
                int units = campaign.getInt("units");
                int daysLeft = (int) ((lastDay - System.currentTimeMillis()) / (1000 * 60 * 60 * 24)) + 2;
                double AppNdq = ((double) units / (double) daysLeft);
                double factor = campaign.getInt("factor") + 1;
                int exp_group_lbTraffic = 2;
                int exp_allocation = 100;
                experimentNdq = Math.ceil(AppNdq * factor * exp_group_lbTraffic * exp_allocation * 0.001);
                System.out.println("experimentNdq: " + experimentNdq);
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        });

        And("^I send the same amount of impressions url as the number of NDQ$", () -> {
            LongAdder impressionsSent = sendImpressionRequestsToUASImmediately();
            System.out.println("impressionsSent: " + impressionsSent);
            assertEquals("Number of impression urls sent as the number of NDQ", experimentNdq,
                    impressionsSent.intValue(), 8d);
        });




        And("^I send zone request (\\d+) times for zone (.*) until I get strategy (.*)$", (Integer times, String zone_name, String strategy) -> {
            ResultSet entityByName = SqlWorkflowUtils.getEntityByName("zones", "zonename", zone_name);
            String requestId = UUID.randomUUID().toString();
//            int cnt=0;
            for(int i = 0; i<times; i ++) {
                if (AthenaUtils.testAthena(ATHENA_SAMPLE_QUERY
                        + " where dt='" + dateFormat.format(date)
                        + "' and request_id like '" + requestId +"';", String.valueOf((strategy.equals("random")?301:300)))) {
                    System.out.println("Found requests in Req bucket. Sending impressions!");
                    for (int j = 0; j < 55; j++) {
                        sendImpressionRequestsToUASImmediately();
                        try {
                            TimeUnit.SECONDS.sleep(3);
                        } catch (InterruptedException e) {
                            fail(e.getMessage());
                        }
                    }
                    break;
                } else {
//                    cnt++;
//                    System.out.println("Didn't find requests with req id " + requestId +
//                            " and strategy " + strategy + " in Req bucket. Sending " + times +
//                            " zone requests!\nSo far sent " + cnt*times + " requests.");
                    sut.getUASRquestModule().addHttpHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36");
                    UasApi.sendMultipleZoneIdAdRequestsWithParameter(90, "requestid=" + requestId, 2, true);
                }
            }
        });

        Given("^I setup the db$", () -> {
            setupDB();
        });

        Given("I restart \\{(.*)\\}", (String serverName) -> {
            restartServerNamed(serverName);
        });

    }
    private Date yesterday(){
        final Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);
        return cal.getTime();
    }
}


