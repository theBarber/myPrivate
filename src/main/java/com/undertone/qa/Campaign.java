package com.undertone.qa;

import static java.util.Objects.requireNonNull;

import java.util.Comparator;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Stream;

import com.undertone.automation.module.Named;
import com.undertone.automation.module.WithId;

public class Campaign implements Named, WithId, Comparable<Campaign> {

    private final String name, id;

    private Set<Banner> banners = new TreeSet<>();
    final Set<ZoneSet> zoneSetAssoc = new TreeSet<>();

    public Campaign(String name, String id) {
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

    public Stream<Banner> banners() {
	return this.banners.stream();
    }

    @Override
    public int compareTo(Campaign that) {
	return Comparator.comparing(Campaign::getId).compare(this, requireNonNull(that));
    }

    public Stream<ZoneSet> getZoneSetAssoc() {
	return zoneSetAssoc.stream();
    }

    <B extends Banner> B addBanner(B b) {
	banners.add(b);
	return b;
    }

    ZoneSet addZoneSet(ZoneSet zoneSet) {
	zoneSetAssoc.add(zoneSet);
	return zoneSet;
    }

    @Override
    public String toString() {
	return "Campaign [name=" + getName() + "]";
    }

}
