package entities.ramp.app.api;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
@JsonIgnoreProperties(ignoreUnknown = true)
public class CreativeRequest {

    public CreativeRequest(){}

    public CreativeRequest(String creativeName, int adUnitId,String htmlTemplate) {
        this.creativeName = creativeName;
        this.htmlTemplate = htmlTemplate;
        this.adUnitId = adUnitId;
    }

    @JsonProperty("creativeName")
    public String creativeName;

    @JsonProperty("selectedCampaignIds")
    public List<Integer> selectedCampaignIds;

    @JsonProperty("status")
    public int status = 0;

    @JsonProperty("bannerCategoryId")
    public Integer bannerCategoryId = 1;

    @JsonProperty("creativeType")
    public String creativeType = "html";

    @JsonProperty("thirdPartyTagId")
    public int thirdPartyTagId = 1;

    @JsonProperty("htmlTemplate")
    public String htmlTemplate;

    @JsonProperty("productId")
    public int productId = 0;

    @JsonProperty("htmlCache")
    public int htmlCache = 0;

    @JsonProperty("adUnitId")
    public int adUnitId;

    @JsonProperty("appendCode")
    public String appendCode = "";
}
