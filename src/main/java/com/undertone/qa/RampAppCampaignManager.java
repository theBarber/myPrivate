package com.undertone.qa;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UncheckedIOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.UnsupportedCharsetException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.function.Predicate;
import java.util.stream.Stream;

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
import org.apache.http.client.utils.URIBuilder;
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
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.net.HostAndPort;
import com.orbitz.consul.Consul;
import com.undertone.automation.module.Named;
import com.undertone.automation.module.WithId;
import com.undertone.qa.ramp.app.api.Banners;
import com.undertone.qa.ramp.app.api.CampaignsRequest;
import com.undertone.qa.ramp.app.api.CreateCampaignRequest;
import com.undertone.qa.ramp.app.api.CreateCampaignsRequestWrapper;
import com.undertone.qa.ramp.app.api.CreativeRequest;

import gherkin.deps.com.google.gson.JsonArray;
import gherkin.deps.com.google.gson.JsonParser;

public class RampAppCampaignManager extends HardCodedCampaignManager implements AutoCloseable {

    protected CloseableHttpClient httpclient;
    protected final String lineItemId;
    protected final JsonArray lineItemIds;
    private static Consul consul;
    private ObjectMapper m = new ObjectMapper();
    // AtomicReference<LineItem> lineItem = new AtomicReference<>();
    private final CookieStore cookieStore;

    public RampAppCampaignManager(final String hostname, final int port, String lineItemIds) {
	super();
	m.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	this.lineItemIds = new JsonParser().parse(lineItemIds).getAsJsonArray();
	this.lineItemId = this.lineItemIds.get(0).getAsString();
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
	super.buildHardCodedCampaignsAndZones();
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

	lineItemIds.forEach(liId -> {
	    try {
		lineItem(liId.getAsString()).campaigns.stream().map(CampaignPlus.class::cast).forEach(c -> {

		    if (!this.campaigns.contains(c)) {
			this.campaigns.add(c);
			c.zonesets().forEach(zonesetid -> createZoneSet("ZoneSet #" + zonesetid, zonesetid, c.getId()));
			getBanners(c.getId()).ifPresent(s -> s.forEach(b -> {
			    createBanner(b.getName(), b.getId(), c.getId());
			}));
		    }
		});
	    } catch (Exception e) {
		throw new UncheckedIOException(new IOException(e));
	    }
	});
	return super.getCampaign(byName);
    }

    private Optional<CampaignPlus> getRemoteCampaign(String byName, String fromLineItem) {
	try {
	    return lineItem(fromLineItem).campaigns.stream().map(CampaignPlus.class::cast).filter(Named.nameIs(byName))
		    .findAny();
	} catch (Exception e) {
	    throw new UncheckedIOException(new IOException(e));
	}
    }

    public Optional<Stream<Banner>> getBanners(int forCampaign) {

	HttpHost host = this.getAddressOfService("io-service");
	String uri = "/api/v1/io/campaigns/" + forCampaign + "/banners";
	HttpRequest req = new HttpGet(uri);
	try (CloseableHttpResponse r = httpclient.execute(host, req)) {
	    return Optional.of(m.readValue(r.getEntity().getContent(), Banners.class).stream());
	} catch (Exception e) {
	    return Optional.empty();
	}

    }

    public Optional<Campaign> createCampaign(String campaignName) {
	String uri = "/api/v1/io/campaigns";
	HttpPost createCampaignHttpRequest = new HttpPost(uri);
	createCampaignHttpRequest.addHeader("content-type", "application/json");
	CreateCampaignRequest createCampaignRequestBody = new CreateCampaignRequest(lineItem(lineItemId));

	try {
	    CreateCampaignsRequestWrapper requestWrapper = new CreateCampaignsRequestWrapper(createCampaignRequestBody);
	    HttpEntity en;
	    en = new StringEntity(m.writeValueAsString(requestWrapper), ContentType.APPLICATION_JSON);
	    createCampaignHttpRequest.setEntity(en);
	    BufferedReader reqLineReader = new BufferedReader(new InputStreamReader(en.getContent()));
	    while (reqLineReader.ready()) {
		System.out.println(reqLineReader.readLine());
	    }
	} catch (Exception e) {
	    return Optional.empty();
	}

	try (CloseableHttpResponse createResponse = this.execute("io-service", createCampaignHttpRequest)) {
	    createResponse.setEntity(new BufferedHttpEntity(createResponse.getEntity()));
	    BufferedReader lineReader = new BufferedReader(
		    new InputStreamReader(createResponse.getEntity().getContent()));
	    while (lineReader.ready()) {
		System.out.println(lineReader.readLine());
	    }
	    Campaign[] tmpCampaigns = m.readValue(createResponse.getEntity().getContent(), CampaignsRequest.class)
		    .getCampaignsArray();
	    if (tmpCampaigns.length < 1) {
		return Optional.empty();
	    }
	    Campaign tmpCampaign = tmpCampaigns[0];
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
	    try (CloseableHttpResponse renameResponse = this.execute("io-service", renameCampaignHttpRequest)) {
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

    public Optional<CampaignPlus> updateCampaign(Campaign campaign) {
	HttpPut updateCampaignHttpRequest = new HttpPut("/api/v1/io/campaigns");
	try {
	    HttpEntity en;
	    CampaignsRequest updateCampaignTo = new CampaignsRequest(new Campaign[] { campaign });
	    en = new StringEntity(m.writeValueAsString(updateCampaignTo), ContentType.APPLICATION_JSON);
	    updateCampaignHttpRequest.setEntity(en);
	    BufferedReader reqLineReader = new BufferedReader(new InputStreamReader(en.getContent()));
	    while (reqLineReader.ready()) {
		System.out.println(reqLineReader.readLine());
	    }

	    try (CloseableHttpResponse updateResponse = this.execute("io-service", updateCampaignHttpRequest)) {
		updateResponse.setEntity(new BufferedHttpEntity(updateResponse.getEntity()));
		BufferedReader lineReader = new BufferedReader(
			new InputStreamReader(updateResponse.getEntity().getContent()));
		while (lineReader.ready()) {
		    System.out.println(lineReader.readLine().replaceAll("\\\n", "\n"));
		}
		return getRemoteCampaign(campaign.getName(), lineItemId);
	    }
	} catch (Exception e) {
	    return Optional.empty();
	}

    }

    LineItem lineItem(String id) {
	String uri = "/api/v1/io/line_item/" + id;
	try (CloseableHttpResponse r = this.execute("io-service", new HttpGet(uri))) {
	    return m.readValue(r.getEntity().getContent(), LineItem.class);
	} catch (IOException e) {
	    throw new UncheckedIOException(e);
	}
    }

    @Override
    public void close() throws Exception {
	this.httpclient.close();
    }

    public Optional<Banner> createBanner(String withName, String forCampaignName) {
	Integer forCampaignId = getCampaign(forCampaignName).map(Campaign::getId).get();

	try {
	    HttpPost createCreativeHttpRequest = new HttpPost("/api/v1/io/line_item/" + lineItemId + "/creative");
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
	    try (BufferedReader lineReader = new BufferedReader(new InputStreamReader(en.getContent()))) {
		while (lineReader.ready()) {
		    System.out.println(lineReader.readLine());
		}
	    }
	    try (CloseableHttpResponse createBannerResponse = this.execute("io-service", createCreativeHttpRequest)) {
		createBannerResponse.setEntity(new BufferedHttpEntity(createBannerResponse.getEntity()));
		try (BufferedReader lineReader = new BufferedReader(
			new InputStreamReader(createBannerResponse.getEntity().getContent()))) {
		    while (lineReader.ready()) {
			System.out.println(lineReader.readLine().replaceAll("\\\n", "\n"));
		    }
		}
		// XXX bug #UT-1909 Auto-generated catch block 
		
	    }

	    return Optional.empty();
//	    getRemoteCampaign(forCampaignName, lineItemId).map(Campaign::banners)		    .flatMap(banners -> banners.filter(Named.nameIs(withName)).findFirst());
	} catch (UnsupportedCharsetException | UnsupportedOperationException | IOException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	    return Optional.empty();
	}
    }

    private HttpHost getAddressOfService(String prefix) {
	Predicate<String> withThePrefix = s -> s.startsWith(prefix);
	String serviceName = consul.catalogClient().getServices().getResponse().keySet().stream().filter(withThePrefix)
		.findFirst().orElseThrow(() -> new RuntimeException(new ServiceNotFoundException("io-service")));

	return consul.catalogClient().getService(serviceName).getResponse().stream().findFirst()
		.map(cs -> new HttpHost(cs.getAddress(), cs.getServicePort(), "http")).get();
    }

    private CloseableHttpResponse execute(final String serviceName, final HttpRequest request)
	    throws ClientProtocolException, IOException {
	return this.execute(getAddressOfService(serviceName), request);
    }

    private CloseableHttpResponse execute(final HttpHost target, final HttpRequest request)
	    throws IOException, ClientProtocolException {
	return httpclient.execute(target, request);
    }

    public Optional<ZoneSet> getZoneset(String byName) {
	HttpHost host = this.getAddressOfService("zone-service");

	URI uri = null;
	try {
	    uri = new URIBuilder().setPath("/api/v1/zones/zonesets").addParameter("name", byName).build();
	} catch (URISyntaxException e1) {
	    e1.printStackTrace();
	    return Optional.empty();
	}

	HttpGet req = new HttpGet(uri);
	try (CloseableHttpResponse r = httpclient.execute(host, req)) {
	    r.setEntity(new BufferedHttpEntity(r.getEntity()));
	    BufferedReader lineReader = new BufferedReader(new InputStreamReader(r.getEntity().getContent()));
	    while (lineReader.ready()) {
		System.out.println(lineReader.readLine().replaceAll("\\\n", "\n"));
	    }
	    List<ZoneSet> responseZoneSets = Arrays.asList(m.readValue(r.getEntity().getContent(), ZoneSet[].class));
	    return responseZoneSets.stream().filter(Named.nameIs(byName)).findFirst();
	} catch (Exception e) {
	    e.printStackTrace();
	    return Optional.empty();
	}
    }

    public Optional<Zone> getZone(String byName, String forZoneset) {
	return getZoneset(forZoneset).map(WithId::getId).flatMap(zonesetsIds -> {

	    HttpHost host = this.getAddressOfService("zone-service");
	    URI uri = null;
	    try {
		uri = new URIBuilder().setPath("/api/v1/zones/zonesets/zones")
			.addParameter("zonesetsIds", String.valueOf(zonesetsIds)).build();
	    } catch (URISyntaxException e) {
		e.printStackTrace();
		return Optional.empty();
	    }
	    HttpGet req = new HttpGet(uri);
	    try (CloseableHttpResponse r = httpclient.execute(host, req)) {
		r.setEntity(new BufferedHttpEntity(r.getEntity()));
		BufferedReader lineReader = new BufferedReader(new InputStreamReader(r.getEntity().getContent()));
		// System.err.println(r.getEntity().getContentLength());
		while (lineReader.ready()) {
		    System.out.println(lineReader.readLine().replaceAll("\\\n", "\n"));
		}

		List<Zone> zones = Arrays.asList(m.readValue(r.getEntity().getContent(), Zone[].class));
		zones.forEach(System.out::println);
		zones.forEach(z -> this.createZone(z.getName(), z.getId(), zonesetsIds));
		return this.getZone(byName);

	    } catch (Exception e) {
		e.printStackTrace();
		return Optional.empty();
	    }
	});
    }
}
