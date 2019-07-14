package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;


@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:VidAd.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/VidAd_$TIMESTAMP$.json"})
public class VidAdTest extends BaseTest {
    public VidAdTest(){
        super();
    }
    public Integer getEntityId(String entity, String name)
    {
        String myEntity;
        switch (entity.toLowerCase()) {
            case "adid":
                myEntity = "banner";break;
            case "campaignid":
                myEntity = "campaign";break;
            case "zoneid":
                myEntity = "zone";break;
            default:
                myEntity = null;
        }
        return sut.getExecutorCampaignManager().getterFor(myEntity).apply(name).orElseThrow(() -> new AssertionError(name+" wasn't found")).getId();
    }
}

