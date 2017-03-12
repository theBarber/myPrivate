package entities;

import static java.util.Objects.requireNonNull;

import java.util.Comparator;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Stream;

import com.fasterxml.jackson.annotation.JsonProperty;

import infra.module.Named;
import infra.module.WithId;

public class ZoneSet implements Named, WithId<Integer>, Comparable<ZoneSet> {

	private final String name;
	private final Integer id;

	@JsonProperty("Zones")
	private Set<Zone> zones = new TreeSet<>();

	public ZoneSet(@JsonProperty("zonesetName") String name, @JsonProperty("zonesetId") Integer id) {
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

	public Stream<Zone> zones() {
		return this.zones.stream();
	}

	@Override
	public int compareTo(ZoneSet that) {
		return Comparator.comparing(ZoneSet::getId).compare(this, requireNonNull(that));
	}

	<Z extends Zone> Z addZone(Z zone) {
		zones.add(zone);
		return zone;
	}
}
