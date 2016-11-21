package com.undertone.qa;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Optional;
import java.util.function.Function;

import javax.management.ServiceNotFoundException;

import org.apache.http.HttpHost;
import org.apache.http.HttpRequest;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.config.SocketConfig;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.net.HostAndPort;
import com.orbitz.consul.Consul;

public class RampAppCampaignManager extends CampaignManager {

    protected CloseableHttpClient httpclient;
    protected String lineItemId = "197419";
    private Consul consul;
    private ObjectMapper m = new ObjectMapper();

    public RampAppCampaignManager(final String hostname, final int port) {
	m.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

	consul = Consul.builder().withHostAndPort(HostAndPort.fromParts(hostname, port)).build();

	httpclient = HttpClients.custom().setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(100000).build())
		.build();
    }

    @Override
    public Optional<Campaign> getCampaign(String byName) {
	Optional<Campaign> campaign = super.getCampaign(byName);
	if (campaign.isPresent()) {
	    return campaign;
	}

	String ioServiceName = consul.catalogClient().getServices().getResponse().keySet().stream()
		.filter(serviceName -> serviceName.startsWith("io-service")).findFirst()
		.orElseThrow(() -> new RuntimeException(new ServiceNotFoundException("io-service")));
	System.out.println(ioServiceName);
	// http://service.url/api/v1/io/line_item/:lineItemId
	HttpHost host = consul.catalogClient().getService(ioServiceName).getResponse().stream().findFirst()
		.map(cs -> new HttpHost(cs.getAddress(), cs.getServicePort(), "http")).get();

	String uri = "/api/v1/io/line_item/" + lineItemId;

	try {
	    URL url = new URL(host.getSchemeName(), host.getHostName(), host.getPort(), uri);
	    LineItem l = lineItemFrom(url);
	    l.campaigns.stream().map(CampaignPlus.class::cast).forEach(c -> {
		if (!this.campaigns.contains(c)) {
		    this.campaigns.add(c);
		    c.zonesets().forEach(zonesetid -> createZoneSet("ZoneSet #" + zonesetid, zonesetid, c.getId()));
		}
	    });
	} catch (Exception e) {
	    throw new UncheckedIOException(new IOException(e));
	}
	return super.getCampaign(byName);
    }

    LineItem lineItemFrom(URL url)
	    throws JsonParseException, JsonMappingException, UnsupportedOperationException, IOException {
	return m.readValue(url, LineItem.class);
    }

    public static void main(String[] args) throws JsonProcessingException {
	RampAppCampaignManager manager = new RampAppCampaignManager("consul-staging.ramp-ut.io", 8500);
	Campaign campaign = manager.getCampaign("75396-197419-Cross Screen Video Blend-147")
		.orElseThrow(NullPointerException::new);

	System.out.println(manager.m.writeValueAsString(campaign));

    }

}
