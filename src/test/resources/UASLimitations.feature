@Integration
@Sanity
@UASLimitationsFiltering
@cli
@uas
@campaign
@hardcoded
@stable
Feature: UAS limitations filtering

#Background: 
#FF - 75396-208153-275578-See Through-RampLift-1
#CH - 75396-208153-275579-See Through-RampLift-1
#IE - 75396-208153-275580-See Through-RampLift-1
#UNLIMITED - 75396-208153-275581-See Through-RampLift-1

Scenario: limitations testing - Single banner with limitation - positive test - FF
	Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
	When I send 10 times an ad request for zone named {INT2434 - See Through - ramp-lift-auto-zone-limitations-test} to UAS
	Then The response code is 200
	And The response contains script
	And The responses has impression-urls
	And The impressionUrl has bannerid field matching the id of the banner named {75396-208153-275578-See Through-RampLift-1} 100% of the time

Scenario: limitations testing - 2 banners with limitation
	Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)} as user-agent string to send my requests to uas
	When I send 10 times an ad request for zone named {INT2434 - See Through - ramp-lift-auto-zone-limitations-test} to UAS
	Then The response code is 200
	And The response contains script
	Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
	When I send 10 additional ad requests for zone named {INT2434 - See Through - ramp-lift-auto-zone-limitations-test} to UAS
	And The response contains script
	And  All requests are sent
	And The impressionUrl has bannerid field matching the id of the banner named {75396-208153-275580-See Through-RampLift-1} 50% of the time
	And The impressionUrl has bannerid field matching the id of the banner named {75396-208153-275579-See Through-RampLift-1} 50% of the time

Scenario: limitations testing - 3 banners with limitations
	Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
	When I send 10 times an ad request for zone named {INT2434 - See Through - ramp-lift-auto-zone-limitations-test} to UAS
	And  All requests are sent
	Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
	When I send 10 additional ad requests for zone named {INT2434 - See Through - ramp-lift-auto-zone-limitations-test} to UAS
	And  All requests are sent
	Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)} as user-agent string to send my requests to uas
	When I send 10 additional ad requests for zone named {INT2434 - See Through - ramp-lift-auto-zone-limitations-test} to UAS
	Then The response code is 200
	And The impressionUrl has bannerid field matching the id of the banner named {75396-208153-275578-See Through-RampLift-1} 33% of the time
	And The impressionUrl has bannerid field matching the id of the banner named {75396-208153-275579-See Through-RampLift-1} 33% of the time
	And The impressionUrl has bannerid field matching the id of the banner named {75396-208153-275580-See Through-RampLift-1} 33% of the time
