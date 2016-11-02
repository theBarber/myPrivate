package com.undertone.ramp.lift.adselector.automation;

import com.undertone.qa.Campaign;
import com.undertone.qa.CampaignManager;
import com.undertone.qa.ZoneSet;
import cucumber.api.java8.En;
import org.hamcrest.Matchers;
import org.junit.Assume;

/**
 * Created by assafm on 31/10/2016.
 */
public interface CampaignManaging  {
    String[] CAMPAIGN_TESTS = {"@campaign"};
    String[] HARDCODED = {"@hardcoded","@campaign"};


    default public void givenCampaignManager(){
        En thisAsEn = null;
        if (this instanceof En) {
            thisAsEn = (En) this;
        } else {
            throw  new NullPointerException();
        }


        thisAsEn.Before(HARDCODED , scenario ->  load(getCampaignManager()));
        thisAsEn.Before(CAMPAIGN_TESTS ,scenario -> {
            //build another type of campaign manager
        });

    }
    default
    public CampaignManager getCampaignManager() {
        if (this instanceof BaseTest) {
            return ((BaseTest) this).campaignManager;
        }
        throw  new NullPointerException();
    }
    default
     void load(CampaignManager campaignManager) {
        {
            Campaign emptyCampaign = campaignManager.createCampaign("null", "XXXXXX");
            Campaign campaign2 = campaignManager.createCampaign("999-undefined-undefined-NaN", "2");
            Campaign campaign3 = campaignManager.createCampaign("campaign3", "233711");
            Campaign campaign4 = campaignManager.createCampaign("campaign4", "254974");

            // Banner banner15 =
            campaignManager.createBanner("Test Banner1", "15", campaign2.getId()).get();
            // Banner banner17 =
            campaignManager.createBanner("Test Banner", "17", campaign2.getId()).get();
            //Banner banner879498 =
            campaignManager.createBanner("Undertone [The Trade Desk] Xaxis Always On Billboard", "879498", campaign3.getId()).get();
            //Banner banner968381 =
            campaignManager.createBanner("Int-test-unlimited-banner", "968381", campaign4.getId()).get();

            ZoneSet zoneSet719 = campaignManager.createZoneSet("hwu zonesets", "719", campaign2.getId()).get();

            ZoneSet zoneSet50161 = campaignManager.createZoneSet("IO 58815 - HBO Series - HBO The Brink - Billboard Media", "50161",emptyCampaign.getId()).get();

            ZoneSet zoneSet55023 = campaignManager.createZoneSet("zoneset55023", "55023", campaign3.getId()).get();

            ZoneSet zoneSet21808 = campaignManager.createZoneSet("zoneset21808", "21808", campaign4.getId()).get();

            // Zone zone2 =
            campaignManager.createZone("qa.undertone.com - Full Banner", "2", zoneSet719.getId()).get();
            // Zone zone3 =
            campaignManager.createZone("qa.undertone.com - Half Banner", "3", zoneSet719.getId()).get();
            // Zone zone112211 =
            campaignManager.createZone("INT03 - Billboard 970x250 - HBO Series - HBO The Brink", "112211", zoneSet50161.getId()).get();
            // Zone zone144960 =
            campaignManager.createZone("INT3132 - Billboard 970x250 - TEST_1", "144960", zoneSet55023.getId()).get();
            // Zone zone37750 =
            campaignManager.createZone("QA-INT03 - Half Page Ad 300x600 - INT03AFP - Half Page Ad", "37750", zoneSet21808.getId()).get();


        }
    }


}
