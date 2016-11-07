package com.undertone.qa;

public class HardCodedCampaignManager extends CampaignManager {

	public HardCodedCampaignManager() {
		super();
		Campaign emptyCampaign = this.createCampaign("null", "XXXXXX");
		Campaign campaign2 = this.createCampaign("999-undefined-undefined-NaN", "2");
		Campaign campaign3 = this.createCampaign("campaign3", "233711");
		Campaign campaign4 = this.createCampaign("campaign4", "254974");
		Campaign campaign5 = this.createCampaign("campaign5", "255174");

		// Banner banner15 =
		this.createBanner("Test Banner1", "15", campaign2.getId()).get();
		// Banner banner17 =
		this.createBanner("Test Banner", "17", campaign2.getId()).get();
		// Banner banner879498 =
		this.createBanner("Undertone [The Trade Desk] Xaxis Always On Billboard", "879498", campaign3.getId()).get();
		// Banner banner968381 =
		this.createBanner("Int-test-unlimited-banner", "968381", campaign4.getId()).get();
		// Banner banner968473 =
		this.createBanner("Int-test-adselctor-default-value-2", "968473", campaign5.getId()).get();




		ZoneSet zoneSet719 = this.createZoneSet("hwu zonesets", "719", campaign2.getId()).get();

		ZoneSet zoneSet50161 = this.createZoneSet("IO 58815 - HBO Series - HBO The Brink - Billboard Media", "50161",
				emptyCampaign.getId()).get();

		ZoneSet zoneSet55023 = this.createZoneSet("zoneset55023", "55023", campaign3.getId()).get();

		ZoneSet zoneSet21808 = this.createZoneSet("zoneset21808", "21808", campaign4.getId()).get();
		ZoneSet zoneSet21808_1 = this.createZoneSet("QA-accuweather - INT03", "21808", campaign5.getId()).get();

		// Zone zone2 =
		this.createZone("qa.undertone.com - Full Banner", "2", zoneSet719.getId()).get();
		// Zone zone3 =
		this.createZone("qa.undertone.com - Half Banner", "3", zoneSet719.getId()).get();
		// Zone zone112211 =
		this.createZone("INT03 - Billboard 970x250 - HBO Series - HBO The Brink", "112211", zoneSet50161.getId()).get();
		// Zone zone144960 =
		this.createZone("INT3132 - Billboard 970x250 - TEST_1", "144960", zoneSet55023.getId()).get();
		// Zone zone37750 =
		this.createZone("QA-INT03 - Half Page Ad 300x600 - INT03AFP - Half Page Ad", "37750", zoneSet21808.getId())
				.get();
		// Zone zone11457 =
		this.createZone("QA-INT01 - Half Page Ad 300x600 - INT01N - Half Page Ad (300 x 600)", "11457", zoneSet21808_1.getId()).get();


	}

}
