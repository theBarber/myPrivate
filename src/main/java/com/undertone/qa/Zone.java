package com.undertone.qa;

import static java.util.Objects.requireNonNull;

import java.util.Comparator;

import com.undertone.automation.module.Named;
import com.undertone.automation.module.WithId;

public class Zone implements Named, WithId, Comparable<Zone> {
    private final String name, id;

    Zone(String name, String id) {
	this.name = requireNonNull(name);
	this.id = requireNonNull(id);
    }

    @Override
    public String getName() {
	return name;
    }

    @Override
    public String getId() {
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
