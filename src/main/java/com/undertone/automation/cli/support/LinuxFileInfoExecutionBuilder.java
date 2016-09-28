package com.undertone.automation.cli.support;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.undertone.automation.assertion.ComparableAssertion;
import com.undertone.automation.cli.conn.CliConnection;
import com.undertone.automation.cli.process.CliCommandExecution;
import com.undertone.automation.support.CompareMethod;
import com.undertone.automation.support.Formatter;
import com.undertone.automation.support.Parser;

public class LinuxFileInfoExecutionBuilder {

	String name = "";
	private final CliConnection cliConnection;

	private ResultType resultType = ResultType.FileSize;

	public LinuxFileInfoExecutionBuilder(CliConnection cliConnection, String fileName) {
		super();
		this.cliConnection = cliConnection;
		this.name = fileName;
	}

	LinuxFileInfoExecutionBuilder named(String name) {
		this.name = name;
		return this;
	}

	public CliCommandExecution build() {
		if (name.length() == 0)
			throw new IllegalStateException("file name is not set");
		return new CliCommandExecution(cliConnection, "ls -l --time-style=full-iso " + this.name
				+ " | grep -v '^total' | awk {'print " + resultType.awkPrint + "'}").error("No such file or directory").error(
				"cannot access");
	}

	public LinuxFileInfoExecutionBuilder getFileSize() {
		this.resultType = ResultType.FileSize;
		return this;
	}

	public LinuxFileInfoExecutionBuilder getFileDate() {
		this.resultType = ResultType.FileSize;
		return this;
	}

//	public CliExecutionExpectedCondition<Long> fileSizeToBe(CompareMethod compareMethod, long expectedSize) {
//		getFileSize();
//		return execute(resultType, expectedSize, compareMethod);
//	}
//
//	private CliExecutionExpectedCondition<Long> execute(final ResultType resultType, final long expected,
//			final CompareMethod compareMethod) {
//		StringBuilder examinedObjectName = new StringBuilder("file ");
//		examinedObjectName.append(name).append(" ");
//		examinedObjectName.append(resultType.name());
//		return executionLogicHappens(
//				new ComparableAssertion<>(compareMethod, expected).examinedObjectTitled(examinedObjectName.toString())
//						.formatObjectWith(resultType)
//
//				, resultType.parser);
//
//	}

	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS Z");

	public enum ResultType implements Formatter<Long> {
		FileDate("$6,$7,$8", new Parser<Long>() {
			@Override
			public Long parse(String s) throws ParseException {
				Date actual = dateFormat.parse(s);
				return actual.getTime();
			}

		}) {
			@Override
			public String toString(Long l) {
				return dateFormat.format(l);
			}

			@Override
			public String toString() {
				return "date";
			}
		},

		FileSize("$5", new Parser<Long>() {
			@Override
			public Long parse(String s) {
				long actual = Long.parseLong(s);
				return actual;
			}
		}) {
			@Override
			public String toString(Long l) {
				return Long.toString(l);
			}

			@Override
			public String toString() {
				return "size";
			}
		};

		final String awkPrint;
		final Parser<Long> parser;

		ResultType(final String awkPrint, final Parser<Long> parser) {
			this.awkPrint = awkPrint;
			this.parser = parser;
		}

		public Parser<Long> getParser() {
			return parser;
		}
	}
}
