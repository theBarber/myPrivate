package entities;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UncheckedIOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import entities.ramp.app.api.*;
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


import static org.hamcrest.Matchers.is;
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
		}};
		httpclient = HttpClients.custom().setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(100000).build())
				.setDefaultHeaders(defaultHeaders).setDefaultCookieStore(new BasicCookieStore()).build();
	}

	public CloseableHttpResponse createCampaign(String campaignName, Integer lineItemId, Integer creativeID, Integer zonesetID)
	{
		CloseableHttpResponse createCampaignResponse;
		String url = getServiceAddress("/api/v1/io/campaigns");
		CreateCampaignRequest createCampaignRequest = getCreateCampaignRequestEntity(campaignName, String.valueOf(lineItemId), creativeID, zonesetID);
		CreateCampaignsRequestWrapper requestWrapper = new CreateCampaignsRequestWrapper(createCampaignRequest);
		HttpPost httpPost = new HttpPost(url);
		try {
			HttpEntity entity = new StringEntity(mapper.writeValueAsString(requestWrapper), ContentType.APPLICATION_JSON);
			httpPost.setEntity(entity);
			printEntityContent(entity);
			createCampaignResponse = httpclient.execute(httpPost);
		}catch (IOException e)
		{
			e.printStackTrace();
			throw new UncheckedIOException("failed to send request (" + url + ") ", e);
		}
		assertThat("Status code of create campaign request", createCampaignResponse.getStatusLine().getStatusCode(), is(200));
		return createCampaignResponse;
	}

	private String dateFromNow(Integer daysToAdd) {
		final Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, daysToAdd);
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		return dateFormat.format(cal.getTime());
	}

	private String getServiceAddress(String service)
	{
		return  "http://" + host + Optional.ofNullable(port).filter(s->!s.isEmpty()).map(s->":"+s).orElse("") + service;
	}

	private CreateCampaignRequest getCreateCampaignRequestEntity(String campaignName,String lineItemId, Integer creativeID, Integer zonesetID)
	{
		Zonesets zonesets = new Zonesets();
		zonesets.setInclude(new ArrayList<Integer>(){{add(zonesetID);}});
		return new CreateCampaignRequest(campaignName,lineItemId,
				zonesets, new ArrayList<Integer>(){{add(creativeID);}},
				dateFromNow(-1),dateFromNow(1));
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
		String url = getServiceAddress("/api/v1/io/campaigns?campaignIds="+campaignID);
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


	@Override
	public void close() throws Exception {
		this.httpclient.close();
	}
}
