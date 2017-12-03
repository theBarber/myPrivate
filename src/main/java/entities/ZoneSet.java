package entities;

import static java.util.Objects.requireNonNull;

import java.util.Comparator;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Stream;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import infra.module.Named;
import infra.module.WithId;
@JsonIgnoreProperties(ignoreUnknown = true)
public class ZoneSet implements Named, WithId<Integer>, Comparable<ZoneSet> {

	private String name;
	private Integer id;
	@JsonProperty("Zones")
	private Set<Zone> zones = new TreeSet<>();

	public ZoneSet(){}

	public ZoneSet( String name,  Integer id) {
		this.name = name;
		this.id = id;
	}
	@JsonProperty("zonesetName")
	public void setName(String name) {
		this.name = name;
	}
	@JsonProperty("zonesetId")
	public void setId(Integer id) {
		this.id = id;
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

	public void addZone(Zone zone) {
		zones.add(zone);
	}
}
