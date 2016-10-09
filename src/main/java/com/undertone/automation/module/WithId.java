package com.undertone.automation.module;

import java.util.Objects;
import java.util.function.Predicate;

public interface WithId {
    public String getId();

    static Predicate<WithId> idIs(String id) {
	return i -> i.getId().equals(Objects.requireNonNull(id));
    }

}
