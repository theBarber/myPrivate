package ramp.lift.uas.automation;

import com.couchbase.client.java.Bucket;
import com.couchbase.client.java.Cluster;
import com.couchbase.client.java.CouchbaseCluster;
import com.couchbase.client.java.document.JsonDocument;
import com.couchbase.client.java.document.json.JsonObject;
import com.couchbase.client.java.env.CouchbaseEnvironment;
import com.couchbase.client.java.env.DefaultCouchbaseEnvironment;
import infra.module.AbstractModuleImpl;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * Created by kereng on 5/22/2017.
 */
public class CouchbaseBucketModule extends AbstractModuleImpl<Void>{

  private String name;
  private List<String> nodes;
  Cluster couchbase;
  private Bucket bucket;
  private String ADSERVER_PASS = "adserver";
  private String USERS_PASS = "users";

  public CouchbaseBucketModule(String name, List<String> nodes) {
    this.name = name;
    this.nodes = nodes;

  }

  @Override
  public void init() {
    CouchbaseEnvironment couchbaseEnvironment = DefaultCouchbaseEnvironment.builder()
            //this set the IO socket timeout globally, to 45s
            .socketConnectTimeout((int) TimeUnit.SECONDS.toMillis(45))
            //this sets the connection timeout for openBucket calls globally (unless a particular call provides its own timeout)
            .connectTimeout(TimeUnit.SECONDS.toMillis(60))
            .build();
    couchbase = CouchbaseCluster.create(couchbaseEnvironment, nodes);
    openBucket(name);
  }

  private void openBucket(String name) {
    if (name.contains("adserver")) {
      bucket = couchbase.openBucket(name, ADSERVER_PASS, 1, TimeUnit.MINUTES);
    }
    if (name.contains("user")) {
      bucket = couchbase.openBucket(name, USERS_PASS, 1, TimeUnit.MINUTES);
    }
    else {
      bucket = couchbase.openBucket(name, 1, TimeUnit.MINUTES);
    }
  }

  public Bucket getBucket() {
    return bucket;
  }

  @Override
  public void close() throws Exception {
    if(bucket != null) {
      bucket.close();
      bucket = null;
    }
    if(couchbase != null){
      couchbase.disconnect();
      couchbase = null;
    }
  }

  public void insertDocument(String key, String jsonDoc){
    JsonDocument doc = JsonDocument.create(key, JsonObject.fromJson(jsonDoc));
    bucket.upsert(doc);
  }

  public void deleteDocument(String key){
    bucket.remove(key);
  }
}
