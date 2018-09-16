package infra.utils;

import static org.junit.Assert.fail;

import entities.ramp.models.Experiment;
import entities.ramp.models.ExperimentGroup;
import ramp.lift.uas.automation.SystemUnderTest;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class SqlRampAdminUtils {

	protected static SystemUnderTest sut = SystemUnderTest.getInstance();

	public static void createNewExperimentGroup(List<ExperimentGroup> experimentGroupsList) {
		experimentGroupsList.forEach(experimentGroup -> {
			try {
				String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
				experimentGroup.setCreatedAt(today);
				experimentGroup.setUpdatedAt(today);
				Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();
				String insertGroupQuery = "INSERT INTO staging_ramp_admin.experiment_group VALUES ("
						+ experimentGroup.toString() + ")";
				if (stmt.executeUpdate(insertGroupQuery) < 1) {
					fail("insert new experiment group failed");
				}
			} catch (SQLException e) {
				fail(e.getMessage());
			}
		});
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
		experimentGroupsList.forEach(experiment -> {
			try {
				Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();
				String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
				experiment.setExperimentGroupId(experimentGroupId);
				experiment.setCreatedAt(today);
				experiment.setUpdatedAt(today);
				String insertExperimentQuery = "INSERT INTO staging_ramp_admin.experiment VALUES ("
						+ experiment.toString() + ")";
				if (stmt.executeUpdate(insertExperimentQuery) < 1) {
					fail("insert new experiment failed");
				}
			} catch (SQLException e) {
				fail(e.getMessage());
			}
		});
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
			
			rs.close();
		} catch (SQLException e) {
			fail(e.getMessage());
		}

		return experimentGroupId;
	}


	public static void setActivationStatusinTable(String experimentName, Integer activationStatus, String tableName) {
		try {
			Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();

			String updateExperimentQuery = "UPDATE staging_ramp_admin." + tableName + " set active=" + activationStatus
                  + " where name= '" + experimentName + "'";
		
			if (stmt.executeUpdate(updateExperimentQuery) < 1) {
				fail("set activation status failed");
			}
		} catch (SQLException e) {
			fail(e.getMessage());
		}
	}
//UPDATED
	public static void setTestStrategyToTestIdGroup(String TestStrategyName, Integer testId) {
		try {
			Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();

			String updateExperimentQuery = "UPDATE staging_ramp_admin.test_strategy set test_id=" + testId
					+ " where description= '" + TestStrategyName + "'";

			if (stmt.executeUpdate(updateExperimentQuery) < 1) {
				fail("set test_strategy failed");
			}
		} catch (SQLException e) {
			fail(e.getMessage());
		}
	}


	public static void unableAllExperimentGroups() {
      try {
          Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();

          String updateExperimentQuery = "UPDATE staging_ramp_admin.experiment_group set active=0 where id !=0;";
      
          if (stmt.executeUpdate(updateExperimentQuery) < 1) {
              fail("set activation status failed");
          }
      } catch (SQLException e) {
          fail(e.getMessage());
      }
  }
	
	//set the activation status of the experiment group and his experiments
	public static void setActivationStatusHierarchy(String experimentGroupName, Integer activationStatus) {
      try {
          Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();
          int Id = getIdFromTableByName(experimentGroupName, "experiment_group");
          String updateExperimentQuery = "UPDATE staging_ramp_admin.experiment set active=" + activationStatus
                + " where experiment_group_id=" + Id;
            
          if (stmt.executeUpdate(updateExperimentQuery) < 1) {
              fail("set activation status in experiment failed");
          }
          
          updateExperimentQuery = "UPDATE staging_ramp_admin.experiment_group set active=" + activationStatus
                + " where id=" + Id;
          
          if (stmt.executeUpdate(updateExperimentQuery) < 1) {
              fail("set activation status in experiment group failed");
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

	public static void unableAllExperimentGroupsExcept(Integer experimentID) {
		try {
			Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();

			String updateExperimentQuery = "UPDATE staging_ramp_admin.experiment_group set active=0 where id !=0 and id!="+experimentID+";";

			if (stmt.executeUpdate(updateExperimentQuery) < 1) {
				fail("set activation status failed");
			}
		} catch (SQLException e) {
			fail(e.getMessage());
		}

	}
//UPDET TEST
	public static void disableAllTestsExcept(Integer testID) {
		try {
			Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();

			String updateExperimentQuery = "UPDATE staging_ramp_admin.test set active=0 where id !=50 and id!="+testID+";";

			if (stmt.executeUpdate(updateExperimentQuery) < 1) {
				fail("set activation status failed");
			}
		} catch (SQLException e) {
			fail(e.getMessage());
		}

	}

	public static void setTestStatus(Integer testID, Integer status) {
		try {
			Statement stmt = sut.getRampAdminDbConnector().actual().createStatement();

			String updateExperimentQuery = "UPDATE staging_ramp_admin.test set active="+status+" where id="+testID+";";

			if (stmt.executeUpdate(updateExperimentQuery) < 1) {
				fail("set TestStatus failed");
			}
		} catch (SQLException e) {
			fail(e.getMessage());
		}
	}

}
