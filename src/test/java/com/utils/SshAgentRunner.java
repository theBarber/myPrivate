package com.utils;

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

        sshAgent.enterSshCommand("cat /var/log/ramp-lift-ad-selector/ad-selector.log.1 /var/log/ramp-lift-ad-selector/ad-selector.log > temp_logs\ntac temp_logs | egrep -o -m1 [_[:alnum:]]+\\.json > temp_file_name\nrm temp_logs");
//        File f = sshAgent.copyFileFromRemote("temp_file_name");
//        sshAgent.compareContent(f, "");
//        sshAgent.close();
    }
}
