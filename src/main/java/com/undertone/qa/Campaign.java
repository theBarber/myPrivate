package com.undertone.qa;

import static java.util.Objects.requireNonNull;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Stream;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeName;
import com.fasterxml.jackson.annotation.JsonSubTypes.Type;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.annotation.JsonTypeInfo.As;
import com.fasterxml.jackson.annotation.JsonTypeInfo.Id;
import com.undertone.automation.module.Named;
import com.undertone.automation.module.WithId;

@SuppressWarnings("unused")
@JsonTypeName("Campaign")
@JsonSubTypes(@Type(CampaignPlus.class))
@JsonTypeInfo(use = Id.CLASS, defaultImpl = CampaignPlus.class)

public class Campaign implements Named, WithId<Integer>, Comparable<Campaign> {

    private String campaignName;
    private Integer campaignId;

    private Set<Banner> banners = new TreeSet<>();
    final Set<ZoneSet> zoneSetAssoc = new TreeSet<>();
    
        
    private Campaign() {

    }

    public Campaign(String campaignName, Integer campaignId) {
	this.campaignName = requireNonNull(campaignName);
	this.campaignId = requireNonNull(campaignId);
    }

    @Override
    @JsonIgnore
    public String getName() {
	return campaignName;
    }

    @Override
    @JsonProperty("campaignId")
    public Integer getId() {
	return campaignId;
    }

    public Stream<Banner> banners() {
	return this.banners.stream();
    }

    @Override
    public int compareTo(Campaign that) {
	return Comparator.comparing(Campaign::getId).compare(this, requireNonNull(that));
    }

    @JsonIgnore
    public Stream<ZoneSet> getZoneSetAssoc() {
	return zoneSetAssoc.stream();
    }

    <B extends Banner> B addBanner(B b) {
	banners.add(b);
	return b;
    }

    @JsonIgnore
    ZoneSet addZoneSet(ZoneSet zoneSet) {
	zoneSetAssoc.add(zoneSet);
	return zoneSet;
    }

    @Override
    public String toString() {
	return "Campaign [name=" + getName() + "]";
    }
    
    @JsonProperty("campaignName")
    private String getCampaignName() {
	return campaignName;
    }

    
    @JsonProperty("campaignName")
    private void setCampaignName(String campaignName) {
	this.campaignName = campaignName;
    }

    @JsonProperty("Banners")
    private void setBanners(List<Banner> banners) {
	this.banners.addAll(banners);
    }
    
    @JsonProperty("campaignId")
    private void setCampaignId(Integer campaignId) {
	this.campaignId = campaignId;
    }
}
