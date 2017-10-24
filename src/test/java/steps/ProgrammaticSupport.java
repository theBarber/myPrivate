package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.PendingException;
import cucumber.api.junit.Cucumber;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.config.SocketConfig;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UncheckedIOException;
import java.util.ArrayList;
import java.util.List;


@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:ProgrammaticSupport.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/ProgrammaticSupport_$TIMESTAMP$.json"})
public class ProgrammaticSupport extends BaseTest{
    private String host;


    public ProgrammaticSupport() {
        super();
        Before(PROGRAMMATIC, (scenario) -> {
            host = sut.getProgrammaticHost();
        });

        Given("^banner_id (\\d+) linked to deal_id (\\d+) with IO (\\d+)$", this::assertBannerLinkedToDeal);
        And("^verify banner_id (\\d+) exists in zone_cache$", (Integer deal_id) -> {
            //CacheProcessTest.getBannerFromZoneCache(deal_id); need to implement that
            throw new PendingException();
        });
    }

    private void assertBannerLinkedToDeal(String banner_id, String deal_id,String IO_ID)
    {
        //check that the deal_id's io is same as deal_id
        Assert.assertThat((getDeal(deal_id,IO_ID)), Matchers.containsString(banner_id)); //maybe needed to be checked differently (check that the banner exist in banners..)
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