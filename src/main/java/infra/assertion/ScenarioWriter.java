package infra.assertion;

import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.util.Collection;

import cucumber.api.Scenario;

public class ScenarioWriter extends Writer implements Scenario {

    protected StringWriter local;
    protected final Scenario scenario;

    public ScenarioWriter(Scenario scenario) {
	super(scenario);
	this.scenario = scenario;
	local = new StringWriter();
    }

    @Override
    public void write(char[] cbuf, int off, int len) throws IOException {
	local.write(cbuf, off, len);
    }

    @Override
    public void flush() throws IOException {
	local.flush();
	synchronized (lock) {
	    scenario.write(local.toString());
	}

    }

    @Override
    public void close() throws IOException {
	synchronized (lock) {
	    local.close();
	    local = new StringWriter();
	}

    }

    public Collection<String> getSourceTagNames() {
	return scenario.getSourceTagNames();
    }

    public String getStatus() {
	return scenario.getStatus();
    }

    public boolean isFailed() {
	return scenario.isFailed();
    }

    public void embed(byte[] data, String mimeType) {
	scenario.embed(data, mimeType);
    }

    public void write(String text) {
	scenario.write(text);
    }

    public String getName() {
	return scenario.getName();
    }

    public String getId() {
	return scenario.getId();
    }

}
