package infra.utils;

import com.amazonaws.services.athena.AmazonAthena;
import infra.utils.AthenaClient.AthenaClientFactory;
import infra.utils.AthenaClient.ExampleConstants;
import org.apache.commons.codec.binary.Hex;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import static infra.utils.AthenaClient.AthenaUtils.*;

public class testbench {
    public static void main(String[] args) {

        testAthena();
    }

    private static void hv() {
        String salt = "dv#Omn!@Xclusion";
        String encodedUrl = "com.peoplefun.wordcross";
        String urlPath = String.format("/dv-iqc?partnerid=%d&bundleid=%s", 81234, encodedUrl);
        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance("SHA-256");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        byte[] bytes = new byte[0];
        try {
            bytes = md.digest((urlPath + salt).getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String urlPathHash = Hex.encodeHexString(bytes);

        System.out.println("http://testauth.iq.doubleverify.com" + urlPath + "&hv=" + urlPathHash);
    }


    private static void testAthena(){

        // Build an AmazonAthena client
        AthenaClientFactory factory = new AthenaClientFactory();
        AmazonAthena athenaClient = factory.createClient();

        String queryExecutionId = submitAthenaQuery(athenaClient, ExampleConstants.ATHENA_SAMPLE_QUERY);

        try {
            waitForQueryToComplete(athenaClient, queryExecutionId);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        processResultRows(athenaClient, queryExecutionId);

    }
}
