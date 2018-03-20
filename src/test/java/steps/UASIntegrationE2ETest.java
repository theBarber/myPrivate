package steps;

import co.unruly.matchers.OptionalMatchers;
import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import entities.*;
import entities.ramp.app.api.CampaignsRequest;
import infra.module.WithId;
import infra.utils.SqlWorkflowUtils;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.util.EntityUtils;
import org.junit.runner.RunWith;

import java.io.IOException;
import java.util.Optional;

import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.isOneOf;
import static org.hamcrest.Matchers.not;
import static org.junit.Assert.assertThat;

@CucumberOptions(features = "classpath:UASIntegrationE2E.feature", plugin = { "pretty",
        "infra.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)
public class UASIntegrationE2ETest extends BaseTest {
    private RampAppCreateEntitiesManager rampAppCreateEntitiesManager;
    private ObjectMapper mapper = new ObjectMapper();
    private Campaign lastCreatedCampaign;

    public UASIntegrationE2ETest()
    {
        super();
    }


}
