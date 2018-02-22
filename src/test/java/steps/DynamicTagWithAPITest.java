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
    public DynamicTagWithAPITest()
    {
        super();
    }


}
