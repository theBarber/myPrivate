package com.undertone.qa;

import static com.undertone.automation.module.WithId.idIs;
import static java.util.Objects.requireNonNull;
import static java.util.function.Function.identity;

import java.util.Optional;
import java.util.Set;
import java.util.TreeSet;
import java.util.function.Function;

import com.undertone.automation.module.Named;
import com.undertone.automation.module.WithId;

public class CampaignManager {

    final Set<Campaign> campaigns = new TreeSet<>();

    public CampaignManager() {

    }

    public Optional<Campaign> getCampaign(String byName) {
	return campaigns.stream().filter(c -> c.getName().equals(byName)).findFirst();
    }

    public Optional<Zone> getZone(String byName) {
	return campaigns.stream().flatMap(Campaign::getZoneSetAssoc).flatMap(ZoneSet::zones)
		.filter(Named.nameIs(byName)).findFirst();
    }

    
    public Optional<Banner> getBanner(String byName) {
  	return campaigns.stream().flatMap(Campaign::banners).filter(Named.nameIs(byName)).findFirst();
      }
    /**
     * get a zone that may result with the given campaign
     * 
     * @param forCampaignId
     *            the {@link Campaign#getId()}
     * @param byName
     *            the name of the zone
     * @return
     */
    public Optional<Zone> getZone(String forCampaignId, String byName) {
	return campaigns.stream().filter(WithId.idIs(forCampaignId)).flatMap(Campaign::getZoneSetAssoc)
		.flatMap(ZoneSet::zones).filter(Optional.ofNullable(byName).map(Named::nameIs).orElse(b -> true))
		.findFirst();
    }

    /**
     * Create a new {@link Campaign}
     * 
     * @param name
     *            the name
     * @param id
     *            the id
     * @return the newly created campaign
     */
    public Campaign createCampaign(String name, String id) {
	return createCampaign(name, id, Function.identity());
    }

    /**
     * Create a new {@link Campaign}
     * 
     * @param name
     *            the name
     * @param id
     *            the id
     * @param campaignEnricher
     *            a function that converts a campaign to a better one
     * @return the newly created campaign
     */
    public <C extends Campaign> C createCampaign(String name, String id, Function<Campaign, C> campaignEnricher) {
	campaigns.stream().filter(WithId.idIs(id)).findFirst().ifPresent(c -> {
	    throw new IllegalArgumentException("campaign " + c.toString() + " with id " + c.getId() + "already exists");
	});
	C res;
	campaigns.add(requireNonNull(res = requireNonNull(campaignEnricher).apply(new Campaign(name, id))));
	return res;
    }

    /**
     * create a banner and add it to the campaign
     * 
     * @param name
     *            the name of the banner
     * @param id
     *            the id of the banner
     * @param forCampaignId
     *            the campaign to create the banner for
     * @return The created (and enriched) banner
     */
    public Optional<Banner> createBanner(String name, String id, String forCampaignId) {
	return createBanner(name, id, forCampaignId, identity());
    }

    /**
     * create a banner and add it to the campaign
     * 
     * @param name
     *            the name of the banner
     * @param id
     *            the id of the banner
     * @param forCampaignId
     *            the campaign to create the banner for
     * @param bannerEnricher
     *            a function that converts a banner to a better one
     * @return The created (and enriched) banner
     */
    public <B extends Banner> Optional<B> createBanner(String name, String id, String forCampaignId,
	    Function<Banner, B> bannerEnricher) {
	return campaigns.stream().filter(idIs(forCampaignId)).findFirst()
		.map(c -> c.addBanner(bannerEnricher.apply(new Banner(name, id))));
    }

    public Optional<ZoneSet> createZoneSet(String name, String id, String forCampaignId) {
	return campaigns.stream().filter(idIs(forCampaignId)).findFirst()
		.map(c -> c.addZoneSet(new ZoneSet(name, id)));
    }

    public Optional<Zone> createZone(String name, String id, String forZoneSetId) {
	return createZone(name, id, forZoneSetId, identity());
    }

    public <Z extends Zone> Optional<Z> createZone(String name, String id, String forZoneSetId,
	    Function<Zone, Z> zoneEnricher) {
	return campaigns.stream().flatMap(Campaign::getZoneSetAssoc).filter(idIs(forZoneSetId)).findFirst()
		.map(zs -> zs.addZone(requireNonNull(zoneEnricher).apply(new Zone(name, id))));
    }
    
    public Function<String,Optional<? extends WithId>> getterFor(String entityType){
	switch (entityType.toLowerCase()) {
	case "banner":
	    return this::getBanner;
	case "campaign":
	    return this::getCampaign;
	case "zone":
	    return this::getZone;
	default:
	    return noSuchEntity->Optional.empty();
	}
    }
}
