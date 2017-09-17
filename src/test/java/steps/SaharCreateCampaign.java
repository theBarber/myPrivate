package steps;

import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import entities.LineItem;
import entities.ramp.app.api.CreateCampaignRequest;
import entities.ramp.app.api.CreateCampaignsRequestWrapper;
import gherkin.deps.com.google.gson.JsonArray;
import gherkin.deps.com.google.gson.JsonObject;
import gherkin.deps.com.google.gson.JsonParser;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.junit.runner.RunWith;
import sun.net.www.http.HttpClient;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:SaharCreateCampaignCheck.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/uas-adselector-Sahar_$TIMESTAMP$.json"})
public class SaharCreateCampaign extends BaseTest{

    public SaharCreateCampaign()
    {
        super();
        When("I create new Campaign named \\{([^}]+)\\} for LineItem (\\d+)", this::createCampaign);

        Then("new campaign created successfully for LineItem (\\d+)", (Integer s) -> {

        });
    }

    private void createCampaign(String campaignName, Integer lineItemId) {
        ObjectMapper m = new ObjectMapper();
        List<Header> defaultHeaders = new ArrayList<>();
        defaultHeaders.add(new BasicHeader("rampInternal", "true"));
        CloseableHttpClient httpclient = HttpClients.custom().setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(100000).build())
                .setDefaultHeaders(defaultHeaders).build();
        HttpPost authRequest = new HttpPost("/workflow/users/process_login");

        List<NameValuePair> authenticationParameters = new ArrayList<>();
        authenticationParameters.add(new BasicNameValuePair("email", "wfadmin@undertone.com"));
        authenticationParameters.add(new BasicNameValuePair("password", "b6b7c564667652e05aa6a6f54eb6bf90d"));
        authenticationParameters.add(new BasicNameValuePair("authenticity_token", "17bcfbfdeb3ce02da583bc84cd035801"));
        try  {
        HttpEntity postProcessLoginEntity = new UrlEncodedFormEntity(authenticationParameters);
        authRequest.setEntity(postProcessLoginEntity);
        HttpHost host = new HttpHost("stgadmin.undertone.com");

            CloseableHttpResponse r = httpclient.execute(host, authRequest);
            r.getEntity();
        }catch (Exception e)
        {
            e.printStackTrace();
        }


/*        String json = "{\"campaignsArray\":[{\n" +
                "\"campfaignName\":\"75396-197419-16\",\n" +
                "\"endDateTime\":\"2018-08-31 23:59\",\n" +
                "\"lineItemId\":\"197419\",\n" +
                "\"startDateTime\":\"2017-09-13 10:28\"\n" +
                "}]}";



        String url = "http://services-ramp-staging.ramp-ut.io:3003/api/v1/io/campaigns";
//        LineItem lineItem = new LineItem();
//        lineItem.setIoLineItemId(lineItemId);
//        lineItem.setStartDate("2016-07-27 16:50:35");
//        lineItem.setEndDate("2016-07-27 16:50:35");
//        CreateCampaignRequest createCampaignRequestBody = new CreateCampaignRequest(lineItem);

        HttpPost httpPost = new HttpPost(url);
        httpPost.addHeader("content-type", "application/json");
        httpPost.addHeader("rampInternal", "true");
        try{
//            CreateCampaignsRequestWrapper requestWrapper = new CreateCampaignsRequestWrapper(createCampaignRequestBody);
            HttpEntity en;
            en = new StringEntity(json, ContentType.APPLICATION_JSON);
            httpPost.setEntity(en);
            CloseableHttpResponse createCreativeResponse = httpclient.execute(httpPost);
            createCreativeResponse.setEntity(new BufferedHttpEntity(createCreativeResponse.getEntity()));
            try (BufferedReader lineReader = new BufferedReader(
                    new InputStreamReader(createCreativeResponse.getEntity().getContent()))) {
                while (lineReader.ready()) {
                    System.out.println(lineReader.readLine().replaceAll("\\\n", "\n"));
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }*/

    }


}
