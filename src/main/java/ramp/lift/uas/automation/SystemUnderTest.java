package ramp.lift.uas.automation;

import static org.hamcrest.Matchers.isEmptyOrNullString;
import static org.hamcrest.Matchers.not;

import java.io.Closeable;
import java.io.File;
import java.io.IOException;
import java.io.UncheckedIOException;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Stream;

import org.junit.Assume;

import cucumber.api.Scenario;
import entities.CampaignManager;
import entities.HardCodedCampaignManager;
import entities.RampAppCampaignManager;
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
	protected final Map<String, LinuxDefaultCliConnection> uasCliConnections = new HashMap<>();
	protected final Map<String, UASLogModule> uasLogModulesByLogType = new HashMap<>();
	protected UASRequestModule uas;
	protected CampaignManager campaignManager;
	protected SqlConnectionModule rampAdminDbConnector;
	protected SqlConnectionModule workflowDbConnector;
	private static SystemUnderTest instance = null;
	public static final List<String> SETUP_CONF = Arrays.asList(System.getenv("SETUP_CONF").split(","));

	private ScenarioWriter scenarioWriter;

	private SystemUnderTest() {
		_o = 0;
	}

	public synchronized void setup(Scenario scenario, Map<String, String> config) {
		this.scenarioWriter = new ScenarioWriter(scenario);
		AtomicReference<RuntimeException> exception = new AtomicReference<>();
	scenario.getSourceTagNames().forEach(tag -> {
			switch (tag) {
	    case "@cli":
				if (uasCliConnections.isEmpty()) {
					setupCli(config, exception);
				}
				break;
	    case "@uas":
				if (uas == null) {
					try {
						uas = new UASRequestModule();
						uas.setHost(config.get("uas.host"));
						uas.setPort(config.get("uas.port"));
						uas.init();
					} catch (Exception e) {
						delegate(exception, e);
					}
				}
				break;

	    case "@campaign":
				if (campaignManager == null) {
		    if (scenario.getSourceTagNames().contains("@hardcoded")) {
						campaignManager = new HardCodedCampaignManager();
					} else {
						campaignManager = new RampAppCampaignManager(config.get("ramp.app.consul.host"),
								Integer.valueOf(config.get("ramp.app.consul.port")),
								config.get("ramp.test.lineItemId"));
					}
				}
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

	public synchronized void teardown(Collection<String> forTags, Map<String, String> config) {
		AtomicReference<RuntimeException> exception = new AtomicReference<>();
		SETUP_CONF.stream().forEach(tag -> {
			switch (tag) {
	    case "@cli":
				if (!uasCliConnections.isEmpty()) {
					teardownCli();
				}
				break;
	    case "@uas":
				if (uas != null) {
					try {
						uas.close();
					} catch (Exception e) {
						delegate(exception, e);
					}
				}
				break;
	    case "@campaign":
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
				break;

	    case "@ramp_admin_db":
				if (rampAdminDbConnector != null) {
					try {
						rampAdminDbConnector.close();
						rampAdminDbConnector = null;
					} catch (Exception e) {
						delegate(exception, e);
					}
				}
				break;

			case "@workflow_db":
				if (workflowDbConnector != null) {
					try {
						workflowDbConnector.close();
						workflowDbConnector = null;
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
		return campaignManager;
	}

	public SqlConnectionModule getRampAdminDbConnector() {
		return rampAdminDbConnector;
	}
	
	public SqlConnectionModule getWorkflowDbConnector() {
		return workflowDbConnector;
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