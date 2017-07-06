package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.DataTable;
import cucumber.api.junit.Cucumber;
import entities.ramp.models.Experiment;
import entities.ramp.models.ExperimentGroup;
import infra.utils.SqlRampAdminUtils;
import ramp.lift.uas.automation.RampAppRequestModule;

import org.junit.runner.RunWith;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by AssafM on 11/01/2017.
 */

@CucumberOptions(features = "classpath:ABTesting.feature", plugin = { "pretty",
		"infra.RotatingJSONFormatter:target/cucumber/solver_plan_handler_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)
public class ABTestingTest extends BaseTest {
	List<Integer> createdExperimentGroupIds = new ArrayList<>();
	List<Integer> createdExperimentIds = new ArrayList<>();
	int latestExperimentIdBeforeTest = 0;
	int latestExperimentGroupIdBeforeTest = 0;

	public ABTestingTest() {
		super();
		Given("^I set the activation status of experiment group named \\{([^}]+)\\} and his experiments to \\{([^}]+)\\}$",
            (String experimentGroupName, String activationStatus) -> {
              int status = 0;
              if (activationStatus.equals("active")) {
                status = 1;
              } 
              
              SqlRampAdminUtils.setActivationStatusHierarchy(experimentGroupName, status);

            });
		
		Given("^Unable all experiment groups$", () -> {
              SqlRampAdminUtils.unableAllExperimentGroups();
            });
		
		Given("^I create new experiment groups with the following fields$", (DataTable experimentGroupsTable) -> {
			List<ExperimentGroup> experimentGroupsList = experimentGroupsTable.asList(ExperimentGroup.class);
			latestExperimentGroupIdBeforeTest = SqlRampAdminUtils.getMaxIdFromTable("experiment_group");
			SqlRampAdminUtils.createNewExperimentGroup(experimentGroupsList);
		});

		And("^I create new experiments for group named \\{([^}]+)\\} with the following fields$",
				(String experimentGroupName, DataTable experimentsTable) -> {
					List<Experiment> experiments = experimentsTable.asList(Experiment.class);
					latestExperimentIdBeforeTest = SqlRampAdminUtils.getMaxIdFromTable("experiment");
					int experimentGroupId = SqlRampAdminUtils.getIdFromTableByName(experimentGroupName,
							"experiment_group");
					SqlRampAdminUtils.createNewExperimentForGroupId(experimentGroupId, experiments);
				});

		And("^I set the activation status of experiment named \\{([^}]+)\\} to \\{(\\d+)\\}$",
				(String experimentName, Integer activationStatus) -> {
					SqlRampAdminUtils.setActivationStatusinTable(experimentName, activationStatus, "experiment");
				});
		
		And("^I update the s3 experiment data$", () -> {
		  RampAppRequestModule appReqModule = new RampAppRequestModule();
		  appReqModule.requestToRampApp("http://services-ramp-staging.ramp-ut.io:3002/api/v1/experiments?active=true");
		});

		After(1,scenario -> {
//		  inactive the test experiment groups and experiments
			  SqlRampAdminUtils.unableAllExperimentGroups();
		});
	}
}
