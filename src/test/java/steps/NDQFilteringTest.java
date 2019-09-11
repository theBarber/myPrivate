package steps;

import com.amazonaws.services.athena.AmazonAthena;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.utils.AthenaClient.AthenaClientFactory;
import infra.utils.AthenaClient.AthenaUtils;
import infra.utils.SqlWorkflowUtils;
import model.ResponseType;
import org.apache.http.HttpResponse;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;
import ramp.lift.uas.automation.UASRequestModule;
import util.ResponseVerifier;
import util.api.UasApi;

import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.LongAdder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.junit.Assert.assertEquals;
import static steps.UASIntegrationTest.sendImpressionRequestsToUASImmediately;

@RunWith(Cucumber.class)
@CucumberOptions(features = {
//        "classpath:NDQFiltering.feature",
        "classpath:NdqFilteringCL.feature",
//        "classpath:NdqFilteringSL.feature",
//        "classpath:NdqFilteringTL.feature",
}, plugin = {"pretty",})
public class NDQFilteringTest extends BaseTest {
    AmazonAthena aa = new AthenaClientFactory().createClient();
    double experimentNdq;
    private static DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
    private static Date date = new Date();
    private static final String ATHENA_SAMPLE_QUERY = "select zone_id,request_id,experiment_id FROM dl_raw_data.fact_dam_requests where zone_id=2 and dt='" + dateFormat.format(date) + "'";

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


        And("^I send generic request (\\d+) times until I get strategy \\{(.*)\\}$", (Integer times, String strategy) -> {
            String output = AthenaUtils.submitAthenaQuery(aa, ATHENA_SAMPLE_QUERY);
            while(!output.contains("300")) {
                output = AthenaUtils.submitAthenaQuery(aa, ATHENA_SAMPLE_QUERY);
                UasApi.sendMultipleZoneIdAdRequestsWithParameter(times, "requestid=meow123", 2, true);
            }
            for (int i = 0; i < 55; i++) {
                sendImpressionRequestsToUASImmediately();
            }
//            Pattern pat = Pattern.compile("(https?|ftp|file)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]");
//            sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
//                Matcher mat = pat.matcher(content);
//                while (mat.find())
//                    if(mat.group().contains("/l?"))
//                        System.out.println("Match: " + mat.group());
//            });
        });




        Given("^I setup the db$", () -> {
            setupDB();
        });

        Given("I restart \\{(.*)\\}", (String serverName) -> {
            restartServerNamed(serverName);
        });
    }

    private boolean athenaResponseContains(String query){
        String queryExecutionId = AthenaUtils.submitAthenaQuery(aa, query);

        try {
            AthenaUtils.waitForQueryToComplete(aa, queryExecutionId);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        AthenaUtils.processResultRows(aa, queryExecutionId).contains();
    }
}


