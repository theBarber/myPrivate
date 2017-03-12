package infra.utils;

import org.apache.http.HttpResponse;
import org.junit.Assert;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Created by nive on 2016-11-01.
 */
public class HttpContentTest {
    public static String getContent(HttpResponse http) {

	StringBuilder sb = new StringBuilder();
	try {
	    BufferedReader rd = new BufferedReader(new InputStreamReader(http.getEntity().getContent()));
	    String line;
	    while ((line = rd.readLine()) != null) {
		sb.append(line);
	    }
	} catch (IOException e) {
	    Assert.assertNotNull(e);
	}
	return sb.toString();
    }
}
