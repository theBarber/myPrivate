package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.DataTable;
import cucumber.api.junit.Cucumber;
import infra.utils.SqlWorkflowUtils;
import org.junit.runner.RunWith;

import java.nio.charset.Charset;
import java.util.List;

import java.util.Random;
import java.util.UUID;


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
        Then("i send (\\d+) times Dynamic Tag synchronized ad request to UAS for publisher (\\w+) with url_enc \\{([^}]+)\\}",this::sendDynamicTagSynchronizedRequestsWithFullUrlToUAS);
        Then("i send (\\d+) times Dynamic Tag ad request to UAS for publisher (\\w+) with domain \\{([^}]+)\\}",this::sendDynamicTagRequestsToUAS);
        Then("i send (\\d+) times Dynamic Tag ad request to UAS for publisher (\\w+) with extra params \\{([^}]+)\\}",this::sendDynamicTagRequestsToUAS);
        Then("i send (\\d+) times Dynamic Tag synchronized ad request with tag id (\\w+) to UAS for publisher (\\w+) with domain \\{([^}]+)\\}",this::sendDynamicTagWithTagSynchronizedRequestsToUAS);
        Given("i remove all zones related to web_section id (\\d+)",this::removeAllZonesFrom);
        Given("only tags \\{([^}]+)\\} are enabled and the rest are disabled for publisher (\\d+)",this::removeTagsFromPublisher);
        And("i remove all zones from publishers: \\{([^}]+)\\}, apart from zones:\\{([^}]+)\\}",this::removeAllZonesForPublisherApartFrom);
        And("i remove all zones from publishers: \\{([^}]+)\\}",this::removeAllZonesForPublisher);
        Given("I add cookie (\\w+) with random value to my requests to uas", (String paramName) -> {
            Integer randomCookie = new Random().nextInt()& Integer.MAX_VALUE;;
            System.out.println ("the cookie added "+randomCookie);
            sut.getUASRquestModule().addCookie(paramName, String.valueOf(randomCookie ));
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
        SqlWorkflowUtils.WorkflowQuery("UPDATE undertone.publishers_products SET daily_cap_per_user="+value+" WHERE publisher_id = "+publisherId+" and product_id ="+productID);
    }

    public void sendDynamicTagSynchronizedRequestsToUAS(Integer times, String publisherId, String domain)
    {
        sut.getUASRquestModule().sendMultipleDynamicTagGetRequests(times,null,publisherId, domain,null,false,false);
    }

    public void sendDynamicTagSynchronizedRequestsWithFullUrlToUAS(Integer times, String publisherId, String url_enc){
        sut.getUASRquestModule().sendMultipleDynamicTagGetRequests(times,null,publisherId, url_enc,null,false,false);
    }

    public void sendDynamicTagRequestsToUAS(Integer times, String publisherId, String domain)
    {
        sut.getUASRquestModule().sendMultipleDynamicTagGetRequests(times,null,publisherId, domain,null,true,false);
    }

    public void sendDynamicTagRequestsToUASWithParams(Integer times, String publisherId, String extraParams)
    {
        sut.getUASRquestModule().sendMultipleDynamicTagGetRequests(times,null,publisherId, null,extraParams,true,false);
    }

    public void sendDynamicTagWithTagSynchronizedRequestsToUAS(Integer times,String tagID, String publisherId, String domain)
    {
        sut.getUASRquestModule().sendMultipleDynamicTagGetRequests(times,tagID,publisherId, domain,null,false,false);
    }

    public void removeAllZonesForPublisherApartFrom(String publishersID, String remainingZones)
    {
        SqlWorkflowUtils.WorkflowQuery("UPDATE `undertone`.`zones` as z_n SET `status`='1' WHERE z_n.zoneid in\n" +
                "(select zoneid from (SELECT * FROM zones) as z join web_sections w_s on z.web_section_id = w_s.id \n" +
                "\tjoin publishers_web_properties p_w_p on w_s.web_property_id = p_w_p.web_property_id \n" +
                "\twhere p_w_p.publisher_id in ("+publishersID+") and z.status = 0 and z.zoneid not in ("+remainingZones+"));");

        SqlWorkflowUtils.WorkflowQuery("UPDATE `undertone`.`zones` SET `status`='0' WHERE `zoneid` in ("+remainingZones+");");
    }

    public void removeAllZonesForPublisher(String publishersID)
    {
        SqlWorkflowUtils.WorkflowQuery("UPDATE `undertone`.`zones` as z_n SET `status`='1' WHERE z_n.zoneid in\n" +
                "(select zoneid from (SELECT * FROM zones) as z join web_sections w_s on z.web_section_id = w_s.id \n" +
                "\tjoin publishers_web_properties p_w_p on w_s.web_property_id = p_w_p.web_property_id \n" +
                "\twhere p_w_p.publisher_id in ("+publishersID+") and z.status = 0);");
    }

    private void removeAllZonesFrom(Integer web_sectionID)
    {
        SqlWorkflowUtils.setColumnInWorkflow("zones", "web_section_id",String.valueOf(web_sectionID), "status", "1");
    }

    public void removeTagsFromPublisher(String tags, String publisherID)
    {
        SqlWorkflowUtils.WorkflowQuery("UPDATE `undertone`.`tags` SET `status`='1' WHERE `publisher_id` = "+publisherID+" and `tagid` not in ("+tags+") ;");
    }
}
