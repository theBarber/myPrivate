package com.undertone.automation.support;

import static java.time.temporal.ChronoUnit.MILLIS;
import static java.time.temporal.ChronoUnit.SECONDS;

import java.time.Duration;
import java.time.temporal.TemporalUnit;
import java.util.Collection;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.TimeoutException;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.function.Supplier;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.StringDescription;

public class FluentWait<T> implements Wait<T> {
    public static final Duration FIVE_HUNDRED_MILLIS = Duration.of(500, MILLIS);

    private final T input;
    private final Clock clock;
    private final Sleeper sleeper;

    private Duration timeout = FIVE_HUNDRED_MILLIS;
    private Duration interval = FIVE_HUNDRED_MILLIS;
    private Supplier<String> messageSupplier = new Supplier<String>() {
	@Override
	public String get() {
	    return null;
	}
    };

    private List<Class<? extends Throwable>> ignoredExceptions = new LinkedList<>();

    /**
     * @param input
     *            The input value to pass to the evaluated conditions.
     */
    public FluentWait(T input) {
	this(input, new SystemClock(), Sleeper.SYSTEM_SLEEPER);
    }

    /**
     * @param input
     *            The input value to pass to the evaluated conditions.
     * @param clock
     *            The clock to use when measuring the timeout.
     * @param sleeper
     *            Used to put the thread to sleep between evaluation loops.
     */
    public FluentWait(T input, Clock clock, Sleeper sleeper) {
	this.input = Objects.requireNonNull(input);
	this.clock = Objects.requireNonNull(clock);
	this.sleeper = Objects.requireNonNull(sleeper);
    }

    /**
     * Sets how long to wait for the evaluated condition to be true. The default
     * timeout is {@link #FIVE_HUNDRED_MILLIS}.
     *
     * @param duration
     *            The timeout duration.
     * @param unit
     *            The unit of time.
     * @return A self reference.
     */
    public FluentWait<T> withTimeout(long duration, TemporalUnit unit) {
	this.timeout = Duration.of(duration, unit);
	return this;
    }

    /**
     * Sets the message to be displayed when time expires.
     *
     * @param message
     *            to be appended to default.
     * @return A self reference.
     */
    public FluentWait<T> withMessage(final String message) {
	this.messageSupplier = new Supplier<String>() {
	    @Override
	    public String get() {
		return message;
	    }
	};
	return this;
    }

    /**
     * Sets the message to be evaluated and displayed when time expires.
     *
     * @param messageSupplier
     *            to be evaluated on failure and appended to default.
     * @return A self reference.
     */
    public FluentWait<T> withMessage(Supplier<String> messageSupplier) {
	this.messageSupplier = messageSupplier;
	return this;
    }

    /**
     * Sets how often the condition should be evaluated.
     *
     * <p>
     * In reality, the interval may be greater as the cost of actually
     * evaluating a condition function is not factored in. The default polling
     * interval is {@link #FIVE_HUNDRED_MILLIS}.
     *
     * @param duration
     *            The timeout duration.
     * @param unit
     *            The unit of time.
     * @return A self reference.
     */
    public FluentWait<T> pollingEvery(long duration, TemporalUnit unit) {
	this.interval = Duration.of(duration, unit);
	return this;
    }

    /**
     * Configures this instance to ignore specific types of exceptions while
     * waiting for a condition. Any exceptions not whitelisted will be allowed
     * to propagate, terminating the wait.
     *
     * @param types
     *            The types of exceptions to ignore.
     * @param <K>
     *            an Exception that extends Throwable
     * @return A self reference.
     */
    public <K extends Throwable> FluentWait<T> ignoreAll(Collection<Class<? extends K>> types) {
	ignoredExceptions.addAll(types);
	return this;
    }

    /**
     * @see #ignoreAll(Collection)
     * @param exceptionType
     *            exception to ignore
     * @return a self reference
     */
    public FluentWait<T> ignoring(Class<? extends Throwable> exceptionType) {
	return this.ignoreAll(Collections.singleton(exceptionType));
    }

    /**
     * @see #ignoreAll(Collection)
     * @param firstType
     *            exception to ignore
     * @param secondType
     *            another exception to ignore
     * @return a self reference
     */
    public FluentWait<T> ignoring(Class<? extends Throwable> firstType, Class<? extends Throwable> secondType) {
	return this.ignoring(firstType).ignoring(secondType);
    }

    /**
     * Repeatedly applies this instance's input value to the given predicate
     * until the timeout expires or the predicate evaluates to true.
     *
     * @param isTrue
     *            The predicate to wait on.
     * @throws TimeoutException
     *             If the timeout expires.
     */
    public void until(final Predicate<T> isTrue) {
	until(new Function<T, Boolean>() {
	    public Boolean apply(T input) {
		return isTrue.test(input);
	    }

	    public String toString() {
		return isTrue.toString();
	    }
	});
    }

    /**
     * Repeatedly applies this instance's input value to the given predicate
     * until the timeout expires or the predicate evaluates to true.
     *
     * @param isTrue
     *            The predicate to wait on.
     * @throws TimeoutException
     *             If the timeout expires.
     */
    public void until(final Matcher<T> isTrue) {
	until(new Function<T, Boolean>() {
	    public Boolean apply(T input) {
		return isTrue.matches(input);
	    }

	    public String toString() {
		Description description = new StringDescription();
		description.appendText(" until ");
		if (input == null) {
		    isTrue.describeMismatch(input, description);
		} else {
		    isTrue.describeTo(description);
		}
		return description.toString();
	    }
	});
    }

    /**
     * Repeatedly applies this instance's input value to the given function
     * until one of the following occurs:
     * <ol>
     * <li>the function returns neither null nor false,</li>
     * <li>the function throws an unignored exception,</li>
     * <li>the timeout expires,
     * <li>
     * <li>the current thread is interrupted</li>
     * </ol>
     *
     * @param isTrue
     *            the parameter to pass to the {@link ExpectedCondition}
     * @param <V>
     *            The function's expected return type.
     * @return The functions' return value if the function returned something
     *         different from null or false before the timeout expired.
     * @throws TimeoutException
     *             If the timeout expires.
     */
    public <V> V until(Function<? super T, V> isTrue) {
	long end = clock.laterBy(timeout.get(MILLIS));
	Throwable lastException = null;
	while (true) {
	    try {
		V value = isTrue.apply(input);
		if (value != null && Boolean.class.equals(value.getClass())) {
		    if (Boolean.TRUE.equals(value)) {
			return value;
		    }
		} else if (value != null) {
		    return value;
		}

		// Clear the last exception; if another retry or timeout
		// exception would
		// be caused by a false or null value, the last exception is not
		// the
		// cause of the timeout.
		lastException = null;
	    } catch (Throwable e) {
		lastException = propagateIfNotIgnored(e);
	    }

	    // Check the timeout after evaluating the function to ensure
	    // conditions
	    // with a zero timeout can succeed.
	    if (!clock.isNowBefore(end)) {
		String message = messageSupplier != null ? messageSupplier.get() : null;

		String timeoutMessage = String.format(
			"Expected condition failed: %s (tried for %d second(s) with %s interval)",
			message == null ? "waiting for " + isTrue : message, timeout.get(SECONDS), interval);
		throw timeoutException(timeoutMessage, lastException);
	    }

	    try {
		sleeper.sleep(interval);
	    } catch (InterruptedException e) {
		Thread.currentThread().interrupt();
		throw new RuntimeException(e);
	    }
	}
    }

    private Throwable propagateIfNotIgnored(Throwable e) {
	for (Class<? extends Throwable> ignoredException : ignoredExceptions) {
	    if (ignoredException.isInstance(e)) {
		return e;
	    }
	}
	throw new RuntimeException(e);
    }

    /**
     * Throws a timeout exception. This method may be overridden to throw an
     * exception that is idiomatic for a particular test infrastructure, such as
     * an AssertionError in JUnit4.
     *
     * @param message
     *            The timeout message.
     * @param lastException
     *            The last exception to be thrown and subsequently suppressed
     *            while waiting on a function.
     * @return Nothing will ever be returned; this return type is only specified
     *         as a convenience.
     */
    protected RuntimeException timeoutException(String message, Throwable lastException) {
	RuntimeException exception = new RuntimeException(new TimeoutException(message));
	exception.addSuppressed(lastException);
	return exception;
    }
}
