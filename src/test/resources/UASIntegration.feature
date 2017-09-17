@UASe2eAdRequestFlows
	@Integration
	@cli
	@uas
	@stable
	Feature: UAS Ad request flows

	@Sanity
	Scenario: Send an ad request to UAS and parse impression url
	 	Given I setup the db
		When I send 10 times an ad request for zone named {INT2434 - See Through - RAMP Lift Test 1} to UAS
	 ##   When I send an ad-request for zone {pacing 200} is sent to UAS
		And The response contains script
		And The responses has impression-urls
		And The impressionUrl has bannerid field matching the id of the banner named {75396-210722-278956-See Through-RampLift-1} 100% of the time
		And The impressionUrl has zoneid field matching the id of the zone named {INT2434 - See Through - RAMP Lift Test 1} 100% of the time
		And The impressionUrl has campaignid field matching the id of the campaign named {75396-210722-ramp-lift-Test 1} 100% of the time
		And The responses has click-urls
		And The clickUrl has bannerid field matching the id of the banner named {75396-210722-278956-See Through-RampLift-1} 100% of the time

Scenario: Send an ad request to UAS and parse logs
        Given I Delete req logs
        Given I Delete imp logs
        When I send 10 times an ad request for zone named {INT2434 - See Through - RAMP Lift Test 1} to UAS
        And The response has impression-url
        And The response has click-url
        When I send impression requests to UAS
        Then I read the latest req log file from uas
        Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
        And The field zoneid in the 4 column of the req log is the same as in impression-url
        And The field bannerid in the 5 column of the req log is the same as in impression-url
        And The field campaignid in the 6 column of the req log is the same as in impression-url
        Then I read the latest imp log file from uas
        And I filter in the imp log to the lines where id at column 1 is the same as in impression-url
        Given I Delete clk logs
        When I send click requests to UAS
        Then I read the latest clk log file from uas
        And I filter in the clk log to the lines where id at column 1 is the same as in impression-url
