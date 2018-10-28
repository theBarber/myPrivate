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
import java.util.Optional;

import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertThat;

public class CouchBaseUtils {
    private String host;
    private String port;
    private String user;
    private String password;

    public CouchBaseUtils(String host,String port, String user, String password)
    {
        this.host = host;
        this.port = port;
        this.user = user;
        this.password = password;
    }

    public void flushBucket(String bucketName)
    {
        String encoding = Base64.getEncoder().encodeToString((user+":"+password).getBytes(Charset.forName("ISO-8859-1")));
        HttpClient httpClient = HttpClients.custom()
                .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(100000).build())
                .build();
        HttpResponse response;
        String url = "http://" +host + Optional.ofNullable(port).filter(s->!s.isEmpty()).map(s->":"+s).orElse("")+ "/pools/default/buckets/"+bucketName+"/controller/doFlush";
        try {
            HttpPost post = new HttpPost(url);
            post.setHeader("Authorization", "Basic " + encoding);
            response =  httpClient.execute(post);
           } catch (IOException e) {
            throw new UncheckedIOException("failed to send request (" + url + ") ", e);
        }
//        assertThat("Status code of flushing bucket request", response.getStatusLine().getStatusCode(), is(200));
    }
}
