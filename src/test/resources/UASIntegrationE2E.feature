@cli
@uas
@RampAppCreateCampaign
@scheduled
@zoneTagSanity

    Feature: UAS E2E Ad request flow - with new entities

   Scenario: Send an ad request to UAS and parse impression url
        When I send 10 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-sanity-1-a} to UAS
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
			And  All requests are sent
			And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-limitations-test-F-banner-1} 50% of the time
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



#Scenario: Send an ad request to UAS and parse logs
#        Given I Delete req logs
#        Given I Delete imp logs
#        Given I clear all cookies from uas requests
#        When I send 10 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-sanity-1-a} to UAS
#        And The response has impression-url
#        And The response has click-url
#        When I send impression requests to UAS
#        And I sleep for 20 seconds
#		Then I read the latest req log file from uas
#        Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
#        And The field zoneid in the 4 column of the req log is the same as in impression-url
#        And The field bannerid in the 5 column of the req log is the same as in impression-url
#        And The field campaignid in the 6 column of the req log is the same as in impression-url
#        And I sleep for 20 seconds
#        Then I read the latest imp log file from uas
#        And I filter in the imp log to the lines where id at column 1 is the same as in impression-url
#        Given I Delete clk logs
#        When I send click requests to UAS
#        And I sleep for 20 seconds
#        Then I read the latest clk log file from uas
#        And I filter in the clk log to the lines where id at column 1 is the same as in impression-url


#   s bannerid field matching the id of the banner named {75396-197420-270914-Medium Rectangle 300x250-test} 50% of the time