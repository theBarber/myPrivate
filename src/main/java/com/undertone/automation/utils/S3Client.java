package com.undertone.automation.utils;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.*;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

/**
 * Created by nive on 2016-09-27.
 */
public class S3Client {
    final private String PROP_PATH="src/test/resources/user_info.properties";
    private static AmazonS3 amazonS3;
    private static S3Client client;

    private S3Client()
    {
        Properties prop = new Properties();
        try {
            BufferedReader in = new BufferedReader(new FileReader(PROP_PATH));
            prop.load(in);
            in.close();
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
        AWSCredentials s3Credential =
                new BasicAWSCredentials(prop.getProperty("s3_access_key"), prop.getProperty("s3_secret_key"));
        amazonS3 = new AmazonS3Client(s3Credential);

    }
    public static S3Client getInstance(){
        if(client == null){
            client = new S3Client();
        }
        return client;
    }
    public PutObjectResult uploadFile(String from, String to){
        int bucketDel = to.indexOf('/');
        File file = new File(from);
        String uploadKey = to.substring(bucketDel+1);
        PutObjectResult res = amazonS3.putObject(new PutObjectRequest(to.substring(0,bucketDel),uploadKey,file));
        return res;
    }
    public void deleteFile(String f){
        int bucketDel = f.indexOf('/');
        amazonS3.deleteObject(f.substring(0,bucketDel),f.substring(bucketDel+1));
    }
}
