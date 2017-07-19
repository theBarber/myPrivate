package ramp.lift.uas.automation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Optional;

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
    Optional.ofNullable(actual()).filter(c -> {
      try {
        return !c.isClosed();
      } catch (SQLException e) {
        return false;
      }
    }).ifPresent(c -> {
      try {
        c.close();
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    });

  }
}
