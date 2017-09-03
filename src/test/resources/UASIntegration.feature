@UASe2eAdRequestFlows
	@Integration
	@cli
	@uas
	@stable
	Feature: UAS E2E Ad request flows (unknown zones)

#Background: setup
#	Given I setup the db

	@Sanity
	Scenario: Send an ad request to UAS and parse impression url
#		Given I setup the db
		When I send 10 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} to UAS
	 ##   When I send an ad-request for zone {pacing 200} is sent to UAS
		And The response contains script
		And The responses has impression-urls
		And The impressionUrl has bannerid field matching the id of the banner named {75396-197420-270477-Medium Rectangle 300x250-ramp-lift-auto-banner1-test} 100% of the time
		And The impressionUrl has zoneid field matching the id of the zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} 100% of the time
		And The impressionUrl has campaignid field matching the id of the campaign named {ramp-lift-auto-campaign1-test} 100% of the time
		And The responses has click-urls
		And The clickUrl has bannerid field matching the id of the banner named {75396-197420-270477-Medium Rectangle 300x250-ramp-lift-auto-banner1-test} 100% of the time


#Scenario: Send an ad request to UAS and parse logs
#	When I send 10 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} to UAS
#	And The response has impression-url
#	And The response has click-url
#	When I send impression requests to UAS
#	And I sleep for 10 seconds
#	Then I read the latest req log file from uas
#	Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
#	And The field zoneid in the 4 column of the req log is the same as in impression-url
#	And The field bannerid in the 5 column of the req log is the same as in impression-url
#	And The field campaignid in the 6 column of the req log is the same as in impression-url
#	Then I read the latest imp log file from uas
#	And I filter in the imp log to the lines where id at column 1 is the same as in impression-url
#	When I send click requests to UAS
#	Then I read the latest clk log file from uas
#	And I filter in the clk log to the lines where id at column 1 is the same as in impression-url
