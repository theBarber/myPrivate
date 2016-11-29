package com.undertone.automation.assertion;

import java.util.regex.Pattern;

import org.hamcrest.core.SubstringMatcher;

public class StringMatchesPattern extends SubstringMatcher {

    public StringMatchesPattern(String pattern) {
	super(pattern);
	Pattern.compile(pattern);
    }

    @Override
    protected boolean evalSubstringOf(String s) {
	return s.matches(substring);
    }

    @Override
    protected String relationship() {
	return "matches regex pattern";
    }

}
