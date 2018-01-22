@Sanity 
@UASBuyAtMost 
@Integration 
@hardcoded
@cli
@uas
Feature: UAS buy at most

Scenario: buy at most testing - Single banner - positive test
		Given I upload a new solver plan with the following slices
			| {"buying_strategy_id": -1, "slices": [{"slice_id":"${guid}","banner_id":"${workflow.banner(UAS-by-at-most-1-banner)}","pub_acnt_id": 2434,"weight":10,"start_time":1478044800,"end_time":1478131199,"KPI_SCORE": 1, "KPI_TYPE": "Pacing","buy_at_most":250,"is_programmatic": false,"hour": -1, "country": "-1", "region": "-1"},{"slice_id":"${guid}","banner_id":"${workflow.banner(UAS-by-at-most-2-banner)}","pub_acnt_id": 2434,"weight":10,"start_time":1478044800,"end_time":1478131199,"KPI_SCORE": 0, "KPI_TYPE": "Pacing","buy_at_most":0,"is_programmatic": false,"hour": -1, "country": "-1", "region": "-1"}]}   |
		And I sleep for 70 seconds
		Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko with BuyAtMostTest} as user-agent string to send my requests to uas
		And I Delete req logs
		When  I send ad requests I sleep 150 millis
		And I add optimize query parameter with value {1} to send my requests to uas
		When I send 500 times an ad request with query parameters for zone named {Uas-by-at-most-zone-1} to UAS
		And I send impression requests to UAS immediately!
		Then The response code is 200
		And The impressionUrl has bannerid field matching the id of the banner named {UAS-by-at-most-1-banner} 50% of the time
		And The impressionUrl has bannerid field matching the id of the banner named {UAS-by-at-most-2-banner} 50% of the time
		And I sleep for 20 seconds
		When I send 20 times an ad request with query parameters for zone named {Uas-by-at-most-zone-1} to UAS
		And I send impression requests to UAS immediately!
		And I sleep for 60 seconds
		When I send 100 times an ad request with query parameters for zone named {Uas-by-at-most-zone-1} to UAS
		Then The response code is 200
		And The impressionUrl has bannerid field matching the id of the banner named {UAS-by-at-most-2-banner} 100% of the time

	Scenario: restore original plan to S3
		Then I restore the original plan
		And I sleep for 70 seconds
