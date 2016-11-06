package com.undertone.ramp.lift.adselector.automation;

import com.amazonaws.services.s3.model.PutObjectResult;
import com.undertone.automation.support.SystemClock;
import com.undertone.automation.utils.HttpContentTest;
import com.undertone.automation.utils.S3Client;
import com.undertone.qa.Zone;
import cucumber.api.CucumberOptions;
import cucumber.api.java.en.Then;
import cucumber.api.junit.Cucumber;
import org.apache.http.HttpResponse;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.Assume;
import org.junit.runner.RunWith;

import java.io.*;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.*;
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
    private String slice  = "{\"buying_strategy_id\": -1, \"slices\": [{\"banner_id\": 879498, \"weight\": 4, " +
            "\"slice_id\": \"#sliceId#\", \"start_time\": 1477872001, " +
            "\"zone_id\": 144960, \"end_time\": 1477958399, " +
            "\"predicates\": {\"AND\": [{\"==\": [\"body.features.zone_id\", 144960]}]}, \"buy_at_most\": 100}]}";
    public AdSelectorIntegrationTest(){
        super();
        givenCampaignManager();


        Given("^Loading test_plan (.*) to S3 directory (.*)",(String from, String to)-> {
            URL url = getClass().getClassLoader().getResource(from);
            PutObjectResult res = (new S3Client()).uploadFile(getClass().getClassLoader().getResource(from).getPath(), to);

            // TODO: 2016-10-31 add regex with timestamp to slice id
            try {
                File tmp = File.createTempFile("tempTest1", ".tmp");
                Files.copy(Paths.get(url.toURI()),tmp.toPath(), StandardCopyOption.REPLACE_EXISTING);
                String tmpSlice = slice.replace("#sliceId#", String.valueOf(System.currentTimeMillis()));
                System.out.println(tmpSlice);
                Files.write(Paths.get(tmp.toURI()), tmpSlice.getBytes(), StandardOpenOption.APPEND);

                tmp.delete();
                assertThat(res, is(notNullValue()));
            } catch (IOException | URISyntaxException e) {
                Assert.assertNull(e.getMessage(),e);
            }
        });
    }
}
