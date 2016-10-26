package com.undertone.automation.cli.support;

import java.util.function.Function;

import com.undertone.automation.cli.process.CliCommandExecution;

public interface CliExecutionExpectedCondition<T> extends Function<CliCommandExecution, T> {

}
