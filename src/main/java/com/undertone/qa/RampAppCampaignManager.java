package com.undertone.qa;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UncheckedIOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.UnsupportedCharsetException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;

import javax.management.ServiceNotFoundException;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpRequest;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CookieStore;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.net.HostAndPort;
import com.orbitz.consul.Consul;
import com.undertone.qa.ramp.app.api.CreateCampaignRequest;
import com.undertone.qa.ramp.app.api.CreativeRequest;
import com.undertone.qa.ramp.app.api.CampaignsRequest;

public class RampAppCampaignManager extends CampaignManager implements AutoCloseable {

    protected CloseableHttpClient httpclient;
    protected final String lineItemId; // = "197419";
    private static Consul consul;
    private ObjectMapper m = new ObjectMapper();
    AtomicReference<LineItem> lineItem = new AtomicReference<>();
    private final CookieStore cookieStore;

    public RampAppCampaignManager(final String hostname, final int port, String lineItemId) {
	super();
	m.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	this.lineItemId = lineItemId;
	if (consul == null) {
	    synchronized (RampAppCampaignManager.class) {
		if (consul == null) {
		    consul = Consul.builder().withHostAndPort(HostAndPort.fromParts(hostname, port)).build();
		}
	    }
	}
	cookieStore = new BasicCookieStore();
	List<Header> defaultHeaders = new ArrayList<>();
	defaultHeaders.add(new BasicHeader("rampInternal", "true"));
	httpclient = HttpClients.custom().setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(100000).build())
		.setDefaultHeaders(defaultHeaders).setDefaultCookieStore(this.cookieStore).build();

    }

    RampAppCampaignManager authenticate(String email, String password, String authenticity_token)
	    throws ClientProtocolException, IOException {
	HttpPost authRequest = new HttpPost("/workflow/users/process_login");

	List<NameValuePair> authenticationParameters = new ArrayList<>();
	authenticationParameters.add(new BasicNameValuePair("email", email));
	authenticationParameters.add(new BasicNameValuePair("password", password));
	authenticationParameters.add(new BasicNameValuePair("authenticity_token", authenticity_token));

	HttpEntity postProcessLoginEntity = new UrlEncodedFormEntity(authenticationParameters);
	authRequest.setEntity(postProcessLoginEntity);

	HttpHost host = new HttpHost("stgadmin.undertone.com");
	try (CloseableHttpResponse r = httpclient.execute(host, authRequest)) {
	    r.getEntity();
	}
	return this;
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
	    lineItem.set(lineItemFrom(host, url));
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

	String ioServiceName = consul.catalogClient().getServices().getResponse().keySet().stream()
		.filter(serviceName -> serviceName.startsWith("io-service")).findFirst()
		.orElseThrow(() -> new RuntimeException(new ServiceNotFoundException("io-service")));

	HttpHost host = consul.catalogClient().getService(ioServiceName).getResponse().stream().findFirst()
		.map(cs -> new HttpHost(cs.getAddress(), cs.getServicePort(), "http")).get();

	String uri = "/api/v1/io/campaigns";
	HttpPost createCampaignHttpRequest = new HttpPost(uri);
	createCampaignHttpRequest.addHeader("content-type", "application/json");
	// CreateCampaignRequest createCampaignRequestBody = new
	// CreateCampaignRequest(lineItem.get());
	// class CampaignsRequest {
	// public final CreateCampaignRequest[] campaignsArray = {
	// createCampaignRequestBody };
	// }

	try {
	    CampaignsRequest request = new CampaignsRequest(new Campaign[] {});
	    HttpEntity en;
	    en = new StringEntity(m.writeValueAsString(request), ContentType.APPLICATION_JSON);
	    createCampaignHttpRequest.setEntity(en);
	    BufferedReader reqLineReader = new BufferedReader(new InputStreamReader(en.getContent()));
	    while (reqLineReader.ready()) {
		System.out.println(reqLineReader.readLine());
	    }
	} catch (Exception e) {
	    return Optional.empty();
	}

	try (CloseableHttpResponse createResponse = httpclient.execute(host, createCampaignHttpRequest)) {
	    createResponse.setEntity(new BufferedHttpEntity(createResponse.getEntity()));
	    BufferedReader lineReader = new BufferedReader(
		    new InputStreamReader(createResponse.getEntity().getContent()));
	    while (lineReader.ready()) {
		System.out.println(lineReader.readLine());
	    }
	    Campaign tmpCampaign = m.readValue(createResponse.getEntity().getContent(), CampaignsRequest.class)
		    .getCampaignsArray()[0];
	    Campaign campaign = new Campaign(campaignName, tmpCampaign.getId());

	    HttpPut renameCampaignHttpRequest = new HttpPut(uri);
	    renameCampaignHttpRequest.addHeader("content-type", "application/json");

	    HttpEntity en;
	    CampaignsRequest renameCampaignTo = new CampaignsRequest(new Campaign[] { campaign });
	    en = new StringEntity(m.writeValueAsString(renameCampaignTo), ContentType.APPLICATION_JSON);
	    renameCampaignHttpRequest.setEntity(en);
	    BufferedReader reqLineReader = new BufferedReader(new InputStreamReader(en.getContent()));
	    while (reqLineReader.ready()) {
		System.out.println(reqLineReader.readLine());
	    }
	    try (CloseableHttpResponse renameResponse = httpclient.execute(host, renameCampaignHttpRequest)) {
		renameResponse.setEntity(new BufferedHttpEntity(renameResponse.getEntity()));
		lineReader = new BufferedReader(new InputStreamReader(renameResponse.getEntity().getContent()));
		while (lineReader.ready()) {
		    System.out.println(lineReader.readLine().replaceAll("\\\n", "\n"));
		}
		// Campaign tmpCampaign2 =
		// m.readValue(renameResponse.getEntity().getContent(),
		// Campaign[].class);
		// System.out.println(tmpCampaign2.getName());
	    }
	    this.campaigns.add(campaign);
	    return Optional.of(campaign);
	} catch (Exception e) {
	    return Optional.empty();
	}

    }

    LineItem lineItemFrom(HttpHost host, URL url) throws JsonParseException, JsonMappingException,
	    UnsupportedOperationException, IOException, URISyntaxException {
	HttpRequest req = new HttpGet(url.toURI());
	try (CloseableHttpResponse r = httpclient.execute(host, req)) {
	    return m.readValue(r.getEntity().getContent(), LineItem.class);
	}
    }

    public static void main(String[] args) throws ClientProtocolException, IOException {
	RampAppCampaignManager manager = new RampAppCampaignManager("consul-staging.ramp-ut.io", 8500, "197419");
	String campaignName = "G13";

	Optional<Campaign> campaign = Optional.of(campaignName).flatMap(manager::getCampaign);
	if (!campaign.isPresent()) {
	    campaign = Optional.of(campaignName).flatMap(manager::createCampaign);
	}
	System.out.println(manager.m.writeValueAsString(campaign.orElse(null)));

    }

    @Override
    public void close() throws Exception {
	this.httpclient.close();
    }

    public Optional<Banner> createBanner(String withName, Integer forCampaignId) {

	try {
	    String ioServiceName = consul.catalogClient().getServices().getResponse().keySet().stream()
		    .filter(serviceName -> serviceName.startsWith("io-service")).findFirst()
		    .orElseThrow(() -> new RuntimeException(new ServiceNotFoundException("io-service")));

	    HttpHost host = consul.catalogClient().getService(ioServiceName).getResponse().stream().findFirst()
		    .map(cs -> new HttpHost(cs.getAddress(), cs.getServicePort(), "http")).get();

	    String uri = "/api/v1/io/line_item/" + lineItemId + "/creative";
	    HttpPost createCreativeHttpRequest = new HttpPost(uri);
	    createCreativeHttpRequest.addHeader("content-type", "application/json");

	    CreativeRequest creativeRequest = new CreativeRequest();
	    creativeRequest.selectedCampaignIds = new ArrayList<>();
	    creativeRequest.selectedCampaignIds.add(forCampaignId);
	    creativeRequest.creativeName = withName;
	    creativeRequest.htmlTemplate = new StringBuilder("<html>").append("<body>")
		    .append("<a href='http://localhost/").append(forCampaignId).append("'>").append(withName)
		    .append("</a>").append("</body>").append("</html>").toString();
	    HttpEntity en;
	    en = new StringEntity(m.writeValueAsString(creativeRequest), ContentType.APPLICATION_JSON);
	    createCreativeHttpRequest.setEntity(en);
	    
	    try (CloseableHttpResponse createBannerResponse = httpclient.execute(host, createCreativeHttpRequest)) {
		createBannerResponse.setEntity(new BufferedHttpEntity(createBannerResponse.getEntity()));
		BufferedReader lineReader = new BufferedReader(
			new InputStreamReader(createBannerResponse.getEntity().getContent()));
		while (lineReader.ready()) {
		    System.out.println(lineReader.readLine().replaceAll("\\\n", "\n"));
		}
		// Campaign tmpCampaign2 =
		// m.readValue(renameResponse.getEntity().getContent(),
		// Campaign[].class);
		// System.out.println(tmpCampaign2.getName());

		// TODO Auto-generated catch block
	    }

	    return Optional.empty();
	} catch (UnsupportedCharsetException | UnsupportedOperationException | IOException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	    return Optional.empty();
	}
    }

}
