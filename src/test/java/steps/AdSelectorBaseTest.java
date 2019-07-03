package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import cucumber.api.java.en.*;
import entities.Zone;
import infra.utils.HttpContentTest;

import org.junit.Assert;
import org.junit.runner.RunWith;
/**
 * Created by nive on 2016-10-30.
 */
@RunWith(RerunningCucumber.class)
@CucumberOptions(features = "classpath:AdSelectorBase.feature", plugin = { "pretty",
        "infra.RotatingJSONFormatter:target/cucumber/uas-adselector-integration_$TIMESTAMP$.json" }, glue = "C:\\Dev\\ramp-lift-automation\\src\\test\\resources\\AdSelectorBase.feature")

public class AdSelectorBaseTest extends BaseTest  {
    private String slice  = "{\"buying_strategy_id\": -1, \"slices\": [{\"banner_id\": 879498, \"weight\": 4, " +
            "\"slice_id\": \"#sliceId#\", \"start_time\": 1477872001, " +
            "\"zone_id\": 144960, \"end_time\": 1477958399, " +
            "\"predicates\": {\"AND\": [{\"==\": [\"body.features.zone_id\", 144960]}]}, \"buy_at_most\": 100}]}";
    public AdSelectorBaseTest(){
        super();
//
//        Given("^Loading test_plan (.*) to S3 directory (.*)",(String from, String to)-> {
//            URL url = getClass().getClassLoader().getResource(from);
//            PutObjectResult res = (new S3Client()).uploadFile(getClass().getClassLoader().getResource(from).getPath(), to);
//
//            // TODO: 2016-10-31 add regex with timestamp to slice id
//            try {
//                File tmp = File.createTempFile("tempTest1", ".tmp");
//                Files.copy(Paths.get(url.toURI()),tmp.toPath(), StandardCopyOption.REPLACE_EXISTING);
//                String tmpSlice = slice.replace("#sliceId#", String.valueOf(System.currentTimeMillis()));
//                sut.write(tmpSlice);
//                Files.write(Paths.get(tmp.toURI()), tmpSlice.getBytes(), StandardOpenOption.APPEND);
//
//                tmp.delete();
//                assertThat(res, is(notNullValue()));
//            } catch (IOException | URISyntaxException e) {
//                Assert.assertNull(e.getMessage(),e);
//            }
//        });
        Then("^The banner to passback ratio for banner \\{(.+)\\} should be (\\d+)%", (String bannerId, Integer percentage) -> {
            long total  = sut.getUASRquestModule().responses().count();
            long numOfImp = sut.getUASRquestModule().responses().filter(fh -> HttpContentTest.getContent(fh.join()).contains("/l?bannerid=")).count();
            double actualRatio = numOfImp / (double) total;
            final double neededRatio = percentage / 100.0;
            Assert.assertEquals("Total impressions for banner "+bannerId+ " is: "+numOfImp+" out of "+ total+ " responses.", neededRatio, actualRatio, 0.1);

        });
        When("^I send (\\d+) times an ad request for zone named \\{([^}]+)\\} and zone limitation (.*) to UAS",
                (Integer times, String zoneByName, String param) -> {
                    Zone zone = sut.getExecutorCampaignManager().getZone(zoneByName)
                            .orElseThrow(() -> new AssertionError("The Zone " + zoneByName + " does not exist!"));
                    sut.getUASRquestModule().zoneRequestsWithGeo(zone.getId(), times, param);
                });
    }
}
