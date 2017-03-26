package entities;

import java.util.ArrayList;
import java.util.Objects;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.stream.IntStream;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonCreator.Mode;

import entities.ramp.app.api.Zonesets;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("Campaign")
public class CampaignPlus extends Campaign {

    private String limitation = "";
    private final AtomicBoolean isDirty = new AtomicBoolean();

    private int lineItemId;

    @JsonCreator(mode = Mode.DELEGATING)
    public CampaignPlus(@JsonProperty("campaignName") String campaignName,
	    @JsonProperty("campaignId") Integer campaignId) {
	super(campaignName, campaignId);
	isDirty.set(false);
    }

    @JsonProperty("limitation")
    public CampaignPlus withLimitation(String limitation) {
	this.limitation = Optional.ofNullable(limitation).orElse("");
	isDirty.set(true);
	return this;
    }


    @JsonProperty("limitation")
    public String limitation() {
	return limitation;
    }

    @JsonProperty("lineItemId")
    public CampaignPlus withLineItemId(int lineItemId) {
	this.lineItemId = lineItemId;
	isDirty.set(true);
	return this;
    }
}
