package ramp.lift.uas.automation;

import static ramp.lift.uas.automation.SystemUnderTest.delegate;
import static ramp.lift.uas.automation.SystemUnderTest.throwIfNeeded;

import java.io.File;
import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.Predicate;
import java.util.stream.Stream;

import infra.cli.conn.LinuxDefaultCliConnection;
import infra.module.AbstractModuleImpl;
import infra.module.Named;

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
        AtomicReference<RuntimeException> exception = new AtomicReference<>();
        connections.forEach(connection -> {
            try {
                connection.init();
            } catch (Exception e) {
                delegate(exception, e);
            }
        });
        throwIfNeeded(exception);

    }

    @Override
    public void close() {
        actual = new ArrayList<>();
        AtomicReference<RuntimeException> exception = new AtomicReference<>();

        connections.forEach(connection -> {
            try {
                connection.close();
            } catch (Exception e) {
                delegate(exception, e);
            }
        });
        throwIfNeeded(exception);
    }

    public UASLogModule filter(int column, String value) {
        return this.filter(l -> l.get(column).equals(value));
    }

    public UASLogModule filter(Predicate<List<String>> filter) {
        this.filter = filter;
        return this;
    }

    public synchronized UASLogModule deleteLogFiles(String fileName, boolean multiDeletion) {

        String multi = "";
        AtomicReference<RuntimeException> exception = new AtomicReference<>();
        if (multiDeletion) {
            multi = "*";
        }
        String file2Del = LOGDIRECTORY + fileName + multi;
        connections.forEach(conn -> {
            try {
                if (!conn.isConnected()) {
                    conn.connect();
                }
            conn.deleteFiles(file2Del);
            }
            catch (IOException ioEx){
                delegate(exception,ioEx);
            }
        });
        return this;
    }



    public synchronized UASLogModule readLogs() {
        _actual().clear();
        AtomicReference<RuntimeException> exception = new AtomicReference<>();
        connections.forEach(conn -> {
            try {
                if (!conn.isConnected()) {
                    conn.connect();
                }
                conn.fileList(LOGDIRECTORY) //taking all the wanted type files (such as reg file)
                                .filter(s ->getName() //get name = (req\imp\clk)
                                .equals(s.substring(LOGDIRECTORY.length(), LOGDIRECTORY.length() + getName().length()))) // getting just those who are (req\imp\clk)
                        .sorted(String.CASE_INSENSITIVE_ORDER.reversed()).limit(3).forEach(remote -> { //remote = remote file name
                    File tempFile;
                    try {
                        conn.get(remote,
                                tempFile = File.createTempFile("tmp", remote.substring(LOGDIRECTORY.length())));
                        Files.lines(Paths.get(tempFile.toURI()), StandardCharsets.ISO_8859_1).forEach(line -> { //reading all the lines
                            _actual().add(Arrays.asList(line.split(SPLIT_BY_TAB))); //adding the lines to list inside this object
                        });
                        tempFile.delete();
                    } catch (IOException e) {
                        delegate(exception, e);
                    }catch (UncheckedIOException e)
                    {
                        e.printStackTrace();
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
        //sahar check: printing the file-----------------------------
//                _actual().stream().filter(Optional.ofNullable(filter).orElse(l -> !l.isEmpty())).forEach(m-> System.out.println(m));
        //-----------------------------------------
        return _actual().stream().filter(Optional.ofNullable(filter).orElse(l -> !l.isEmpty()));
    }



    @SuppressWarnings("unchecked")
    public Collection<List<String>> _actual() {
        return (Collection<List<String>>) actual;
    }
}
