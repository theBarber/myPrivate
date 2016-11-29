package com.undertone.automation;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.regex.Pattern;

import cucumber.runtime.formatter.CucumberJSONFormatter;
import gherkin.formatter.model.Match;
import gherkin.formatter.model.Result;;

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

    @Override
    public void match(Match match) {
	if (!match.getLocation().contains("LambdaGlueBase.java")) {
	    super.match(match);
	}
    }

    @Override
    public void before(Match match, Result result) {
	if (!match.getLocation().contains("LambdaGlueBase.java")) {
	    super.before(match, result);
	}
    }

    @Override
    public void after(Match match, Result result) {
	if (!match.getLocation().contains("LambdaGlueBase.java")) {
	    super.after(match, result);
	}
    }
    
}
