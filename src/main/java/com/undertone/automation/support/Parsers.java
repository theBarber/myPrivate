package com.undertone.automation.support;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.function.Predicate;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class Parsers {

	private final Object __;

	private Parsers() {
		__ = null;
		if (__ == null)
			;
	}

	private static class NumberFormatParseException extends ParseException {
		private static final long serialVersionUID = -8164703305382254148L;
		public NumberFormatParseException(String s, int errorOffset, NumberFormatException cause) {
			super(s, errorOffset);
			initCause(cause);
		}
	}

	public static final Parser<Long> longParser = new Parser<Long>() {
		@Override
		public Long parse(String source) throws ParseException {
			try {
				return Long.parseLong(source);
			} catch (final NumberFormatException e) {
				throw new NumberFormatParseException(source, 0, e);
			}
		}
	};

	public static final Parser<Integer> intParser = new Parser<Integer>() {
		@Override
		public Integer parse(String source) throws ParseException {
			try {
				return Integer.parseInt(source);
			} catch (final NumberFormatException e) {
				throw new NumberFormatParseException(source, 0, e);
			}
		}
	};

	public static final Parser<Double> doubleParser = new Parser<Double>() {
		@Override
		public Double parse(String source) throws ParseException {
			try {
				return Double.parseDouble(source);
			} catch (final NumberFormatException e) {
				throw new NumberFormatParseException(source, 0, e);
			}
		}
	};
	/**
	 * parse a string into itself, or throw an exception when it is null
	 */
	public static final Parser<String> stringParser = new Parser<String>() {
		@Override
		public String parse(String source) throws ParseException {
			if (source != null) {
				return source;
			}
			throw new ParseException("source string is null", 0);
		}
	};

	/**
	 * parse an object after finding a match, using the given regular expression
	 * 
	 * @param parser
	 *            the parser to run on the match found
	 * @param pattern
	 *            the pattern to search for
	 * @param groupToFind
	 *            when using groups, return the specified group
	 * @return parser for the pattern
	 * @see {@link Pattern#compile(String) }
	 * @see {@link Matcher#group(int)}
	 */
	public static final <T> Parser<T> parseFromRegexp(final Parser<T> parser, String pattern, final int groupToFind) {
		final Matcher m = Pattern.compile(pattern).matcher("");
		return new Parser<T>() {
			@Override
			public T parse(String source) throws ParseException {
				if (m.reset(source).find()) {
					return parser.parse(m.group(groupToFind));
				} else {
					throw new ParseException(source, 0);
				}
			}
		};
	}

	/**
	 * Parser for a multiple lines
	 * 
	 * @param parseInLine
	 *            a parser that will parse a single line into a T object
	 * @param filterValues
	 *            a predicate that filters some of the T objects
	 * @param filterLines
	 *            a predicate that filter lines (sometimes needed for headers,
	 *            footers etc.,) or null to not filter
	 * @return a parser that parses multiple lines and returns an
	 *         {@link Iterable} of T objects, each for a line as parsed by
	 *         parseInLine
	 * */
	public static final <T> Parser<Iterable<T>> parseLines(final Parser<T> parseInLine, Predicate<T> filterValues,
			Predicate<String> filterLines) {
		final Predicate<T> filterValuesLocalPredicate = Optional.ofNullable(filterValues).orElse(x->true);
		final Predicate<String> filterLinesLocalPredicate = Optional.ofNullable(filterLines).orElse(x->true);
		return new Parser<Iterable<T>>() {

			@Override
			public List<T> parse(String source) throws ParseException {
				List<T> lines = new ArrayList<>();
				int pos = 0;
				BufferedReader reader = null;
				try {
					reader = new BufferedReader(new StringReader(source));
					for (String line = reader.readLine(); line != null; line = reader.readLine()) {
						if (filterLinesLocalPredicate.test(line)) {
							try {
								T t = parseInLine.parse(line);
								if (t != null && filterValuesLocalPredicate.test(t)) {
									lines.add(t);
								}
							} catch (ParseException exception) {
								throw new ParseException(source, pos);
							}
						}
						pos += line.length();
					}
					return lines;
				} catch (IOException e) {
					throw new ParseException(source, pos);
				} finally {
					if (reader != null) {
						try {
							reader.close();
						} catch (IOException e) {
							throw new ParseException(e.getMessage(), 0);
						}
					}
				}
			}
		};
	}

}
