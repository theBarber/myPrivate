package com.undertone.qa;

import static java.util.Objects.requireNonNull;

import java.util.Comparator;

import com.undertone.automation.module.Named;
import com.undertone.automation.module.WithId;

public class Zone implements Named, WithId<Integer>, Comparable<Zone> {
    private final String name;
    private final Integer id;

    Zone(String name, Integer id) {
	this.name = requireNonNull(name);
	this.id = requireNonNull(id);
    }

    @Override
    public String getName() {
	return name;
    }

    @Override
    public Integer getId() {
	return id;
    }

    @Override
    public int compareTo(Zone that) {
	return Comparator.comparing(Zone::getId).compare(this, requireNonNull(that));
    }

    @Override
    public String toString() {
	return "Zone " + getId() + " [name=" + getName() + "]";
    }
}
