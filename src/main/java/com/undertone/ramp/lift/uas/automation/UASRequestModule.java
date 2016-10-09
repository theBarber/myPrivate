package com.undertone.ramp.lift.uas.automation;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.function.Predicate;
import java.util.stream.Stream;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import com.undertone.automation.module.AbstractModuleImpl;

public class UASRequestModule extends AbstractModuleImpl<List<CompletableFuture<HttpResponse>>> {

    private ExecutorService requestSubmitter;

    public String getHost() {
	return host;
    }

    public void setHost(String host) {
	this.host = host;
    }

    public String getPort() {
	return port;
    }

    public void setPort(String port) {
	this.port = port;
    }

    private String host;
    private String port;
    protected CloseableHttpClient httpclient;

    public UASRequestModule() {
	setActual(new ArrayList<>());
	httpclient = HttpClients.createDefault();
	requestSubmitter = Executors.newFixedThreadPool(5);
    }

    public void zoneRequest(String forZone) {
	String url = "http://" + host + ":" + port + "/af?zoneid=" + forZone + "&ct=1";
	request(url, true);
    }

    public void zoneRequests(String forZone, int times) {
	reset();
	String url = "http://" + host + ":" + port + "/af?zoneid=" + forZone + "&ct=1";

	for (; times > 0; times--) {
	    request(url, false);
	}
    }

    public void healthCheckRequest() {

	String url = "http://" + host + ":" + port + "/health";
	request(url, true);
    }

    public void healthCheckRequestSkip(String servicenameToSkip) {
	int skipFlag = 0xF;
	switch (servicenameToSkip) {
	case "RabbitMQ":
	    skipFlag = 0b1110;
	    break;
	case "Couchbase":
	    skipFlag = 0b1101;
	    break;
	case "Redis":
	    skipFlag = 0b1011;
	    break;
	case "Workflow":
	    skipFlag = 0b0111;
	    break;
	}
	String url = "http://" + host + ":" + port + "/health?skip=" + skipFlag;
	request(url, true);
    }

    private void request(String url, boolean toReset) {
	if (toReset) {
	    reset();
	}

	actual().add(CompletableFuture.supplyAsync(() -> {
	    try {
		HttpResponse response = httpclient.execute(new HttpGet(url));
		return response;
	    } catch (IOException e) {
		throw new RuntimeException("failed to send request", e);
	    }
	}, requestSubmitter));
    }

    public Stream<CompletableFuture<HttpResponse>> responses() {
	return actual().stream();
    }

    protected final void reset() {
	this.actual().stream().parallel().filter(((Predicate<Future<HttpResponse>>) Future::isDone).negate())
		.forEach(f -> f.cancel(true));

	this.actual().clear();
    }

}
