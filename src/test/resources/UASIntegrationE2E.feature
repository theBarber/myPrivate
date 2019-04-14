@cli
@uas
@RampAppCreateCampaign
@scheduled
@parallel
@noAA


Feature: UAS E2E Ad request flow - with new entities
	Background: health check
		When Sending a healthcheck request to UAS
		Then The response code is 200

	@zoneTagSanity

   Scenario: Send an ad request to UAS and parse impression url
        When I send 10 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-sanity-1-a} to UAS
		Then The response code is 200
		And The response contains script
		And The responses has impression-urls
		And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-1-a-sanity-banner-1} 100% of the time
		And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-sanity-1-a} 100% of the time
		And The impressionUrl has campaignid field matching the id of the campaign named {campaign-API-1-a-sanity} 100% of the time
		And The responses has click-urls
		And The clickUrl has bannerid field matching the id of the banner named {campaign-API-1-a-sanity-banner-1} 100% of the time
		@limitationSanity
		Scenario: limitations testing - Single banner with limitation - positive test - FF
			Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
			When I send 10 times an ad request for zone named {zone-zoneset-limitations-test} to UAS
			Then The response code is 200
			And The response contains script
			And The responses has impression-urls
			And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-limitations-test-F-banner-1} 100% of the time
		@limitationSanity
		Scenario: limitations testing - 2 banners with limitation
			Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)} as user-agent string to send my requests to uas
			When I send 100 times an ad request for zone named {zone-zoneset-limitations-test} to UAS
			Then The response code is 200
			And The response contains script
			Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
			When I send 100 additional ad requests for zone named {zone-zoneset-limitations-test} to UAS
			And The response contains script
			Then The response code is 200
			And  All requests are sent
			And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-limitations-test-C-banner-1} 50% of the time
			And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-limitations-test-W-banner-1} 50% of the time
		@limitationSanity
		Scenario: limitations testing - 3 banners with limitations
			Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
			When I send 100 times an ad request for zone named {zone-zoneset-limitations-test} to UAS
			And  All requests are sent
			Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
			When I send 100 additional ad requests for zone named {zone-zoneset-limitations-test} to UAS
			And  All requests are sent
			Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)} as user-agent string to send my requests to uas
			When I send 100 additional ad requests for zone named {zone-zoneset-limitations-test} to UAS
			Then The response code is 200
			And The responses has impression-urls
			And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-limitations-test-F-banner-1} 33% of the time
			And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-limitations-test-C-banner-1} 33% of the time
			And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-limitations-test-W-banner-1} 33% of the time
