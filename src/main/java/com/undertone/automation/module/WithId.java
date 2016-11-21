package com.undertone.automation.module;

import java.util.Objects;
import java.util.function.Predicate;

public interface WithId<T> {
    public T getId();

    static <U> Predicate<WithId<U>> idIs(U id) {
	return i -> Objects.equals(i.getId(), Objects.requireNonNull(id));
    }

}
