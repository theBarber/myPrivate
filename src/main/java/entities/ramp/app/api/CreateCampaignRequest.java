package entities.ramp.app.api;

import java.time.temporal.Temporal;
import java.util.List;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.sun.org.apache.xpath.internal.operations.Bool;
import entities.LineItem;

public class CreateCampaignRequest {

    private String campaignName;
    private String lineItemId;
    private Zonesets zonesets;
    private List<Integer> selectedCreativeId;
    private Integer selectedDealId;
    private String priority;
    private String startDateTime;
    private String endDateTime;
    private SupplySources supplySources;
    private String avThreshold;
    private Boolean avEnabled;
    private String avVendor;
    private Integer trafficType;


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
   /* @JsonProperty("SourceLists")
    String SourceLists = "[]";*/


    public CreateCampaignRequest(String campaignName, String lineItemId, Zonesets zonesets, List<Integer> selectedCreativeId,Integer selectedDealId, String startDateTime, String endDateTime)
    {
        this.campaignName = campaignName;
        this.lineItemId = lineItemId;
        this.zonesets = zonesets;
        this.selectedCreativeId = selectedCreativeId;
        this.selectedDealId = selectedDealId;
        this.startDateTime = "2018-03-06T19:06:44.809Z";
        this.endDateTime = "2020-12-31T04:59:59.999Z";
//        this.startDateTime = startDateTime;
//        this.endDateTime = endDateTime;
    }

    @JsonProperty("priority")
    public String getPriority() {
        return priority;
    }

    @JsonProperty("priority")
    public void setPriority(String priority) {
        this.priority = priority;
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
        return selectedCreativeId;
    }

    @JsonProperty("selectedCreativeIds")
    public void setSelectedCreativeIds(List<Integer> selectedCreativeIds) {
        this.selectedCreativeId = selectedCreativeIds;
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


    @JsonProperty("avThreshold")
    public String getAvThreshold() {
        return avThreshold;
    }
    @JsonProperty("avThreshold")
    public void setAvThreshold(String avThreshold) {
        this.avThreshold = avThreshold;
    }
    @JsonProperty("avEnabled")
    public Boolean getAvEnabled() {
        return avEnabled;
    }
    @JsonProperty("avEnabled")
    public void setAvEnabled(Boolean avEnabled) {
        this.avEnabled = avEnabled;
    }

    @JsonProperty("avVendor")
    public String getAvVendor() {
        return avVendor;
    }

    @JsonProperty("avVendor")
    public void setAvVendor(String avVendor) {
        this.avVendor = avVendor;
    }


    public void setViewability(String avThreshold, String avVendor, Boolean avEnabled ) {
        this.avThreshold = avThreshold;
        this.avVendor = avVendor;
        this.avEnabled = avEnabled;
    }
    @JsonProperty("trafficType")
    public void settrafficType(Integer type) {
        trafficType = type;
    }
    @JsonProperty("trafficType")
    public Integer gettrafficType()
    {
        return trafficType;
    }
}
