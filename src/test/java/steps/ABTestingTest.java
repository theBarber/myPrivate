package steps;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.DataTable;
import cucumber.api.junit.Cucumber;
import entities.ramp.models.Experiment;
import entities.ramp.models.ExperimentGroup;
import infra.utils.SqlRampAdminUtils;

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
					SqlRampAdminUtils.setActivationStatusOfExperimentNamed(experimentName, activationStatus);
				});

		After(1,scenario -> {
			try {
				Connection dbConnection;

				dbConnection = DriverManager.getConnection(config.get("ramp.admin.db.jdbc.connection"),
						config.get("ramp.admin.db.user"), config.get("ramp.admin.db.password"));

				Statement stmt = dbConnection.createStatement();
				if (latestExperimentGroupIdBeforeTest > 0) {
					SqlRampAdminUtils.deleteFromTableFromId(latestExperimentGroupIdBeforeTest, "experiment_group",
							stmt);
				}

				if (latestExperimentIdBeforeTest > 0) {
					SqlRampAdminUtils.deleteFromTableFromId(latestExperimentIdBeforeTest, "experiment", stmt);
				}

				dbConnection.close();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		});
	}
}
