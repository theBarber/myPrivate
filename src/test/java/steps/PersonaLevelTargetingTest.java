package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.RerunningCucumber;
import org.junit.runner.RunWith;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.PendingException;
import cucumber.api.junit.Cucumber;
import org.apache.http.HttpResponse;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.AssumptionViolatedException;
import org.junit.runner.RunWith;
import ramp.lift.uas.automation.UASRequestModule;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.isIn;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:PersonaLevelTargeting.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/PersonaLevelTargeting_$TIMESTAMP$.json"})
public class PersonaLevelTargetingTest  extends BaseTest{
    public PersonaLevelTargetingTest() {
        super();
    }
}
