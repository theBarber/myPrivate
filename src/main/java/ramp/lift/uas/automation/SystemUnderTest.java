package ramp.lift.uas.automation;

import cucumber.api.Result;
import cucumber.api.Scenario;
import entities.CampaignManager;
import entities.ExecutorCampaignManager;
import gherkin.deps.com.google.gson.JsonArray;
import gherkin.deps.com.google.gson.JsonParser;
import infra.assertion.Assert;
import infra.assertion.ScenarioWriter;
import infra.cli.conn.CliConnection;
import infra.cli.conn.CliConnectionImpl.EnumConnectionType;
import infra.cli.conn.LinuxDefaultCliConnection;
import infra.cli.conn.RootLinuxCliConnection;
import infra.cli.process.CliCommandExecution;
import infra.module.AbstractModuleImpl;
import infra.support.StringUtils;
import infra.utils.CouchBaseUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.client.protocol.HttpClientContext;
import org.junit.Assume;
import ramp.lift.uas.automation.UAScontainer.Builder;

import java.io.Closeable;
import java.io.File;
import java.io.IOException;
import java.io.UncheckedIOException;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Stream;

import static org.hamcrest.Matchers.isEmptyOrNullString;
import static org.hamcrest.Matchers.not;

@Slf4j
public class SystemUnderTest extends AbstractModuleImpl<SystemUnderTest> implements Scenario {
    final int _o;
    private RampAppRequestModule rampAppCreateEntitiesManager;
    protected final Map<String, LinuxDefaultCliConnection> uasCliConnections = new HashMap<>();
    protected final Map<String, LinuxDefaultCliConnection> uasHostConnections = new HashMap<>();
    protected final Map<String, LinuxDefaultCliConnection> cronCliConnection = new HashMap<>();
    protected final Map<String, UASLogModule> uasLogModulesByLogType = new HashMap<>();
    protected UASRequestModule uas;
    //protected CIRequestModule ci;
    protected UAScontainer uasKubeMachines;
    protected CampaignManager campaignManager;
    protected ExecutorCampaignManager executorCampaignManager;
    protected SqlConnectionModule rampAdminDbConnector;
    protected SqlConnectionModule workflowDbConnector;
    protected CouchbaseBucketModule userInfoBucket;
    protected CouchbaseBucketModule userHistoryBucket;
    protected CouchbaseBucketModule adserverBucket;
    protected CouchbaseBucketModule usersBucket;
    protected CouchbaseBucketModule usersLogsBucket;
    protected CouchBaseUtils couchBaseUtils;
    private static SystemUnderTest instance = null;
    //public static final List<String> SETUP_CONF = Arrays.asList(System.getenv("SETUP_CONF").split(","));
    private Map<String, String> config;
    private RampAppPublisherRequestModule rampAppPublisherModule;

    public Map<String, String> getConfigFile() {
        return config;
    }

    private ScenarioWriter scenarioWriter;
    private AtomicReference<RuntimeException> exception;

    private SystemUnderTest() {
        _o = 0;
    }

    public synchronized void setup(Scenario scenario, Map<String, String> config) {
        this.scenarioWriter = new ScenarioWriter(scenario) {
            @Override
            public String getUri() {
                return null;
            }

            @Override
            public List<Integer> getLines() {
                return null;
            }
        };
        this.config = config;
        this.exception = new AtomicReference<>();
        scenario.getSourceTagNames().forEach(tag -> {
            switch (tag) {
                case "@cli":
                    if (uasCliConnections.isEmpty()) {
                        setupCli(config, exception);
                    }
                    break;
                case "@userinfo":
                    if (userInfoBucket == null) {
                        userInfoBucket = createCouchbaseBucketModule("us-east-1-users", config);
                    }
                    break;
                case "@userhistory":
                    if (userHistoryBucket == null) {
                        userHistoryBucket = createCouchbaseBucketModule("us-east-1-users", config);
                    }
                    break;
                case "@adserverBucket":
                    if (adserverBucket == null) {
                        adserverBucket = createCouchbaseBucketModule("us-east-1-adserver", config);
                    }
                    break;
                case "@couchBaseUtil":
                    if (couchBaseUtils == null) {
                        couchBaseUtils = new CouchBaseUtils(config.get("couchbase.host"), config.get("couchbase.port"), config.get("couchbase.user"), config.get("couchbase.password"));
                    }
                case "@usersBucket":
                    if (usersBucket == null) {
                        usersBucket = createCouchbaseBucketModule("us-east-1-users", config);
                    }
                    break;
                case "@uas":
                    if (uas == null) {
                        try {
                            UAScontainer.Builder builder = new Builder();
                            uasKubeMachines = builder.setConfig(config.get("uas.k8s.path.config")).build();
                            uas = new UASRequestModule();
                            //uas.setDomain(config.get("uas.host"));
                            uas.setDomain(config.get("uas.domain"));
                            uas.setPort(config.get("uas.port"));
                            uas.init();
                        } catch (Exception e) {
                            delegate(exception, e);
                        }
                    }
                    break;

                case "@campaign":
                    if (campaignManager == null)
                        campaignManager = new CampaignManager(config.get("env.name"), config.get("append.entities"));
                    break;
                case "@RampAppRequestModule":
                    if (rampAppCreateEntitiesManager == null)
                        rampAppCreateEntitiesManager = new RampAppRequestModule(config.get("ramp.io.host"),
                                (config.get("ramp.io.port")));
                    if (rampAppPublisherModule == null)
                        rampAppPublisherModule = new RampAppPublisherRequestModule(config.get("ramp.publisher"),
                                (config.get("ramp.io.port")));
                    break;
                case "@ramp_admin_db":
                    if (rampAdminDbConnector == null) {
                        rampAdminDbConnector = new SqlConnectionModule(config.get("ramp.admin.db.jdbc.connection"),
                                config.get("ramp.admin.db.user"),
                                config.get("ramp.admin.db.password"));
                        try {
                            rampAdminDbConnector.init();
                        } catch (Exception e) {
                            delegate(exception, e);
                        }
                    }
                    break;

                case "@workflow_db":
                    if (workflowDbConnector == null) {
                        workflowDbConnector = new SqlConnectionModule(config.get("workflow.db.jdbc.connection"),
                                config.get("workflow.db.user"), config.get("workflow.db.password"));
                        try {
                            workflowDbConnector.init();
                        } catch (Exception e) {
                            delegate(exception, e);
                        }
                    }
                    break;
                default:
                    break;
            }
        });
        //Properties prop = new Properties();
        //try {
        //	BufferedReader in = new BufferedReader(new FileReader(PROP_PATH));
        //	prop.load(in);
        //	in.close();
        //} catch (IOException e) {
        //	org.junit.Assert.fail(e.getMessage());
        //}
        //AWSCredentials s3Credential = new BasicAWSCredentials(prop.getProperty("s3_access_key"),
        //		prop.getProperty("s3_secret_key"));

        //AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(s3Credential);
        //ec2 = AmazonEC2ClientBuilder.standard().withRegion(prop.getProperty("s3_region")).withCredentials(credentialsProvider).build();
        throwIfNeeded(exception);
    }

    private CouchbaseBucketModule createCouchbaseBucketModule(String name, Map<String, String> config) {
        String nodesParam = config.get("couchbase.nodes");
        JsonArray nodesConfig = new JsonParser().parse(nodesParam).getAsJsonArray();

        List<String> nodes = new ArrayList<>(nodesConfig.size());
        nodesConfig.forEach(jsonElement -> nodes.add(jsonElement.getAsString()));
        CouchbaseBucketModule module = new CouchbaseBucketModule(name, nodes);
        module.init();
        return module;
    }

    public HttpClientContext getContext() {
        return uas.getContext();
    }

    public synchronized void teardown(Collection<String> forTags, Map<String, String> config) {
        AtomicReference<RuntimeException> exception = new AtomicReference<>();
//		SETUP_CONF.stream().forEach(tag -> {
//			switch (tag) {
//	    case "@cli":
        if (!uasCliConnections.isEmpty()) {
            teardownCli();
        }
        if (userInfoBucket != null) {
            try {
                userInfoBucket.close();
                userInfoBucket = null;
            } catch (Exception e) {
                delegate(exception, e);
            }
        }
        if (userHistoryBucket != null) {
            try {
                userHistoryBucket.close();
                userHistoryBucket = null;
            } catch (Exception e) {
                delegate(exception, e);
            }
        }
//				break;
//	    case "@uas":
        if (uas != null) {
            try {
                uas.close();
                //uasKubeMachines.close();
            } catch (Exception e) {
                delegate(exception, e);
            }
        }
//				break;
//	    case "@campaign":
        if (campaignManager != null) {
            try {
                if (campaignManager instanceof Closeable) {
                    Closeable cm = (Closeable) campaignManager;
                    cm.close();
                    cm = null;
                }
            } catch (IOException e) {
                delegate(exception, e);
            }
        }
//				break;
        if (executorCampaignManager != null) {
            try {
                if (executorCampaignManager instanceof Closeable) {
                    Closeable ecm = (Closeable) executorCampaignManager;
                    ecm.close();
                    ecm = null;
                }
            } catch (IOException e) {
                delegate(exception, e);
            }
        }
//	    case "@ramp_admin_db":
        if (rampAdminDbConnector != null) {
            try {
                rampAdminDbConnector.close();
                rampAdminDbConnector = null;
            } catch (Exception e) {
                delegate(exception, e);
            }
        }
//				break;

//			case "@workflow_db":
        if (workflowDbConnector != null) {
            try {
                workflowDbConnector.close();
                workflowDbConnector = null;
            } catch (Exception e) {
                delegate(exception, e);
            }
        }
        if (rampAppCreateEntitiesManager != null) {
            try {
                AutoCloseable cm = (AutoCloseable) rampAppCreateEntitiesManager;
                cm.close();
                cm = null;
                rampAppCreateEntitiesManager = null;
            } catch (Exception e) {
                delegate(exception, e);
            }
        }
//				break;
//			default:
//				break;
//			}

//		});

        throwIfNeeded(exception);
        if (scenarioWriter != null) {
            synchronized (this) {
                try {
                    scenarioWriter.flush();
                    scenarioWriter.close();
                } catch (IOException cause) {
                    throw new UncheckedIOException(cause);
                } finally {
                    scenarioWriter = null;
                }
            }
        }
    }

    public Stream<LinuxDefaultCliConnection> uasCliConnections() {
        if (uasCliConnections.isEmpty()) {
            setupCli(config, exception);
        }
        return this.uasCliConnections.values().stream();
    }

    public Map<String, LinuxDefaultCliConnection> getUasCliConnections() {
        if (uasCliConnections.isEmpty()) {
            setupCli(config, exception);
        }
        return this.uasCliConnections;
    }

    public Map<String, LinuxDefaultCliConnection> getCronCliConnection() {
        if (cronCliConnection.isEmpty()) {
            setupCli(config, exception);
        }
        return this.cronCliConnection;
    }

    public Map<String, LinuxDefaultCliConnection> getHostsConnection() {
        if (uasHostConnections.isEmpty()) {
            setupCli(config, exception);
        }
        return this.uasHostConnections;
    }


    public CouchBaseUtils getCouchBaseUtils() {
        if (couchBaseUtils == null) {
            couchBaseUtils = new CouchBaseUtils(config.get("couchbase.host"), config.get("couchbase.port"), config.get("couchbase.user"), config.get("couchbase.password"));
        }
        return this.couchBaseUtils;
    }


    protected void setupCli(Map<String, String> config, AtomicReference<RuntimeException> exception) {
//		String cliConnectionsHostsParam = null;
//		DescribeAddressesResult response = ec2.describeAddresses(new DescribeAddressesRequest().withFilters((new Filter("App").withValues("uas")),(new Filter("Environment").withValues("staging"))));
//		for (Address address : response.getAddresses()){
//			cliConnectionsHostsParam += address.getPrivateIpAddress();
//		}
        String cliConnectionsHostsParam = config.get("uas.cliconnection.hosts");
        String cliconnectionKeyname = config.getOrDefault("uas.cliconnection.keyname", "");
        String cliconnectionCron = config.getOrDefault("uas.cliconnection.cron", "");

        JsonArray hostsConfig = new JsonParser().parse(cliConnectionsHostsParam).getAsJsonArray();
        JsonArray cronsConfig = new JsonParser().parse(cliconnectionCron).getAsJsonArray();
        File keyFile = Optional.of(cliconnectionKeyname).filter(StringUtils.nonEmpty)
                .map(filename -> new File(new File(System.getProperty("user.home"), ".ssh"), filename))
                .orElse(null);

        if (config.get("is.remote").equals("true")) {
            keyFile = new File("perion-automation/pems/" + cliconnectionKeyname);
        }

        File finalKeyFile = keyFile;
        hostsConfig.forEach(jsonElement -> {
            String host = jsonElement.getAsString();
            LinuxDefaultCliConnection conn = getConnection(host, finalKeyFile);
            uasHostConnections.put(host, conn);
            uasCliConnections.put(host, conn);
        });

        cronsConfig.forEach(jsonElement -> {
            String host = jsonElement.getAsString();
            LinuxDefaultCliConnection conn = getConnection(host, finalKeyFile);
            cronCliConnection.put(host, conn);
            uasCliConnections.put(host, conn);
        });

        //for all connections
        uasCliConnections.values().forEach(conn -> {
            try {
                conn.init();
            } catch (IOException cause) {
                delegate(exception, cause);
            }
        });
    }

    private LinuxDefaultCliConnection getConnection(String host, File keyFile) {
        String uasCliConnectionUser = config.get("uas.cliconnection.user");
        String uasCliConnectionPassword = config.getOrDefault("uas.cliconnection.password", null);
        LinuxDefaultCliConnection conn;

        if (uasCliConnectionUser.equals("root")) {
            conn = new RootLinuxCliConnection();
        } else {
            conn = new LinuxDefaultCliConnection();
        }

        conn.setHost(host);
        conn.setUser(uasCliConnectionUser);
        conn.setPassword(uasCliConnectionPassword);
        conn.setConnectOnInit(false);
        conn.setUseThreads(true);

        if (keyFile != null) {
            Assert.assertThat("the file " + keyFile.getAbsolutePath(), keyFile,
                    org.hamcrest.io.FileMatchers.anExistingFile());
            Assert.assertThat("the file " + keyFile.getAbsolutePath(), keyFile,
                    org.hamcrest.io.FileMatchers.aReadableFile());
            conn.setPrivateKey(keyFile);
            conn.setProtocol(EnumConnectionType.SSH_RSA.value());
        } else {
            Assume.assumeThat("connection to " + host + " password is not set", conn.getPassword(),
                    not(isEmptyOrNullString()));
        }

        return conn;

    }

    protected void teardownCli() {
        uasCliConnections.values().forEach(CliConnection::disconnect);
        uasCliConnections.clear();
        uasLogModulesByLogType.forEach((log, module) -> module.close());
        uasLogModulesByLogType.clear();
    }

    public UASRequestModule getUASRquestModule() {
        if (uas == null) {
            try {
                uas = new UASRequestModule();
                uas.setDomain(config.get("uas.domain"));
                uas.setPort(config.get("uas.port"));
                uas.init();
            } catch (Exception e) {
                delegate(exception, e);
            }
        }
        return this.uas;
    }

    public UAScontainer getUasKubeMachines() {
        return uasKubeMachines;
    }

    //public CIRequestModule getCIRquestModule() {
    //	if (ci == null) {
    //		try {
    //			ci = new CIRequestModule();
    //			ci.setDomain(config.get("ci.domain"));
    //			ci.setWfdomain(config.get("ci.wfdomain"));
    //			ci.setPort(config.get("ci.port"));
    //			ci.init();
    //		} catch (Exception e) {
    //			delegate(exception, e);
    //		}
    //	}
    //	return this.ci;
    //}

    public UASLogModule logFor(String logType) {
        return uasLogModulesByLogType.computeIfAbsent(logType, logname -> {
            UASLogModule logModule = new UASLogModule(uasHostConnections.values(), logname);
            logModule.init();
            return logModule;
        });
    }


    public CampaignManager getCampaignManager() {
        if (campaignManager == null) {
            campaignManager = new CampaignManager(config.get("env.name"), config.get("append.entities"));
        }
        return campaignManager;
    }

    public ExecutorCampaignManager getExecutorCampaignManager() {
        if (executorCampaignManager == null) {
            executorCampaignManager = new ExecutorCampaignManager(config.get("env.name"));
        }
        return executorCampaignManager;
    }

    public RampAppRequestModule getRampAppRequestModule() {
        if (rampAppCreateEntitiesManager == null) {
            rampAppCreateEntitiesManager = new RampAppRequestModule(config.get("ramp.io.host"),
                    (config.get("ramp.io.port")));
        }
        return rampAppCreateEntitiesManager;
    }

    public RampAppPublisherRequestModule getRampAppPublisherRequestModule() {
        if (rampAppPublisherModule == null) {
            rampAppPublisherModule = new RampAppPublisherRequestModule(config.get("ramp.publisher"),
                    (config.get("ramp.io.port")));
        }
        return rampAppPublisherModule;
    }


    public SqlConnectionModule getRampAdminDbConnector() {
        if (rampAdminDbConnector == null) {
            rampAdminDbConnector = new SqlConnectionModule(config.get("ramp.admin.db.jdbc.connection"),
                    config.get("ramp.admin.db.user"),
                    config.get("ramp.admin.db.password"));
            try {
                rampAdminDbConnector.init();
            } catch (Exception e) {
                delegate(exception, e);
            }
        }
        return rampAdminDbConnector;
    }

    public SqlConnectionModule getWorkflowDbConnector() {
        if (workflowDbConnector == null) {
            workflowDbConnector = new SqlConnectionModule(config.get("workflow.db.jdbc.connection"),
                    config.get("workflow.db.user"), config.get("workflow.db.password"));
            try {
                workflowDbConnector.init();
            } catch (Exception e) {
                delegate(exception, e);
            }
        }
        return workflowDbConnector;
    }


    public CouchbaseBucketModule getUserInfoBucket() {
        if (userInfoBucket == null) {
            userInfoBucket = createCouchbaseBucketModule("us-east-1-user-info", config);
        }
        return userInfoBucket;
    }


    public CouchbaseBucketModule getUserHistoryBucket() {
        if (userHistoryBucket == null) {
            userHistoryBucket = createCouchbaseBucketModule("us-east-1-user-history", config);
        }
        return userHistoryBucket;
    }

    public CouchbaseBucketModule getAdserverBucket() {
        if (adserverBucket == null) {
            adserverBucket = createCouchbaseBucketModule("us-east-1-adserver", config);
        }
        return adserverBucket;
    }

    public CouchbaseBucketModule getUsersBucket() {
        if (usersBucket == null) {
            usersBucket = createCouchbaseBucketModule("us-east-1-users", config);
        }
        return usersBucket;
    }

    public CouchbaseBucketModule getUsersLogsBucket() {
        if (usersLogsBucket == null) {
            usersLogsBucket = createCouchbaseBucketModule("us-east-1-user_logs", config);
        }
        return usersLogsBucket;
    }

    @Override
    public void init() throws Exception {
        super.init();
    }

    public SystemUnderTest actual() {
        return this;
    }

    ;

    public static SystemUnderTest getInstance() {
        if (instance == null) {
            // Thread Safe. Might be costly operation in some case
            synchronized (SystemUnderTest.class) {
                if (instance == null) {
                    instance = new SystemUnderTest();
                }
            }
        }
        return instance;
    }

    public static <E extends Exception> void delegate(AtomicReference<RuntimeException> ref, E cause) {
        synchronized (ref) {
            if (ref.compareAndSet(null, new RuntimeException(cause))) {
                // the reference was empty
                // now it has one from this line above
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

    public static <E extends Exception> void throwIfNeeded(AtomicReference<? extends E> ref) throws E {
        synchronized (ref) {
            if (ref.get() != null) {
                throw ref.get();
            }
        }
    }

    public String getProgrammaticHost() {
        return config.get("programmatic.host") + Optional.ofNullable(config.get("programmatic.port")).filter(s -> !s.isEmpty()).map(s -> ":" + s).orElse("");
    }

    public void cmd(String cmd, String error) {
        this.getHostsConnection().forEach((host, conn) -> {
            try {
                this.write("********************************************************************");
                CliCommandExecution command = new CliCommandExecution(conn, cmd).error(error)
                        .withTimeout(3, TimeUnit.MINUTES);
                command.execute();
            } catch (IOException e) {
                throw new UncheckedIOException(e);
            }

        });
    }

    @Override
    public Collection<String> getSourceTagNames() {
        return scenarioWriter.getSourceTagNames();
    }

    @Override
    public Result.Type getStatus() {
        return scenarioWriter.getStatus();
    }

    @Override
    public boolean isFailed() {
        return scenarioWriter.isFailed();
    }

    @Override
    public void embed(byte[] data, String mimeType) {
        scenarioWriter.embed(data, mimeType);
    }

    @Override
    public synchronized void write(String text) {
        scenarioWriter.write(text);
    }

    @Override
    public String getId() {
        return scenarioWriter.getId();
    }

    @Override
    public String getUri() {
        return null;
    }

    @Override
    public List<Integer> getLines() {
        return null;
    }
}
