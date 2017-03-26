package infra.assertion;

import org.junit.Assert;

public class DefaultAssertionListener<T> implements AssertionListener<T> {

    @Override
    public void assertionPassed(T actual, AbstractAssertionLogic<T> logic) {
	// default - do nothing
    }

    @Override
    public void assertionFailed(T actual, AbstractAssertionLogic<T> logic) {
	// Reporter.log("Assertion failed: " + logic.getTitle(),
	// logic.getMessage(), false);
	Assert.fail(logic.getTitle());

    }

    @Override
    public void assertionFailed(T actual, AbstractAssertionLogic<T> logic, Throwable t) {
	// Reporter.log("Assertion process failed: ", t);
	Exception e = new Exception(logic.getTitle(), t);
	Assert.fail(e.getMessage());
    }
};