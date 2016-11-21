package com.undertone.qa.ramp.app.api;

import java.time.temporal.Temporal;
import java.util.Objects;

import com.undertone.qa.LineItem;

public class CreateCampaignRequest {
    Integer lineItemId;
    Temporal startDateTime, endDateTime;
    String name;

    public CreateCampaignRequest(LineItem lineItem) {
	this.lineItemId = lineItem.getId();
	startDateTime = lineItem.getStartDate();
	endDateTime = lineItem.getEndDate();
    }

    public CreateCampaignRequest withName(String name) {
	this.name = Objects.requireNonNull(name);
	return this;
    }

    private String getName() {
	return name;
    }

}
