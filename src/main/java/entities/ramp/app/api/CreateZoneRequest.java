package entities.ramp.app.api;

import com.fasterxml.jackson.annotation.JsonProperty;

public class CreateZoneRequest {
    private String zoneName;
    private String adUnitId;
    private String limitation;
    private String updatedAt;
    private String webSectionId;
    private String passback;

    public CreateZoneRequest(@JsonProperty("zoneName")String zoneName, @JsonProperty("adUnitId")String adUnitId, @JsonProperty("limitation")String limitation,@JsonProperty("webSectionId")String webSectionId,  @JsonProperty("updatedAt")String updatedAt, @JsonProperty("passback")String passback)
    {
        this.zoneName = zoneName;
        this.adUnitId = adUnitId;
        this.limitation = limitation;
        this.updatedAt = updatedAt;
        this.passback = passback;
        this.webSectionId = webSectionId;
    }

    public void setZoneName(String zoneName) {
        this.zoneName = zoneName;
    }

    public void setAdUnitId(String adUnitId) {
        this.adUnitId = adUnitId;
    }

    public void setLimitation(String limitation) {
        this.limitation = limitation;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }

    public void setPassback(String passback) {
        this.passback = passback;
    }

    public String getZoneName() {
        return zoneName;
    }

    public String getAdUnitId() {
        return adUnitId;
    }

    public String getLimitation() {
        return limitation;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public String getPassback() {
        return passback;
    }

    public String getWebSectionId() {
        return webSectionId;
    }

    public void setWebSectionId(String webSectionId) {
        this.webSectionId = webSectionId;
    }
}
