package com.undertone.ramp.lift.adselector.automation;

import com.undertone.qa.ramp.models.Experiment;
import com.undertone.qa.ramp.models.ExperimentGroup;
import cucumber.api.CucumberOptions;
import cucumber.api.DataTable;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.function.Consumer;
import java.util.stream.Collectors;

import static org.junit.Assert.fail;

/**
 * Created by AssafM on 11/01/2017.
 */

@CucumberOptions(features = "classpath:ABTesting.feature", plugin = { "pretty",
		"com.undertone.automation.RotatingJSONFormatter:target/cucumber/solver_plan_handler_$TIMESTAMP$.json" })
@RunWith(Cucumber.class)
public class ABTestingTest extends BaseTest{
    List<Integer> createdExperimentGroupIds = new ArrayList<>();
    List<Integer> createdExperimentIds = new ArrayList<>();

    public ABTestingTest(){
	super();

	Given("^I create new experiment groups with the following fields$", (DataTable experimentGroupsTable) -> {
	    try{
		List<ExperimentGroup> experimentGroupsList = experimentGroupsTable.asList(ExperimentGroup.class);
		ExperimentGroup theGroup = experimentGroupsList.get(0);
		Connection dbConnection = sut.getRampAdminDbConnector().actual();
		Statement stmt = dbConnection.createStatement();
		String maxGroupQuery = "SELECT max(id) FROM staging_ramp_admin.experiment_group";
		ResultSet rs = stmt.executeQuery(maxGroupQuery);
		rs.next();
		int maxGroupId = rs.getInt(1);
		String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		theGroup.setId(maxGroupId + 1);
		theGroup.setCreatedAt(today);
		theGroup.setUpdatedAt(today);
		String insertGroupQuery = "INSERT INTO staging_ramp_admin.experiment_group VALUES (" + theGroup.toString() + ")";
		stmt.executeUpdate(insertGroupQuery);
		createdExperimentGroupIds.add(maxGroupId + 1);
	    }catch (SQLException e){
		fail(e.getMessage());
	    }
	});

	And("^I create new experiments for group named \\{([^}]+)\\} with the following fields$", (String experimentGroupName, DataTable experimentsTable) -> {
	    List<Experiment> experiments = experimentsTable.asList(Experiment.class);
	    Connection dbConnection = sut.getRampAdminDbConnector().actual();
	    experiments.forEach(experiment -> {
		try {
		    Statement stmt = dbConnection.createStatement();
		    String maxExperimentQuery = "SELECT max(id) FROM staging_ramp_admin.experiment";
		    ResultSet rs = stmt.executeQuery(maxExperimentQuery);
		    rs.next();
		    int maxExperimentId = rs.getInt(1);
		    String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		    String findExperimentGroupIdQuery =
				    "SELECT id FROM staging_ramp_admin.experiment_group where name=" + "'" + experimentGroupName + "'";
		    rs = stmt.executeQuery(findExperimentGroupIdQuery);
		    rs.next();
		    int experimentGroupId = rs.getInt(1);
		    experiment.setId(maxExperimentId + 1);
		    experiment.setExperimentGroupId(experimentGroupId);
		    experiment.setCreatedAt(today);
		    experiment.setUpdatedAt(today);
		    String insertExperimentQuery =
				    "INSERT INTO staging_ramp_admin.experiment VALUES (" + experiment.toString() + ")";
		    stmt.executeUpdate(insertExperimentQuery);
		    createdExperimentIds.add(maxExperimentId + 1);
		} catch (SQLException e) {
		    fail(e.getMessage());
		}

	    });
	});

	And("^I set the activation status of experiment named \\{([^}]+)\\} to \\{(\\d+)\\}$", (String experimentName, Integer activationStatus) -> {
	    try{
		Connection dbConnection = sut.getRampAdminDbConnector().actual();
		Statement stmt = dbConnection.createStatement();
		String findExperimentQuery = "SELECT id FROM staging_ramp_admin.experiment where name='" + experimentName + "'";
		ResultSet rs = stmt.executeQuery(findExperimentQuery);
		rs.next();
		int experimentId = rs.getInt(1);
		String updateExperimentQuery = "UPDATE staging_ramp_admin.experiment set active=" + activationStatus + " where id=" + experimentId;
		stmt.executeUpdate(updateExperimentQuery);
	    }catch (SQLException e) {
		fail(e.getMessage());
	    }
	});

	And("^I clean the created experiments$", () -> {
	    try{
		Connection dbConnection = sut.getRampAdminDbConnector().actual();
		Statement stmt = dbConnection.createStatement();
		String experimentsToDelete = createdExperimentIds.stream().map(i->i.toString()).collect(Collectors.joining(","));
		String deleteExperimentsQuery = "DELETE FROM staging_ramp_admin.experiment where id in (" + experimentsToDelete + ")";
		stmt.executeUpdate(deleteExperimentsQuery);
	    }catch (SQLException e) {
		fail(e.getMessage());
	    }
	});

	And("^I clean the created experiment groups$", () -> {
	    try{
		Connection dbConnection = sut.getRampAdminDbConnector().actual();
		Statement stmt = dbConnection.createStatement();
		String experimentsGroupToDelete = createdExperimentGroupIds.stream().map(i->i.toString()).collect(Collectors.joining(","));
		String deleteGroupsQuery = "DELETE FROM staging_ramp_admin.experiment_group where id in (" + experimentsGroupToDelete + ")";
		stmt.executeUpdate(deleteGroupsQuery);
	    }catch (SQLException e) {
		fail(e.getMessage());
	    }
	});
    }
}
