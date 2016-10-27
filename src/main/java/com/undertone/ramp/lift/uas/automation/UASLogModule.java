package com.undertone.ramp.lift.uas.automation;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Stream;

import com.undertone.automation.cli.conn.LinuxDefaultCliConnection;
import com.undertone.automation.module.AbstractModuleImpl;

public class UASLogModule extends AbstractModuleImpl<Stream<List<String>>> {
    private static final String LOGDIRECTORY = "/var/log/ut-ramp-uas/";
    private static final String SPLIT_BY_TAB = "\t";
    private final List<LinuxDefaultCliConnection> connections = new ArrayList<>();

    public UASLogModule(LinuxDefaultCliConnection connection, String logname) {
	this(Collections.singleton(connection), logname);
    }

    public UASLogModule(Collection<LinuxDefaultCliConnection> connections, String logname) {
	this.setName(logname);
	connections.addAll(connections);
    }

    public void readLogs() throws IOException {
	actual = new ArrayList<>();
	AtomicReference<IOException> exception = new AtomicReference<IOException>();
	connections.forEach(conn -> {
	    Optional<String> remoteFile;
	    try {
		remoteFile = conn.fileList(LOGDIRECTORY)
			.filter(s -> getName().equals(s.substring(LOGDIRECTORY.length(), getName().length())))
			.sorted(String.CASE_INSENSITIVE_ORDER.reversed()).findFirst();

		File tempFile = File.createTempFile("tmp", remoteFile.get());
		conn.get(remoteFile.get(), tempFile);

		Files.lines(Paths.get(tempFile.toURI())).forEach(line -> {
		    getactual().add(Arrays.asList(line.split(SPLIT_BY_TAB)));
		});
		tempFile.delete();
	    } catch (IOException e) {
		if (!exception.compareAndSet(null, e)) {
		    exception.updateAndGet(ioEx -> {
			ioEx.addSuppressed(e);
			return ioEx;
		    });
		}

	    }
	});
	if (exception.get() != null) {
	    throw exception.get();
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
