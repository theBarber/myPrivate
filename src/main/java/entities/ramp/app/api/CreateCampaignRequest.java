package entities.ramp.app.api;

import java.time.temporal.Temporal;
import java.util.List;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonProperty;
import entities.LineItem;

public class CreateCampaignRequest {

    private String campaignName;
    private String lineItemId;
    private Zonesets zonesets;
    private List<Integer> selectedCreativeIds;
    private String startDateTime;
    private String endDateTime;
    private String priority;

    public CreateCampaignRequest(String campaignName, String lineItemId, Zonesets zonesets, List<Integer> selectedCreativeIds, String startDateTime, String endDateTime,String priority)
    {
        this.campaignName = campaignName;
        this.lineItemId = lineItemId;
        this.zonesets = zonesets;
        this.selectedCreativeIds = selectedCreativeIds;
        this.startDateTime = startDateTime;
        this.endDateTime = endDateTime;
        this.priority = priority;
    }
    @JsonProperty("campaignName")
    public String getCampaignName() {
        return campaignName;
    }

    @JsonProperty("campaignName")
    public void setCampaignName(String campaignName) {
        this.campaignName = campaignName;
    }

    @JsonProperty("lineItemId")
    public String getLineItemId() {
        return lineItemId;
    }
    @JsonProperty("lineItemId")
    public void setLineItemId(String lineItemId) {
        this.lineItemId = lineItemId;
    }

    @JsonProperty("Zonesets")
    public Zonesets getZonesets() {
        return zonesets;
    }

    @JsonProperty("Zonesets")
    public void setZonesets(Zonesets zonesets) {
        this.zonesets = zonesets;
    }

    @JsonProperty("selectedCreativeIds")
    public List<Integer> getSelectedCreativeIds() {
        return selectedCreativeIds;
    }

    @JsonProperty("selectedCreativeIds")
    public void setSelectedCreativeIds(List<Integer> selectedCreativeIds) {
        this.selectedCreativeIds = selectedCreativeIds;
    }

    @JsonProperty("startDateTime")
    public String getStartDateTime() {
        return startDateTime;
    }

    public void setStartDateTime(String startDateTime) {
        this.startDateTime = startDateTime;
    }

    @JsonProperty("endDateTime")
    public String getEndDateTime() {
        return endDateTime;
    }

    public void setEndDateTime(String endDateTime) {
        this.endDateTime = endDateTime;
    }

    @JsonProperty("priority")
    public String getPriority() {
        return priority;
    }
    @JsonProperty("priority")
    public void setPriority(String priority) {
        this.priority = priority;
    }
}
