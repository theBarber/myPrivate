package steps;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.junit.Assert;
import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.DataTable;
import cucumber.api.junit.Cucumber;
import infra.ParameterPlaceholderParser;
import infra.utils.S3Client;

/**
 * Created by assafm on 02/11/2016.
 */

@CucumberOptions(features = "classpath:UASLimitations.feature", plugin = {"pretty",
    "infra.RotatingJSONFormatter:target/cucumber/solver_plan_handler_$TIMESTAMP$.json"})
@RunWith(RerunningCucumber.class)
public class SolverPlanTest extends BaseTest {
  public SolverPlanTest() {
    super();
    Given("^I upload a new solver plan with the following slices$", (DataTable slices) -> {

      ParameterPlaceholderParser parameterPlaceholderParser = new ParameterPlaceholderParser<>(
          sut.getCampaignManager());
      List<String> slicesAsList = slices.asList(String.class).stream()
          .map(parameterPlaceholderParser::replacePlaceholderOf).collect(Collectors.toList());
      uploadNew(slicesAsList);
    });
    Then("^I delete the test solver plan$", this::deleteTestSolverPlanFromS3);
    Then("^I restore the original plan$", this::restoreOriginal);
  }

  private void uploadNew_Version2(List<String> slices) {
    try {
      S3Client s3Client = new S3Client();

      /*creating new file with the plan*/
      String planFileName = config.get("as.solver_plan.file_name");
      Path planLocalPath = Paths.get(planFileName);
      Files.write(planLocalPath, slices, Charset.forName("UTF-8"));

      /* Upload the new plan to S3 */
      String s3NewPlanPath = config.get("as.solver_plan.file_path") + "/"
              + planFileName.substring(0, planFileName.lastIndexOf('.')) + "_int_test.json";
      sut.write("uploading file " + s3NewPlanPath);
      s3Client.uploadFile(planFileName, s3NewPlanPath);
      /* Delete the new plan from the disk */
      Files.delete(planLocalPath);
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  private void uploadNew(List<String> slices) {
    try {
      S3Client s3Client = new S3Client();
      /* Download existing plan */
      String planFileName = config.get("as.solver_plan.file_name");
      String s3PlanPath = config.get("as.solver_plan.file_path") + "/" + planFileName;
      sut.write("downloading file " + s3PlanPath);
      s3Client.downloadFile(s3PlanPath, planFileName+".tmp"); //solver_plan_v4.json.tmp
      /* Backup existing plan */
      Path planLocalPath = Paths.get(planFileName); //solver_plan_v4.json
      //Path origPlanLocalPath = Paths.get(planFileName + ".tmp");  //solver_plan_v4.json.tmp

      //Files.copy(planLocalPath, origPlanLocalPath); //copy from solver_plan_v4.json to solver_plan_v4.json.tmp

      /* Add input slices to the plan */
      Files.write(planLocalPath, slices, Charset.forName("UTF-8")); //add slices to solver_plan_v4.json
      /* Delete original file from S3 */
      s3Client.deleteFile(s3PlanPath);
      /* Upload the new plan to S3 */
     // String s3NewPlanPath = config.get("as.solver_plan.file_path") + "/"
         // + planFileName.substring(0, planFileName.lastIndexOf('.')) + "_int_test.json";
      sut.write("uploading file " + s3PlanPath);
      s3Client.uploadFile(planFileName, s3PlanPath);
      /* Delete the new plan from the disk */
      Files.delete(planLocalPath);
    } catch (IOException e) {
      Assert.fail(e.getMessage());
    }
  }


  private void deleteTestSolverPlanFromS3()
  {
    S3Client s3Client = new S3Client();
      /* Delete the new plan from S3 */
    String planFileName = config.get("as.solver_plan.file_name");
    String s3NewPlanPath = config.get("as.solver_plan.file_path") + "/"
            + planFileName.substring(0, planFileName.lastIndexOf('.')) + "_int_test.json";
    s3Client.deleteFile(s3NewPlanPath);
  }

  private void restoreOriginal() {
    try {
      S3Client s3Client = new S3Client();
      /* Delete the new plan from S3 */
      String planFileName = config.get("as.solver_plan.file_name");
      String s3NewPlanPath = config.get("as.solver_plan.file_path") + "/"
          + planFileName.substring(0, planFileName.lastIndexOf('.')) + "_int_test.json";
      s3Client.deleteFile(s3NewPlanPath);
       /*upload the original plan back to S3 */
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
