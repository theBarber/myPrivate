package infra.cli.support;

import java.util.function.Function;

import infra.cli.conn.CliConnection;

public interface CliExpectedCondition<T> extends Function<CliConnection, T> {

}
