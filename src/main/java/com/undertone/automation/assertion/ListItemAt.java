package com.undertone.automation.assertion;

import static org.hamcrest.core.AllOf.allOf;
import static org.hamcrest.core.IsEqual.equalTo;

import java.util.ArrayList;
import java.util.List;

import org.hamcrest.Description;
import org.hamcrest.Factory;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeDiagnosingMatcher;

public class ListItemAt<T> extends TypeSafeDiagnosingMatcher<List<? super T>> {
    private final Matcher<? super T> elementMatcher;
    private final int index;

    public ListItemAt(int index, Matcher<? super T> elementMatcher) {
	this.index = index;
        this.elementMatcher = elementMatcher;
    }

    @Override
    protected boolean matchesSafely(List<? super T> collection, Description mismatchDescription) {
        boolean isPastFirst = false;
        if (elementMatcher.matches(collection.get(index)){
            return true;
        }
        elementMatcher.describeMismatch(collection, mismatchDescription);
        
        return false;
    }

    @Override
    public void describeTo(Description description) {
        description
            .appendText("a list containing ")
            .appendDescriptionOf(elementMatcher) .appendText(" at index " + index) ;
    }

    
    /**
     * Creates a matcher for {@link Iterable}s that only matches when a single pass over the
     * examined {@link Iterable} yields at least one item that is matched by the specified
     * <code>itemMatcher</code>.  Whilst matching, the traversal of the examined {@link Iterable}
     * will stop as soon as a matching item is found.
     * <p/>
     * For example:
     * <pre>assertThat(Arrays.asList("foo", "bar"), hasItem(startsWith("ba")))</pre>
     * 
     * @param itemMatcher
     *     the matcher to apply to items provided by the examined {@link Iterable}
     */
    @Factory
    public static <T> Matcher<List<? super T>> theItemAt(Matcher<? super T> itemMatcher) {
        return new ListItemAt<T>(itemMatcher);
    }

    /**
     * Creates a matcher for {@link Iterable}s that only matches when a single pass over the
     * examined {@link Iterable} yields at least one item that is equal to the specified
     * <code>item</code>.  Whilst matching, the traversal of the examined {@link Iterable}
     * will stop as soon as a matching item is found.
     * <p/>
     * For example:
     * <pre>assertThat(Arrays.asList("foo", "bar"), hasItem("bar"))</pre>
     * 
     * @param item
     *     the item to compare against the items provided by the examined {@link Iterable}
     */
    @Factory
    public static <T> Matcher<Iterable<? super T>> hasItem(T item) {
        // Doesn't forward to hasItem() method so compiler can sort out generics.
        return new ListItemAt<T>(equalTo(item));
    }

    /**
     * Creates a matcher for {@link Iterable}s that matches when consecutive passes over the
     * examined {@link Iterable} yield at least one item that is matched by the corresponding
     * matcher from the specified <code>itemMatchers</code>.  Whilst matching, each traversal of
     * the examined {@link Iterable} will stop as soon as a matching item is found.
     * <p/>
     * For example:
     * <pre>assertThat(Arrays.asList("foo", "bar", "baz"), hasItems(endsWith("z"), endsWith("o")))</pre>
     * 
     * @param itemMatchers
     *     the matchers to apply to items provided by the examined {@link Iterable}
     */
    @Factory
    public static <T> Matcher<Iterable<T>> hasItems(Matcher<? super T>... itemMatchers) {
        List<Matcher<? super Iterable<T>>> all = new ArrayList<Matcher<? super Iterable<T>>>(itemMatchers.length);
        
        for (Matcher<? super T> elementMatcher : itemMatchers) {
          // Doesn't forward to hasItem() method so compiler can sort out generics.
          all.add(new ListItemAt<T>(elementMatcher));
        }
        
        return allOf(all);
    }
    
    /**
     * Creates a matcher for {@link Iterable}s that matches when consecutive passes over the
     * examined {@link Iterable} yield at least one item that is equal to the corresponding
     * item from the specified <code>items</code>.  Whilst matching, each traversal of the
     * examined {@link Iterable} will stop as soon as a matching item is found.
     * <p/>
     * For example:
     * <pre>assertThat(Arrays.asList("foo", "bar", "baz"), hasItems("baz", "foo"))</pre>
     * 
     * @param items
     *     the items to compare against the items provided by the examined {@link Iterable}
     */
    @Factory
    public static <T> Matcher<Iterable<T>> hasItems(T... items) {
        List<Matcher<? super Iterable<T>>> all = new ArrayList<Matcher<? super Iterable<T>>>(items.length);
        for (T element : items) {
            all.add(hasItem(element));
        }
        
        return allOf(all);
    }

}
