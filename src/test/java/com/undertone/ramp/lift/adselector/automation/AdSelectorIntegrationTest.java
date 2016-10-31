package com.undertone.ramp.lift.adselector.automation;

import com.amazonaws.services.s3.model.PutObjectResult;
import com.undertone.automation.utils.S3Client;
import com.undertone.qa.Zone;
import cucumber.api.CucumberOptions;
import cucumber.api.java.en.Then;
import cucumber.api.junit.Cucumber;
import org.apache.http.HttpResponse;
import org.junit.runner.RunWith;
import java.io.InputStream;
import java.net.URL;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeUnit;
import java.util.function.Function;
import java.util.stream.Collectors;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.notNullValue;
/**
 * Created by nive on 2016-10-30.
 */
@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:AdSelectorIntegration.feature", plugin = {
        "com.undertone.automation.RotatingJSONFormatter:target/cucumber/uas-adselector-integration_$TIMESTAMP$.json" })
public class AdSelectorIntegrationTest extends BaseTest implements CampaignManaging  {
    public AdSelectorIntegrationTest(){
        super();
        givenCampaignManager();
        Given("^Loading test_plan (.*) to S3 directory (.*)",(String from, String to)-> {
//            PutObjectResult res = S3Client.getInstance().uploadFile(from, to);
//            assertThat(res, is(notNullValue()));
//            wait X time for ad selector to load plan
            InputStream in = getClass().getClassLoader().getResourceAsStream("input_files/req_zone_2.json");
            System.out.println("################# printing:"    + in);
        });

    }
}
