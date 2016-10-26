package com.undertone.automation.module;

import java.util.Objects;
import java.util.function.Predicate;

public interface Named {
    public String getName();

    static Predicate<Named> nameIs(String name) {
	return n -> n.getName().equals(Objects.requireNonNull(name));
    }
}