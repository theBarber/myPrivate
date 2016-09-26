package com.utils;

import com.jcraft.jsch.*;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Properties;
import java.util.Scanner;


public class SshAgent {

    private Session session;

    public SshAgent(String proFile){

        final String PROP_NAME = proFile;
        try{
            Properties prop = new Properties();
            FileInputStream inProp = new FileInputStream(PROP_NAME);
            prop.load(inProp);
            inProp.close();

            JSch jsch = new JSch();
            jsch.addIdentity(prop.getProperty("pem_key"));

            String host = prop.getProperty("host");
            String user = prop.getProperty("user");
            int port = Integer.parseInt(prop.getProperty("port"));
            session = jsch.getSession(user, host, port);
            session.setConfig(prop);
            session.connect();

        }
        catch(Exception e){
            System.out.println(e.getMessage());
        }
    }
    public void enterSshCommand(String comm){
        try {
            Channel ssh = session.openChannel("shell");
            PrintWriter out = new PrintWriter(ssh.getOutputStream());
            ssh.connect();
            out.println(comm);
            out.flush();
            out.close();


        } catch (JSchException | IOException e) {
            System.out.println(e.getMessage());
        }
    }
    public File copyFileFromRemote(String fileToDownload){
        ChannelSftp channel = null;
        File f = null;
        try {
            channel = (ChannelSftp) session.openChannel("sftp");
            channel.connect();

            f = File.createTempFile("trrrrrr",".txt");

            FileOutputStream out = new FileOutputStream(f);
            channel.get(fileToDownload,out);

        } catch (SftpException | JSchException | IOException e) {
            System.out.println(e.getMessage());
        }  finally {
            channel.disconnect();
        }
        return f;
    }
    public boolean compareContent(File f, String s){
        StringBuilder sb = new StringBuilder();
        try {
            Scanner scn = new Scanner(f);
            while (scn.hasNext()){
                sb.append(scn.nextLine()+"\n");
            }

        } catch (FileNotFoundException e) {
            System.out.println(e.getMessage());
        }
        System.out.println(sb);
        return sb.toString().equalsIgnoreCase(s);
    }


    public void close(){
        session.disconnect();
    }
}