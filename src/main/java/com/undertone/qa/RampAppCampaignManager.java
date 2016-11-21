package com.undertone.qa;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UncheckedIOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.UnsupportedCharsetException;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.Function;

import javax.management.ServiceNotFoundException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.net.HostAndPort;
import com.orbitz.consul.Consul;
import com.undertone.qa.ramp.app.api.CreateCampaignRequest;

public class RampAppCampaignManager extends CampaignManager {

    protected CloseableHttpClient httpclient;
    protected String lineItemId = "197419";
    private Consul consul;
    private ObjectMapper m = new ObjectMapper();
    AtomicReference<LineItem> lineItem;

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
	    lineItem.set(lineItemFrom(url));
	    lineItem.get().campaigns.stream().map(CampaignPlus.class::cast).forEach(c -> {
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

    public Optional<Campaign> createCampaign(String campaignName) {
	Campaign c = null;
	String ioServiceName = consul.catalogClient().getServices().getResponse().keySet().stream()
		.filter(serviceName -> serviceName.startsWith("io-service")).findFirst()
		.orElseThrow(() -> new RuntimeException(new ServiceNotFoundException("io-service")));

	HttpHost host = consul.catalogClient().getService(ioServiceName).getResponse().stream().findFirst()
		.map(cs -> new HttpHost(cs.getAddress(), cs.getServicePort(), "http")).get();

	String uri = "/api/v1/io/campaigns";
	HttpPost post = new HttpPost(uri);
	// post.addHeader("content-type", "application/json");

	CreateCampaignRequest createCampaignRequest = new CreateCampaignRequest(lineItem.get()).withName(campaignName);

	try {
	    HttpEntity en;
	    en = new StringEntity(m.writeValueAsString(createCampaignRequest), ContentType.APPLICATION_JSON);
	    post.setEntity(en);
	    BufferedReader reqLineReader = new BufferedReader(new InputStreamReader(en.getContent()));
	    while (reqLineReader.ready()) {
		System.out.println(reqLineReader.readLine());
	    }
	} catch (Exception e) {
	    return Optional.empty();
	}

	try (CloseableHttpResponse r = httpclient.execute(host, post)) {
	    r.setEntity(new BufferedHttpEntity(r.getEntity()));
	    BufferedReader lineReader = new BufferedReader(new InputStreamReader(r.getEntity().getContent()));
	    while (lineReader.ready()) {
		System.out.println(lineReader.readLine());
	    }
	    c = m.readValue(r.getEntity().getContent(), Campaign.class);
	    this.campaigns.add(c);
	} catch (Exception e) {
	    return Optional.empty();
	}

	return Optional.of(c);
    }

    LineItem lineItemFrom(URL url)
	    throws JsonParseException, JsonMappingException, UnsupportedOperationException, IOException {
	return m.readValue(url, LineItem.class);
    }

    public static void main(String[] args) throws JsonProcessingException {
	RampAppCampaignManager manager = new RampAppCampaignManager("consul-staging.ramp-ut.io", 8500);
	String campaignName = "75396-197419-Cross";

	Optional<Campaign> campaign = Optional.of(campaignName).flatMap(manager::getCampaign);
	if (!campaign.isPresent()) {
	    campaign = Optional.of(campaignName).flatMap(manager::createCampaign);
	}
	System.out.println(manager.m.writeValueAsString(campaign));

    }

}
