package entities.ramp.app.api;


import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.ArrayList;
import java.util.List;


public class CreateCampaignRequest {

    @JsonProperty("campaignName")
    private String campaignName;
    @JsonProperty("lineItemId")
    private String lineItemId;
    @JsonProperty("Zonesets")
    private Zonesets zonesets;
    @JsonProperty("selectedCreativeIds")
    private List<Integer> selectedCreativeId;
    @JsonProperty("PlayerSizes")
    private List<Integer> playerSizesIDs;
    @JsonProperty("PlaybackMethods")
    private List<Integer> playbackMethodsIDs;
    @JsonProperty("selectedDealId")
    private Integer selectedDealId;
    @JsonProperty("priority")
    private String priority;
    @JsonProperty("startDateTime")
    private String startDateTime;
    @JsonProperty("endDateTime")
    private String endDateTime;
    @JsonProperty("RawSupplySources")
    private SupplySources supplySources;
    @JsonProperty("avThreshold")
    private String avThreshold;
    @JsonProperty("avEnabled")
    private Boolean avEnabled;
    @JsonProperty("avVendor")
    private String avVendor;
    @JsonProperty("trafficType")
    private Integer trafficType;
    @JsonProperty("CampaignPassBacks")
    private List<Integer> CampaignPassBacks;
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
    @JsonProperty("campaignCategorizationId")
    private int campaignCategorizationId;


    public CreateCampaignRequest(String campaignName, String lineItemId, Zonesets zonesets, List<Integer> selectedCreativeId,Integer selectedDealId, String startDateTime, String endDateTime,List<Integer> playerSizesIDs,List<Integer> playbackMethodsIDs)
    {
        this.campaignName = campaignName;
        this.lineItemId = lineItemId;
        this.zonesets = zonesets;
        this.selectedCreativeId = selectedCreativeId;
        this.selectedDealId = selectedDealId;
//        this.startDateTime = "2018-03-06T19:06:44.809Z";
//        this.endDateTime = "2020-12-31T04:59:59.999Z";
        this.CampaignPassBacks = new ArrayList<>();
        this.startDateTime = startDateTime;
        this.endDateTime = endDateTime;
        this.playerSizesIDs = playerSizesIDs;
        this.playbackMethodsIDs = playbackMethodsIDs;
        this.campaignCategorizationId = 1;
    }

    @JsonProperty("priority")
    public String getPriority() {
        return priority;
    }

    @JsonProperty("RawSupplySources")
    public SupplySources getSupplySources() {
        return supplySources;
    }

    @JsonProperty("selectedDealId")
    public Integer getSelectedDealId() {
        return selectedDealId;
    }

    @JsonProperty("campaignName")
    public String getCampaignName() {
        return campaignName;
    }

    @JsonProperty("lineItemId")
    public String getLineItemId() {
        return lineItemId;
    }

    @JsonProperty("Zonesets")
    public Zonesets getZonesets() {
        return zonesets;
    }

    @JsonProperty("selectedCreativeIds")
    public List<Integer> getSelectedCreativeIds() {
        return selectedCreativeId;
    }

    @JsonProperty("CampaignPassBacks")
    public List<Integer> getCampaignPassBacks() {
        return CampaignPassBacks;
    }

    @JsonProperty("selectedCreativeIds")
    public void setSelectedCreativeIds(List<Integer> selectedCreativeIds) {
        this.selectedCreativeId = selectedCreativeIds;
    }

    @JsonProperty("CampaignPassBacks")
    public void setCampaignPassBacks(List<Integer> campaignPassBacks) {
        this.selectedCreativeId = campaignPassBacks;
    }

    @JsonProperty("startDateTime")
    public String getStartDateTime() {
        return startDateTime;
    }

    @JsonProperty("endDateTime")
    public String getEndDateTime() {
        return endDateTime;
    }

    @JsonProperty("avThreshold")
    public String getAvThreshold() {
        return avThreshold;
    }

    @JsonProperty("avEnabled")
    public Boolean getAvEnabled() {
        return avEnabled;
    }

    @JsonProperty("avVendor")
    public String getAvVendor() {
        return avVendor;
    }

    @JsonProperty("campaignCategorizationId")
    public int getCampaignCategorizationId() {
        return campaignCategorizationId;
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

    @JsonProperty("PlayerSizes")
    public void setPlayerSizesIDs(List<Integer> playerSizesIDs) {
        this.playerSizesIDs = playerSizesIDs;
    }

    @JsonProperty("PlaybackMethods")
    public void setPlaybackMethodsIDs(List<Integer> playbackMethodsIDs) {
        this.playbackMethodsIDs = playbackMethodsIDs;
    }

    @JsonProperty("selectedDealId")
    public void setSelectedDealId(Integer selectedDealId) {
        this.selectedDealId = selectedDealId;
    }

    @JsonProperty("priority")
    public void setPriority(String priority) {
        this.priority = priority;
    }

    @JsonProperty("startDateTime")
    public void setStartDateTime(String startDateTime) {
        this.startDateTime = startDateTime;
    }

    @JsonProperty("endDateTime")
    public void setEndDateTime(String endDateTime) {
        this.endDateTime = endDateTime;
    }

    @JsonProperty("RawSupplySources")
    public void setSupplySources(SupplySources supplySources) {
        this.supplySources = supplySources;
    }

    @JsonProperty("avThreshold")
    public void setAvThreshold(String avThreshold) {
        this.avThreshold = avThreshold;
    }

    @JsonProperty("avEnabled")
    public void setAvEnabled(Boolean avEnabled) {
        this.avEnabled = avEnabled;
    }

    @JsonProperty("avVendor")
    public void setAvVendor(String avVendor) {
        this.avVendor = avVendor;
    }

    @JsonProperty("optimizeReason")
    public void setOptimizeReason(String optimizeReason) {
        this.optimizeReason = optimizeReason;
    }

    @JsonProperty("campaignType")
    public void setCampaignType(String campaignType) {
        this.campaignType = campaignType;
    }

    @JsonProperty("pacing")
    public void setPacing(String pacing) {
        this.pacing = pacing;
    }

    @JsonProperty("deliveryMethod")
    public void setDeliveryMethod(String deliveryMethod) {
        this.deliveryMethod = deliveryMethod;
    }

    @JsonProperty("isUnlimited")
    public void setIsUnlimited(Boolean isUnlimited) {
        this.isUnlimited = isUnlimited;
    }

    @JsonProperty("limitation")
    public void setLimitation(String limitation) {
        this.limitation = limitation;
    }

    @JsonProperty("campaignCategorizationId")
    public void setCampaignCategorizationId(int campaignCategorizationId) {
        this.campaignCategorizationId = campaignCategorizationId;
    }
}
