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
import org.apache.http.HttpEntity;
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
import org.hamcrest.Matchers;
import org.joda.time.format.DateTimeFormat;
import org.junit.runner.RunWith;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
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
    private RampAppCreateCampaign rampAppCampaignManager;
    private ObjectMapper mapper = new ObjectMapper();
    private Campaign lastCreatedCampaign;

    public UASIntegrationE2E()
    {
        super();
        Given("I disable all campaigns named \\{([^}]+)\\} in DB", this::disableAllCampaignsNamed);
        When("I create new Campaign named \\{([^}]+)\\} using ramp-app api's for LineItem (\\d+) associated to creative (\\d+) with zoneset (\\d+)", this::createCampaign);
        Then("I add the created campaign named \\{([^}]+)\\} to line item (\\d+) locally", this::addCampaignToLineItemList);
        Then("I get the Campaign named \\{([^}]+)\\} using ramp-app api's in order to set the banners", this::addBannersToCampaignFromGetRequest);
        And("I update the created campaign \\{([^}]+)\\} banners name to \\{([^}]+)\\} concatenating the serial number",this::updateBannersName);
        And("I update the created (\\w+) named \\{([^}]+)\\} (\\w+) to be (\\w+) in the DB", this::updateDB);
        And("I update last created campaign named \\{([^}]+)\\} (\\w+) to be \\{([^}]+)\\} in the DB", this::updateLastCreatedCampaignDB);
        And("I refresh the zone Cache",()->CacheProcessTest.refreshZoneCache("cmd"));
        And("I get the banners of campaign named \\{([^}]+)\\} and print it",this::printBannersOfLastCreatedCampaign);

    }

    private void createCampaign(String campaignName, Integer lineItemId, Integer creativeID, Integer zonesetID) {
        rampAppCampaignManager = sut.getRampAppCreateCampaign();
        CloseableHttpResponse createCampaignResponse = rampAppCampaignManager.createCampaign(campaignName,lineItemId, creativeID, zonesetID);
        setLastCreatedCampaignEntityFromResponse(createCampaignResponse);
    }

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

     private void addCampaignToLineItemList(String campaignName, Integer lineItemId)
    {
         assertThat("the created campaign isn't match to the given campaign",lastCreatedCampaign.getName(),is(campaignName));
         LineItem li = sut.getCampaignManager().getLineItem(lineItemId).orElseThrow(() -> new AssertionError("The Line item "+lineItemId+" does not exist!")); //lineitem shouldn't be hardcoded!!
         li.addCampaign(lastCreatedCampaign);
    }

    private void setLastCreatedCampaignEntityFromResponse(CloseableHttpResponse createCampaignResponse)
    {
        Campaign[] tmpCampaign = null;
        try{
            tmpCampaign  = mapper.readValue(EntityUtils.toString(createCampaignResponse.getEntity()), CampaignsRequest.class).getCampaignsArray();

        }catch (IOException e)
        {
            e.printStackTrace();
        }
        if(tmpCampaign[0]!=null){
            lastCreatedCampaign = tmpCampaign[0];
            sut.write("campaign successfully created!\ncampaign name: "+lastCreatedCampaign.getName() + "\ncampaign id: "+ lastCreatedCampaign.getId());
        }
        else
        {
            sut.write("campaign created is null!");
        }
    }

    private void updateLastCreatedCampaignDB(String campaignName,String columnToChange, String value)
    {
        assertThat(campaignName, is(lastCreatedCampaign.getName()));
        SqlWorkflowUtils.setColumnInWorkflow("campaigns", "campaignid",String.valueOf(lastCreatedCampaign.getId()), columnToChange, value);
    }

    private void updateDB(String entityType, String entityName,String columnToChange, String value)
    {
        assertThat(entityType, isOneOf("campaign", "banner"));
        Optional<? extends WithId<Integer>> expectedEntity = sut.getCampaignManager().getterFor(entityType)
                .apply(entityName);

        assertThat("Could not find " + entityType + " named " + entityName, expectedEntity,
                is(not(OptionalMatchers.empty())));
        SqlWorkflowUtils.setColumnInWorkflow(entityType+'s', entityType+"id", String.valueOf(expectedEntity.get().getId()), columnToChange, value);
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

    private void printBannersOfLastCreatedCampaign(String campaignName)
    {
        CloseableHttpResponse getCampaignResponse = rampAppCampaignManager.getCampaignRequest(lastCreatedCampaign.getId());
        Campaign[] tmpCampaign;
        try{
            tmpCampaign  = mapper.readValue(EntityUtils.toString(getCampaignResponse.getEntity()), Campaign[].class);
            sut.write("the banners of campaign named: " + tmpCampaign[0].getName()+ " are: ");
            for (Banner banner : tmpCampaign[0].getBanners()) {
                sut.write("created banner id is: "+ banner.getId());
            }
        }catch (IOException IOE)
        {
            IOE.printStackTrace();
        }catch (NullPointerException e)
        {
            e.printStackTrace();
            throw e;
        }
    }

}
