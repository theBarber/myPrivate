package steps;

import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

import entities.Campaign;
import entities.RampAppRequestModule;

import org.junit.runner.RunWith;

@CucumberOptions(features = {
        "classpath:UASIntegrationE2E.feature",
        "classpath:BrandRevealMultipleSizes.feature"
}, plugin = {"pretty",})
@RunWith(Cucumber.class)
public class UASIntegrationE2ETest extends BaseTest {
    private RampAppRequestModule rampAppCreateEntitiesManager;
    private ObjectMapper mapper = new ObjectMapper();
    private Campaign lastCreatedCampaign;

    public UASIntegrationE2ETest() {
        super();
    }


}
