package com.undertone.qa.ramp.app.api;

import com.fasterxml.jackson.annotation.JsonProperty;

public class CreativeRequest {
    @JsonProperty("creativeName")
    String creativeName;

    @JsonProperty("creativeName")
    Integer[] selectedCampaignIds;

    @JsonProperty("status")
    int status = 0;
    
}
