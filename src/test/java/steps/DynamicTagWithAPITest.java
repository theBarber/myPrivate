package steps;

import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import entities.RampAppCreateEntitiesManager;
import entities.Zone;
import entities.ZoneSet;
import entities.ramp.app.api.CampaignsRequest;
import entities.ramp.app.api.Zonesets;
import infra.utils.SqlWorkflowUtils;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.util.EntityUtils;
import org.junit.runner.RunWith;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.util.*;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:DynamicTagWithAPI.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/DynamicTag_WithAPI$TIMESTAMP$.json"})
public class DynamicTagWithAPITest extends BaseTest{
    private ObjectMapper mapper = new ObjectMapper();
    private RampAppCreateEntitiesManager RampAppCreateEntitiesManager;
    public DynamicTagWithAPITest()
    {
        super();
        Before(DYNAMICTAG, (scenario) -> {
            RampAppCreateEntitiesManager = sut.getRampAppCreateEntitiesManager();
        });

        Given("i remove all zones related to web_section id (\\d+)",this::removeAllZonesFrom);
        Then("i create new zone named \\{([^}]+)\\} with limitation \\{([^}]+)\\} with adUnitId (\\w+) and web_section id (\\d+) with affiliateId (\\d+) with po_line_item_id (\\d+)",this::createNewZone);
        Then("i update daily capping for publisher id (\\d+) with product id (\\d+) to be (\\d+)",this::updateProductDailyCappingForPublisher);
        Then("i send (\\d+) times Dynamic Tag ad request to UAS for publisher (\\w+) with domain \\{([^}]+)\\}",this::sendDynamicTagRequestsToUAS);
    }

    private void removeAllZonesFrom(Integer web_sectionID)
    {
        SqlWorkflowUtils.setColumnInWorkflow("zones", "web_section_id",String.valueOf(web_sectionID), "status", "1");
    }

    private void createNewZone(String zoneAndZonesetName, String limitation,String adUnitId, String web_section_id, String affiliateId, String po_lineItem_id)
    {
        Zone createdZone = RampAppCreateEntitiesManager.createZone(zoneAndZonesetName, adUnitId, limitation, web_section_id, affiliateId);
        ZoneSet createdZoneset = RampAppCreateEntitiesManager.createZoneset(zoneAndZonesetName,new TreeSet<Zone>(){{add(createdZone);}},"1","1");
        createdZoneset.addZone(createdZone); //need to be inside line 47
        addCreatedZonesetToCampaignManager(createdZoneset);
        update_po_line_item_zones_InDB(createdZone.getId(), po_lineItem_id); // ------------need to be from api!!!!!!!--------------
    }

    private void update_po_line_item_zones_InDB(Integer zoneId, String po_line_item_ID)
    {
        SqlWorkflowUtils.WorkflowQuery("INSERT INTO `adserver`.`po_line_items_zones` (`po_line_item_id`, `zone_id`, `created_by`, `updated_by`) VALUES ('"+po_line_item_ID+"', '"+zoneId+"', '974', '974');");
    }

    private void addCreatedZonesetToCampaignManager(ZoneSet zoneSet)
    {
        sut.getCampaignManager().getZonesets().add(zoneSet);
    }

    private void updateProductDailyCappingForPublisher(Integer publisherId,Integer productID, Integer value)
    {
        SqlWorkflowUtils.WorkflowQuery("UPDATE adserver.publishers_products SET daily_cap_per_user="+value+" WHERE publisher_id = "+publisherId+" and product_id ="+productID);
    }

    private void sendDynamicTagRequestsToUAS(Integer times, String publisherId, String domain)
    {
        sut.getUASRquestModule().sendMultipleDynamicTagRequests(times,publisherId, domain,true);

    }
}
