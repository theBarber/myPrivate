package entities.ramp.app.api;

import java.time.temporal.Temporal;
import java.util.Objects;

import entities.LineItem;

public class CreateCampaignRequest {
    Integer lineItemId;
    Temporal startDateTime, endDateTime;

    public CreateCampaignRequest(LineItem lineItem) {
	this.lineItemId = lineItem.getId();
	startDateTime = lineItem.getStartDate();
	endDateTime = lineItem.getEndDate();
    }

    public Integer getLineItemId() {
	return lineItemId;
    }

    public String getStartDateTime() {
	return LineItem.formatter.format(startDateTime);
    }

    public String getEndDateTime() {
	return LineItem.formatter.format(endDateTime);
    }

}
