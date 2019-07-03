package infra;

import cucumber.api.junit.Cucumber;
import org.junit.runner.notification.Failure;
import org.junit.runner.notification.RunListener;
import org.junit.runner.notification.RunNotifier;
import org.junit.runners.model.InitializationError;

import java.io.*;
import java.util.HashSet;
import java.util.Set;

public class RerunningCucumber extends Cucumber {

    private final String className;

    @SuppressWarnings("rawtypes")
    public RerunningCucumber(Class clazz) throws InitializationError, IOException {
        super(clazz);
        className = clazz.getSimpleName();
    }


    @Override
    public void run(RunNotifier notifier) {
        notifier.addListener(new RunListener(){

            public void testFailure(Failure failure) throws Exception {

                Throwable error = failure.getException();
                if (error instanceof AssertionError){
                    //Nothing. This is a normal failure. Continue
                    return;
                }

                //No! A wild exception has appeared!
                //Let's run this test again.
                RerunningCucumber.addFile(className);
            }

        });
        super.run(notifier);
    }


    private static final String filename = "target/rerun.properties";
    private static final Set<String> addedClasses = new HashSet<String>();
    public static synchronized void addFile(String className) throws IOException {
        //First find the file

        if (addedClasses.contains(className)){
            return;
        }

        File file = new File(filename);
        if (!file.exists()){
            //Need to create the file
            PrintWriter writer = new PrintWriter(file, "UTF-8");
            writer.print("retryclasses=**/"+className+".class");
            writer.close();
        }
        else {
            PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(file, true)));
            out.print(",**/"+className+".class");
            out.close();
        }

        addedClasses.add(className);
    }
}