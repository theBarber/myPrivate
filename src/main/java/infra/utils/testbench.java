package infra.utils;

import org.apache.commons.codec.binary.Hex;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class testbench {
    public static void main(String[] args) {

        hv();
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
}
