package com.undertone.qa.ramp.app.api;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.undertone.qa.Campaign;

public class RenameCampaignsRequest {
    private final Campaign[] campaignsArray;

    public RenameCampaignsRequest(@JsonProperty("campaignsArray") Campaign[] campaignsArray) {
	this.campaignsArray = campaignsArray;
    }

    public Campaign[] getCampaignsArray() {
	return campaignsArray;
    }

}
