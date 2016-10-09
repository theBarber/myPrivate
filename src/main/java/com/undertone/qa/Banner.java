package com.undertone.qa;

import static java.util.Objects.requireNonNull;

import java.util.Comparator;

import com.undertone.automation.module.Named;
import com.undertone.automation.module.WithId;

public class Banner implements Named, WithId, Comparable<Banner> {

    private final String name, id;

    public Banner(String name, String id) {
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
    public int compareTo(Banner that) {
	return Comparator.comparing(Banner::getId).compare(this, requireNonNull(that));
    }

}
