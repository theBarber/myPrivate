package com.utils;

import org.apache.commons.lang.StringEscapeUtils;

import java.io.File;

/**
 * Created by nive on 2016-09-25.
 */
public class SshAgentRunner {
    public static void main(String[] args){
//        try {
//            Thread.currentThread().wait(1000*60*6);
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
        SshAgent sshAgent = new SshAgent("src\\test\\resources\\user_info.properties");
        String command1 = StringEscapeUtils.
                escapeJava("cat /var/log/ramp-lift-ad-selector/ad-selector.log.1 /var/log/ramp-lift-ad-selector/ad-selector.log > temp_logs");
        String command2 = StringEscapeUtils.escapeJava("tac temp_logs | egrep  -m1 Loaded | egrep -o  solver_plan_[_[:alnum:]]+\\.json > res_log.txt");
        sshAgent.enterSshCommand(command1,2);
        sshAgent.enterSshCommand(command2,2);
        File f = sshAgent.copyFileFromRemote("res_log.txt", 2);
        sshAgent.enterSshCommand("rm temp_logs", 1);
        sshAgent.enterSshCommand("rm res_log.txt", 1);
        sshAgent.compareContent(f, "");
        sshAgent.close();
    }
}
