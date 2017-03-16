package entities;

import static infra.module.WithId.idIs;
import static java.util.Objects.requireNonNull;
import static java.util.function.Function.identity;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.TreeSet;
import java.util.function.Function;
import java.util.stream.Collectors;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.BufferedHttpEntity;

import infra.ParameterProvider;
import infra.module.Named;
import infra.module.WithId;

public class CampaignManager implements ParameterProvider<WithId<Integer>> {

	// final Set<Campaign> campaigns = new TreeSet<>();
	LineItem li;
	List<ZoneSet> zonesets;
	
	public CampaignManager() {

	}

	public Optional<Campaign> getCampaign(String byName) {
		return li.campaigns.stream().filter(Named.nameIs(byName)).findFirst();
	}

	public final Optional<Zone> getZone(String byName) {
		return zonesets.stream().flatMap(z -> z.zones()).filter(Named.nameIs(byName)).findFirst();
//		return li.campaigns.stream().flatMap(Campaign::getZoneSetAssoc).flatMap(ZoneSet::zones)
//				.filter(Named.nameIs(byName)).findFirst();
	}

	public final Optional<Banner> getBanner(String byName) {
		return li.campaigns.stream().flatMap(Campaign::banners).filter(Named.nameIs(byName)).findFirst();
	}
	
	
	public Optional<ZoneSet> getZoneset(Integer byId) {
		return zonesets.stream().filter(WithId.idIs(byId)).findFirst();
	}
	
	public Optional<ZoneSet> getZoneset(String byName) {
		return zonesets.stream().filter(Named.nameIs(byName)).findFirst();
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
	// public Optional<Zone> getZone(Integer forCampaignId, String byName) {
	// return
	// campaigns.stream().filter(WithId.idIs(forCampaignId)).flatMap(Campaign::getZoneSetAssoc)
	// .flatMap(ZoneSet::zones).filter(Optional.ofNullable(byName).map(Named::nameIs).orElse(b
	// -> true))
	// .findFirst();
	// }
//
//	/**
//	 * Create a new {@link Campaign}
//	 * 
//	 * @param name
//	 *            the name
//	 * @param id
//	 *            the id
//	 * @return the newly created campaign
//	 */
//	protected Campaign createCampaign(String name, Integer id) {
//		return createCampaign(name, id, Function.identity());
//	}

//	/**
//	 * Create a new {@link Campaign}
//	 * 
//	 * @param name
//	 *            the name
//	 * @param id
//	 *            the id
//	 * @param campaignEnricher
//	 *            a function that converts a campaign to a better one
//	 * @return the newly created campaign
//	 */
//	protected <C extends Campaign> C createCampaign(String name, Integer id, Function<Campaign, C> campaignEnricher) {
//		campaigns.stream().filter(WithId.idIs(id)).findFirst().ifPresent(c -> {
//			throw new IllegalArgumentException(
//					"campaign " + c.toString() + " with id " + c.getId() + " already exists");
//		});
//		C res;
//		campaigns.add(requireNonNull(res = requireNonNull(campaignEnricher).apply(new Campaign(name, id))));
//		return res;
//	}
//
//	/**
//	 * create a banner and add it to the campaign
//	 * 
//	 * @param name
//	 *            the name of the banner
//	 * @param id
//	 *            the id of the banner
//	 * @param forCampaignId
//	 *            the campaign to create the banner for
//	 * @return The created (and enriched) banner
//	 */
//	protected Optional<Banner> createBanner(String name, Integer id, Integer forCampaignId) {
//		return createBanner(name, id, forCampaignId, identity());
//	}
//
//	/**
//	 * create a banner and add it to the campaign
//	 * 
//	 * @param name
//	 *            the name of the banner
//	 * @param id
//	 *            the id of the banner
//	 * @param forCampaignId
//	 *            the campaign to create the banner for
//	 * @param bannerEnricher
//	 *            a function that converts a banner to a better one
//	 * @param creativeId
//	 * @return The created (and enriched) banner
//	 */
//	protected <B extends Banner> Optional<B> createBanner(String name, Integer id, Integer forCampaignId,
//			Function<Banner, B> bannerEnricher) {
//		return campaigns.stream().filter(idIs(forCampaignId)).findFirst()
//				.map(c -> c.addBanner(bannerEnricher.apply(new Banner(name, id))));
//	}

	// protected Optional<ZoneSet> createZoneSet(String name, Integer id,
	// Integer forCampaignId) {
	// return campaigns.stream().filter(idIs(forCampaignId)).findFirst().map(c
	// -> c.addZoneSet(new ZoneSet(name, id)));
	// }

	// protected Optional<Zone> createZone(String name, Integer id, Integer
	// forZoneSetId) {
	// return createZone(name, id, forZoneSetId, identity());
	// }

	// protected <Z extends Zone> Optional<Z> createZone(String name, Integer
	// id, Integer forZoneSetId,
	// Function<Zone, Z> zoneEnricher) {
	// return
	// campaigns.stream().flatMap(Campaign::getZoneSetAssoc).filter(idIs(forZoneSetId)).findFirst()
	// .map(zs -> zs.addZone(requireNonNull(zoneEnricher).apply(new Zone(name,
	// id))));
	// }

	@Override
	public Function<String, Optional<? extends WithId<Integer>>> getterFor(String entityType) {
		switch (entityType.toLowerCase()) {
		case "banner":
			return this::getBanner;
		case "campaign":
			return this::getCampaign;
		case "zone":
			return this::getZone;
		default:
			return noSuchEntity -> Optional.empty();
		}
	}

	@Override
	public String stringify(WithId<Integer> t) {
		return Objects.toString(t.getId());
	}

	@Override
	public String className() {
		return "workflow";
	}
}
