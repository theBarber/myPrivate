package entities.ramp.app.api;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import entities.Deal;
@JsonIgnoreProperties(ignoreUnknown = true)
public class DealRequest {
    Deal deal;

    public DealRequest(Deal deal) {
        this.deal = deal;
    }

    @JsonProperty("deal")
    public Deal getDeal() {
        return deal;
    }
    @JsonProperty("deal")
    public void setDeal(Deal deal) {
        this.deal = deal;
    }
}
