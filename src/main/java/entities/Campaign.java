package entities;

import static java.util.Objects.requireNonNull;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Stream;

import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.annotation.JsonSubTypes.Type;
import com.fasterxml.jackson.annotation.JsonTypeInfo.As;
import com.fasterxml.jackson.annotation.JsonTypeInfo.Id;

import infra.module.Named;
import infra.module.WithId;

@SuppressWarnings("unused")
@JsonTypeName("Campaign")
@JsonTypeInfo(use = Id.CLASS, defaultImpl = CampaignPlus.class)
@JsonIgnoreProperties(ignoreUnknown = true)
public class Campaign implements Named, WithId<Integer>, Comparable<Campaign> {

	private String campaignName;
	private Integer campaignId;
	private Integer LineItemID;

	@JsonProperty("Banners")
	private Set<Banner> banners = new TreeSet<>();

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

	/*<B extends Banner> B addBanner(B b) {
		banners.add(b);
		return b;
	}*/

	public Set<Banner> getBanners()
	{
		return banners;
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

	public void setBanners(List<Banner> banners) {
		this.banners.addAll(banners);
	}

	public void setBannersFromSet(Set<Banner> banners) {
		this.banners.addAll(banners);
	}
	@JsonProperty("campaignId")
	private void setCampaignId(Integer campaignId) {
		this.campaignId = campaignId;
	}
	//only for check
	public void addBanner(Banner banner)
	{
		banners.add(banner);
	}

}
