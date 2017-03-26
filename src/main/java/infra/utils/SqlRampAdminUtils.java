package infra.utils;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import entities.ramp.models.Experiment;
import entities.ramp.models.ExperimentGroup;
import ramp.lift.uas.automation.SystemUnderTest;

public class SqlRampAdminUtils {

	protected static SystemUnderTest sut = SystemUnderTest.getInstance();

	public static void createNewExperimentGroup(List<ExperimentGroup> experimentGroupsList) {
		// int newGroupId = 0;
		experimentGroupsList.forEach(experimentGroup -> {
			try {
				// int maxGroupId = getMaxIdFromTable("experiment_group");
				// newGroupId = maxGroupId + 1;
				String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
				// experimentGroup.setId(newGroupId);
				experimentGroup.setCreatedAt(today);
				experimentGroup.setUpdatedAt(today);
				Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();
				String insertGroupQuery = "INSERT INTO staging_ramp_admin.experiment_group VALUES ("
						+ experimentGroup.toString() + ")";
				if (stmt.executeUpdate(insertGroupQuery) != 1) {
					fail("insert new experiment group failed");
				}
			} catch (SQLException e) {
				fail(e.getMessage());
			}
		});

		// return newGroupId;
	}

	public static int getMaxIdFromTable(String tableName) {
		int maxGroupId = 0;
		try {
			Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();
			String maxGroupQuery = "SELECT max(id) FROM staging_ramp_admin." + tableName;
			ResultSet rs = stmt.executeQuery(maxGroupQuery);
			rs.next();
			maxGroupId = rs.getInt(1);
			rs.close();
		} catch (SQLException e) {
			fail(e.getMessage());
		}

		return maxGroupId;
	}

	public static void createNewExperimentForGroupId(int experimentGroupId, List<Experiment> experimentGroupsList) {
		// int newExperimentId = 0;
		experimentGroupsList.forEach(experiment -> {
			try {
				// int maxExperimentId = getMaxIdFromTable("experiment");
				// newExperimentId = maxExperimentId + 1;
				Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();
				String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
				// experiment.setId(newExperimentId);
				experiment.setExperimentGroupId(experimentGroupId);
				experiment.setCreatedAt(today);
				experiment.setUpdatedAt(today);
				String insertExperimentQuery = "INSERT INTO staging_ramp_admin.experiment VALUES ("
						+ experiment.toString() + ")";
				if (stmt.executeUpdate(insertExperimentQuery) != 1) {
					fail("insert new experiment failed");
				}
			} catch (SQLException e) {
				fail(e.getMessage());
			}
		});

		// return newExperimentId;
	}

	public static int getIdFromTableByName(String name, String tableName) {
		int experimentGroupId = 0;
		try {
			Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();
			String findExperimentGroupIdQuery = "SELECT id FROM staging_ramp_admin." + tableName + " where name=" + "'"
					+ name + "'";
			ResultSet rs = stmt.executeQuery(findExperimentGroupIdQuery);
			rs.next();
			experimentGroupId = rs.getInt(1);
			sut.write("Id: " + String.valueOf(rs.getInt(1)));
			rs.close();
		} catch (SQLException e) {
			fail(e.getMessage());
		}

		return experimentGroupId;
	}

	public static void setActivationStatusOfExperimentNamed(String experimentName, Integer activationStatus) {
		try {
			Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();
			int experimentId = getIdFromTableByName(experimentName, "experiment");
			String updateExperimentQuery = "UPDATE staging_ramp_admin.experiment set active=" + activationStatus
					+ " where id=" + experimentId;
			if (stmt.executeUpdate(updateExperimentQuery) != 1) {
				fail("set activation status failed");
			}
		} catch (SQLException e) {
			fail(e.getMessage());
		}
	}

	public static void deleteFromTableFromId(int idToStartFrom, String tableName, Statement stmt) {
		try {
			//Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();
			String deleteQuery = "DELETE FROM staging_ramp_admin." + tableName + " where id > " + idToStartFrom;

			if (stmt.executeUpdate(deleteQuery) != 1) {
				fail("delete from " + tableName + " from id " + idToStartFrom + " failed");
			}
		} catch (SQLException e) {
			fail(e.getMessage());
		}
	}

}
