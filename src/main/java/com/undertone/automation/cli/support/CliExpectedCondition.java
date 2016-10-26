package com.undertone.automation.cli.support;

import java.util.function.Function;

import com.undertone.automation.cli.conn.CliConnection;

public interface CliExpectedCondition<T> extends Function<CliConnection, T> {

}
