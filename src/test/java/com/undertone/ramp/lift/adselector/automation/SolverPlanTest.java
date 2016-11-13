package com.undertone.ramp.lift.adselector.automation;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;

import org.junit.Assert;
import org.junit.runner.RunWith;

import com.undertone.automation.utils.S3Client;

import cucumber.api.CucumberOptions;
import cucumber.api.DataTable;
import cucumber.api.junit.Cucumber;

/**
 * Created by assafm on 02/11/2016.
 */

@CucumberOptions(features = "classpath:UASLimitations.feature", plugin = { "pretty",
	"com.undertone.automation.RotatingJSONFormatter:target/cucumber/solver_plan_handler_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)
public class SolverPlanTest extends BaseTest {
    public SolverPlanTest() {
	super();
	Given("^I upload a new solver plan with the following slices$", (DataTable slices) -> {
	    uploadNew(slices.asList(String.class));
	});
	Then("^I will be able to start testing$", () -> {
	});
	Then("^I restore the original solver plan$", () -> {
	    RestoreOriginal();
	});
	And("^I will finish testing$", () -> {
	});
    }

    private void uploadNew(List<String> slices) {
	try {
	    S3Client s3Client = new S3Client();
	    /* Download existing plan */
	    String planFileName = config.get("as.solver_plan.file_name");
	    String s3PlanPath = config.get("as.solver_plan.file_path") + "/" + planFileName;
	    s3Client.downloadFile(s3PlanPath, planFileName);
	    /* Backup existing plan */
	    Path planLocalPath = Paths.get(planFileName);
	    Path origPlanLocalPath = Paths.get(planFileName + ".tmp");
	    Files.copy(planLocalPath, origPlanLocalPath);
	    /* generate new slice IDs for the new slices */
	    List<String> newSlices = generateNewSliceIDs(slices);
	    /* Add input slices to the plan */
	    Files.write(planLocalPath, newSlices, StandardOpenOption.APPEND);
	    /* Delete original file from S3 */
	    s3Client.deleteFile(s3PlanPath);
	    /* Upload the new plan to S3 */
	    String s3NewPlanPath = config.get("as.solver_plan.file_path") + "/" + planFileName.substring(0, planFileName.lastIndexOf('.')) + "_int_test.json";
	    s3Client.uploadFile(planFileName, s3NewPlanPath);
	    /* Delete the new plan from the disk */
	    Files.delete(planLocalPath);
	} catch (IOException e) {
	    Assert.fail(e.getMessage());
	}
    }

    private List<String> generateNewSliceIDs(List<String> slices) {
	List<String> newSlices = new ArrayList<>();
	for (String slice : slices) {
	    newSlices.add(slice.replaceAll("\\$SLICE_ID\\$", java.util.UUID.randomUUID().toString()));
	}
	return newSlices;
    }

    private void RestoreOriginal() {
	try {
	    S3Client s3Client = new S3Client();
	    /* Delete the new plan from S3 */
	    String planFileName = config.get("as.solver_plan.file_name");
	    String s3NewPlanPath = config.get("as.solver_plan.file_path") + "/" + planFileName.substring(0, planFileName.lastIndexOf('.')) + "_int_test.json";
	    s3Client.deleteFile(s3NewPlanPath);
	    /* upload the original plan back to S3 */
	    String s3PlanPath = config.get("as.solver_plan.file_path") + "/" + planFileName;
	    String origPlanFileName = planFileName + ".tmp";
	    s3Client.uploadFile(origPlanFileName, s3PlanPath);
	    /* Delete original plan from the disk */
	    Path origPlanLocalPath = Paths.get(origPlanFileName);
	    Files.delete(origPlanLocalPath);
	} catch (IOException e) {
	    Assert.fail(e.getMessage());
	}
    }
}
