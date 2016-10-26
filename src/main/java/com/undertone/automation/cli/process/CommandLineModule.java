package com.undertone.automation.cli.process;

import com.undertone.automation.cli.conn.CliConnectionImpl;
import com.undertone.automation.module.AbstractModuleImpl;

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
