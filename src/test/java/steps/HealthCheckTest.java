package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;
import ramp.lift.uas.automation.UASRequestModule;
import util.ResponseVerifier;
import util.TestsRoutines;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.function.BiConsumer;
import java.util.stream.Collectors;

import static org.hamcrest.Matchers.not;

@CucumberOptions(features = "classpath:UASHealthcheck.feature", plugin = {"pretty",})
//		"infra.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)
public class HealthCheckTest extends BaseTest {

    protected String svc_ut = "";

    public HealthCheckTest() {
        super();
        // ThenResposeCodeIs();
        When("^Sending a healthcheck request of (RabbitMQ|Couchbase|Redis|Workflow) to UAS$",
                this::healthCheckRequestSkip);
        When("^Sending a healthcheck request to (.*)$", this::healthCheckRequest);
        Then("^The response code is (\\d+)$", this::allResponsesHaveCode);
        Then("^The synchronized response code is (\\d+)$", this::allSynchronizedResponsesHaveCode);
        Then("^The synchronized response code is (\\d+) (\\d+) responses from (\\d+) of the times", this::allSynchronizedResponsesHaveCodePartially);
        Then("^All requests are sent$", this::allResponsesFinished);
        Then("^The response contains \\{(.*)\\}$", this::healthCheckResponseContains);
        Then("^The response not contains (.*)$", this::healthCheckResponseNotContains);

    }

    public void healthCheckResponseNotContains(String something) {
        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            //System.out.println(content); // for checks only
            Assert.assertThat(content, not(Matchers.containsString(something)));
        });
    }

    public void healthCheckResponseContains(String something) {
        ResponseVerifier.getInstance().verifyContains(something);
    }


    public void healthCheckRequestSkip(String servicenameToSkip) {
        sut.getUASRquestModule().healthCheckRequestSkip(servicenameToSkip);
    }


    public void healthCheckRequest(String svc) {
        switch (svc) {
            case "UAS":
                sut.getUASRquestModule().healthCheckRequest();
                svc_ut = "UAS";
                break;
            case "RAMP-IO":
                sut.getRampAppRequestModule().healthCheckRequest();
                svc_ut = "RAMP-IO";
                break;
            default:
                System.out.println("Invalid service " + svc + ". Wasn't initialized.");
        }


    }

    public synchronized void allResponsesHaveCode(Integer expectedResponseCode) {
        switch (svc_ut) {
            case "UAS":
                sut.getUASRquestModule().responses().map(f -> f.thenApply(HttpResponse::getStatusLine)
                        .thenApply(StatusLine::getStatusCode).whenComplete(assertThatResponseCodeIs(expectedResponseCode)))
                        .forEach(CompletableFuture::join);
                break;
            case "RAMP-IO":
                sut.getRampAppRequestModule().responses().map(f -> f.thenApply(HttpResponse::getStatusLine)
                        .thenApply(StatusLine::getStatusCode).whenComplete(assertThatResponseCodeIs(expectedResponseCode)))
                        .forEach(CompletableFuture::join);
                break;
            default:
                System.out.println("You must run health check to service before verifying responses' code!");
        }
    }

    public void allSynchronizedResponsesHaveCode(Integer expectedResponseCode) {
        sut.getUASRquestModule().getSynchronizedResponses().stream().map(HttpResponse::getStatusLine)
                .map(StatusLine::getStatusCode).forEach(statusCode -> Assert.assertThat(statusCode, Matchers.is(expectedResponseCode)));
    }

    public void allSynchronizedResponsesHaveCodePartially(Integer expectedResponseCode, Integer expected,Integer requestSent) {
        int count = 0;
        List<Integer> aa = sut.getUASRquestModule().getSynchronizedResponses().stream().map(HttpResponse::getStatusLine)
                .map(StatusLine::getStatusCode).collect(Collectors.toList());
        for (int status_code : aa) {
            if (status_code == expectedResponseCode)
                count++;
        }

        int throttlingRequests =  requestSent - expected;
        int tolerancePercentages = 10;
        int minValue =  (int) (requestSent - (throttlingRequests * (1 + (double)tolerancePercentages / 100)));
        int maxValue = (int) (requestSent - (throttlingRequests * (1 - (double)tolerancePercentages / 100)));
        System.out.println("total equests with status code : " + expectedResponseCode + " are ==>  " + count + " ... while the expected values are : " + (minValue) + "-" + (maxValue));
        Assert.assertTrue((count <= (maxValue)) && (count >= (minValue)));
    }

    public void allResponsesFinished() {
        sut.getUASRquestModule().responses().forEach(CompletableFuture::join);
    }

    public BiConsumer<Integer, Throwable> assertThatResponseCodeIs(int expected) {
        return (statuscode, failure) -> {
            if (failure != null) {
                Assert.fail("unable to get response");
                return;
            }
            Assert.assertThat(statuscode, Matchers.is(expected));
        };
    }
}
