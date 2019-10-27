package ramp.lift.uas.automation;

import entities.ramp.app.api.ThrottlingRequest;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.junit.Test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class RampAppPublisherRequestModule extends RampAppRequestModule implements AutoCloseable {

    public RampAppPublisherRequestModule(String host, String port) {
        super(host, port);
    }
    public void updateThrottling(ThrottlingRequest throttlingRequest) throws ClientProtocolException, IOException {

        String putEndpoint = getServicesURL("/api/v1/publisher/" + throttlingRequest.getPublisherId() + "/placement-groups/" + throttlingRequest.getPlacementGroupId());

        CloseableHttpClient httpclient = HttpClients.createDefault();

        HttpPut httpPut = new HttpPut(putEndpoint);
        httpPut.setHeader("Accept", "application/json");
        httpPut.setHeader("Content-type", "application/json");
        httpPut.setHeader("rampInternal", "true");

        String inputJson = "{\n" +
                "\t\t\"id\": " + throttlingRequest.getPlacementGroupId() + ",\n" +
                "\t    \"name\": \"ThrottleTest\",\n" +
                "\t    \"type\": \"bidding\",\n" +
                "\t    \"isActive\": " + (throttlingRequest.getStatus().equals("active")?"true":"false") + ",\n" +
                "\t    \"throttling\":" + throttlingRequest.getFactor() + "\n" +
                "\t}";

        StringEntity stringEntity = new StringEntity(inputJson);
        httpPut.setEntity(stringEntity);
        System.out.println("Executing request " + httpPut.getRequestLine());

        HttpResponse response = httpclient.execute(httpPut);

        BufferedReader br = new BufferedReader(new InputStreamReader((response.getEntity().getContent())));

        //Throw runtime exception if status code isn't 200
        if (response.getStatusLine().getStatusCode() != 200) {
            throw new RuntimeException("Failed : HTTP error code : " + response.getStatusLine().getStatusCode());
        }

        //Create the StringBuffer object and store the response into it.
        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = br.readLine()) != null) {
            System.out.println("Response : \n" + result.append(line));
        }
    }

}
