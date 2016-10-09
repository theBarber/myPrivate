package com.undertone.qa;

import static java.util.Objects.requireNonNull;

import java.util.Comparator;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Stream;

import com.undertone.automation.module.Named;
import com.undertone.automation.module.WithId;

public class ZoneSet implements Named, WithId, Comparable<ZoneSet> {

    private final String name, id;

    private Set<Zone> zones = new TreeSet<>();

    ZoneSet(String name, String id) {
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

    public Stream<Zone> zones() {
	return this.zones.stream();
    }

    @Override
    public int compareTo(ZoneSet that) {
	return Comparator.comparing(ZoneSet::getId).compare(this, requireNonNull(that));
    }

    <Z extends Zone> Z addZone(Z zone){
	zones.add(zone);
	return zone;
    }
}
