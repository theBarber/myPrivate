package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.DataTable;
import cucumber.api.junit.Cucumber;
import infra.utils.SqlWorkflowUtils;
import org.junit.runner.RunWith;

import java.util.List;
import java.util.Map;
import java.util.Random;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:DynamicTag.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/DynamicTag_$TIMESTAMP$.json"})
public class DynamicTagTest extends BaseTest{
    public DynamicTagTest()
    {
        super();
        Then("i update daily capping for publisher id (\\d+) with product id (\\d+) to be (\\d+)",this::updateProductDailyCappingForPublisher);
        Given("I update daily capping for publishers:",this::setupPublishers);
        Then("i send (\\d+) times Dynamic Tag synchronized ad request to UAS for publisher (\\w+) with domain \\{([^}]+)\\}",this::sendDynamicTagSynchronizedRequestsToUAS);
        Then("i send (\\d+) times Dynamic Tag ad request to UAS for publisher (\\w+) with domain \\{([^}]+)\\}",this::sendDynamicTagRequestsToUAS);
        Given("i remove all zones related to web_section id (\\d+)",this::removeAllZonesFrom);
        And("i remove all zones from publishers: \\{([^}]+)\\}, apart from zones:\\{([^}]+)\\}",this::removeAllZonesForPublisherApartFrom);
        Given("I add cookie (\\w+) with random value to my requests to uas", (String paramName) -> {
            sut.getUASRquestModule().addCookie(paramName, String.valueOf(new Random().nextInt()));
        });
    }

    public void setupPublishers(DataTable publishersDailyCapping)
    {
       List<List<String>> publishersDailyCappingAsList = publishersDailyCapping.asLists(String.class);
       for(List<String> row : publishersDailyCappingAsList)
       {
           updateProductDailyCappingForPublisher(row.get(0),row.get(1),row.get(2));
       }
    }

    public void updateProductDailyCappingForPublisher(String publisherId,String productID, String value)
    {
        SqlWorkflowUtils.WorkflowQuery("UPDATE adserver.publishers_products SET daily_cap_per_user="+value+" WHERE publisher_id = "+publisherId+" and product_id ="+productID);
    }

    public void sendDynamicTagSynchronizedRequestsToUAS(Integer times, String publisherId, String domain)
    {
        sut.getUASRquestModule().sendMultipleDynamicTagSynchronizedRequests(times,publisherId, domain,true);
    }

    public void sendDynamicTagRequestsToUAS(Integer times, String publisherId, String domain)
    {
        sut.getUASRquestModule().sendMultipleDynamicTagRequests(times,publisherId, domain,true);
    }

    public void removeAllZonesForPublisherApartFrom(String publishersID, String remainingZones)
    {
        SqlWorkflowUtils.WorkflowQuery("UPDATE `adserver`.`zones` as z_n SET `status`='1' WHERE z_n.zoneid in\n" +
                "(select zoneid from (SELECT * FROM zones) as z join web_sections w_s on z.web_section_id = w_s.id \n" +
                "\tjoin publishers_web_properties p_w_p on w_s.web_property_id = p_w_p.web_property_id \n" +
                "\twhere p_w_p.publisher_id in ("+publishersID+") and z.status = 0 and z.zoneid not in ("+remainingZones+"));");
    }

    private void removeAllZonesFrom(Integer web_sectionID)
    {
        SqlWorkflowUtils.setColumnInWorkflow("zones", "web_section_id",String.valueOf(web_sectionID), "status", "1");
    }
}
