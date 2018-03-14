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
    private Integer selectedDealId;
    private String startDateTime;
    private String endDateTime;
    private SupplySources supplySources;


    @JsonProperty("optimizeReason")
    String optimizeReason = "10";
    @JsonProperty("campaignType")
    String campaignType = "1";
    @JsonProperty("pacing")
    String pacing = "25";
    @JsonProperty("deliveryMethod")
    String deliveryMethod = "4";
    @JsonProperty("isUnlimited")
    Boolean isUnlimited = true;
    @JsonProperty("limitation")
    String limitation = "[]";


    public CreateCampaignRequest(String campaignName, String lineItemId, Zonesets zonesets, List<Integer> selectedCreativeIds, String startDateTime, String endDateTime)
    {
        this.campaignName = campaignName;
        this.lineItemId = lineItemId;
        this.zonesets = zonesets;
        this.selectedCreativeIds = selectedCreativeIds;
        this.startDateTime = "2018-03-06T19:06:44.809Z";
        this.endDateTime = "2019-12-31T04:59:59.999Z";
        //this.startDateTime = startDateTime;
       // this.endDateTime = endDateTime;
    }
    //programmatic campaign
    public CreateCampaignRequest(String campaignName, String lineItemId, Zonesets zonesets, Integer selectedDealId, String startDateTime, String endDateTime)
    {
        this.campaignName = campaignName;
        this.lineItemId = lineItemId;
        this.zonesets = zonesets;
        this.selectedDealId = selectedDealId;
        this.startDateTime = startDateTime;
        this.endDateTime = endDateTime;
    }
    @JsonProperty("SupplySources")
    public SupplySources getSupplySources() {
        return supplySources;
    }

    @JsonProperty("SupplySources")
    public void setSupplySources(SupplySources supplySources) {
        this.supplySources = supplySources;
    }

    @JsonProperty("selectedDealId")
    public Integer getSelectedDealId() {
        return selectedDealId;
    }
    @JsonProperty("selectedDealId")
    public void setSelectedDealId(Integer selectedDealId) {
        this.selectedDealId = selectedDealId;
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

}
