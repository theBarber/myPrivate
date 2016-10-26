package com.undertone.automation;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.regex.Pattern;

import cucumber.runtime.formatter.CucumberJSONFormatter;;

public class RotatingJSONFormatter extends CucumberJSONFormatter {
    private static final String DOLLAR = Pattern.quote("$TIMESTAMP$");

    public RotatingJSONFormatter(File out) throws IOException {
	super(fromFile(out));
    }

    private static Appendable fromFile(File f) throws IOException {
	f = new File(new File(System.getProperty("user.dir"), f.getParentFile().getPath()).getAbsoluteFile(),
		f.getName().replaceAll(DOLLAR, Long.toString(System.currentTimeMillis())));
	f.getParentFile().mkdirs();
	f.createNewFile();
	return new BufferedWriter(new FileWriter(f));
    }
}
