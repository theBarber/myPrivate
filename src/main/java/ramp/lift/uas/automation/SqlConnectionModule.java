package ramp.lift.uas.automation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import infra.module.AbstractModuleImpl;

/**
 * Created by AssafM on 10/01/2017.
 */
public class SqlConnectionModule extends AbstractModuleImpl<Connection> {

	private String url;
	private String user;
	private String password;

	public SqlConnectionModule(String dbUrl, String dbUser, String dbPassword) {
		super();
		url = dbUrl;
		user = dbUser;
		password = dbPassword;
	}

	@Override
	public void init() throws Exception {
		try {
			Connection conn = DriverManager.getConnection(url, user, password);
			setActual(conn);
		} catch (SQLException e) {
			throw e;
		}
	}

	@Override
	public void close() throws Exception {
		if (!actual().isClosed()) {
			try {
				actual().close();
			} catch (SQLException e) {
				throw e;
			}
		}
	}
}
