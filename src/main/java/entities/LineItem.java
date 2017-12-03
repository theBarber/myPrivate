package entities;

import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.temporal.Temporal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.fasterxml.jackson.annotation.JsonProperty;

import infra.module.WithId;

public class LineItem implements WithId<Integer> {
	
    public IO Io;
    @JsonProperty("Campaigns")
    public List<Campaign> campaigns;
    private Integer ioLineItemId = null;
    public static final DateTimeFormatter formatter;
    static {
	formatter = new DateTimeFormatterBuilder().append(DateTimeFormatter.ISO_LOCAL_DATE).appendLiteral(' ')
		.append(DateTimeFormatter.ISO_LOCAL_TIME).toFormatter().withZone(ZoneOffset.UTC);
    }

    private ZonedDateTime startDate, endDate;

    @Override
    public Integer getId() {
	return Optional.ofNullable(this.ioLineItemId).orElseThrow(NullPointerException::new);
    }

    
    public void setStartDate(String startDate) {
	this.startDate = formatter.parse(startDate, ZonedDateTime::from);

    }

    public void setEndDate(String endDate) {
	this.endDate = formatter.parse(endDate, ZonedDateTime::from);
    }

    public Temporal getStartDate() {
	return startDate;
    }

    public Temporal getEndDate() {
	return endDate;
    }


    private Integer getIoLineItemId() {
        return ioLineItemId;
    }


    public void setIoLineItemId(Integer ioLineItemId) {
        this.ioLineItemId = ioLineItemId;
    }

    public void addCampaign(Campaign campaign)
    {
        if(campaigns == null)
            campaigns = new ArrayList<>();
        campaigns.add(campaign);
    }
}
