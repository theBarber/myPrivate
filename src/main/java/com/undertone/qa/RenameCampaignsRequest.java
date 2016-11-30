package com.undertone.qa;

import com.fasterxml.jackson.annotation.JsonProperty;

class RenameCampaignsRequest {
    private final Campaign[] campaignsArray;

    public RenameCampaignsRequest(@JsonProperty("campaignsArray") Campaign[] campaignsArray) {
	this.campaignsArray = campaignsArray;
    }

    public Campaign[] getCampaignsArray() {
	return campaignsArray;
    }

}
