package entities.ramp.app.api;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import entities.Zone;

import java.util.Set;
@JsonIgnoreProperties(ignoreUnknown = true)
public class CreateZoneSetRequest {
    private String zonesetName;
    private String agencyId;
    private String zonesetType;
    private Set<Zone> zones;

    public CreateZoneSetRequest(String zonesetName,String agencyId, String zonesetType, Set<Zone> zones)
    {
        this.zonesetName = zonesetName;
        this.agencyId = agencyId;
        this.zonesetType = zonesetType;
        this.zones = zones;
    }
    @JsonProperty("zonesetName")
    public String getZonesetName() {
        return zonesetName;
    }
    @JsonProperty("zonesetName")
    public void setZonesetName(String zonesetName) {
        this.zonesetName = zonesetName;
    }
    @JsonProperty("agencyId")
    public String getAgencyId() {
        return agencyId;
    }
    @JsonProperty("agencyId")
    public void setAgencyId(String agencyId) {
        this.agencyId = agencyId;
    }
    @JsonProperty("zonesetType")
    public String getZonesetType() {
        return zonesetType;
    }
    @JsonProperty("zonesetType")
    public void setZonesetType(String zonesetType) {
        this.zonesetType = zonesetType;
    }
    @JsonProperty("Zones")
    public Set<Zone> getZones() {
        return zones;
    }
    @JsonProperty("Zones")
    public void setZones(Set<Zone> zones) {
        this.zones = zones;
    }
}
