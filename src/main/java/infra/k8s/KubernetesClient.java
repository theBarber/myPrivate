package infra.k8s;

import java.io.Closeable;
import java.io.IOException;
import java.util.Objects;
import io.kubernetes.client.ApiException;
import io.kubernetes.client.Exec;
import io.kubernetes.client.models.V1Pod;

public class KubernetesClient implements Closeable {

  private V1Pod pod;

  public KubernetesClient(V1Pod pod) {
    this.pod = pod;
  }

  public void runCommand(String command, String containerName)  {
    Process proc = null;
    try {
      Exec exec = new Exec();
      String[] comm = command.split("\\s+");
      proc = exec.exec(pod, comm , containerName,false, false);
      proc.destroy();
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } finally {
      if (Objects.nonNull(proc)) {
        proc.destroy();
      }
    }
  }

  @Override
  public void close() throws IOException {
    // TODO: 08/07/18  close stream and what not

  }
}
