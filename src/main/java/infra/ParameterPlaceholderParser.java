package infra;

import java.time.format.DateTimeFormatter;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.MissingFormatArgumentException;
import java.util.Optional;
import java.util.function.Function;
import java.util.function.LongBinaryOperator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.time.Clock;
import java.time.LocalTime;

public class ParameterPlaceholderParser<T> {
	private static final String CLASS_DOT_FUNCTION = "([\\w]+)\\.([\\w]+)";

	private static final Pattern CLASS_DOT_FUNCTION_PATTERN = Pattern.compile(CLASS_DOT_FUNCTION);

	public static Pattern bracketEnclosedString() {
		return Pattern.compile("\\$\\{((?>\\w+)(?>[\\.\\w]+)?)((?>\\([,-:\\.\\w\\s]+\\))?)\\}");
	}

	private static String functionToExecute(String functionDotField) {
		return classDotFunction(functionDotField, 2);
	}

	private static String classDotFunction(String functionDotField, int g) {
		Matcher matcher = CLASS_DOT_FUNCTION_PATTERN.matcher(functionDotField);
		matcher.find();
		return matcher.group(g);
	}

	private static String className(String functionDotField) {
		return classDotFunction(functionDotField, 1);
	}

	private final Map<String, ParameterProvider<T>> parameterProviders;

	public ParameterPlaceholderParser(ParameterProvider<T> parameterProvider) {
		this.parameterProviders = new HashMap<>();
		parameterProviders.put(parameterProvider.className().toLowerCase(), parameterProvider);
	}

	public ParameterPlaceholderParser(Collection<ParameterProvider<T>> parameterProviders) {
		this.parameterProviders = new HashMap<>(parameterProviders.size());
		parameterProviders.forEach(p -> this.parameterProviders.put(p.className().toLowerCase(), p));
		if (parameterProviders.size() != this.parameterProviders.size()) {
			throw new IllegalArgumentException("ParameterProvider Collision");
		}
	}

	public String replacePlaceholderOf(String parameter) {
		StringBuilder parameterBuilder = new StringBuilder(parameter);
		Matcher matcheCurlyBracketTemplate = bracketEnclosedString().matcher(parameterBuilder);
		while (matcheCurlyBracketTemplate.find()) {
			String function;

			function = matcheCurlyBracketTemplate.group(1);

			String replaceWith = "";

			if (!CLASS_DOT_FUNCTION_PATTERN.matcher(function).find()) {
				switch (function) {
				case "guid":
				case "uuid":
					replaceWith = java.util.UUID.randomUUID().toString();
					break;
				case "UTC_Time":
					replaceWith = LocalTime.now(Clock.systemUTC()).format(DateTimeFormatter.ofPattern("HH"));
					break;
				}

			} else {
				String className = className(function).toLowerCase();
				String params = null;
				if (matcheCurlyBracketTemplate.groupCount() == 2) {
					params = matcheCurlyBracketTemplate.group(2);
					if (!params.isEmpty()) {
						params = params.substring(1, params.length() - 1);
					}
				} else {
					throw new MissingFormatArgumentException("invalid template:" + parameter + " missing params");
				}

				switch (className) {
				case "string": {
					String functionToExecute = functionToExecute(function);
					String[] p = params.split(":");
					if (p.length == 3 && functionToExecute.equalsIgnoreCase("isempty")) {
						replaceWith = (p[0].isEmpty()) ? p[1] : p[2];
					} else if (p.length == 4 && functionToExecute.equalsIgnoreCase("equals")) {
						replaceWith = (p[0].equals(p[1]) ? p[2] : p[3]);
					} else {
						throw new MissingFormatArgumentException("invalid template:" + parameter + " missing params");
					}
				}
					break;
				case "system": {
					String functionToExecute = functionToExecute(function);
					if (functionToExecute.equalsIgnoreCase("currentTimeMillis")) {
						replaceWith = String.valueOf(System.currentTimeMillis());
					} else {
						throw new MissingFormatArgumentException("invalid template:" + parameter + " missing params");
					}
				}
					break;
				case "int":
				case "long":
				case "integer": {
					String[] p = params.split(":");
					String functionToExecute = functionToExecute(function).toLowerCase();

					LongBinaryOperator f;
					switch (functionToExecute) {
					case "sum":
					case "add":
						f = Long::sum;
						break;
					case "substract":
					case "minus":
						f = (a, b) -> a - b;
						break;
					case "divide":
						f = Long::divideUnsigned;
						break;
					case "modulus":
					case "reminder":
						f = Long::remainderUnsigned;
						break;
					case "truncate":
						f = (a, b) -> a - Long.remainderUnsigned(a, b);
						break;
					case "min":
						f = Long::min;
						break;
					case "max":
						f = Long::max;
						break;
					default:
						throw new MissingFormatArgumentException("invalid template:" + parameter + " missing params");
					}
					if (p.length == 2) {
						long operand1 = Long.valueOf(p[0]), oprerand2 = Long.valueOf(p[1]);
						replaceWith = String.valueOf(f.applyAsLong(operand1, oprerand2));
					} else {
						throw new MissingFormatArgumentException("invalid template:" + parameter + " missing params");
					}
				}
					break;
				default:
					ParameterProvider<T> parameterProvider = this.parameterProviders.get(className);
					String objectToFind = params;

					if (parameterProvider != null) {
						String functionToExecute = functionToExecute(function);
						Function<String, Optional<? extends T>> find = parameterProvider.getterFor(functionToExecute);
						replaceWith = find.apply(objectToFind).map(parameterProvider::stringify)
								.orElseThrow(() -> new IllegalArgumentException(
										"the " + functionToExecute + " named " + objectToFind + " does not exist!"));
					} else {
						throw new MissingFormatArgumentException("invalid template:" + className);
					}
				}
			}

			matcheCurlyBracketTemplate.reset(parameterBuilder.replace(matcheCurlyBracketTemplate.start(),
					matcheCurlyBracketTemplate.end(), replaceWith));
		}
		return parameterBuilder.toString();
	}

}
