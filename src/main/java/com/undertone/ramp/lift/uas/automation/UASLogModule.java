package com.undertone.ramp.lift.uas.automation;

import java.io.File;
import java.io.IOException;
import java.io.UncheckedIOException;
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
import java.util.stream.Stream;

import com.undertone.automation.cli.conn.LinuxDefaultCliConnection;
import com.undertone.automation.module.AbstractModuleImpl;
import com.undertone.automation.module.Named;

public class UASLogModule extends AbstractModuleImpl<Stream<List<String>>> {
    private static final String LOGDIRECTORY = "/var/log/ut-ramp-uas/";
    private static final String SPLIT_BY_TAB = "\t";
    private final Set<LinuxDefaultCliConnection> connections = new TreeSet<>(Comparator.comparing(Named::getName));

    public UASLogModule(LinuxDefaultCliConnection connection, String logname) {
	this(Collections.singleton(connection), logname);
    }

    public UASLogModule(Collection<LinuxDefaultCliConnection> connections, String logname) {
	this.setName(logname);
	connections.forEach(this.connections::add);
    }

    public synchronized void readLogs() {
	actual = new ArrayList<>();

	AtomicReference<UncheckedIOException> exception = new AtomicReference<>();
	connections.forEach(conn -> {
	    Optional<String> remoteFile;
	    try {
		if (!conn.isConnected()) {
		    conn.connect();
		}
		remoteFile = conn.fileList(LOGDIRECTORY)
			.filter(s -> getName()
				.equals(s.substring(LOGDIRECTORY.length(), LOGDIRECTORY.length() + getName().length())))
			.sorted(String.CASE_INSENSITIVE_ORDER.reversed()).findFirst();

		remoteFile.ifPresent(remote -> {
		    File tempFile;
		    try {
			conn.get(remote,
				tempFile = File.createTempFile("tmp", remote.substring(LOGDIRECTORY.length())));
			Files.lines(Paths.get(tempFile.toURI())).forEach(line -> {
			    getactual().add(Arrays.asList(line.split(SPLIT_BY_TAB)));
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
    }

    public static <E extends Exception> void throwIfNeeded(AtomicReference<? extends E> ref) throws E {
	synchronized (ref) {
	    if (ref.get() != null) {
		throw ref.get();
	    }
	}
    }

    public static <E extends Exception> void delegate(AtomicReference<UncheckedIOException> ref, IOException cause) {
	synchronized (ref) {
	    if (ref.compareAndSet(null, new UncheckedIOException(cause))) {
		// the reference was empty
		// now it has one from the
		// remove this frame of this method of the stacktrace
		ref.updateAndGet(newEx -> {
		    newEx.setStackTrace(Arrays.copyOfRange(newEx.getStackTrace(), 1, newEx.getStackTrace().length));
		    return newEx;
		});
	    } else {
		ref.updateAndGet(newEx -> {
		    newEx.addSuppressed(cause);
		    return newEx;
		});
	    }
	}
    }

    @Override
    public Stream<List<String>> actual() {
	return getactual().stream();
    };

    @SuppressWarnings("unchecked")
    private Collection<List<String>> getactual() {
	return (Collection<List<String>>) actual;
    }
}
