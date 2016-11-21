package com.undertone.qa;

import java.util.ArrayList;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.stream.IntStream;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("Campaign")
public class CampaignPlus extends Campaign {

    private String limitation = "";
    private Zonesets zonesets = new Zonesets();
    private final AtomicBoolean isDirty = new AtomicBoolean();

    private int lineItemId;

    @JsonCreator(mode = Mode.DELEGATING)
    public CampaignPlus(@JsonProperty("campaignName") String campaignName,
	    @JsonProperty("campaignId") Integer campaignId) {
	super(campaignName, campaignId);
	isDirty.set(false);
    }

    // public static CampaignPlus enrich(Campaign c, CampaignPlus with) {
    // return new CampaignPlus(c.getName(),
    // c.getId()).withLimitation(with.limitation).withZonesets(with.zonesets);
    // }

    @JsonProperty("limitation")
    public CampaignPlus withLimitation(String limitation) {
	this.limitation = Objects.requireNonNull(limitation);
	isDirty.set(true);
	return this;
    }

    @JsonProperty("Zonesets")
    public CampaignPlus withZonesets(Zonesets zonesets) {
	if (this.zonesets.include == null) {
	    this.zonesets.include = new ArrayList<>();
	}

	if (this.zonesets.exclude == null) {
	    this.zonesets.exclude = new ArrayList<>();
	}

	this.zonesets.include.addAll(zonesets.include);
	this.zonesets.exclude.addAll(zonesets.exclude);
	isDirty.set(true);
	return this;
    }

    @JsonIgnore
    IntStream zonesets() {
	return this.zonesets.include.stream().mapToInt(Integer::intValue);
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
