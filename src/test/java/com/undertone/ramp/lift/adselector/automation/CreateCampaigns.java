package com.undertone.ramp.lift.adselector.automation;

import static org.hamcrest.CoreMatchers.instanceOf;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.not;

import java.util.Optional;
import java.util.stream.Stream;

import org.junit.Assert;
import org.junit.runner.RunWith;

import com.undertone.automation.module.Named;
import com.undertone.qa.Banner;
import com.undertone.qa.Campaign;
import com.undertone.qa.CampaignManager;
import com.undertone.qa.CampaignPlus;
import com.undertone.qa.RampAppCampaignManager;
import com.undertone.qa.ZoneSet;

import co.unruly.matchers.OptionalMatchers;
import co.unruly.matchers.StreamMatchers;
import cucumber.api.CucumberOptions;
import cucumber.api.PendingException;
import cucumber.api.junit.Cucumber;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:CreateCampaigns.feature", tags = "@campaign")

public class CreateCampaigns extends BaseTest {

    RampAppCampaignManager rampAppCampaignManager = null;

    public CreateCampaigns() {
	super();

	Before(CAMPAIGNTESTS, (scenario) -> {
	    CampaignManager manager = sut.getCampaignManager();
	    Assert.assertThat("Manager that can access the RampApp API", manager,
		    instanceOf(RampAppCampaignManager.class));
	    rampAppCampaignManager = (RampAppCampaignManager) manager;

	});
	Given("^Campaign named \\{([^}]+)\\}$", (String c) -> {

	    Optional<Campaign> campaign = Optional.of(c).flatMap(rampAppCampaignManager::getCampaign);
	    if (!campaign.isPresent()) {
		campaign = Optional.of(c).flatMap(rampAppCampaignManager::createCampaign);
	    }

	    Assert.assertThat("campaign named [" + c + "] does not exist", campaign, is(not(OptionalMatchers.empty())));
	});

	Given("^Campaign named \\{([^}]+)\\} has a creative with banner named \\{([^}]+)\\}$", (String c, String b) -> {
	    Optional<Campaign> campaign = Optional.of(c).flatMap(rampAppCampaignManager::getCampaign);
	    Optional<Banner> banner = campaign.flatMap(cmp -> cmp.banners().filter(Named.nameIs(b)).findFirst());

	    if (!banner.isPresent()) {
		if (!banner.isPresent()) {
		    throw new PendingException("implementation of rampAppCampaignManager.createBanner() is missing");
		}
		// XXX TODO
		Assert.assertThat("campaign named [" + c + "] does not exist", campaign,
			is(not(OptionalMatchers.empty())));
		Integer campaignId = campaign.map(Campaign::getId).get();
		banner = rampAppCampaignManager.createBanner(b, campaignId);

	    }

	});

	Given("^Campaign named \\{([^}]+)\\} limitations are \\{([^}]+)\\}$", (String c, String l) -> {
	    Optional<CampaignPlus> campaign = Optional.of(c).flatMap(rampAppCampaignManager::getCampaign)
		    .filter(CampaignPlus.class::isInstance).map(CampaignPlus.class::cast);
	    Assert.assertThat("campaign named [" + c + "] does not exist", campaign, is(not(OptionalMatchers.empty())));

	    String limitation = campaign.get().limitation();
	    if (!limitation.equals(l)) {
		Assert.assertThat("campaign named [" + c + "] does not have limitation [" + l + "]",
			campaign.map(camp -> camp.withLimitation(l)).flatMap(rampAppCampaignManager::updateCampaign),
			is(not(OptionalMatchers.empty())));
	    }

	});

	Given("^Zoneset named \\{([^}]+)\\}$", (String z) -> {
	    Assert.assertThat("zoneset named [" + z + "] does not exist", rampAppCampaignManager.getZoneset(z),
		    is(not(OptionalMatchers.empty())));
	});

	Given("^Zone named \\{([^}]+)\\} is in the zoneset named \\{([^}]+)\\}$", (String z, String zs) -> {
	    Assert.assertThat("zone named {" + z + "} does not exist", rampAppCampaignManager.getZone(z, zs),
		    is(not(OptionalMatchers.empty())));
	});

	Given("^Campaign named \\{([^}]+)\\} is in the zoneset named \\{([^}]+)\\}$", (String c, String zs) -> {

	    Optional<Stream<ZoneSet>> oczs = rampAppCampaignManager.getCampaign(c).map(Campaign::getZoneSetAssoc);

	    Assert.assertThat("campaign named {" + c + "} does not exist", oczs, is(not(OptionalMatchers.empty())));
	    Stream<ZoneSet> czs = oczs.get();
	    ZoneSet expectedZoneset = rampAppCampaignManager.getZoneset(zs).orElseThrow(() -> {
		return new AssertionError("Zoneset named " + zs + " does not exist");
	    });
	    Assert.assertThat("campaign named {" + c + "} is not associated to any zoneset", czs,
		    is(not(StreamMatchers.contains(expectedZoneset))));
	    
	});
    }

}
