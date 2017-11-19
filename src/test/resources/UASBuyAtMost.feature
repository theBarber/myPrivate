@Sanity 
@UASBuyAtMost 
@Integration 
@hardcoded
Feature: UAS buy at most

Scenario: buy at most testing - Single banner - positive test
		Given I upload a new solver plan with the following slices
			| {"buying_strategy_id": -1, "slices": [{"zone_id":${workflow.zone(INT2434 - See Through - RAMP Lift Test 1)},"slice_id":"${guid}","banner_id":"${workflow.banner(75396-210722-278956-See Through-RampLift-1)}","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",${workflow.zone(INT2434 - See Through - RAMP Lift Test 1)}]}]},"KPI_SCORE": 1, "KPI_TYPE": "Pacing","buy_at_most":500}]}   |
		And I sleep for 70 seconds
		Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko with BuyAtMostTest} as user-agent string to send my requests to uas
		When  I send ad requests I sleep 150 millis
		And I add optimize query parameter with value {1} to send my requests to uas
		When I send 500 times an ad request with query parameters for zone named {INT2434 - See Through - RAMP Lift Test 1} to UAS
		And I send impression requests to UAS immediately!
		Then The response code is 200
		And The impressionUrl has bannerid field matching the id of the banner named {75396-210722-278956-See Through-RampLift-1} 100% of the time
		And I sleep for 20 seconds
		When I send 20 times an ad request with query parameters for zone named {INT2434 - See Through - RAMP Lift Test 1} to UAS
		And I send impression requests to UAS immediately
		And I sleep for 20 seconds
		When I send 100 times an ad request with query parameters for zone named {INT2434 - See Through - RAMP Lift Test 1} to UAS
		Then The response code is 200
		And The responses are passback

	Scenario: Delete the test plan to S3
		Then I delete the test solver plan
		And I sleep for 70 seconds
