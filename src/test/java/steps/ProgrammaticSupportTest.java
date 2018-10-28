package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.PendingException;
import cucumber.api.junit.Cucumber;
import infra.utils.S3Client;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.glassfish.jersey.client.ClientConfig;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import static org.hamcrest.core.Is.is;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:ProgrammaticSupp8ort.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/ProgrammaticSuipport_$TIMESTAMP$.json"})
public class ProgrammaticSupportTest extends BaseTest{
    private String host;


    public ProgrammaticSupportTest() {
        super();
        Before(PROGRAMMATIC, (scenario) -> {
            host = sut.getProgrammaticHost();
        });

        Given("^banner_id (\\d+) linked to deal_id (\\d+) with IO (\\d+)$", this::assertBannerLinkedToDeal);
        And("banner_id (\\d+) exist in s3 banner cache", this::assertBannerExistInS3BannerCache);
        And("banner_id (\\d+) exist in ramp-lift-services banner cache", this::assertBannerExistInRampLiftServicesBannerCache);
        And("^verify banner_id (\\d+) exists in zone_cache$", (Integer deal_id) -> {
            //CacheProcessTest.getBannerFromZoneCache(deal_id); need to implement that
            //throw new PendingException();
        });
    }

    private void assertBannerLinkedToDeal(String banner_id, String deal_id,String IO_ID)
    {
        //check that the deal_id's io is same as deal_id
        Assert.assertThat((getDeal(deal_id,IO_ID)), Matchers.containsString(banner_id)); //maybe needed to be checked differently (check that the banner exist in banners..)
    }

    public void assertBannerExistInS3BannerCache(Integer bannerId)
    {
        S3Client s3Client = new S3Client();
        String s3bannerCachePath = config.get("banner_cache.file_path");

        s3Client.assertFileContains(s3bannerCachePath,String.valueOf(bannerId));
    }

    public void assertBannerExistInRampLiftServicesBannerCache(Integer bannerId)
    {
        ClientConfig clientConfig = new ClientConfig();
        Client client = ClientBuilder.newClient(clientConfig);
        WebTarget webTarget = client.target("http://172.31.48.20:8877"); //TODO: need to be generic

        Response response = webTarget
                .path("/delivery_engine/refreshCache")
                .request(MediaType.APPLICATION_JSON)
                .post(Entity.json("{\"action\":\"info\"}"));
        Assert.assertNotNull(response);
        String responseStr = response.readEntity(String.class);
        Assert.assertEquals(200, response.getStatus());
        Assert.assertNotNull(responseStr);
        Assert.assertThat(responseStr, Matchers.containsString(String.valueOf(bannerId)));
    }

    private String getDeal(String deal_id,String IO_ID)
    {
        String dealJson = null;
        HttpResponse response;
        String url = getServiceAddress("/api/v1/io/"+IO_ID+"/deal/"+deal_id);
        HttpGet httpGet = new HttpGet(url);
        HttpClient httpclient = getHttpProgrammaticClient();
        try
        {
            response = httpclient.execute(httpGet);
            dealJson = getEntity(response.getEntity());
        }catch (IOException e)
        {
            e.printStackTrace();
            throw new UncheckedIOException("failed to send request (" + url + ") ", e);
        }
        return dealJson;
    }

    private String getEntity(HttpEntity entity)
    {
        StringBuilder builder = new StringBuilder();
        try {
            BufferedReader reqLineReader = new BufferedReader(new InputStreamReader(entity.getContent()));
            while (reqLineReader.ready()) {
                builder.append(reqLineReader.readLine());
            }
        }catch (IOException e)
        {
            throw new UncheckedIOException("failed to get the content ", e);
        }
        return builder.toString();
    }

    private HttpClient getHttpProgrammaticClient() {
        List<Header> defaultHeaders = new ArrayList<Header>(){{
            add(new BasicHeader("rampInternal", "true"));
        }};
        return HttpClients.custom().setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(100000).build())
                .setDefaultHeaders(defaultHeaders).setDefaultCookieStore(new BasicCookieStore()).build();
    }


    private String getServiceAddress(String service)
    {
        return  "http://" + host + service;
    }


}