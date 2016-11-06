package com.undertone.automation.support;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.*;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public abstract class StringUtils {
    @SuppressWarnings("unused")
    private final boolean __;

    private StringUtils() {
	__ = true;
    }

    public final static Predicate<String> length(final CompareMethod method, final int length) {
	return new Predicate<String>() {
	    @Override
	    public boolean test(String input) {
		return method.compare(input.length(), length);
	    }
	};
    }

    public final static Predicate<String> is(final CompareMethod compare, final String another) {
	return compare.to(another);
    }

    public final static Predicate<String> startsWith(final String another) {
	return new Predicate<String>() {
	    @Override
	    public boolean test(String input) {
		return input.startsWith(another);
	    }
	};
    }

    public final static Predicate<String> nonEmpty = s -> s != null && s.trim().length() > 0;

    public final static Predicate<String> nullOrEmpty = s -> s == null || s.isEmpty();

    public final static Predicate<String> startsWith(final Collection<String> oneOfTheStrings) {
	// List<Predicate<String>> startWithEitherString = new ArrayList<>();
	// for (String string : oneOfTheStrings) {
	// startWithEitherString.add(startsWith(string));
	// }
	// return Predicates.or(startWithEitherString);
	return s -> oneOfTheStrings.stream().anyMatch(StringUtils.startsWith(s));
    }

    public static String getStackTrace(Throwable t) {
	if (t != null) {
	    StringWriter stringWriter = new StringWriter();
	    PrintWriter printWriter = new PrintWriter(stringWriter);
	    t.printStackTrace(printWriter);
	    return stringWriter.toString();
	}
	return "";
    }

    private static final Function<StackTraceElement, String> getClassNameFunction = new Function<StackTraceElement, String>() {
	@Override
	public String apply(StackTraceElement input) {
	    return input.getClassName();
	}
    };

    public static String getStackTrace(Throwable t, Set<String> packagesToFilter) {
	if (t != null) {
	    if (t.getCause() != null && t.getCause() != t) {
		getStackTrace(t.getCause(), packagesToFilter);
	    }

	    List<StackTraceElement> filteredStackTrace = Arrays.stream(t.getStackTrace())
		    .filter(ste -> startsWith(packagesToFilter).test(ste.getClassName())).collect(Collectors.toList());

	    t.setStackTrace(filteredStackTrace.toArray(new StackTraceElement[] {}));

	    return getStackTrace(t);
	}
	return "";
    }

    public static String getPrefix(String s, String delim) {
	return s.substring(0, s.lastIndexOf(delim));
    }

    /**
     * get the suffix of a string after a specified delimiter
     * 
     * @param s
     *            the string to get the suffix from
     * @param delim
     *            the delimiter to find in it
     * 
     * @return the last part of the string after the delimiter.<br>
     * @throws IndexOutOfBoundsException
     *             when the delimiter does not exist in the string
     */
    public static String getSuffix(String s, String delim) {
	return s.substring(s.lastIndexOf(delim)).substring(delim.length());
    }

    /**
     * get the suffix of a string after a specified delimiter
     * 
     * @param s
     *            the string to get the suffix from
     * @param delim
     *            the delimiter to find in it
     * @param orAll
     *            flag for returning entire string if the delimiter does not
     *            exist in the string
     * @return the last part of the string after the delimiter.<br>
     *         If the delimiter does not exist in the string:
     *         <ul>
     *         <li>if orAll is true: return the entire string</li>
     *         <li>if orAll is false: throws
     *         {@link IndexOutOfBoundsException}</li>
     *         </ul>
     */
    public static String getSuffix(String s, String delim, boolean orAll) {
	return orAll ? s.substring(1 + s.lastIndexOf(delim)) : getSuffix(s, delim);
    }

    /**
     * get the suffix of the source string, after finding the longest substring
     * of prefix.
     * 
     * @param src
     *            the source to find the prefix in
     * @param prefix
     *            the prefix to find.
     * @return the first suffix after the largest substring of prefix.
     */
    public static String getFirstSubStringSuffix(String src, String prefix) {
	return getFirstSubStringSuffix(src, prefix, null);
    }

    /**
     * get the suffix of the source string, after finding the longest substring
     * of prefix.
     * 
     * @param src
     *            the source to find the prefix in
     * @param prefix
     *            the prefix to find.
     * @param prefixLeftovers
     *            a buffer to put the rest of the prefix. ignored if set to null
     * @return the first suffix after the largest substring of prefix.
     */

    public static String getFirstSubStringSuffix(String src, String prefix, StringBuffer prefixLeftovers) {
	int srcIndex = src.indexOf(prefix);
	String subPrefix = prefix;
	while (srcIndex < 0 && subPrefix.length() > 0) {
	    subPrefix = subPrefix.substring(0, subPrefix.length() - 1);
	    srcIndex = src.indexOf(subPrefix);
	}
	if (prefixLeftovers != null && prefixLeftovers.length() == 0 && subPrefix.length() < prefix.length()) {
	    prefixLeftovers.append(getSuffix(prefix, subPrefix));
	}
	return getSuffix(src, subPrefix);
    }

    public static String getFirstSubStringSuffix(String src, String prefix, boolean loopUntilPrefixIsCleared) {
	String result;
	StringBuffer prefixLeftovers = new StringBuffer();
	result = getFirstSubStringSuffix(src, prefix, prefixLeftovers);
	while (prefixLeftovers.length() > 0) {
	    prefix = prefixLeftovers.toString();
	    result = getFirstSubStringSuffix(src, prefix, prefixLeftovers = new StringBuffer());
	}
	return result;
    }
}
