package infra.cli.conn;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import infra.cli.terminal.Prompt;
import infra.support.StringUtils;

public class RootLinuxCliConnection extends LinuxDefaultCliConnection {

    private String suUser = "";

    @Override
    public Prompt[] getPrompts() {
	List<Prompt> prompts = new ArrayList<>();
	prompts.addAll(Arrays.asList(super.getPrompts()));

	Prompt rootPrompt = new Prompt();
	rootPrompt.setPrompt("# ");
	if (StringUtils.nullOrEmpty.test(suUser)) {
	    rootPrompt.setCommandEnd(true);
	} else {
	    rootPrompt.setStringToSend("su -l " + getSuUser());
	}
	prompts.add(rootPrompt);
	return prompts.toArray(new Prompt[prompts.size()]);

    }

    public String getSuUser() {
	return suUser;
    }

    public void setSuUser(String suUser) {
	this.suUser = suUser;
    }
}
