package com.undertone.qa.ramp.app.api;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

public class CreativeRequest {
    @JsonProperty("creativeName")
    public String creativeName;

    @JsonProperty("creativeName")
    public List<Integer> selectedCampaignIds;

    @JsonProperty("status")
    public int status = 0;

}
