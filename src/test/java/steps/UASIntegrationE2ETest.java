package steps;

import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

import entities.Campaign;
import entities.RampAppRequestModule;

import org.junit.runner.RunWith;

@CucumberOptions(features = "classpath:UASIntegrationE2E.feature", plugin = { "pretty",})
//        "infra.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)
public class UASIntegrationE2ETest extends BaseTest {
    private RampAppRequestModule rampAppCreateEntitiesManager;
    private ObjectMapper mapper = new ObjectMapper();
    private Campaign lastCreatedCampaign;

    public UASIntegrationE2ETest()
    {
        super();
    }


}
