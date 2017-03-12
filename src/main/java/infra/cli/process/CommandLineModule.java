package infra.cli.process;

import infra.cli.conn.CliConnectionImpl;
import infra.module.AbstractModuleImpl;

public class CommandLineModule extends AbstractModuleImpl<String> {

    protected CliConnectionImpl cliConnectionImpl;

    public CliCommandExecution executer() {
	return new CliCommandExecution(cliConnectionImpl);
    }

    public CliConnectionImpl getCliConnectionImpl() {
	return cliConnectionImpl;
    }

    public void setCliConnectionImpl(CliConnectionImpl cliConnectionImpl) {
	this.cliConnectionImpl = cliConnectionImpl;
    }

}
