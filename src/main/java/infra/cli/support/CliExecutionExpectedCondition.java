package infra.cli.support;

import java.util.function.Function;

import infra.cli.process.CliCommandExecution;

public interface CliExecutionExpectedCondition<T> extends Function<CliCommandExecution, T> {

}
