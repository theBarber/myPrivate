package steps;

import co.unruly.matchers.OptionalMatchers;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.junit.Cucumber;
import entities.*;
import entities.ramp.app.api.*;
import infra.module.WithId;
import infra.utils.SqlWorkflowUtils;
import io.cucumber.datatable.DataTable;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.util.EntityUtils;
import org.junit.Assert;
import org.junit.runner.RunWith;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import static junit.framework.TestCase.fail;
import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertThat;


//@CucumberOptions(features = "classpath:API_Examples.feature", plugin = {"pretty",})
//        "infra.RotatingJSONFormatter:target/cucumber/API_Examples_$TIMESTAMP$.json"})
@RunWith(Cucumber.class)
public class API_EntitiesCreator extends BaseTest {
    final private String CREATIVES_SOURCE_FILE_PATH = "/input_files/creativesTemplates.json";
    final private String CAMPAIGN_PATTERN_SOURCE_FILE_PATH = "/input_files/Templates.json";
    private ObjectMapper mapper = new ObjectMapper();
    public String endDateVal = "2020-03-03";
    public String startDateVal = "2019-04-04";

    public API_EntitiesCreator() {
        super();
        Then("i create new zone named \\{(.*)\\} with limitation \\{(.*)\\} with adUnitId? (.*) and web_section id? (.*) with affiliateId? (.*) with po_line_item_id? (.*)", this::createNewZoneAndZoneset);
        And("i create new campaigns with existing zoneset", this::createMultipleCampaigns);
        And("i create new campaigns with zoneset by name", this::createMultipleCampaignsWithZoneName);
        And("i create new campaigns with new zoneset", this::createMultipleCampaignsWithNewZoneset);
        And("i create new priority campaigns with new zoneset", this::createMultipleCampaignsWithPriority);
        And("i create new campaigns with viewability", this::createCampaignsWithViewability);
        And("i create new campaigns with Supply type", this::createCampaignsWithSupplyType);
        Given("i create new campaigns, new zoneset with domains", this::createMultipleCampaignsWithNewZonesetWithDomains);
        And("i update? (.*) end date by id \\{(.*)\\}", this::updateEndDateEntityDataByID);
        And("i update? (.*) with id \\{(.*)\\} filed \\{(.*)\\} to be \\{(.*)\\}", this::updateEntityFiledByID);
        And("i update? (.*) data by? (.*)", this::updateEntityDataByID);
        And("i disable campaigns by name on db", this::removeAllCampaignsByName);
        And("i set campaigns capping on db", this::setCampaignCapping);
        And("i create new Deals", this::createMultipleDeals);
        And("i create new creatives", this::createMultipleCreatives);
        And("i create campaigns from Template", this::createMultipleCampaignsFromTemplate);
        And("save all entities to json file", this::saveEntities);
        Given("I disable all campaigns named \\{(.*)\\} in DB", this::disableAllCampaignsNamed);
        When("I create new Campaign named \\{(.*)\\} using ramp-app api's for LineItem (\\d+) associated to creative (\\d+) with zoneset (\\d+) with priority \\{(.*)\\}", this::createCampaign);
        And("I update the created campaign \\{(.*)\\} banners name to \\{(.*)\\} chained with the serial number", this::updateBannersName);
        And("I update the created (\\w+) named \\{(.*)\\} (\\w+) to be (\\w+) in the DB", this::updateDB);
        And("I update last created campaign named \\{(.*)\\} (\\w+) to be \\{(.*)\\} in the DB", this::updateLastCreatedCampaignDB);
        And("I refresh the zone Cache", () -> CacheProcessTest.refreshZoneCache("cmd"));
        And("i create new Campaign named \\{(.*)\\} for LineItem (\\d+) associated to creative (\\d+) with zoneset named \\{(.*)\\} with priority \\{(.*)\\}", this::createCampaignWithZonesetName);
        Given("^i create new campaigns with multiple creatives$", this::createCampaignsWithMultipleCreatives);
        Given("i update bid_price_type for publisher = (\\d+) for adunit = (\\d+) to be (\\d+)", this::setBidPriceTypeForPublisherAdunit);
        Given("i update floor_price for publisher = (\\d+) for adunit = (\\d+) to be (\\d+)", this::setFloorPriceForPublisherAdunit);
        Given("I run (select|update) SQL query? (.*)", this::runSqlQuery);
        Given("^I set (mobile|desktop) margin (\\d+)% for campaign? (.*)$", this::setMarginForCampaign);
        Given("^I set campaign (.*) for (\\d+) days$", this::updateCampaignEndDate);
    }

    private void setMarginForCampaign(String method, Integer margin, String campaignName) {
        String query = "UPDATE `undertone`.`campaigns` SET `hb_" + method + "_bid_price_percentage`= '" + margin + "' WHERE `campaignname` LIKE '%" + campaignName + "%'";
        System.out.println(query);
        SqlWorkflowUtils.WorkflowQuery(query);
    }

    private void setFloorPriceForPublisherAdunit(Integer publisherId, Integer adUnitId, Integer floor_price) {
        String query = "UPDATE `undertone`.`publisher_selected_adunits` SET `floor_price`= '" + floor_price + "' WHERE `pub_id`= '" + publisherId + "' and adunit_id = '" + adUnitId + "'";
        System.out.println(query);
        SqlWorkflowUtils.WorkflowQuery(query);
    }

    private void runSqlQuery(String method, String sqlQuery) {
        try {
            Statement stmt = sut.getWorkflowDbConnector().actual().createStatement();
            if (method.equalsIgnoreCase("select")) {
                ResultSet rs = stmt.executeQuery(sqlQuery);
                rs.next();
                sut.write(rs.getString(1));
                rs.close();
            }
            if (method.equalsIgnoreCase("update")) {
                stmt.executeUpdate(sqlQuery);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            fail(e.getMessage());
        }
    }

    private void updateEntityFiledByID(String entityName, String id, String field, String updated) {
        SqlWorkflowUtils.setColumnInWorkflow(entityName + 's', "id", id, field, updated);
    }


    private void createCampaignsWithMultipleCreatives(DataTable campaigns) {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<Integer> creativeAsInt = new ArrayList<>();
        List<String> campaign;
        List<Integer> zonesetsId;

        for (int i = 1; i < campaignsList.size(); i++) {
            Zonesets zonesets = new Zonesets();
            campaign = campaignsList.get(i);
            zonesetsId = getZonesetsIds(campaign);
            zonesets.setInclude(zonesetsId);
            List<String> creatives = Arrays.asList(campaign.get(4).split(","));
            for (String s : creatives) creativeAsInt.add(Integer.valueOf(s));
            CreateCampaignRequest createCampaignRequest = new CreateCampaignRequest(/*campaignName*/campaign.get(0), /*lineItemId*/campaign.get(2), zonesets, creativeAsInt, null, dateFromNow(-1), dateFromNow(1));
            createCampaign(createCampaignRequest,/*IO_id*/Integer.valueOf(campaign.get(1)),/*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
        }
    }


    private void saveEntities() {
        if (sut.getCampaignManager() == null)
            throw new AssertionError("io list and zonesets list are empty");
        sut.getCampaignManager().writeZoneSets(environmentName);
        sut.getCampaignManager().writeLineItem(environmentName);
    }


    private void createMultipleCampaignsWithPriority(DataTable campaigns) {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<String> campaign;
        List<Integer> zonesetsId;
        for (int i = 1; i < campaignsList.size(); i++) {
            campaign = campaignsList.get(i);
            zonesetsId = getZonesetsIds(campaign);
            Integer creativeOrDealID = Boolean.valueOf(campaign.get(3)) ? getDealId(campaign.get(4)) : getCreativeId(campaign.get(4));
            CreateCampaignRequest createCampaignRequest = getCreateCampaignRequestEntity(/*campaignName*/campaign.get(0), /*lineItemId*/campaign.get(2),/*creativeID_Or_DealID*/creativeOrDealID, zonesetsId, /*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
            createCampaignRequest.setPriority(campaign.get(11));
            createCampaign(createCampaignRequest,/*IO_id*/Integer.valueOf(campaign.get(1)),/*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
        }
    }

    private void createMultipleCampaignsWithZoneName(DataTable campaigns) {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<String> campaign;
        List<Integer> zonesetsId;
        for (int i = 1; i < campaignsList.size(); i++) {
            campaign = campaignsList.get(i);
            zonesetsId = getZonesetsIds(campaign);
            CreateCampaignRequest createCampaignRequest = getCreateCampaignRequestEntity(/*campaignName*/campaign.get(0), /*lineItemId*/campaign.get(2),/*creativeID_Or_DealID*/Integer.valueOf(campaign.get(4)), zonesetsId, /*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
            createCampaign(createCampaignRequest,/*IO_id*/Integer.valueOf(campaign.get(1)),/*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
        }
    }

    private void createMultipleCampaigns(DataTable campaigns) {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<String> campaign;
        List<Integer> zonesetsId;
        for (int i = 1; i < campaignsList.size(); i++) {
            campaign = campaignsList.get(i);
            zonesetsId = getZonesetsIds(campaign);
            CreateCampaignRequest createCampaignRequest = getCreateCampaignRequestEntity(/*campaignName*/campaign.get(0), /*lineItemId*/campaign.get(2),/*creativeID_Or_DealID*/Integer.valueOf(campaign.get(4)), zonesetsId, /*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
            createCampaign(createCampaignRequest,/*IO_id*/Integer.valueOf(campaign.get(1)),/*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
        }
    }

    private void createMultipleCampaignsWithNewZoneset(DataTable campaigns) {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<String> campaign;
        List<Integer> zonesetsId;
        for (int i = 1; i < campaignsList.size(); i++) {
            campaign = campaignsList.get(i);
            zonesetsId = getZonesetsIds(campaign);
            Integer creativeOrDealID = Boolean.valueOf(campaign.get(3)) ? getDealId(campaign.get(4)) : getCreativeId(campaign.get(4));
            CreateCampaignRequest createCampaignRequest = getCreateCampaignRequestEntity(/*campaignName*/campaign.get(0), /*lineItemId*/campaign.get(2),/*creativeID_Or_DealID*/creativeOrDealID, zonesetsId, /*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
            createCampaign(createCampaignRequest,/*IO_id*/Integer.valueOf(campaign.get(1)),/*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
        }
    }

    private Integer getDealId(String deal) {
        if (tryParseInt(deal)) {
            return Integer.parseInt(deal);
        } else {
            return sut.getCampaignManager().getDeal(deal).orElseThrow(() -> new AssertionError("deal: " + deal + " wasn't found!")).getDealId();
        }
    }

    private Integer getCreativeId(String creative) {
        if (tryParseInt(creative)) {
            return Integer.parseInt(creative);
        } else {
            return sut.getCampaignManager().getCreative(creative).orElseThrow(() -> new AssertionError("creative: " + creative + " wasn't found!")).getId();
        }
    }

    private boolean tryParseInt(String value) {
        try {
            Integer.parseInt(value);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private void createCampaignsWithViewability(DataTable campaigns) {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<String> campaign;
        List<Integer> zonesetsId;
        for (int i = 1; i < campaignsList.size(); i++) {
            campaign = campaignsList.get(i);
            zonesetsId = getZonesetsIds(campaign);
            CreateCampaignRequest createCampaignRequest = getCreateCampaignRequestEntity(/*campaignName*/campaign.get(0), /*lineItemId*/campaign.get(2),/*creativeID_Or_DealID*/Integer.valueOf(campaign.get(4)), zonesetsId, /*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
            createCampaignRequest.setViewability(campaign.get(11), campaign.get(12), true);
            createCampaign(createCampaignRequest,/*IO_id*/Integer.valueOf(campaign.get(1)),/*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
        }
    }

    private void createCampaignsWithSupplyType(DataTable campaigns) {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<String> campaign;
        List<Integer> zonesetsId;
        for (int i = 1; i < campaignsList.size(); i++) {
            campaign = campaignsList.get(i);
            zonesetsId = getZonesetsIds(campaign);
            CreateCampaignRequest createCampaignRequest = getCreateCampaignRequestEntity(/*campaignName*/campaign.get(0), /*lineItemId*/campaign.get(2),/*creativeID_Or_DealID*/Integer.valueOf(campaign.get(4)), zonesetsId, /*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
            createCampaignRequest.settrafficType(getTypeCode(campaign.get(11)));
            createCampaign(createCampaignRequest,/*IO_id*/Integer.valueOf(campaign.get(1)),/*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
        }

    }

    private Integer getTypeCode(String type) {
        Integer typecode = 0;
        switch (type.toLowerCase()) {
            case "all":
                typecode = 1;
                break;
            case "hb":
                typecode = 2;
                break;
            case "direct":
                typecode = 3;
                break;
            default:
                throw new AssertionError("no type: " + type + " defined");
        }
        return typecode;
    }

    private void createMultipleCampaignsWithNewZonesetWithDomains(DataTable campaigns) {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<String> campaign;
        List<Integer> zonesetsId;
        for (int i = 1; i < campaignsList.size(); i++) {
            campaign = campaignsList.get(i);
            zonesetsId = getZonesetsIds(campaign);
            CreateCampaignRequest createCampaignRequest = getCreateCampaignRequestEntity(/*campaignName*/campaign.get(0), /*lineItemId*/campaign.get(2),/*creativeID_Or_DealID*/Integer.valueOf(campaign.get(4)), zonesetsId, /*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
            createCampaignRequest.setSupplySources(getSupplySources(campaign.get(11), campaign.get(12)));
            createCampaign(createCampaignRequest,/*IO_id*/Integer.valueOf(campaign.get(1)),/*isServerProgrammatic*/Boolean.valueOf(campaign.get(3)));
        }
    }


    //creating zones and zoneset if needed (if not exist)
    private List<Integer> getZonesetsIds(List<String> campaignDataTable) {
        String zonesetsNameAsString = campaignDataTable.get(5);
        List<String> zonesetNamesAsList;
        List<Integer> zonesetsIdsList = new ArrayList<>();
        Integer zonesetId;

        if (zonesetsNameAsString.length() < 3)
            throw new AssertionError("zonesetList is invalid,should be larger then 2");

        zonesetNamesAsList = Arrays.asList(zonesetsNameAsString.substring(1, zonesetsNameAsString.length() - 1).split(","));
        for (String zonset : zonesetNamesAsList) {
            zonset = zonset.trim();
            try {
                zonesetId = Integer.parseInt(zonset); /*check if it number -> then its an id*/
            } catch (NumberFormatException e) //not a number -> then a name
            {
                if (!(sut.getCampaignManager().getZoneset(zonset)).isPresent())
                    createNewZoneAndZoneset(/*zoneAndZonesetName*/zonset,/*limitation*/campaignDataTable.get(6), /*adUnitId*/campaignDataTable.get(7),/*web_section_id*/campaignDataTable.get(8),/*affiliateId*/campaignDataTable.get(9),/*po_lineItem_id*/campaignDataTable.get(10));
                zonesetId = sut.getCampaignManager().getZoneset(zonset).orElseThrow(() -> new AssertionError("zoneset were not found!")).getId();
            }
            zonesetsIdsList.add(zonesetId);
        }
        return zonesetsIdsList;
    }

    private SupplySources getSupplySources(String include, String exclude) {
        List<SupplySource> includeList = null, excludeList = null;
        if ((isParenthesisMatch(include)) && (isParenthesisMatch(exclude))) {
            includeList = parseSupplyList(include);
            excludeList = parseSupplyList(exclude);
        }
        return new SupplySources(includeList, excludeList);
    }

    private List<SupplySource> parseSupplyList(String supply) {
        if (supply.length() <= 2)
            return null;

        List<SupplySource> supplySources = new ArrayList<>();
        List<String> objects = Arrays.asList((supply.substring(1, supply.length() - 1)).split(";"));//{app1,2};{domain,1}

        for (String object : objects) {
            //data[0] = app1, data[1] = 2
            List<String> data = Arrays.asList((object.substring(1, object.length() - 1)).split(","));
            assert data.size() == 2;
            supplySources.add(new SupplySource(data.get(0), Integer.parseInt(data.get(1))));
        }
        return supplySources;
    }

    private void createMultipleDeals(DataTable deals) {
        List<List<String>> dealList = deals.asLists(String.class);
        List<String> deal;
        for (int i = 1; i < dealList.size(); i++) {
            deal = dealList.get(i);
            createDeal(deal.get(0), Integer.valueOf(deal.get(1)), Integer.valueOf(deal.get(2)), Integer.valueOf(deal.get(3)), Integer.valueOf(deal.get(4)), Integer.valueOf(deal.get(5)));
        }
    }

    private void createMultipleCreatives(DataTable creatives) {
        List<List<String>> creativeList = creatives.asLists(String.class);
        List<String> creative;
        for (int i = 1; i < creativeList.size(); i++) {
            creative = creativeList.get(i);
            createCreative(creative.get(0), Integer.valueOf(creative.get(1)), Integer.valueOf(creative.get(2)), creative.get(3));
        }
    }

    private void createMultipleCampaignsFromTemplate(DataTable campaigns) {
        List<List<String>> campaignsList = campaigns.asLists(String.class);
        List<String> campaign;
        JsonNode campaignsTemplates = getCampaignsTemplates().orElseThrow(() -> new AssertionError("can't parse campaigns templates"));
        JsonNode campaignNode;

        for (int i = 1; i < campaignsList.size(); i++) {
            campaign = campaignsList.get(i);
            campaignNode = campaignsTemplates.get(campaign.get(1)).get(campaign.get(2));
            createNewZoneAndZoneset(/*zoneAndZonesetName*/campaign.get(3),/*limitation*/"[]", /*adUnitId*/campaignNode.get("adUnit").toString(),/*web_section_id*/campaignNode.get("web_section_id").toString(),/*affiliateId*/campaignNode.get("publisher").toString(),/*po_lineItem_id*/campaignNode.get("po_line_item").toString());
            if (campaign.get(1).contains("server programmatic"))
                createCampaignWithZonesetName(campaign.get(0), campaignNode.get("io").intValue(), campaignNode.get("io_lineItem").intValue(), true, campaignNode.get("dealID").intValue(), campaign.get(3));
            else {
                createCampaignWithZonesetName(campaign.get(0), campaignNode.get("io").intValue(), campaignNode.get("io_lineItem").intValue(), false, campaignNode.get("creative").intValue(), campaign.get(3));
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

    private void createCreative(String creativeName, Integer IO, Integer adUnitID, String htmlTemplateType) {
        JsonNode creativesTemplates;
        try {
            creativesTemplates = mapper.readTree(this.getClass().getResourceAsStream(CREATIVES_SOURCE_FILE_PATH));
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
        Creative creative = sut.getRampAppRequestModule().createCreative(creativeName, IO, adUnitID, creativesTemplates.get(htmlTemplateType).toString());
        sut.getCampaignManager().getIO(IO).orElseThrow(() -> new AssertionError("IO: " + IO + "doesn't exist")).creatives.add(creative);
    }

    private void createDeal(String dealName, Integer dspID, Integer floorPrice, Integer dealType, Integer adUnitId, Integer IO) {
        List<Integer> adUnitsIds = new ArrayList<Integer>() {{
            add(adUnitId);
        }};
        DealRequest dealRequest = new DealRequest(new Deal(0, dealName, dspID, floorPrice, dealType, adUnitsIds));
        Deal deal = sut.getRampAppRequestModule().createDeal(dealRequest, IO);
        sut.getCampaignManager().getIO(IO).orElseThrow(() -> new AssertionError("IO: " + IO + "doesn't exist")).deals.add(deal);
    }

    private void createNewZoneAndZoneset(String zoneAndZonesetName, String limitation, String adUnitId, String web_section_id, String affiliateId, String po_lineItem_id) {
        Optional<Zone> createdZone = sut.getRampAppRequestModule().createZone(zoneAndZonesetName, adUnitId, limitation, web_section_id, affiliateId);
        if (!createdZone.isPresent()) {
            throw new AssertionError("zone wasn't created!");
        } else {
            Optional<ZoneSet> createdZoneset = sut.getRampAppRequestModule().createZoneset(zoneAndZonesetName, new TreeSet<Zone>() {{
                add(createdZone.get());
            }}, "1", "1");
            if (!createdZoneset.isPresent()) {
                throw new AssertionError("zoneset wasn't created!");
            } else {
                createdZoneset.get().addZone(createdZone.get());
                addCreatedZonesetToCampaignManager(createdZoneset.get());
                update_po_line_item_zones_InDB(createdZone.get().getId(), po_lineItem_id);
                printZonesetAndZone(createdZoneset.get(), createdZone.get());
            }
        }
    }

    private void printZonesetAndZone(ZoneSet zoneSet, Zone zone) {
        sut.write("zoneset created successfully! zoneset id is:" + zoneSet.getId());
        sut.write("zone created successfully! zone id is:" + zone.getId());
    }


    private void updateEndDateEntityDataByID(String entity, String idsStr) {
        String[] idsArr = idsStr.split(",");
        for (int i = 0; i < idsArr.length; i++) {
            SqlWorkflowUtils.setColumnInWorkflow(entity + 's', "id", idsArr[i], "end_date", endDateVal);
            SqlWorkflowUtils.setColumnInWorkflow(entity + 's', "id", idsArr[i], "start_date", startDateVal);

        }

    }


    private void updateCampaignEndDate(String campaign_name, Integer days) {

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date(System.currentTimeMillis());
        String currentDate = formatter.format(date);
        Calendar cal = new GregorianCalendar(/* remember about timezone! */);
        cal.setTime(date);
        cal.add(Calendar.DATE, days);
        String endDate = formatter.format(cal.getTime());

        SqlWorkflowUtils.WorkflowQuery("UPDATE `undertone`.`campaigns` SET `expire` = '" + endDate + "', `activate` = '"+ currentDate +"' WHERE `campaignname` like '%" + campaign_name +"%' and `status` = 0;");
    }


    private void updateEntityDataByID(String entity, String updateBy, DataTable entities) {
        List<List<String>> EntityList = entities.asLists(String.class);
        List<String> entityData;
        Integer entityID;
        for (int i = 1; i < EntityList.size(); i++) {
            entityData = EntityList.get(i);
            entityID = updateBy.equals("name") ? sut.getCampaignManager()
                    .getterFor(entity).apply(entityData.get(0)).orElseThrow(() -> new AssertionError("entity wasn't found")).getId() : Integer.valueOf(entityData.get(0));
            for (int j = 1; j < entityData.size(); j++) {
//                try {
//                    if (SqlWorkflowUtils.getEntityByName(entity + "s", entity + "id", entityData.get(0)).next()) {
                SqlWorkflowUtils.setColumnInWorkflow(entity + "s", entity + "id", entityID.toString(), EntityList.get(0).get(j), entityData.get(j));
//                    }
//                } catch (SQLException e) {
//                    Assert.fail(e.getMessage());
//                }

            }
        }
    }

    private void removeAllCampaignsByName(DataTable entities) {
        List<List<String>> EntityList = entities.asLists(String.class);
        List<String> entityData;


        for (int i = 1; i < EntityList.size(); i++) {
            entityData = EntityList.get(i);
            try {
                if (SqlWorkflowUtils.getEntityByName("campaigns", "campaignname", entityData.get(0)).next()) {
                    SqlWorkflowUtils.setColumnInWorkflow("campaigns", "campaignname", entityData.get(0), "status", "1");
                }else{
                    sut.write("Unable to fetch campaign " + entityData.get(0)+ " data!");
                    break;
                }
            } catch (SQLException e) {
                Assert.fail(e.getMessage());
            }


        }
    }

    private void setCampaignCapping(DataTable entities) {
        List<List<String>> EntityList = entities.asLists(String.class);
        List<String> entityData;

        for (int i = 1; i < EntityList.size(); i++) {
            entityData = EntityList.get(i);
            SqlWorkflowUtils.setColumnInWorkflow("campaigns", "campaignname", entityData.get(0), "capping", entityData.get(1));
        }
    }

    private void update_po_line_item_zones_InDB(Integer zoneId, String po_line_item_ID) {
        SqlWorkflowUtils.WorkflowQuery("INSERT INTO `undertone`.`po_line_items_zones` (`po_line_item_id`, `zone_id`, `created_by`, `updated_by`) VALUES ('" + po_line_item_ID + "', '" + zoneId + "', '974', '974');");
    }

    private void addCreatedZonesetToCampaignManager(ZoneSet zoneSet) {
        sut.getCampaignManager().getZonesets().add(zoneSet);
    }

    private void createCampaign(CreateCampaignRequest campaignsRequest, Integer IO_id, Boolean isServerProgrammatic) { /*String campaignName, Integer IO_id, Integer lineItemId, Boolean isServerProgrammatic, Integer creativeID_Or_DealID, Integer zonesetID) {*/
        Optional<Campaign> createdCampaign = sut.getRampAppRequestModule().createCampaign(campaignsRequest, isServerProgrammatic);

        if (!createdCampaign.isPresent()) {
            throw new AssertionError("Error: campaign wasn't created!");
        } else {
            insertCampaignToIOMap(createdCampaign.get(), IO_id, Integer.valueOf(campaignsRequest.getLineItemId()));
            updateBannersName(createdCampaign.get().getName(), createdCampaign.get().getName() + "-banner-");
            printCampaign(createdCampaign.get());
            updateCampaign(createdCampaign.get().getId(), "status", "0");
            updateCampaign(createdCampaign.get().getId(), "run_on_unknown_domains", "1");
        }
    }

    private CreateCampaignRequest getCreateCampaignRequestEntity(String campaignName, String lineItemId, Integer creativeID_Or_DealID, List<Integer> zonesetsIDs, Boolean isServerProgrammatic) {
        List<Integer> creatives = new ArrayList<>();
        Integer dealID = null;
        Zonesets zonesets = new Zonesets();
        zonesets.setInclude(zonesetsIDs);
        if (isServerProgrammatic)
            dealID = creativeID_Or_DealID;
        else
            creatives.add(creativeID_Or_DealID);

        return new CreateCampaignRequest(campaignName, lineItemId,
                zonesets, creatives, dealID,
                dateFromNow(-1), dateFromNow(1));
    }

    private String dateFromNow(Integer daysToAdd) {
        final Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, daysToAdd);
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        return dateFormat.format(cal.getTime());
    }

    private void printCampaign(Campaign campaign) {
        sut.write("Campaign id: " + campaign.getId());
        sut.write("Campaign name: " + campaign.getName());
        sut.write("the banners of campaign named: " + campaign.getName() + " are: ");
        for (Banner banner : campaign.getBanners()) {
            sut.write("Banner id:" + banner.getId());
            sut.write("Banner name:" + banner.getName());
        }
    }

    private void setBidPriceTypeForPublisherAdunit(Integer publisherId, Integer adUnitId, Integer bid_price_type) {
        String query = "UPDATE `undertone`.`publisher_selected_adunits` SET `bid_price_type`= '" + bid_price_type + "' WHERE `pub_id`= '" + publisherId + "' and adunit_id = '" + adUnitId + "'";
        System.out.println(query);
        SqlWorkflowUtils.WorkflowQuery(query);
    }

    private void createCampaignWithZonesetName(String campaignName, Integer IO_id, Integer lineItemId, Boolean isServerProgrammatic, Integer creativeID_Or_DealID, String zonesetName) {
        ZoneSet zoneset = sut.getCampaignManager().getZoneset(zonesetName).orElseThrow(() -> new AssertionError("zoneset doesn't exist!"));

        //createCampaign(campaignName,IO_id ,lineItemId,isServerProgrammatic,creativeID_Or_DealID,zoneset.getId());
    }

    private void insertCampaignToIOMap(Campaign campaign, Integer IO_id, Integer lineItemID) {
        if (sut.getCampaignManager().getCampaign(campaign.getName()).isPresent())
            throw new AssertionError("campaign name should be with unique name");

        sut.getCampaignManager().insertCampaignToIOMap(campaign, lineItemID, IO_id);
    }


    private void updateCampaign(Integer id, String columnToChange, String value) {
        SqlWorkflowUtils.setColumnInWorkflow("campaigns", "campaignid", String.valueOf(id), columnToChange, value);
    }

    private void updateLastCreatedCampaignDB(String campaignName, String columnToChange, String value) //remove!-------------------------------
    {
        // assertThat(campaignName, is(lastCreatedCampaign.getName()));
        // SqlWorkflowUtils.setColumnInWorkflow("campaigns", "campaignid",String.valueOf(lastCreatedCampaign.getId()), columnToChange, value);
    }

    private void updateDB(String entityType, String entityName, String columnToChange, String value) {
        assertThat(entityType, isOneOf("campaign", "banner"));
        Optional<? extends WithId<Integer>> expectedEntity = sut.getCampaignManager().getterFor(entityType)
                .apply(entityName);

        assertThat("Could not find " + entityType + " named " + entityName, expectedEntity,
                is(not(OptionalMatchers.empty())));
        SqlWorkflowUtils.setColumnInWorkflow(entityType + 's', entityType + "id", String.valueOf(expectedEntity.get().getId()), columnToChange, value);
    }

    private void disableAllCampaignsNamed(String CampaignName) {
        SqlWorkflowUtils.setColumnInWorkflow("campaigns", "campaignname", CampaignName, "status", "1");
    }

    private void updateBannersName(String campaignName, String bannerName) {
        Campaign campaign = sut.getCampaignManager().getCampaign(campaignName).orElseThrow(() -> new AssertionError("The Campaign " + campaignName + " does not exist!"));
        int index = 1;
        for (Banner banner : campaign.getBanners()) {
            banner.setName(bannerName + index);
            index++;
        }
    }

    private void printBannersOfCampaign(Integer campaignID) {
        CloseableHttpResponse getCampaignResponse = sut.getRampAppRequestModule().getCampaignRequest(campaignID);
        Campaign[] tmpCampaign;
        try {
            tmpCampaign = mapper.readValue(EntityUtils.toString(getCampaignResponse.getEntity()), Campaign[].class);
            sut.write("the banners of campaign named: " + tmpCampaign[0].getName() + " are: ");
            for (Banner banner : tmpCampaign[0].getBanners()) {
                sut.write("created banner id is: " + banner.getId());
            }
        } catch (IOException IOE) {
            IOE.printStackTrace();
        } catch (NullPointerException e) {
            e.printStackTrace();
            throw e;
        }
    }

    private static boolean isParenthesisMatch(String str) {
        if (str.charAt(0) == '{')
            return false;

        Stack<Character> stack = new Stack<Character>();

        char c;
        for (int i = 0; i < str.length(); i++) {
            c = str.charAt(i);

            if (c == '(')
                stack.push(c);
            else if (c == '{')
                stack.push(c);
            else if (c == ')')
                if (stack.empty())
                    return false;
                else if (stack.peek() == '(')
                    stack.pop();
                else
                    return false;
            else if (c == '}')
                if (stack.empty())
                    return false;
                else if (stack.peek() == '{')
                    stack.pop();
                else
                    return false;
        }
        return stack.empty();
    }


}
