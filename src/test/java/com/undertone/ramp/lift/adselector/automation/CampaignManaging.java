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

            // Banner banner15 =
            campaignManager.createBanner("Test Banner1", "15", campaign2.getId()).get();
            // Banner banner17 =
            campaignManager.createBanner("Test Banner", "17", campaign2.getId()).get();

            ZoneSet zoneSet719 = campaignManager.createZoneSet("hwu zonesets", "719", campaign2.getId()).get();

            ZoneSet zoneSet50161 = campaignManager.createZoneSet("IO 58815 - HBO Series - HBO The Brink - Billboard Media", "50161",emptyCampaign.getId()).get();

            // Zone zone2 =
            campaignManager.createZone("qa.undertone.com - Full Banner", "2", zoneSet719.getId()).get();
            // Zone zone3 =
            campaignManager.createZone("qa.undertone.com - Half Banner", "3", zoneSet719.getId()).get();
            // Zone zone112211 =
            campaignManager.createZone("INT03 - Billboard 970x250 - HBO Series - HBO The Brink", "112211", zoneSet50161.getId()).get();

        }
    }


}
