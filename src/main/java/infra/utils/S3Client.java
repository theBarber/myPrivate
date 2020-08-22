package infra.utils;

import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.*;

import org.junit.Assert;

import java.io.*;
import java.util.Properties;

import static org.hamcrest.core.Is.is;

/**
 * Created by nive on 2016-09-27.
 */
public class S3Client {
    final private String PROP_PATH = "src/main/resources/user_info.properties";
    private static AmazonS3 amazonS3;

    public S3Client() {
        Properties prop = new Properties();
        try {
            BufferedReader in = new BufferedReader(new FileReader(PROP_PATH));
            prop.load(in);
            in.close();
        } catch (IOException e) {
            Assert.fail(e.getMessage());
        }
        try {
        AWSCredentials s3Credential = new BasicAWSCredentials(prop.getProperty("s3_access_key"),
                prop.getProperty("s3_secret_key"));

        AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(s3Credential);
        amazonS3 = AmazonS3ClientBuilder
                .standard()
                .withRegion(prop.getProperty("s3_region"))
                .withCredentials(credentialsProvider)
                .build();
        // Get the existing object ACL that we want to modify.
        AccessControlList acl = amazonS3.getObjectAcl("ramp-delivery-qa-east-new", prop.getProperty("s3_secret_key"));

        // Clear the existing list of grants.
        acl.getGrantsAsList().clear();

        // Grant a sample set of permissions, using the existing ACL owner for Full Control permissions.
//        acl.grantPermission(new CanonicalGrantee(acl.getOwner().getId()), Permission.FullControl);
//        acl.grantPermission(new EmailAddressGrantee(emailGrantee), Permission.WriteAcp);

        // Save the modified ACL back to the object.
        amazonS3.setObjectAcl("ramp-delivery-qa-east-new", prop.getProperty("s3_secret_key"), acl);
        } catch (AmazonServiceException e) {
            // The call was transmitted successfully, but Amazon S3 couldn't process
            // it, so it returned an error response.
            e.printStackTrace();
        } catch (SdkClientException e) {
            // Amazon S3 couldn't be contacted for a response, or the client
            // couldn't parse the response from Amazon S3.
            e.printStackTrace();
        }
    }

    public PutObjectResult uploadFile(String from, String to) {
        PutObjectResult res = null;
        try {
            int bucketDel = to.indexOf('/');
            File file = new File(from);
            String uploadKey = to.substring(bucketDel + 1);
            res = amazonS3.putObject(new PutObjectRequest(to.substring(0, bucketDel), uploadKey, file));
        } catch (AmazonClientException e) {
            Assert.fail(e.getMessage());
        }
        return res;
    }

    public ObjectMetadata downloadFile(String from, String to) {
        ObjectMetadata res = null;
        try {
            int bucketDel = from.indexOf('/');
            File file = new File(to);
            String uploadKey = from.substring(bucketDel + 1);
            res = amazonS3.getObject(new GetObjectRequest(from.substring(0, bucketDel), uploadKey), file);
        } catch (AmazonClientException e) {
            Assert.fail(e.getMessage());
        }
        return res;
    }

    public void deleteFile(String f) {
        try {
            int bucketDel = f.indexOf('/');
            amazonS3.deleteObject(f.substring(0, bucketDel), f.substring(bucketDel + 1));
        } catch (AmazonClientException e) {
            Assert.fail(e.getMessage());
        }
    }

    public void assertFileContains(String fileName, String value) {
        S3Object res = null;
        try {
            int bucketDel = fileName.indexOf('/');
            String uploadKey = fileName.substring(bucketDel + 1);
            res = amazonS3.getObject(new GetObjectRequest(fileName.substring(0, bucketDel), uploadKey));
        } catch (AmazonClientException e) {
            Assert.fail(e.getMessage());
        }
        Assert.assertThat("The s3 file doesn't contains the value of: " + value, isFileContentContains(res.getObjectContent(), value), is(true));
    }

    private boolean isFileContentContains(InputStream inputStreamContent, String value) {
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStreamContent));
        try {
            while (reader.ready()) {
                String line = reader.readLine();
                if (line != null) // maybe adding check that smaller than 200 character not valid..
                {
                    if (line.contains(value))
                        return true;
                } else {
                    break;
                }
            }
        } catch (IOException e) {
            Assert.fail(e.getMessage());
        }
        return false;
    }
}
