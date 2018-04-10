package steps;

import co.unruly.matchers.OptionalMatchers;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.DataTable;
import cucumber.api.junit.Cucumber;
import entities.*;
import entities.ramp.app.api.*;
import infra.module.WithId;
import infra.utils.SqlWorkflowUtils;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.util.EntityUtils;
import org.junit.Assert;
import org.junit.runner.RunWith;
import java.io.IOException;
import java.io.UncheckedIOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.isOneOf;
import static org.hamcrest.Matchers.not;
import static org.junit.Assert.assertThat;

@CucumberOptions(features = "classpath:API_Examples.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/API_Examples_$TIMESTAMP$.json"})
@RunWith(Cucumber.class)
public class API_EntitiesCreator extends BaseTest{
    final private String CREATIVES_SOURCE_FILE_PATH = "/input_files/creativesTemplates.json";
    final private String CAMPAIGN_PATTERN_SOURCE_FILE_PATH = "/input_files/Templates.json";
    private ObjectMapper mapper = new ObjectMapper();

    public API_EntitiesCreator()
    {
        super();
        Then("i create new zone named \\{([^}]+)\\} with limitation \\{([^}]+)\\} with adUnitId (\\w+) and web_section id (\\d+) with affiliateId (\\d+) with po_line_item_id (\\d+)",this::createNewZoneAndZoneset);
        And("i create new campaigns with existing zoneset",this::createMultipleCampaigns);
        And("i create new campaigns with zoneset by name",this::createMultipleCampaignsWithZoneName);
        And("i create new campaigns with new zoneset",this::createMultipleCampaignsWithNewZoneset);
        Given("i create new campaigns, new zoneset with domains",this::createMultipleCampaignsWithNewZonesetWithDomains);
        And("i update (campaign|zone|banner) data by (id|name)",this::updateEntityData);
        And("i create new Deals",this::createMultipleDeals);
        And("i create new creatives",this::createMultipleCreatives);
        And("i create campaigns from Template",this::createMultipleCampaignsFromTemplate);
        Given("I disable all campaigns named \\{([^}]+)\\} in DB", this::disableAllCampaignsNamed);
        When("I create new Campaign named \\{([^}]+)\\} using ramp-app api's for LineItem (\\d+) associated to creative (\\d+) with zoneset (\\d+) with priority \\{([^}]+)\\}", this::createCampaign);
        And("I update the created campaign \\{([^}]+)\\} banners name to \\{([^}]+)\\} chained with the serial number",this::updateBannersName);
        And("I update the created (\\w+) named \\{([^}]+)\\} (\\w+) to be (\\w+) in the DB", this::updateDB);
        And("I update last created campaign named \\{([^}]+)\\} (\\w+) to be \\{([^}]+)\\} in the DB", this::updateLastCreatedCampaignDB);
        And("I refresh the zone Cache",()->CacheProcessTest.refreshZoneCache("cmd"));
        And("i create new Campaign named \\{([^}]+)\\} for LineItem (\\d+) associated to creative (\\d+) with zoneset named \\{([^}]+)\\} with priority \\{([^}]+)\\}",this::createCampaignWithZonesetName);
    }

    private void createMultipleCampaignsWithZoneName(DataTable campaigns)
    {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<String> campaign;
        List<Integer> zonesetsId;
        for(int i=1;i<campaignsList.size();i++)
        {
            campaign = campaignsList.get(i);
            zonesetsId = getZonesetsIds(campaign);
            CreateCampaignRequest createCampaignRequest = getCreateCampaignRequestEntity(/*campaignName*/campaign.get(0), /*lineItemId*/campaign.get(2),/*creativeID_Or_DealID*/Integer.valueOf(campaign.get(4)),zonesetsId, /*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
            createCampaign(createCampaignRequest,/*IO_id*/Integer.valueOf(campaign.get(1)),/*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
        }
    }

    private void createMultipleCampaigns(DataTable campaigns)
    {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<String> campaign;
        List<Integer> zonesetsId;
        for(int i=1;i<campaignsList.size();i++)
        {
            campaign = campaignsList.get(i);
            zonesetsId = getZonesetsIds(campaign);
            CreateCampaignRequest createCampaignRequest = getCreateCampaignRequestEntity(/*campaignName*/campaign.get(0), /*lineItemId*/campaign.get(2),/*creativeID_Or_DealID*/Integer.valueOf(campaign.get(4)),zonesetsId, /*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
            createCampaign(createCampaignRequest,/*IO_id*/Integer.valueOf(campaign.get(1)),/*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
        }
    }

    private void createMultipleCampaignsWithNewZoneset(DataTable campaigns)
    {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<String> campaign;
        List<Integer> zonesetsId;
        for(int i=1;i<campaignsList.size();i++)
        {
            campaign = campaignsList.get(i);
            zonesetsId = getZonesetsIds(campaign);
            CreateCampaignRequest createCampaignRequest = getCreateCampaignRequestEntity(/*campaignName*/campaign.get(0), /*lineItemId*/campaign.get(2),/*creativeID_Or_DealID*/Integer.valueOf(campaign.get(4)),zonesetsId, /*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
            createCampaign(createCampaignRequest,/*IO_id*/Integer.valueOf(campaign.get(1)),/*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
        }
    }

    private void createMultipleCampaignsWithNewZonesetWithDomains(DataTable campaigns) {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<String> campaign;
        List<Integer> zonesetsId;
        for(int i=1;i<campaignsList.size();i++)
        {
            campaign = campaignsList.get(i);
            zonesetsId = getZonesetsIds(campaign);
            CreateCampaignRequest createCampaignRequest = getCreateCampaignRequestEntity(/*campaignName*/campaign.get(0), /*lineItemId*/campaign.get(2),/*creativeID_Or_DealID*/Integer.valueOf(campaign.get(4)),zonesetsId, /*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
            createCampaignRequest.setSupplySources(getSupplySources(campaign.get(11),campaign.get(12)));
            createCampaign(createCampaignRequest,/*IO_id*/Integer.valueOf(campaign.get(1)),/*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
        }
    }
    //creating zones and zoneset if needed (if not exist)
    private List<Integer> getZonesetsIds(List<String> campaignDataTable) {
        String zonesetsNameAsString = campaignDataTable.get(5);
        List<String> zonesetNamesAsList;
        List<Integer> zonesetsIdsList = new ArrayList<>();
        Integer zonesetId;

        if(zonesetsNameAsString.length()<3)
            throw new AssertionError("zonesetList is invalid,should be larger then 2");

        zonesetNamesAsList = Arrays.asList(zonesetsNameAsString.substring(1, zonesetsNameAsString.length()-1).split(","));
        for(String zonset: zonesetNamesAsList)
        {
            try{
                zonesetId = Integer.parseInt(zonset); /*check if it number -> then its an id*/
            }catch (NumberFormatException e) //not a number -> then a name
            {
                if(!(sut.getCampaignManager().getZoneset(zonset)).isPresent())
                        createNewZoneAndZoneset(/*zoneAndZonesetName*/zonset,/*limitation*/campaignDataTable.get(6), /*adUnitId*/campaignDataTable.get(7),/*web_section_id*/campaignDataTable.get(8),/*affiliateId*/campaignDataTable.get(9),/*po_lineItem_id*/campaignDataTable.get(10));
                zonesetId = sut.getCampaignManager().getZoneset(zonset).orElseThrow(()->new AssertionError("zoneset were not found!")).getId();
            }
            zonesetsIdsList.add(zonesetId);
        }
        return zonesetsIdsList;
    }

    private SupplySources getSupplySources(String include, String exclude) {
        List<String> includeList =null,excludeList=null;

        if(include.length()>2)
            includeList = Arrays.asList((include.substring(1, include.length()-1)).split(","));
        if(exclude.length()>2)
            excludeList = Arrays.asList(((exclude.substring(1, exclude.length()-1)).split(",")));

        return new SupplySources(includeList,excludeList);
    }

    private void createMultipleDeals(DataTable deals)
    {
        List<List<String>> dealList = deals.asLists(String.class);
        List<String> deal;
        for(int i=1;i<dealList.size();i++)
        {
            deal = dealList.get(i);
            createDeal(deal.get(0),Integer.valueOf(deal.get(1)),Integer.valueOf(deal.get(2)),Integer.valueOf(deal.get(3)),Integer.valueOf(deal.get(4)),Integer.valueOf(deal.get(5)));
        }
    }

    private void createMultipleCreatives(DataTable creatives)
    {
        List<List<String>> creativeList = creatives.asLists(String.class);
        List<String> creative;
        for(int i=1;i<creativeList.size();i++)
        {
            creative = creativeList.get(i);
            createCreative(creative.get(0),Integer.valueOf(creative.get(1)),Integer.valueOf(creative.get(2)),creative.get(3));
        }
    }

    private void createMultipleCampaignsFromTemplate(DataTable campaigns)
    {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<String> campaign;
        JsonNode campaignsTemplates = getCampaignsTemplates().orElseThrow(()->new AssertionError("can't parse campaigns templates"));
        JsonNode campaignNode;

        for(int i=1;i<campaignsList.size();i++)
        {
            campaign = campaignsList.get(i);
            campaignNode = campaignsTemplates.get(campaign.get(1)).get(campaign.get(2));
            createNewZoneAndZoneset(/*zoneAndZonesetName*/campaign.get(3),/*limitation*/"[]", /*adUnitId*/campaignNode.get("adUnit").toString(),/*web_section_id*/campaignNode.get("web_section_id").toString(),/*affiliateId*/campaignNode.get("publisher").toString(),/*po_lineItem_id*/campaignNode.get("po_line_item").toString());
            if(campaign.get(1).contains("server programmatic"))
                createCampaignWithZonesetName(campaign.get(0),campaignNode.get("io").intValue(),campaignNode.get("io_lineItem").intValue(),true,campaignNode.get("dealID").intValue(),campaign.get(3));
            else {
                createCampaignWithZonesetName(campaign.get(0),campaignNode.get("io").intValue(),campaignNode.get("io_lineItem").intValue(),false,campaignNode.get("creative").intValue(),campaign.get(3));
            }
        }
    }


    private Optional<JsonNode> getCampaignsTemplates() {
        JsonNode campaignsTemplates = null;
        try {
            campaignsTemplates = mapper.readTree(this.getClass().getResourceAsStream(CAMPAIGN_PATTERN_SOURCE_FILE_PATH));
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
        return Optional.of(campaignsTemplates);
    }

    private void createCreative(String creativeName, Integer IO, Integer adUnitID,String htmlTemplateType)
    {
        JsonNode creativesTemplates;
        try {
            creativesTemplates = mapper.readTree(this.getClass().getResourceAsStream(CREATIVES_SOURCE_FILE_PATH));
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
        Creative creative = sut.getRampAppCreateEntitiesManager().createCreative(creativeName, IO, adUnitID, creativesTemplates.get(htmlTemplateType).toString());
        //add it some list
    }

    private void createDeal(String dealName,Integer dspID,Integer floorPrice,Integer dealType,Integer adUnitId, Integer IO)
    {
        List<Integer>adUnitsIds = new ArrayList<Integer>(){{add(adUnitId);}};
        DealRequest dealRequest = new DealRequest(new Deal(0,dealName,dspID,floorPrice,dealType,adUnitsIds));
        Deal deal = sut.getRampAppCreateEntitiesManager().createDeal(dealRequest,IO);
        //add it to some list
    }

   private void createNewZoneAndZoneset(String zoneAndZonesetName, String limitation,String adUnitId, String web_section_id, String affiliateId, String po_lineItem_id)
    {
        Optional<Zone> createdZone = sut.getRampAppCreateEntitiesManager().createZone(zoneAndZonesetName, adUnitId, limitation, web_section_id, affiliateId);
        if(!createdZone.isPresent())
        {
            throw new AssertionError("zone wasn't created!");
        }
       else
        {
            Optional<ZoneSet> createdZoneset = sut.getRampAppCreateEntitiesManager().createZoneset(zoneAndZonesetName, new TreeSet<Zone>() {{ add(createdZone.get()); }}, "1", "1");
            if (!createdZoneset.isPresent()) {
                 throw new AssertionError("zoneset wasn't created!");
            }
            else
            {
                createdZoneset.get().addZone(createdZone.get());
                addCreatedZonesetToCampaignManager(createdZoneset.get());
                update_po_line_item_zones_InDB(createdZone.get().getId(), po_lineItem_id);
                printZonesetAndZone(createdZoneset.get(), createdZone.get());
            }
        }
    }

    private void printZonesetAndZone(ZoneSet zoneSet, Zone zone) {
        sut.write("zoneset created successfully! zoneset id is:"+ zoneSet.getId());
        sut.write("zone created successfully! zone id is:"+ zone.getId());
    }

    private void updateEntityData(String entity, String updateBy, DataTable entities)
    {
        List<List<String>> EntityList = entities.asLists(String.class);
        List<String> entityData;
        Integer entityID;

        for(int i=1;i<EntityList .size();i++)
        {
            entityData = EntityList.get(i);
            entityID = updateBy.equals("name")?sut.getCampaignManager().getterFor(entity).apply(entityData.get(0)).orElseThrow(()->new AssertionError("entity wasn't found")).getId():Integer.valueOf(entityData.get(0));
            for(int j=1;j<entityData.size();j++)
            {
                SqlWorkflowUtils.setColumnInWorkflow(entity+"s", entity + "id",entityID.toString(), EntityList.get(0).get(j), entityData.get(j));
            }
        }
    }

    private void update_po_line_item_zones_InDB(Integer zoneId, String po_line_item_ID)
    {
        SqlWorkflowUtils.WorkflowQuery("INSERT INTO `adserver`.`po_line_items_zones` (`po_line_item_id`, `zone_id`, `created_by`, `updated_by`) VALUES ('"+po_line_item_ID+"', '"+zoneId+"', '974', '974');");
    }

    private void addCreatedZonesetToCampaignManager(ZoneSet zoneSet)
    {
        sut.getCampaignManager().getZonesets().add(zoneSet);
    }

    private void createCampaign(CreateCampaignRequest campaignsRequest,Integer IO_id, Boolean isServerProgrammatic){ /*String campaignName, Integer IO_id, Integer lineItemId, Boolean isServerProgrammatic, Integer creativeID_Or_DealID, Integer zonesetID) {*/
        Optional<Campaign> createdCampaign = sut.getRampAppCreateEntitiesManager().createCampaign(campaignsRequest,isServerProgrammatic);

        if(!createdCampaign.isPresent()){
            throw new AssertionError("Error: campaign wasn't created!");
        }
        else
        {
            insertCampaignToIOMap(createdCampaign.get(),IO_id,Integer.valueOf(campaignsRequest.getLineItemId()));
            updateBannersName(createdCampaign.get().getName(),createdCampaign.get().getName()+"-banner-");
            printCampaign(createdCampaign.get());
            updateCampaign(createdCampaign.get().getId(),"status","0");
        }
    }

    private void updateCamapaignInitiativeSetUpOnDB(Integer campaignid) {
        updateCampaign(campaignid,"status","0");
        updateCampaign(campaignid,"priority","-1");
        updateCampaign(campaignid,"units","-1");
        updateCampaign(campaignid,"campaign_delivery_method","2");
    }

    private CreateCampaignRequest getCreateCampaignRequestEntity(String campaignName, String lineItemId, Integer creativeID_Or_DealID, List<Integer> zonesetsIDs, Boolean isServerProgrammatic)
    {
        Zonesets zonesets = new Zonesets();
        zonesets.setInclude(zonesetsIDs);
        if(!isServerProgrammatic)
            return new CreateCampaignRequest(campaignName,lineItemId,
                    zonesets, new ArrayList<Integer>(){{add(creativeID_Or_DealID);}},
                    dateFromNow(-1),dateFromNow(1));
        else
            return new CreateCampaignRequest(campaignName,lineItemId,
                    zonesets, creativeID_Or_DealID,
                    dateFromNow(-1),dateFromNow(1));
    }

    private String dateFromNow(Integer daysToAdd) {
        final Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, daysToAdd);
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        return dateFormat.format(cal.getTime());
    }

    private void printCampaign(Campaign campaign) {
        sut.write("Campaign id: "+ campaign.getId());
        sut.write("Campaign name: "+ campaign.getName());
        sut.write("the banners of campaign named: " + campaign.getName()+ " are: ");
        for(Banner banner: campaign.getBanners())
        {
            sut.write("Banner id:"+ banner.getId());
            sut.write("Banner name:"+ banner.getName());
        }
    }

    private void createCampaignWithZonesetName(String campaignName,Integer IO_id, Integer lineItemId,Boolean isServerProgrammatic, Integer creativeID_Or_DealID, String zonesetName)
    {
        ZoneSet zoneset = sut.getCampaignManager().getZoneset(zonesetName).orElseThrow(()->new AssertionError("zoneset doesn't exist!"));

        //createCampaign(campaignName,IO_id ,lineItemId,isServerProgrammatic,creativeID_Or_DealID,zoneset.getId());
    }

    private void insertCampaignToIOMap(Campaign campaign, Integer IO_id,Integer lineItemID)
    {
        if(sut.getCampaignManager().getCampaign(campaign.getName()).isPresent())
            throw new AssertionError("campaign name should be with unique name");

        sut.getCampaignManager().insertCampaignToIOMap(campaign,lineItemID,IO_id);
    }



   /* private void setLastCreatedCampaignEntityFromResponse(CloseableHttpResponse createCampaignResponse)
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
    }*/

    private void updateCampaign(Integer id, String columnToChange, String value)
    {
        SqlWorkflowUtils.setColumnInWorkflow("campaigns", "campaignid",String.valueOf(id), columnToChange, value);
    }

    private void updateLastCreatedCampaignDB(String campaignName,String columnToChange, String value) //remove!-------------------------------
    {
       // assertThat(campaignName, is(lastCreatedCampaign.getName()));
       // SqlWorkflowUtils.setColumnInWorkflow("campaigns", "campaignid",String.valueOf(lastCreatedCampaign.getId()), columnToChange, value);
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

    private void printBannersOfCampaign(Integer campaignID)
    {
        CloseableHttpResponse getCampaignResponse = sut.getRampAppCreateEntitiesManager().getCampaignRequest(campaignID);
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
