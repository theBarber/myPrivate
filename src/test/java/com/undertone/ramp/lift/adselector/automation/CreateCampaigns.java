package com.undertone.ramp.lift.adselector.automation;

import static org.hamcrest.CoreMatchers.instanceOf;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.not;

import java.util.Optional;

import org.junit.Assert;
import org.junit.runner.RunWith;

import com.undertone.automation.module.Named;
import com.undertone.qa.Banner;
import com.undertone.qa.Campaign;
import com.undertone.qa.CampaignManager;
import com.undertone.qa.RampAppCampaignManager;

import co.unruly.matchers.OptionalMatchers;
import cucumber.api.CucumberOptions;
import cucumber.api.PendingException;
import cucumber.api.junit.Cucumber;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:CreateCampaigns.feature", tags = "@campaign")

public class CreateCampaigns extends BaseTest {

    RampAppCampaignManager rampAppCampaignManager =null;
    
    public CreateCampaigns() {
	super();
	
	Before(()->{
	    CampaignManager manager = sut.getCampaignManager();
	    Assert.assertThat("Manager that can access the RampApp API", manager, instanceOf(RampAppCampaignManager.class));
	    rampAppCampaignManager = (RampAppCampaignManager) manager;
	    
	});
	Given("^Campaign named \\{([^}]+)\\}$", (String c) -> {
	    
	    Optional<Campaign> campaign = Optional.of(c).flatMap(rampAppCampaignManager::getCampaign);
	    if (!campaign.isPresent()) {
		campaign = Optional.of(c).flatMap(rampAppCampaignManager::createCampaign);
	    }

	    Assert.assertThat("campaign named [" + c + "] does not exist", campaign,
		    is(not(OptionalMatchers.empty())));
	});
	
	
	Given("^Campaign named \\{([^}]+)\\} has a creative with banner named \\{([^}]+)\\}$", (String c,String b) -> {
	    Optional<Campaign> campaign = Optional.of(c).flatMap(rampAppCampaignManager::getCampaign);
	    Optional<Banner> banner = campaign.flatMap(cmp->cmp.banners().filter(Named.nameIs(b)).findFirst());
	    if (!banner.isPresent()){
		throw new PendingException("implementation of rampAppCampaignManager.createBanner() is missing");
		//XXX TODO rampAppCampaignManager.createBanner();
		
	    }
	    
	});
    }

}
