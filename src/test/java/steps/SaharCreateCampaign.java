//package steps;
//
//import com.fasterxml.jackson.databind.ObjectMapper;
//import cucumber.api.CucumberOptions;
//import cucumber.api.junit.Cucumber;
//import entities.Campaign;
//import entities.LineItem;
//import entities.ramp.app.api.CreateCampaignRequest;
//import entities.ramp.app.api.CreateCampaignsRequestWrapper;
//import org.junit.runner.RunWith;
//import java.util.Optional;
//
//@RunWith(Cucumber.class)
//@CucumberOptions(features = "classpath:SaharCreateCampaignCheck.feature", plugin = {"pretty",
//        "infra.RotatingJSONFormatter:target/cucumber/uas-adselector-Sahar_$TIMESTAMP$.json"})
//public class SaharCreateCampaign extends BaseTest{
//
//    public SaharCreateCampaign()
//    {
//        super();
//        When("I create new Campaign named \\{([^}]+)\\} for LineItem (\\d+)", (String campaignName, Integer lineItemId) -> {
//            createCampaign(campaignName,lineItemId);
//        });
//
//        Then("new campaign created successfully for LineItem (\\d+)", (Integer s) -> {
//
//        });
//    }
//
//    private void createCampaign(String campaignName, Integer lineItemId) {
//
//        ObjectMapper m = new ObjectMapper();
//        LineItem lineItem = new LineItem();
//        lineItem.setIoLineItemId(210722);
//        lineItem.setStartDate("2016-07-27 16:50:35");
//        lineItem.setEndDate("2016-07-27 16:50:35");
//        CreateCampaignRequest createCampaignRequestBody = new CreateCampaignRequest(lineItem);
//        CreateCampaignsRequestWrapper requestWrapper = new CreateCampaignsRequestWrapper(createCampaignRequestBody);
//        try{
//            String check = m.writeValueAsString(requestWrapper);
//            System.out.println(check);
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//
//    }
//
//
//}
