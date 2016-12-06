package com.undertone.qa;

import static java.util.Objects.requireNonNull;

import java.util.Comparator;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.undertone.automation.module.Named;
import com.undertone.automation.module.WithId;

public class Banner implements Named, WithId<Integer>, Comparable<Banner> {

    private final String name;
    private final int id;

    public Banner(@JsonProperty("creativeName") String name, @JsonProperty("bannerId") Integer id) {
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
    public int compareTo(Banner that) {
	return Comparator.comparing(Banner::getId).compare(this, requireNonNull(that));
    }

    @Override
    public String toString() {
	return "Banner [name=" + getName() + "]";
    }
}
