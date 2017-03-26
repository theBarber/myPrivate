package entities;

import static java.util.Objects.requireNonNull;

import java.util.Comparator;

import com.fasterxml.jackson.annotation.JsonProperty;

import infra.module.Named;
import infra.module.WithId;

public class Zone implements Named, WithId<Integer>, Comparable<Zone> {

	private final String name;
	private final Integer id;
	private Integer adunitid;

	public Zone(@JsonProperty("zoneName") String name, @JsonProperty("zoneId") Integer id) {
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

	public Integer getAdunitid() {
		return adunitid;
	}

	@JsonProperty("adUnitId")
	private void setAdunitid(Integer adunitid) {
		this.adunitid = adunitid;
	}
}
