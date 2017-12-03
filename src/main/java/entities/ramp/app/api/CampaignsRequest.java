package entities.ramp.app.api;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import entities.Campaign;
@JsonIgnoreProperties(ignoreUnknown = true)
public class CampaignsRequest {
    private final Campaign[] campaignsArray;

    public CampaignsRequest(@JsonProperty("campaignsArray") Campaign... campaignsArray) {
	    this.campaignsArray = campaignsArray;
    }

    @JsonProperty("campaignsArray")
    public Campaign[] getCampaignsArray() {
	return campaignsArray;
    }

}
