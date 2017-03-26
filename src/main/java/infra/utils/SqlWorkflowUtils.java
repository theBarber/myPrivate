package infra.utils;

import static org.junit.Assert.fail;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.Assert;
import org.junit.internal.runners.statements.Fail;

import ramp.lift.uas.automation.SystemUnderTest;

public class SqlWorkflowUtils {
	
	protected static SystemUnderTest sut = SystemUnderTest.getInstance();
		
	public static String getLimitationForZone(int zoneId) {
		String limitation = "";
		try {
			Statement stmt = sut.getWorkflowDbConnector().actual().createStatement();
			String sqlQuery = "SELECT limitation FROM adserver.zones where zoneid =" + zoneId;
			ResultSet rs = stmt.executeQuery(sqlQuery);
			rs.next();
			sut.write(rs.getString(1));
			limitation = rs.getString(1).toString();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
			fail(e.getMessage());
		}
		return limitation;
	}
	
	public static void setLimitationForZone(Integer zoneId, String newLimitation) {
		try {
			Statement stmt = sut.getWorkflowDbConnector().actual().createStatement();
			String query = "UPDATE adserver.zones SET limitation ='" + newLimitation + "' WHERE zoneid='"
					+ zoneId + "';";
			sut.write(query);
			if (stmt.executeUpdate(query) != 1) {
				fail("update limitation in zone " + zoneId + " failed");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			fail(e.getMessage());
		}
	}
}