package infra.assertion;

import java.util.List;

import org.hamcrest.Description;
import org.hamcrest.Factory;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeDiagnosingMatcher;

public class ListItemAt<T> extends TypeSafeDiagnosingMatcher<List<T>> {
    private final Matcher<T> elementMatcher;
    private final int index;

    public ListItemAt(int index, Matcher<T> elementMatcher) {
	this.index = index;
	this.elementMatcher = elementMatcher;
    }

    @Override
    protected boolean matchesSafely(List<T> list, Description mismatchDescription) {
	if (elementMatcher.matches(list.get(index))) {
	    return true;
	}
	elementMatcher.describeMismatch(list, mismatchDescription);

	return false;
    }

    @Override
    public void describeTo(Description description) {
	description.appendText("a list containing ").appendDescriptionOf(elementMatcher)
		.appendText(" at index " + index);
    }

    /**
     * Creates a matcher for {@link List}s that only matches the specific item
     * with the given index
     * <p/>
     * For example:
     * 
     * <pre>
     * assertThat(Arrays.asList("foo", "bar"), theItemAt(1, startsWith("ba")))
     * </pre>
     * 
     * @param itemMatcher
     *            the matcher to apply to items provided by the examined
     *            {@link Iterable}
     */
    @Factory
    public static <T> Matcher<List<T>> theItemAt(int index, Matcher<T> itemMatcher) {
	return new ListItemAt<T>(index, itemMatcher);
    }

}
