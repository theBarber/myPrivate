package com.undertone.ramp.lift.uas.automation;

import static com.undertone.ramp.lift.uas.automation.SystemUnderTest.delegate;
import static com.undertone.ramp.lift.uas.automation.SystemUnderTest.throwIfNeeded;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.TreeSet;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.Predicate;
import java.util.stream.Stream;

import com.undertone.automation.cli.conn.LinuxDefaultCliConnection;
import com.undertone.automation.module.AbstractModuleImpl;
import com.undertone.automation.module.Named;

public class UASLogModule extends AbstractModuleImpl<Stream<List<String>>> {
    private static final String LOGDIRECTORY = "/var/log/ut-ramp-uas/";
    private static final String SPLIT_BY_TAB = "\t";
    private final Set<LinuxDefaultCliConnection> connections = new TreeSet<>(Comparator.comparing(Named::getName));
    private Predicate<List<String>> filter;

    public UASLogModule(LinuxDefaultCliConnection connection, String logname) {
	this(Collections.singleton(connection), logname);
    }

    public UASLogModule(Collection<LinuxDefaultCliConnection> connections, String logname) {
	this.setName(logname);
	connections.forEach(this.connections::add);
    }

    @Override
    public void init() {
	actual = new ArrayList<>();
    }

    @Override
    public void close() {
	actual = new ArrayList<>();
    }

    public UASLogModule filter(int column, String value) {
	return this.filter(l -> l.get(column).equals(value));
    }

    public UASLogModule filter(Predicate<List<String>> filter) {
	this.filter = filter;
	return this;
    }

    public synchronized UASLogModule readLogs() {
	_actual().clear();
	AtomicReference<RuntimeException> exception = new AtomicReference<>();
	connections.forEach(conn -> {
	    try {
		if (!conn.isConnected()) {
		    conn.init();
		    conn.connect();
		}
		conn.fileList(LOGDIRECTORY)
			.filter(s -> getName()
				.equals(s.substring(LOGDIRECTORY.length(), LOGDIRECTORY.length() + getName().length())))
			.sorted(String.CASE_INSENSITIVE_ORDER.reversed()).limit(3).forEach(remote -> {
			    File tempFile;
			    try {
				conn.get(remote,
					tempFile = File.createTempFile("tmp", remote.substring(LOGDIRECTORY.length())));
				Files.lines(Paths.get(tempFile.toURI())).forEach(line -> {
				    _actual().add(Arrays.asList(line.split(SPLIT_BY_TAB)));
				});
				tempFile.delete();
			    } catch (IOException e) {
				delegate(exception, e);
			    }
			});
	    } catch (IOException e) {
		delegate(exception, e);
	    }
	});
	throwIfNeeded(exception);
	return this;
    }

    @Override
    public Stream<List<String>> actual() {
	return _actual().stream().filter(Optional.ofNullable(filter).orElse(l -> !l.isEmpty()));
    };

    @SuppressWarnings("unchecked")
    private Collection<List<String>> _actual() {
	return (Collection<List<String>>) actual;
    }
}
