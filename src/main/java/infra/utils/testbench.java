package infra.utils;

import com.amazonaws.services.athena.AmazonAthena;
import infra.utils.AthenaClient.AthenaClientFactory;
import infra.utils.AthenaClient.ExampleConstants;
import org.apache.commons.codec.binary.Hex;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.LinkedHashMap;
import java.util.Map;

import static infra.utils.AthenaClient.AthenaUtils.*;

//    ramplift-s-ut-ramp-uas-us-east-1-k8s-internal.ramp-ut.io
//  ads-s-us-east-1.undertone.com
public class testbench {
    public static void main(String[] args) {
        String resp = "response = [{\"ad\":\"<html><body><script type=\\\"text/javascript\\\">var ut_ju = 'https://ramplift-s-ut-ramp-uas-us-east-1-k8s-internal.ramp-ut.io/aj';ut = new Object();ut.bidid='21b46f0d859b35';ut.bannerid=1407787;ut.zoneid=190925;ut.hbprice=2.00;ut.fallbackbannerid='';ut.fallbackzoneid='';ut.width=300;ut.height=250;ut.adaptor='prebid';ut.pid=3836;ut.extpid='';ut.domain='DynamicPricingWithMargin7.com';ut.id='OXbidDynMarg';ut.stid=149;ut.win_country='us';ut.win_city='';ut.win_region='';ut.win_dma='0';ut.win_lat='25.811501';ut.win_long='-80.237701';ut.win_mob_car='';ut.win_zip='33142';ut.win_gmt='-400';ut.win_netspeed='broadband';ut.win_isp='choopa%20llc';ut.win_isgdpr='0';ut.win_isUtPii='1';ut.sm='false';ut.os='Desktop';ut.ad_os='';ut.ad_osv='';ut.ad_br='';ut.ad_brv='';ut.brand='Apache';ut.ffactor='Desktop';ut.model='HttpClient';ut.marketing='';ut.release='1994_january';ut.pmethod='mouse';ut.uxdesk='true';ut.resh='600';ut.resw='800';ut.physh='400';ut.physw='400';ut.max_dr='3200';ut.osv='';ut.wd='false';ut.phone='false';ut.lscreen='true';ut.tablet='false';ut.app='true';ut.robot='false';ut.app_webv='false';ut.dyn_price='0';ut.cmargin='-1.000000';ut.po_price='1.000000';ut.placement_id='';</script><script type=\\\"text/javascript\\\" src=\\\"https://cdn.undertone.com/js/ajs.js\\\"></script></body></html>\",\"publisherId\":3836,\"bidRequestId\":\"21b46f0d859b35\",\"placementId\":\"\",\"adId\":1407787,\"campaignId\":349938,\"height\":250,\"width\":300,\"ttl\":720,\"currency\":\"USD\",\"cpm\":2,\"adaptor\":\"prebid\",\"netRevenue\":\"true\"}]";
//        testAthena();
        splitHBQuery(resp);
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

    private static Map<String, String> splitHBQuery(String query){

        Map<String, String> query_pairs = new LinkedHashMap<>();
        String[] pairs = query.split(";");
        pairs[0] = pairs[0].substring(pairs[0].indexOf("ut_ju")).trim();
        for (String pair : pairs) {
            int idx = pair.indexOf("=");
            if(pair.substring(0, idx).contains("ut.") || pair.substring(0, idx).contains("ut_"))
                query_pairs.put(pair.substring(0, idx),pair.substring(idx + 1).trim().replace("'", ""));
        }
        return query_pairs;
    }
}
