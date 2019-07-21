package infra.utils;

import java.io.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

public class ScenarioInventory {

    private static ScenarioInventory instance;
    private ScenarioInventory(){
    }


    public static ScenarioInventory getInstance(){
        if(instance==null){
            instance = new ScenarioInventory();
        }
        return instance;
    }
    Map<String, ArrayList<String>> s = new ConcurrentHashMap<>();


    public void add(String sc){
        String key = sc.split(":")[1];
        String value = sc.split(":")[2];
        ArrayList<String> dummy = new ArrayList<>();
        if (!s.containsKey(key)) {
            dummy.add(value);
            s.put(key, dummy);
        }

        if (s.containsKey(key) && !s.get(key).contains(value)) {
            writeToFile(sc);
            dummy = s.get(key);
            dummy.add(value);
            s.put(key, dummy);
        }
    }


    public void writeToFile(String sc) {
        FileOutputStream fop = null;
        File file;

        try {
            file = new File("target/rerun.txt");
            fop = new FileOutputStream(file, true);

            // if file doesnt exists, then create it
            if (!file.exists()) {
                file.createNewFile();
            }
            fop.write(sc.getBytes());
            fop.write(System.lineSeparator().getBytes());

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (fop != null) {
                    fop.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
