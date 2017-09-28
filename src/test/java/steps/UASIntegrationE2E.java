package steps;

import co.unruly.matchers.OptionalMatchers;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.org.apache.xpath.internal.SourceTreeManager;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import entities.*;
import entities.ramp.app.api.CampaignsRequest;
import infra.module.WithId;
import infra.utils.SqlWorkflowUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.joda.time.format.DateTimeFormat;
import org.junit.runner.RunWith;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Optional;

import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.isOneOf;
import static org.hamcrest.Matchers.not;
import static org.junit.Assert.assertThat;

@CucumberOptions(features = "classpath:UASIntegrationE2E.feature", plugin = { "pretty",
        "infra.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)
public class UASIntegrationE2E extends BaseTest {
    private CloseableHttpClient httpclient = HttpClients.custom().setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(30000).build()).build();
    private RampAppCreateCampaign rampAppCampaignManager;
    private ObjectMapper mapper = new ObjectMapper();
    public UASIntegrationE2E()
    {
        super();
        Given("I disable all campaigns named \\{([^}]+)\\} in DB", this::disableAllCampaignsNamed);
        When("I create new Campaign named \\{([^}]+)\\} using ramp-app api's for LineItem (\\d+) associated to creative (\\d+) with zoneset (\\d+)", this::createCampaign);
        Then("I get the Campaign named \\{([^}]+)\\} using ramp-app api's in order to set the banners", this::addBannersToCampaignFromGetRequest);
        And("I update the created campaign \\{([^}]+)\\} banners name to \\{([^}]+)\\} concatenating the serial number",this::updateBannersName);
        And("I update the created (\\w+) named \\{([^}]+)\\} status to be (\\d+)", this::updateStatus);
        And("I refresh the zone Cache",()->CacheProcessTest.refreshZoneCache("cmd"));

    }

    private void createCampaign(String campaignName, Integer lineItemId, Integer creativeID, Integer zonesetID) {
        rampAppCampaignManager = sut.getRampAppCreateCampaign();
        CloseableHttpResponse createCampaignResponse = rampAppCampaignManager.createCampaign(campaignName,lineItemId, creativeID, zonesetID);
        addCampaignToLineItemList(createCampaignResponse, lineItemId);

        // rampAppCampaignManager.createCampaign(campaignName);
       /* String uri = "http://services-ramp-staging.ramp-ut.io:3003/api/v1/io/campaigns";//the beginning of the url should be brought from env
        //String uri = "http://172.19.35.74:3003/api/v1/io/campaigns"; // for dev
        String lineItemAsString = String.valueOf(lineItemId);

        String json = "{\"campaignsArray\":[{\n" +
                "\"campaignName\":\""+campaignName+"\",\n"+
                "\"endDateTime\":\""+dateFromNow(1)+"\",\n" +
                "\"lineItemId\":\""+lineItemAsString+"\",\n"+
                "\"selectedCreativeIds\":[{\"id\":\""+creativeID+"\",\"weight\":\"1\"}],\n" +
                "\"Zonesets\":{\"include\":["+zonesetID+"],\n \"exclude\":[]}," +
                "\"startDateTime\":\""+dateFromNow(-1)+"\"\n" +
                "}]}";
        HttpPost httpPost = new HttpPost(uri);
        httpPost.setHeader("rampInternal","true");
        httpPost.setEntity(new StringEntity(json, ContentType.APPLICATION_JSON));
        CloseableHttpResponse createCampaignResponse = null;
        try {
            createCampaignResponse = httpclient.execute(httpPost);

        } catch (IOException e) {
            e.printStackTrace();
            throw new UncheckedIOException("failed to send request (" + uri + ") ", e);
        }
        assertThat("Status code of create campaign request", createCampaignResponse.getStatusLine().getStatusCode(), is(200));
        addCampaignToLineItemList(createCampaignResponse, lineItemId);*/
    }

//    private String dateFromNow(Integer daysToAdd) {
//        final Calendar cal = Calendar.getInstance();
//        cal.add(Calendar.DATE, daysToAdd);
//        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
//        return dateFormat.format(cal.getTime());
//    }

    /*private CloseableHttpResponse getCampaignRequest(String campaignName)
    {

         Campaign campaign= sut.getCampaignManager().getCampaign(campaignName).orElseThrow(() -> new AssertionError("The Campaign " + campaignName + " does not exist!"));
        String url = "http://services-ramp-staging.ramp-ut.io:3003/api/v1/io/campaigns?campaignIds="+campaign.getId(); //the beginning of the url should be brought from env
        //String url = "http://172.19.35.74:3003/api/v1/io/campaigns?campaignIds="+campaign.getId(); // for dev
        HttpGet httpGet = new HttpGet(url);
        httpGet.setHeader("rampInternal","true");
        CloseableHttpResponse getCampaignResponse = null;
        try {
            getCampaignResponse = httpclient.execute(httpGet);
        } catch (IOException e) {
            e.printStackTrace();
            throw new UncheckedIOException("failed to send request (" + url + ") ", e);
        }
        assertThat("Status code of impression request", getCampaignResponse.getStatusLine().getStatusCode(), is(200));
        return getCampaignResponse;
    }*/

    private void addBannersToCampaignFromGetRequest(String campaignName)
    {
        rampAppCampaignManager = sut.getRampAppCreateCampaign();
        Campaign campaign = sut.getCampaignManager().getCampaign(campaignName).orElseThrow(() -> new AssertionError("The Campaign " + campaignName + " does not exist!"));
        CloseableHttpResponse getCampaignResponse = rampAppCampaignManager.getCampaignRequest(campaign.getId());
        Campaign[] tmpCampaign;
        try{
            tmpCampaign  = mapper.readValue(EntityUtils.toString(getCampaignResponse.getEntity()), Campaign[].class);
            campaign.setBannersFromSet(tmpCampaign[0].getBanners());
        }catch (IOException IOE)
        {
            IOE.printStackTrace();
        }catch (NullPointerException e)
        {
            e.printStackTrace();
            throw e;
        }
    }

     private void addCampaignToLineItemList(CloseableHttpResponse CreateCampaignResponse, Integer lineItemId)
    {
        Campaign[] tmpCampaign;
        try{
            tmpCampaign  = mapper.readValue(EntityUtils.toString(CreateCampaignResponse.getEntity()), CampaignsRequest.class).getCampaignsArray();
            LineItem li = sut.getCampaignManager().getLineItem(lineItemId).orElseThrow(() -> new AssertionError("The Line item "+lineItemId+" does not exist!")); //lineitem shouldn't be hardcoded!!
            li.addCampaign(tmpCampaign[0]);
        }catch (IOException e)
        {
            e.printStackTrace();
        }catch (NullPointerException NPE)
        {
            NPE.printStackTrace();
            throw NPE;
        }
    }

    private void updateStatus(String entityType, String entityName, Integer status)
    {
        assertThat(entityType, isOneOf("campaign", "banner"));
        Optional<? extends WithId<Integer>> expectedEntity = sut.getCampaignManager().getterFor(entityType)
                .apply(entityName);

        assertThat("Could not find " + entityType + " named " + entityName, expectedEntity,
                is(not(OptionalMatchers.empty())));
        SqlWorkflowUtils.setColumnInWorkflow(entityType+'s', entityType+"id", String.valueOf(expectedEntity.get().getId()), "status", String.valueOf(status));

    }

    private void disableAllCampaignsNamed(String CampaignName)
    {
        SqlWorkflowUtils.setColumnInWorkflow("campaigns", "campaignname",CampaignName, "status", "1");
    }

    private void updateBannersName(String campaignName, String bannerName)
    {
        Campaign campaign= sut.getCampaignManager().getCampaign(campaignName).orElseThrow(() -> new AssertionError("The Campaign " + campaignName + " does not exist!"));
        int index = 1;
        for (Banner banner : campaign.getBanners()) {
            banner.setName(bannerName+index);
            index++;
        }
    }
}
