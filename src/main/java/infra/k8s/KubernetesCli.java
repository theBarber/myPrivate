package infra.k8s;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import io.kubernetes.client.ApiClient;
import io.kubernetes.client.ApiException;
import io.kubernetes.client.Configuration;
import io.kubernetes.client.apis.CoreV1Api;
import io.kubernetes.client.models.V1Pod;
import io.kubernetes.client.models.V1PodList;
import io.kubernetes.client.util.Config;

public class KubernetesCli {

  public static void main(String[] args) throws IOException, ApiException, InterruptedException {


    InputStream is = ClassLoader.getSystemResourceAsStream("k8s_integration_password");
    ApiClient client = Config.fromConfig(is);
    is.close();

    Configuration.setDefaultApiClient(client);

    List<V1Pod> pods = new ArrayList<>();
    CoreV1Api api = new CoreV1Api();
    V1PodList list =
        api.listPodForAllNamespaces(null, null, null, null, null, null, null, null, null);
    for (V1Pod item : list.getItems()) {
      if (item.getMetadata().getName().startsWith("ut-ramp-uas")) {
        System.out.println(item.getMetadata().getName());
        pods.add(item);
      }
    }

    V1Pod uasPod = pods.get(0);
//    PodLogs log = new PodLogs();
//    InputStream is = log.streamNamespacedPodLog(uasPod);
//    ByteStreams.copy(is, System.out);


    KubernetesClient kubernetesClient = new KubernetesClient(uasPod);
    kubernetesClient.runCommand("touch duwap", "ut-ramp-uas");





    //    PodLogs logs = new PodLogs();
//    V1Pod pod = api.
//        listNamespacedPod("default", "false", null, null, null, null, null, null, null, null).getItems().get(0);
//
//    InputStream is = logs.streamNamespacedPodLog(pod);
//    ByteStreams.copy(is, System.out);








  }

}
