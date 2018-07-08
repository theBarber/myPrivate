package ramp.lift.uas.automation;

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

import infra.k8s.KubernetesClient;

public class UAScontainer {

  private List<KubernetesClient> kubernetesClients;
  public static final String UAS_CONTAINER = "ut-ramp-uas";

  private UAScontainer(String path) throws ApiException, IOException {
    InputStream is = this.getClass().getClassLoader().getResourceAsStream(path);
    ApiClient client = Config.fromConfig(is);
    is.close();

    Configuration.setDefaultApiClient(client);

    List<V1Pod> pods = new ArrayList<>();
    CoreV1Api api = new CoreV1Api();
    V1PodList list =
        api.listPodForAllNamespaces(null, null, null, null, null, null, null, null, null);
    for (V1Pod item : list.getItems()) {
      if (item.getMetadata().getName().startsWith(UAS_CONTAINER)) {
        pods.add(item);
      }
    }
    kubernetesClients = new ArrayList<>();
    pods.forEach(pod -> kubernetesClients.add(new KubernetesClient(pod)));
  }

  public void runCommand(String command) {
    kubernetesClients.forEach(cli -> cli.runCommand(command, UAS_CONTAINER));
  }

  public static class Builder {
    private String path2Config;

    public Builder() {
    }

    public Builder setConfig(String path) {
      path2Config = path;
      return this;
    }

    public UAScontainer build() {
      UAScontainer uaScontainer = null;
      try {
        uaScontainer = new UAScontainer(this.path2Config);
      } catch (ApiException | IOException ex) {
        System.out.println(ex.getMessage());
      }
      return uaScontainer;
    }
  }
}
