package infra.utils;

import com.amazonaws.services.s3.AmazonS3;
import com.offbytwo.jenkins.JenkinsServer;
import com.offbytwo.jenkins.model.Build;
import com.offbytwo.jenkins.model.JobWithDetails;
import com.offbytwo.jenkins.model.QueueItem;
import com.offbytwo.jenkins.model.QueueReference;
import org.glassfish.jersey.internal.Errors;

import java.net.URI;

public class JenkinsClient {
    private static final String JENKINS_URL = "http://jenkins.ramp-ut.io/";
    private static final String USER = "yanivc";
    private static final String PASSWORD = "Yle01102210";
    private JenkinsServer js;

    public JenkinsClient() throws Exception{
        js = new JenkinsServer(new URI(JENKINS_URL),USER,PASSWORD);
    }

    public boolean executeJob(String jobName)
    {
        try{
        JobWithDetails job = js.getJob(jobName);
        QueueReference queueRef = job.build(true);

        System.out.println("Ref:" + queueRef.getQueueItemUrlPart());

        job = js.getJob(jobName);
        QueueItem queueItem = js.getQueueItem(queueRef);
        while (!queueItem.isCancelled() && job.isInQueue()) {
            System.out.println("In Queue " + job.isInQueue());
            Thread.sleep(200);
            job = js.getJob(jobName);
            queueItem = js.getQueueItem(queueRef);
        }
        if (queueItem.isCancelled()) {
            System.out.println("Job has been canceled.");
            return false;
        }

        job = js.getJob(jobName);
        Build lastBuild = job.getLastBuild();

        boolean isBuilding = lastBuild.details().isBuilding();
        while (isBuilding) {
            System.out.println("Is building...(" + lastBuild.getNumber() + ")");
            Thread.sleep(2000);
            isBuilding = lastBuild.details().isBuilding();
        }

        System.out.println("Finished.");
        System.out.println(" Result: " + lastBuild.details().getResult());
        return ("SUCCESS".equals(lastBuild.details().getResult().toString()));
       }catch (Exception e)
        {
            throw new Error("error while trying jenkins plugin!!!");
        }
    }

}
