/**
 * 
 */
package infra.assertion;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import infra.support.StringUtils;

/**
 * @author Aharon hacmon
 *
 */
public class FailSafeAssertionListener<T> implements AssertionListener<T> {

    /*
     * (non-Javadoc)
     * 
     * @see
     * il.co.topq.integframework.assertion.AssertionListener#assertionPassed(
     * java.lang.Object,
     * il.co.topq.integframework.assertion.AbstractAssertionLogic)
     */
    @Override
    public void assertionPassed(T actual, AbstractAssertionLogic<T> logic) {
	// TODO Auto-generated method stub

    }

    protected final List<Throwable> suppressed = new ArrayList<>();

    /*
     * (non-Javadoc)
     * 
     * @see
     * il.co.topq.integframework.assertion.AssertionListener#assertionFailed(
     * java.lang.Object,
     * il.co.topq.integframework.assertion.AbstractAssertionLogic)
     */
    @Override
    public void assertionFailed(T actual, AbstractAssertionLogic<T> logic) {
	suppressed.add(new AssertionError(
		Optional.ofNullable(logic.message).filter(StringUtils.nonEmpty).orElseGet(logic::getTitle)));
    }

    /*
     * (non-Javadoc)
     * 
     * @see
     * il.co.topq.integframework.assertion.AssertionListener#assertionFailed(
     * java.lang.Object,
     * il.co.topq.integframework.assertion.AbstractAssertionLogic,
     * java.lang.Throwable)
     */
    @Override
    public void assertionFailed(T actual, AbstractAssertionLogic<T> logic, Throwable t) {
	suppressed.add(new AssertionError(
		Optional.ofNullable(logic.message).filter(StringUtils.nonEmpty).orElseGet(logic::getTitle), t));

    }

    public Iterator<Throwable> getSuppressedThrowables() {
	return new ArrayList<>(suppressed).iterator();
    }

    public Throwable getLastSuppressedThrowable() {
	if (suppressed.size() > 0) {
	    return suppressed.get(suppressed.size() - 1);
	}
	return null;
    }

    public Throwable getRootSuppressedThrowable() {
	Throwable t;
	for (t = getLastSuppressedThrowable(); t != null && t.getCause() != null
		&& (t.getCause() != t || !(t instanceof AssertionError)); t = t.getCause())
	    ;/* DoNothing */
	return t;
    }
}
