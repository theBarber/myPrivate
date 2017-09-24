package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.junit.runner.RunWith;

import java.io.IOException;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:SaharCreateCampaignCheck.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/uas-adselector-Sahar_$TIMESTAMP$.json"})
public class SaharCreateCampaign extends BaseTest{

    public SaharCreateCampaign()
    {
        super();
        When("I create new Campaign named \\{([^}]+)\\} for LineItem (\\d+)", this::createCampaign);
        Then("i get Campaign (\\d+)", this::getCampaign);
        Then("new campaign created successfully for LineItem (\\d+)", (Integer s) -> {

        });
    }

    private void createCampaign(String campaignName, Integer lineItemId) {
       /* String lineItemAsString = String.valueOf(lineItemId);
        String json = "{\"campaignsArray\":[{\n" +
                "\"campaignName\":\""+campaignName+"\",\n"+
                "\"endDateTime\":\"2018-08-31 23:59\",\n" +
                "\"lineItemId\":\""+lineItemAsString+"\",\n"+
                "\"selectedCreativeIds\":[204],\n" +
               "\"Zonesets\":{\"include\":[62185]\n, \"exclude\":[]}," +
                "\"startDateTime\":\"2017-09-13 10:28\"\n" +
                "}]}";
        HttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("http://services-ramp-staging.ramp-ut.io:3003/api/v1/io/campaigns");
        httpPost.setHeader("rampInternal","true");
        httpPost.setEntity(new StringEntity(json, ContentType.APPLICATION_JSON));
        HttpResponse response = null;
        try {
            response = httpclient.execute(httpPost);
            System.out.println(EntityUtils.toString(response.getEntity()));
        } catch (IOException e) {
            e.printStackTrace();
        }*/
    }

    private void getCampaign(Integer campaignID)
    {
        HttpClient httpclient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet("http://services-ramp-staging.ramp-ut.io:3003/api/v1/io/campaigns?"+campaignID);
        httpGet.setHeader("rampInternal","true");
        HttpResponse response = null;
        try {
            response = httpclient.execute(httpGet);
            System.out.println(EntityUtils.toString(response.getEntity()));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}
