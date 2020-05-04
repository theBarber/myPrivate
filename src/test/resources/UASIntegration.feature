	@Integration
	@cli
	@uas
    @stable
    @scheduled
	@parallel
	@noAA
	@request_service
	Feature: UAS Ad request flows
	Background: health check
		Given I add header of {X-Forwarded-For} with value {78.31.205.183}
		When Sending a healthcheck request to UAS
		Then The response code is 200

		@Sanity
	Scenario: Send an ad request to UAS and parse impression url
		When I send 1 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through - RAMP Lift Test 1} to UAS
		Then The response code is 200
	 	And The response contains {script}
		And The responses has impression-urls
		And The impressionUrl has bannerid field matching the id of the banner named {75396-210722-278956-See Through 2.0-Inline DynT Test} 100% of the time
		And The impressionUrl has zoneid field matching the id of the zone named {INT2434 - See Through - RAMP Lift Test 1} 100% of the time
		And The impressionUrl has campaignid field matching the id of the campaign named {75396-210722-ramp-lift-Test 1} 100% of the time
		And The responses has click-urls
		And The clickUrl has bannerid field matching the id of the banner named {75396-210722-278956-See Through 2.0-Inline DynT Test} 100% of the time