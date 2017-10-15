package ramp.lift.uas.automation;

import static org.hamcrest.Matchers.isEmptyOrNullString;
import static org.hamcrest.Matchers.not;

import java.io.Closeable;
import java.io.File;
import java.io.IOException;
import java.io.UncheckedIOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Stream;

import entities.RampAppCreateCampaign;
import org.apache.http.client.protocol.HttpClientContext;
import org.junit.Assume;

import cucumber.api.Scenario;
import entities.CampaignManager;
import entities.HardCodedCampaignManager;
import gherkin.deps.com.google.gson.JsonArray;
import gherkin.deps.com.google.gson.JsonParser;
import infra.assertion.Assert;
import infra.assertion.ScenarioWriter;
import infra.cli.conn.CliConnection;
import infra.cli.conn.CliConnectionImpl.EnumConnectionType;
import infra.cli.conn.LinuxDefaultCliConnection;
import infra.cli.conn.RootLinuxCliConnection;
import infra.module.AbstractModuleImpl;
import infra.support.StringUtils;

public class SystemUnderTest extends AbstractModuleImpl<SystemUnderTest> implements Scenario {
	final int _o;
	private RampAppCreateCampaign rampAppCreateCampaign;
	protected final Map<String, LinuxDefaultCliConnection> uasCliConnections = new HashMap<>();
	protected final Map<String, UASLogModule> uasLogModulesByLogType = new HashMap<>();
	protected UASRequestModule uas;
	protected CampaignManager campaignManager;
	protected SqlConnectionModule rampAdminDbConnector;
	protected SqlConnectionModule workflowDbConnector;
	protected CouchbaseBucketModule userInfoBucket;
	protected CouchbaseBucketModule userHistoryBucket;
	private static SystemUnderTest instance = null;
	//public static final List<String> SETUP_CONF = Arrays.asList(System.getenv("SETUP_CONF").split(","));
	private Map<String, String> config;
	private ScenarioWriter scenarioWriter;
	private AtomicReference<RuntimeException> exception;
	
	private SystemUnderTest() {
		_o = 0;
	}

	public synchronized void setup(Scenario scenario, Map<String, String> config) {
		this.scenarioWriter = new ScenarioWriter(scenario);
		this.config = config;
		this.exception =  new AtomicReference<>();
	scenario.getSourceTagNames().forEach(tag -> {
			switch (tag) {
	    case "@cli":
				if (uasCliConnections.isEmpty()) {
					setupCli(config, exception);
				}
				break;
			case "@userinfo":
				if (userInfoBucket == null) {
					userInfoBucket = createCouchbaseBucketModule("user-info", config);
				}
				break;
			case "@userhistory":
				if (userHistoryBucket == null) {
					userHistoryBucket = createCouchbaseBucketModule("user-history", config);
			}
			break;
	    case "@uas":
				if (uas == null) {
					try {
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
						campaignManager = new HardCodedCampaignManager();
						break;
		case "@RampAppCreateCampaign":
				if(rampAppCreateCampaign == null)
						rampAppCreateCampaign = new RampAppCreateCampaign(config.get("ramp.app.host"),
										(config.get("ramp.app.port")));
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

		throwIfNeeded(exception);
	}

	private CouchbaseBucketModule createCouchbaseBucketModule(String name, Map<String, String> config) {
		String nodesParam = config.get(name + ".couchbase.nodes");
		JsonArray nodesConfig = new JsonParser().parse(nodesParam).getAsJsonArray();

		List<String> nodes = new ArrayList<>(nodesConfig.size());
		nodesConfig.forEach(jsonElement -> nodes.add(jsonElement.getAsString()));
		CouchbaseBucketModule module = new CouchbaseBucketModule(name, nodes);
		try {
			module.init();
		} catch (Exception e) {
			delegate(exception, e);
		}
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
				if (userInfoBucket !=null){
					try {
						userInfoBucket.close();
						userInfoBucket = null;
					} catch (Exception e) {
						delegate(exception, e);
					}
				}
				if (userHistoryBucket !=null){
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
				if(rampAppCreateCampaign != null)
				{
					try {
						AutoCloseable cm = (AutoCloseable) rampAppCreateCampaign;
						cm.close();
						cm = null;
					}
					catch (Exception e) {
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

	protected void setupCli(Map<String, String> config, AtomicReference<RuntimeException> exception) {
		String uasCliConnectionUser = config.get("uas.cliconnection.user");
		String uasCliConnectionPassword = config.getOrDefault("uas.cliconnection.password", null);
		String cliConnectionsHostsParam = config.get("uas.cliconnection.hosts");
		String cliconnectionKeyname = config.getOrDefault("uas.cliconnection.keyname", "");
		JsonArray hostsConfig = new JsonParser().parse(cliConnectionsHostsParam).getAsJsonArray();
		File keyFile = Optional.of(cliconnectionKeyname).filter(StringUtils.nonEmpty)
				.map(filename -> new File(new File(System.getProperty("user.home"), ".ssh"), filename)).orElse(null);
		// InputStream keyFile =
		// ClassLoader.class.getResourceAsStream(cliconnectionKeyname);
		// File keyFile = new
		// File(ClassLoader.class.getResource(cliconnectionKeyname).toString());

		hostsConfig.forEach(jsonElement -> {
			String host = jsonElement.getAsString();
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

			uasCliConnections.put(host, conn);
		});
		uasCliConnections.values().forEach(conn -> {
			try {
				conn.init();
			} catch (IOException cause) {
				delegate(exception, cause);
			}
		});

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

	public UASLogModule logFor(String logType) {
		return uasLogModulesByLogType.computeIfAbsent(logType, logname -> {
			UASLogModule logModule = new UASLogModule(uasCliConnections.values(), logname);
			logModule.init();
			return logModule;
		});
	}


	public CampaignManager getCampaignManager() {
	  if (campaignManager == null) {
                    campaignManager = new HardCodedCampaignManager();
	  }
		return campaignManager;
	}

	public RampAppCreateCampaign getRampAppCreateCampaign() {
		if(rampAppCreateCampaign == null)
		{
			rampAppCreateCampaign =  new RampAppCreateCampaign(config.get("ramp.app.host"),
										(config.get("ramp.app.port")));
		}
		return rampAppCreateCampaign;
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
		if(userInfoBucket == null){
			userInfoBucket =  createCouchbaseBucketModule("user-info", config);
		}
		return userInfoBucket;
	}

	public CouchbaseBucketModule getUserHistoryBucket() {
		if(userHistoryBucket == null){
			userHistoryBucket =  createCouchbaseBucketModule("user-history", config);
		}
		return userHistoryBucket;
	}

	@Override
	public void init() throws Exception {
		super.init();
	}

	public SystemUnderTest actual() {
		return this;
	};

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

	@Override
	public Collection<String> getSourceTagNames() {
		return scenarioWriter.getSourceTagNames();
	}

	@Override
	public String getStatus() {
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
	public void write(String text) {
		scenarioWriter.write(text);

	}

	@Override
	public String getId() {
		return scenarioWriter.getId();
	}
}
