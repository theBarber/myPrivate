package ramp.lift.uas.automation;

import com.fasterxml.jackson.databind.JsonNode;
import entities.ramp.app.api.ThrottlingRequest;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.junit.Assert;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;


public class RampAppPublisherRequestModule extends RampAppRequestModule implements AutoCloseable {

    private JsonNode requests;
    final private String RQUEST_BODY_SOURCE_FILE_PATH = "/input_files/requestBodies.json";

    public RampAppPublisherRequestModule(String host, String port) {
        super(host, port);
    }
    public void updateThrottling(Integer placementGroupId, Integer publisherId, String inputJson){

        String putEndpoint = getServicesURL("/api/v1/publisher/" + publisherId + "/placement-groups/" + placementGroupId);

        CloseableHttpClient httpclient = HttpClients.createDefault();

        HttpPut httpPut = new HttpPut(putEndpoint);
        httpPut.setHeader("Accept", "application/json");
        httpPut.setHeader("Content-type", "application/json");
        httpPut.setHeader("rampInternal", "true");

        try {
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
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void setupThrottling(Integer publisherId, String scenario)
    {
        if(requests == null)
        {
            try {
                requests = mapper.readTree(this.getClass().getResourceAsStream(RQUEST_BODY_SOURCE_FILE_PATH));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        JsonNode jsonNode = requests.get(scenario);
        Assert.assertNotNull( "There is no suitable scenario for scenario: "+scenario, jsonNode);
        sut.getRampAppPublisherRequestModule().updateThrottling(jsonNode.get("id").intValue(), publisherId, jsonNode.toString());
    }

}
