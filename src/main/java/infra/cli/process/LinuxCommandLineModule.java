package infra.cli.process;

import infra.cli.conn.LinuxDefaultCliConnection;

public class LinuxCommandLineModule extends CommandLineModule {
    protected LinuxDefaultCliConnection linux;

    @Override
    public void init() throws Exception {
	super.init();
	linux = (LinuxDefaultCliConnection) cliConnectionImpl;
	// casting exception is good!!! misuse of this class will cause it!!
    }
}
