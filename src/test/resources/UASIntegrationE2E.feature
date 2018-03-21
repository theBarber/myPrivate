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

Scenario: Send an ad request to UAS and parse logs
        Given I Delete req logs
        Given I Delete imp logs
        Given I clear all cookies from uas requests
        When I send 10 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-sanity-1-a} to UAS
        And The response has impression-url
        And The response has click-url
        When I send impression requests to UAS
        And I sleep for 20 seconds
		Then I read the latest req log file from uas
        Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
        And The field zoneid in the 4 column of the req log is the same as in impression-url
        And The field bannerid in the 5 column of the req log is the same as in impression-url
        And The field campaignid in the 6 column of the req log is the same as in impression-url
        And I sleep for 20 seconds
        Then I read the latest imp log file from uas
        And I filter in the imp log to the lines where id at column 1 is the same as in impression-url
        Given I Delete clk logs
        When I send click requests to UAS
        And I sleep for 20 seconds
        Then I read the latest clk log file from uas
        And I filter in the clk log to the lines where id at column 1 is the same as in impression-url


#   s bannerid field matching the id of the banner named {75396-197420-270914-Medium Rectangle 300x250-test} 50% of the time