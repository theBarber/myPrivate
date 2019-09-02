package ramp.lift.uas.automation;

import infra.module.AbstractModuleImpl;

import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

public class RampAppRequestModule extends AbstractModuleImpl<CompletableFuture<HttpResponse>> {

  private String host;
  private String port;
  protected CloseableHttpClient httpclient;
  List<Header> httpHeaders = new ArrayList<Header>();
  List<NameValuePair> queryParams = new ArrayList<>();

  public RampAppRequestModule() {
    setActual(CompletableFuture.completedFuture(null));
    httpclient = HttpClients.custom()
        .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(5000).build())
        .build();
  }

  public void requestToRampApp(String url) {
    setActual(CompletableFuture.supplyAsync(() -> {
      try {
        HttpGet get = new HttpGet(url);
        get.setHeader("Accept", "application/json-object");
        get.setHeader("rampinternal", "true");
        get.setHeader("X-Forwarded-For", "s3://ramp-optimization/entities_data/experiments_meta_data.json");
        HttpResponse response = httpclient.execute(get);
        if (response.getEntity() != null) {
          response.setEntity(new BufferedHttpEntity(response.getEntity()));
        } else {
          response.setEntity(new StringEntity(""));
        }
        
        return response;


      } catch (IOException e) {
        throw new UncheckedIOException("failed to send request (" + url + ") ", e);
      }
    }));
  }

  public String getHost() {
    return host;
  }

  public void setHost(String host) {
    this.host = host;
  }

  public String getPort() {
    return port;
  }

  public void setPort(String port) {
    this.port = port;
  }
}
