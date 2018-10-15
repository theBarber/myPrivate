package entities;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UncheckedIOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import entities.ramp.app.api.*;
import gherkin.lexer.De;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.util.EntityUtils;


import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.nullValue;
import static org.junit.Assert.assertThat;
/**
 * created by Sahar
 * assumptions:
 * campaign is created for specific lineItem, zonset, and creative (all of them are not created here)
 * add campaign to lineItem List is not made here
 */
public class RampAppCreateEntitiesManager implements AutoCloseable {

	private ObjectMapper mapper = new ObjectMapper();
	private CloseableHttpClient httpclient;
	private String host;
	private String port;


	public RampAppCreateEntitiesManager(String host, String port) {
		this.host = host;
		this.port = port;
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		List<Header> defaultHeaders = new ArrayList<Header>(){{
			add(new BasicHeader("rampInternal", "true"));
			add(new BasicHeader("Content-Type", "application/json"));
		}};
		httpclient = HttpClients.custom().setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(100000).build())
				.setDefaultHeaders(defaultHeaders).setDefaultCookieStore(new BasicCookieStore()).build();
	}
// creating campaign with Required fields
	private CloseableHttpResponse createCampaignRequest(CreateCampaignsRequestWrapper requestWrapper)
	{
		CloseableHttpResponse createCampaignResponse;
		String url = getServicesURL("/api/v1/io/campaigns");
		HttpPost httpPost = new HttpPost(url);
		int times = 0;
		//System.out.println("---------------------"+url);
		try {
			do {
				HttpEntity entity = new StringEntity(mapper.writeValueAsString(requestWrapper), ContentType.APPLICATION_JSON);
				httpPost.setEntity(entity);
				printEntityContent(entity);
				createCampaignResponse = httpclient.execute(httpPost);
				times++;
			}while(times < 3 && createCampaignResponse.getStatusLine().getStatusCode() != 200);
		}catch (IOException e)
		{
			e.printStackTrace();
			throw new UncheckedIOException("failed to send request 3 times (" + url + ") ", e);
		}
		assertThat("Status code of create campaign request", createCampaignResponse.getStatusLine().getStatusCode(), is(200));
		return createCampaignResponse;
	}

	public Optional<Campaign> createCampaign(CreateCampaignRequest createCampaignRequest,Boolean isServerProgrammatic)
	{
		CloseableHttpResponse createCampaignResponse = createCampaignRequest(new CreateCampaignsRequestWrapper(createCampaignRequest));
		return getCampaignFromResponse(createCampaignResponse,isServerProgrammatic);
	}

	private Optional<Campaign> getCampaignFromResponse(CloseableHttpResponse createCampaignResponse,Boolean isServerProgrammatic)
	{
		Campaign[] tmpCampaign = null;

		try{
			tmpCampaign  = mapper.readValue(EntityUtils.toString(createCampaignResponse.getEntity()), CampaignsRequest.class).getCampaignsArray();

		}catch (IOException e)
		{
			e.printStackTrace();
		}
		if(tmpCampaign!=null){
			//sut.write("campaign successfully created!\ncampaign name: "+tmpCampaign[0].getName() + "\ncampaign id: "+ tmpCampaign[0].getId());
			if(isServerProgrammatic)
				addBannersFromGetCampaign(tmpCampaign[0]);
			return Optional.of(tmpCampaign[0]);
		}
		else{
			//sut.write("Error! campaign is not created\n");
			return Optional.empty();
		}
	}

	private void addBannersFromGetCampaign(Campaign Campaign)
	{
		CloseableHttpResponse getCampaignResponse = getCampaignRequest(Campaign.getId());
		Campaign[] tmpCampaign;
		try{
			tmpCampaign  = mapper.readValue(EntityUtils.toString(getCampaignResponse.getEntity()), Campaign[].class);
			Campaign.setBannersFromSet(tmpCampaign[0].getBanners());
		}catch (IOException IOE)
		{
			IOE.printStackTrace();
		}catch (NullPointerException e)
		{
			e.printStackTrace();
			throw e;
		}
	}

	private String dateFromNow(Integer daysToAdd) {
		final Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, daysToAdd);
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		return dateFormat.format(cal.getTime());
	}

	private String getServicesURL(String service)
	{
		return  "http://" + host + Optional.ofNullable(port).filter(s->!s.isEmpty()).map(s->":"+s).orElse("") + service;
	}

	private void printEntityContent(HttpEntity entity)
	{
		try {
			BufferedReader reqLineReader = new BufferedReader(new InputStreamReader(entity.getContent()));
			while (reqLineReader.ready()) {
				System.out.println("sending request to Ramp api with: \n" + reqLineReader.readLine());
			}
		}catch (IOException e)
		{
			throw new UncheckedIOException("failed to print the content ", e);
		}
	}

	public CloseableHttpResponse getCampaignRequest(Integer campaignID)
	{
		CloseableHttpResponse getCampaignResponse;
		String url = getServicesURL("/api/v1/io/campaigns?campaignIds="+campaignID);
		HttpGet httpGet = new HttpGet(url);
		try {
			getCampaignResponse = httpclient.execute(httpGet);
		} catch (IOException e) {
			e.printStackTrace();
			throw new UncheckedIOException("failed to send request (" + url + ") ", e);
		}
		assertThat("Status code of impression request", getCampaignResponse.getStatusLine().getStatusCode(), is(200));
		return getCampaignResponse;
	}

	public Optional<Zone> createZone(String zoneName, String adUnitID, String limitation,String webSectionID, String affiliateId)
	{
		CloseableHttpResponse createZoneResponse = createZoneRequest(zoneName,adUnitID,limitation,webSectionID,affiliateId);
		Optional<Zone> zone = getCreatedZoneFromResponse(createZoneResponse);
		zone.ifPresent(zone1 -> zone.get().set(zoneName,adUnitID,limitation,webSectionID));
		return zone;
	}

	private Optional<Zone> getCreatedZoneFromResponse(CloseableHttpResponse createZoneResponse)
	{
		Zone zone = null;
		try{
			zone  = mapper.readValue(EntityUtils.toString(createZoneResponse.getEntity()), Zone.class);

		}catch (IOException e)
		{
			e.printStackTrace();
		}
		//System.out.println("zone created successfully! zone id is: "+ zone.getId());
		if(zone!=null)
			return Optional.of(zone);
		else
			return Optional.empty();
}

	private CloseableHttpResponse createZoneRequest(String zoneName, String adunit, String limitation,String webSectionID,String affiliateId)
	{
		CloseableHttpResponse createZoneResponse;
		String url = getServicesURL("/test/zones/zonesets/zones");
		CreateZoneRequest createZoneRequest = new CreateZoneRequest(zoneName,adunit,limitation,webSectionID,dateFromNow(0),"","12",affiliateId);

		HttpPost httpPost = new HttpPost(url);
		try {
			HttpEntity entity = new StringEntity(mapper.writeValueAsString(createZoneRequest), ContentType.APPLICATION_JSON);
			httpPost.setEntity(entity);
			printEntityContent(entity);
			createZoneResponse = httpclient.execute(httpPost);
		}catch (IOException e)
		{
			e.printStackTrace();
			throw new UncheckedIOException("failed to send request (" + url + ") ", e);
		}
		assertThat("Status code of create zone request", createZoneResponse.getStatusLine().getStatusCode(), is(200));
		return createZoneResponse;
	}

	public Optional<ZoneSet> createZoneset(String zonesetName, Set<Zone> zones,String agencyId, String zonesetType)
	{
		CloseableHttpResponse createZonesetResponse = createZonesetRequest(zonesetName,zones,agencyId,zonesetType);
		Optional<ZoneSet> zoneSet = getCreatedZoneSetFromResponse(createZonesetResponse);
		zoneSet.ifPresent(zoneSet1 -> zoneSet1.setName(zonesetName));
		return zoneSet;
	}

	private Optional<ZoneSet> getCreatedZoneSetFromResponse(CloseableHttpResponse createZoneSetResponse) {
		ZoneSet zoneSet = null;
		try{
			zoneSet  = mapper.readValue(EntityUtils.toString(createZoneSetResponse.getEntity()), ZoneSet.class);

		}catch (IOException e)
		{
			e.printStackTrace();
		}
		if(zoneSet!=null)
			return Optional.of(zoneSet);
		else
			return Optional.empty();
		//System.out.println("zoneset created successfully! zoneset id is: "+ zoneSet.getId());
	}
	private CloseableHttpResponse createZonesetRequest(String zonesetName, Set<Zone> zones,String agencyId, String zonesetType)
	{
		CloseableHttpResponse createZonesetResponse;
		String url = getServicesURL("/test/zones/zonesets");
		CreateZoneSetRequest createZoneSetRequest = new CreateZoneSetRequest(zonesetName, agencyId, zonesetType, zones);
		HttpPost httpPost = new HttpPost(url);
		try {
			HttpEntity entity = new StringEntity(mapper.writeValueAsString(createZoneSetRequest), ContentType.APPLICATION_JSON);
			httpPost.setEntity(entity);
			printEntityContent(entity);
			createZonesetResponse = httpclient.execute(httpPost);
		}catch (IOException e)
		{
			e.printStackTrace();
			throw new UncheckedIOException("failed to send request (" + url + ") ", e);
		}
		assertThat("Status code of create campaign request", createZonesetResponse.getStatusLine().getStatusCode(), is(200));
		return createZonesetResponse;
	}

	private CloseableHttpResponse createDealRequest(DealRequest dealRequest, Integer IO)
	{
		CloseableHttpResponse dealResponse;
		String url = getServicesURL("/io/"+IO+"/deal");
		HttpPost httpPost = new HttpPost(url);
		try {
			HttpEntity entity = new StringEntity(mapper.writeValueAsString(dealRequest), ContentType.APPLICATION_JSON);
			httpPost.setEntity(entity);
			printEntityContent(entity);
			dealResponse = httpclient.execute(httpPost);
		}catch (IOException e)
		{
			e.printStackTrace();
			throw new UncheckedIOException("failed to send request (" + url + ") ", e);
		}
		assertThat("Status code of create campaign request", dealResponse.getStatusLine().getStatusCode(), is(200));
		return dealResponse;
	}


	public Deal createDeal(DealRequest dealRequest, Integer IO)
	{
		CloseableHttpResponse dealResponse = createDealRequest(dealRequest,IO);
		return getDealFromResponse(dealResponse);
	}

	public Creative createCreative(String creativeName, Integer IO, Integer adUnitID, String htmlTemplate)
	{
		CloseableHttpResponse creativeResponse = createCreativeRequest(creativeName,IO,adUnitID,htmlTemplate);
		return getCreativeFromREsponse(creativeResponse);
	}

	private Creative getCreativeFromREsponse(CloseableHttpResponse creativeResponse) {
		Creative creative = null;
		try{
			creative  = mapper.readValue(EntityUtils.toString(creativeResponse.getEntity()), Creative.class);

		}catch (IOException e)
		{
			e.printStackTrace();
		}
		System.out.println("Creative created successfully! Creative id is: "+ creative.getId());
		return creative;

	}

	private Deal getDealFromResponse(CloseableHttpResponse dealResponse) {
		Deal deal = null;
		try{
			deal  = mapper.readValue(EntityUtils.toString(dealResponse.getEntity()), Deal.class);

		}catch (IOException e)
		{
			e.printStackTrace();
		}
		System.out.println("Deal created successfully! deal id is: "+ deal.getDealId());
		return deal;
	}

	public CloseableHttpResponse createCreativeRequest(String creativeName, Integer IO, Integer adUnitID, String htmlTemplate) {
		CloseableHttpResponse creativeResponse;
		String url = getServicesURL("/io/"+IO+"/creative");
		CreativeRequest creativeRequest = new CreativeRequest(creativeName,adUnitID,htmlTemplate);
		CreativeRequestWrapper creativeRequestWrapper = new CreativeRequestWrapper(creativeRequest);
		HttpPost httpPost = new HttpPost(url);
		try {
			HttpEntity entity = new StringEntity(mapper.writeValueAsString(creativeRequestWrapper), ContentType.APPLICATION_JSON);
			httpPost.setEntity(entity);
			printEntityContent(entity);
			creativeResponse = httpclient.execute(httpPost);
		}catch (IOException e)
		{
			e.printStackTrace();
			throw new UncheckedIOException("failed to send request (" + url + ") ", e);
		}
		assertThat("Status code of create campaign request", creativeResponse.getStatusLine().getStatusCode(), is(200));
		return creativeResponse;
	}

	@Override
	public void close() throws Exception {
		this.httpclient.close();
	}
}
