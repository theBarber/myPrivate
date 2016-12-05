package com.undertone.qa.ramp.app.api;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.undertone.qa.Campaign;

public class CampaignsRequest {
    private final Campaign[] campaignsArray;

    public CampaignsRequest(@JsonProperty("campaignsArray") Campaign[] campaignsArray) {
	this.campaignsArray = campaignsArray;
    }
    @JsonProperty("campaignsArray")
    public Campaign[] getCampaignsArray() {
	return campaignsArray;
    }

}
