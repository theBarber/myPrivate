package com.undertone.automation.utils;

/**
 * Created by nive on 2016-09-25.
 */
public class SshAgentRunner {
    public static void main(String[] args){

//        SshAgent sshAgent = new SshAgent("src\\test\\resources\\user_info.properties");
//        String command1 = StringEscapeUtils.
//                escapeJava("cat /var/log/ramp-lift-ad-selector/ad-selector.log.1 /var/log/ramp-lift-ad-selector/ad-selector.log > temp_logs");
//        String command2 = StringEscapeUtils.escapeJava("tac temp_logs | egrep  -m1 Loaded | egrep -o  solver_plan_[_[:alnum:]]+\\.json > res_log.txt");
//        sshAgent.enterSshCommand(command1,2);
//        sshAgent.enterSshCommand(command2,2);
//        File f = sshAgent.copyFileFromRemote("res_log.txt", 2);
//        sshAgent.enterSshCommand("rm temp_logs", 1);
//        sshAgent.enterSshCommand("rm res_log.txt", 1);
//        sshAgent.compareContent(f, "");
//        sshAgent.close();

        S3Client s3client = S3Client.getInstance();
        s3client.uploadFile("C:\\Users\\nive\\Desktop\\test.txt", "ramp-optimization/qa/nelzam/test.txt");
        s3client.deleteFile("ramp-optimization/qa/nelzam/test.txt");
    }
}
