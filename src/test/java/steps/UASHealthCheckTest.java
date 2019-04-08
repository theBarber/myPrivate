package steps;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.function.BiConsumer;
import java.util.stream.Collectors;


import com.google.common.io.Files;
import com.sun.org.apache.xpath.internal.operations.Or;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import ramp.lift.uas.automation.UASRequestModule;

import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.isIn;
import static org.hamcrest.Matchers.not;

@CucumberOptions(features = "classpath:UASHealthcheck.feature", plugin = { "pretty",
		"infra.RotatingJSONFormatter:target/cucumber/uas_healthcheck_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)
public class UASHealthCheckTest extends BaseTest {

	public UASHealthCheckTest() {
		super();
		// ThenResposeCodeIs();
		When("^Sending a healthcheck request of (RabbitMQ|Couchbase|Redis|Workflow) to UAS$",
				this::healthCheckRequestSkip);
		When("^Sending a healthcheck request to UAS$", this::healthCheckRequest);
		Then("^The response code is (\\d+)$", this::allResponsesHaveCode);
		Then("^The synchronized response code is (\\d+)$", this::allSynchronizedResponsesHaveCode);
		Then("^All requests are sent$", this::allResponsesFinished);
		Then("^The response contains (.*)$", this::healthCheckResponseContains);
		Then("^The response not contains (.*)$", this::healthCheckResponseNotContains);

	}
}
