package entities;

import static java.util.Objects.requireNonNull;

import java.util.Comparator;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import infra.module.Named;
import infra.module.WithId;
@JsonIgnoreProperties(ignoreUnknown = true)
public class Zone implements Named, WithId<Integer>, Comparable<Zone> {

	private Integer id;
	private String name;
	private Integer adunitid;
	private String limitation;
	private String webSectionID;

	public Zone()
	{

	}

	public Zone(Integer id) {
		this.id = id;
	}

	public Zone(String name, Integer id, Integer adunitid, String limitation, String webSectionID) {
		this.id = requireNonNull(id);
		this.name = name;
		this.adunitid = adunitid;
		this.limitation = limitation;
		this.webSectionID = webSectionID;
	}

	@Override
	@JsonProperty("zoneName")
	public String getName() {
		return name;
	}

	@JsonProperty("zoneName")
	public void setName(String name) {
		this.name = name;
	}

	@Override
	@JsonProperty("zoneId")
	public Integer getId() {
		return id;
	}

	@JsonProperty("zoneId")
	public void setId(Integer id) {
		this.id = id;
	}

	@Override
	public int compareTo(Zone that) {
		return Comparator.comparing(Zone::getId).compare(this, requireNonNull(that));
	}

	@Override
	public String toString() {
		return "Zone " + getId() + " [name=" + getName() + "]";
	}

	@JsonProperty("adUnitId")
	public Integer getAdunitid() {
		return adunitid;
	}

	@JsonProperty("adUnitId")
	private void setAdunitid(Integer adunitid) {
		this.adunitid = adunitid;
	}

	@JsonProperty("limitation")
	public String getLimitation() {
		return limitation;
	}

	@JsonProperty("limitation")
	public void setLimitation(String limitation) {
		this.limitation = limitation;
	}

	@JsonProperty("webSectionId")
	public String getWebSectionID() {
		return webSectionID;
	}
	@JsonProperty("webSectionId")
	public void setWebSectionID(String webSectionID) {
		this.webSectionID = webSectionID;
	}

	public void set(String zoneName, String adUnitId, String limitation, String webSectionID) {
		this.name = zoneName;
		this.adunitid = Integer.valueOf(adUnitId);
		this.limitation = limitation;
		this.webSectionID = webSectionID;
	}
}
