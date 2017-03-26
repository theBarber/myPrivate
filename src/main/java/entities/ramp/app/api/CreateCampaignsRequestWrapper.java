package entities.ramp.app.api;

import com.fasterxml.jackson.annotation.JsonProperty;

public class CreateCampaignsRequestWrapper {
    private final CreateCampaignRequest[] campaignsArray;

    public CreateCampaignsRequestWrapper(@JsonProperty("campaignsArray") CreateCampaignRequest... campaignsArray) {
	this.campaignsArray = campaignsArray;
    }

    @JsonProperty("campaignsArray")
    public CreateCampaignRequest[] getCampaignsArray() {
	return campaignsArray;
    }

}
