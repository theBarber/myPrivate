package com.undertone.ramp.lift.adselector.automation;

import static org.hamcrest.CoreMatchers.instanceOf;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.Matchers.containsString;
import static org.junit.Assume.assumeThat;

import java.util.Optional;

import org.hamcrest.CoreMatchers;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.experimental.theories.DataPoint;
import org.junit.experimental.theories.Theory;
import org.junit.runner.RunWith;

import com.undertone.qa.Campaign;
import com.undertone.qa.CampaignManager;
import com.undertone.qa.RampAppCampaignManager;

import co.unruly.matchers.OptionalMatchers;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:CreateCampaigns.feature")
public class CreateCampaigns extends BaseTest {

    public CreateCampaigns() {
	super();
	Given("^Campaign named \\{([^}]+)\\}$", (String c) -> {
	    CampaignManager manager = sut.getCampaignManager();
	    Assert.assertThat("Manager that can access the RampApp API", manager, instanceOf(RampAppCampaignManager.class));
	    RampAppCampaignManager rampAppCampaignManager = (RampAppCampaignManager) manager;
	    
	    Optional<Campaign> campaign = Optional.of(c).flatMap(rampAppCampaignManager::getCampaign);
	    if (!campaign.isPresent()) {
		campaign = Optional.of(c).flatMap(rampAppCampaignManager::createCampaign);
	    }

	    Assert.assertThat("campaign named [" + c + "] does not exist", campaign,
		    is(not(OptionalMatchers.empty())));
	});
    }

}
