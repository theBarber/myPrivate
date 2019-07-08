package steps;

import static org.hamcrest.CoreMatchers.instanceOf;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.not;

import java.util.Optional;

import infra.RerunningCucumber;
import org.junit.Assert;
import org.junit.runner.RunWith;

import co.unruly.matchers.OptionalMatchers;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import entities.Banner;
import entities.Campaign;
import entities.CampaignManager;
import entities.CampaignPlus;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:CreateCampaigns.feature", tags = "@campaign")

public class CreateCampaigns extends BaseTest {

	CampaignManager CampaignManager = null;

	public CreateCampaigns() {
		super();

		Before(CAMPAIGNTESTS, (scenario) -> {
			CampaignManager manager = sut.getCampaignManager();
			Assert.assertThat("Manager that can access the RampApp API", manager, instanceOf(CampaignManager.class));
			CampaignManager = manager;

		});
		Given("^Campaign named \\{([^}]+)\\}$", (String c) -> {

			Optional<Campaign> campaign = Optional.of(c).flatMap(CampaignManager::getCampaign);
//			if (!campaign.isPresent()) {
//				campaign = Optional.of(c).flatMap(rampAppCampaignManager::createCampaign);
//			}

			Assert.assertThat("campaign named [" + c + "] does not exist", campaign, is(not(OptionalMatchers.empty())));
		});

		//
		Given("^Campaign named \\{([^}]+)\\} has the banner named \\{([^}]+)\\}$",
				(String camp, String b) -> {
					Optional<Campaign> campaign = Optional.of(camp).flatMap(CampaignManager::getCampaign);

					Optional<? extends Banner> banner = campaign.flatMap(cmp -> cmp.banners().findFirst());

					if (!banner.isPresent()) {
						Assert.assertThat("campaign named [" + camp + "] does not exist", campaign,
								is(not(OptionalMatchers.empty())));

						String campaignName = campaign.map(Campaign::getName).get();

						Assert.assertThat("banner named [" + b + "] does not exist", banner,
								is(not(OptionalMatchers.empty())));
					}
				});

		Given("^Campaign named \\{([^}]+)\\} limitations are \\{([^}]+)\\}$", (String c, String l) -> {
			Optional<CampaignPlus> campaign = Optional.of(c).flatMap(CampaignManager::getCampaign)
					.filter(CampaignPlus.class::isInstance).map(CampaignPlus.class::cast);
			Assert.assertThat("campaign named [" + c + "] does not exist", campaign, is(not(OptionalMatchers.empty())));

			String limitation = campaign.get().limitation();
//			if (!limitation.equals(l)) {
//				Assert.assertThat("campaign named [" + c + "] does not have limitation [" + l + "]",
//						
//						is(not(OptionalMatchers.empty())));
//			}

		});

//		Given("^Creative named \\{([^}]+)\\} with ad unit id (\\d+)\\. If needed - clone from creative \\{([^}]+)\\}$",
//				(String c, Integer adunitid, String src) -> {
//					Optional<Creative> creative = rampAppCampaignManager.getCreative(c);
//					if (!creative.isPresent()) {
//						Optional<Creative> srcCreative = rampAppCampaignManager.getCreative(src);
//						creative = rampAppCampaignManager.cloneCreative(srcCreative.get(), c, adunitid);
//					}
//					Assert.assertThat("Creative named {" + c + "} is not attached to adunit " + adunitid,
//							rampAppCampaignManager.getCreative(c).map(Creative::getAdUnitId),
//							OptionalMatchers.contains(adunitid));
//
//				});

		Given("^Zoneset named \\{([^}]+)\\}$", (String z) -> {
			Assert.assertThat("zoneset named [" + z + "] does not exist", CampaignManager.getZoneset(z),
					is(not(OptionalMatchers.empty())));
		});

//		Given("^Zone named \\{([^}]+)\\} is in the zoneset named \\{([^}]+)\\}$", (String z, String zs) -> {
//			Assert.assertThat("zone named {" + z + "} does not exist", CampaignManager.getZone(z, zs),
//					is(not(OptionalMatchers.empty())));
//		});

		// Given("^Zone named \\{([^}]+)\\} with ad unit id (\\d+)$", (String z,
		// Integer adunitid) -> {
		// Assert.assertThat("zone named {" + z + "} is not attached to adunit "
		// + adunitid,
		// rampAppCampaignManager.getZone(z).map(Zone::getAdunitid),
		// OptionalMatchers.contains(adunitid));
		// });
		//
		// Given("^Campaign named \\{([^}]+)\\} is in the zoneset named
		// \\{([^}]+)\\}$", (String c, String zs) -> {
		// Optional<Stream<ZoneSet>> oczs =
		// rampAppCampaignManager.getCampaign(c).map(Campaign::getZoneSetAssoc);
		// Assert.assertThat("campaign named {" + c + "} does not exist", oczs,
		// is(not(OptionalMatchers.empty())));
		// Stream<ZoneSet> czs = oczs.get();
		// ZoneSet expectedZoneset =
		// rampAppCampaignManager.getZoneset(zs).orElseThrow(() -> {
		// return new AssertionError("Zoneset named " + zs + " does not exist");
		// });
		// Assert.assertThat("campaign named {" + c + "} is not associated to
		// any zoneset", czs,
		// is(not(StreamMatchers.contains(expectedZoneset))));
		//
		// });
	}

}
