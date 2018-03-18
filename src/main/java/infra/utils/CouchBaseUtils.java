package infra.utils;


import infra.assertion.Assert;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.config.SocketConfig;
import org.apache.http.impl.client.HttpClients;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.charset.Charset;
import java.util.Base64;

import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertThat;

public class CouchBaseUtils {
    private static final String HOST = "http://172.31.48.30:8091/";
    private static final String USER = "Administrator";
    private static final String PASSWORD = "couchbase";

    public void flushBucker(String bucketName)
    {
        String encoding = Base64.getEncoder().encodeToString((USER+":"+PASSWORD).getBytes(Charset.forName("ISO-8859-1")));
        HttpClient httpClient = HttpClients.custom()
                .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(10000).build())
                .build();
        HttpResponse response;
        String url = HOST + "/pools/default/buckets/"+bucketName+"/controller/doFlush";
        try {
            HttpPost post = new HttpPost(url);
            post.setHeader("Authorization", "Basic " + encoding);
            response =  httpClient.execute(post);
           } catch (IOException e) {
            throw new UncheckedIOException("failed to send request (" + url + ") ", e);
        }
        assertThat("Status code of impression request", response.getStatusLine().getStatusCode(), is(200));
    }

}
