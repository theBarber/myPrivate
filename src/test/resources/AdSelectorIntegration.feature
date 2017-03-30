@UASIntegrationWithAdSelector
@Integration
@Sanity-basic
Feature: UAS Integration with Ad Selector 

#Background: zones and campaigns etc, exists
#	Given Zoneset named {hwu zonesets}
#	Given Zone named {qa.undertone.com - Full Banner} is in the zoneset named {hwu zonesets}
#	Given Zone named {qa.undertone.com - Half Banner} is in the zoneset named {hwu zonesets}
#	Given Zone named {QA-INT01 - Half Page Ad 300x600 - INT01N - Half Page Ad (300 x 600)}  is in the zoneset named {hwu zonesets}

Scenario: Upload new plan to S3 
	Given I upload a new solver plan with the following slices 
		|{"buying_strategy_id": -1, "slices": [{"banner_id": 968381, "weight": 1000, "slice_id": "$SLICE_ID$", "start_time": 1477872001, "zone_id": 37750, "end_time": 1477958399, "predicates": {"AND": [{"==": ["body.features.zone_id", 37750]}]}, "buy_at_most": 10}]}|
		|{"buying_strategy_id": -1, "slices": [{"banner_id": 968473, "weight": 10000, "slice_id": "$SLICE_ID$", "start_time": 1477872001, "zone_id": 11457, "end_time": 1477958399, "predicates": {"AND": [{"==": ["body.features.zone_id", 11457]}, {"==": ["body.features.dma", 99999]}]}, "buy_at_most": 100}]}|
		|{"buying_strategy_id": -1, "slices": [{"banner_id": 968473, "weight": 10000, "slice_id": "$SLICE_ID$", "start_time": 1477872001, "zone_id": 11457, "end_time": 1477958399, "predicates": {"AND": [{"==": ["body.features.zone_id", 11457]}, {"==": ["body.features.dma", 55]}]}, "buy_at_most": 100}]}   |
		|{"buying_strategy_id": -1, "slices": [{"banner_id": 15, "weight": 1000000, "slice_id": "$SLICE_ID$", "start_time": 1477872001, "zone_id": 2, "end_time": 1477958399, "predicates": {"AND": [{"==": ["body.features.zone_id", 2]}, {"==": ["body.features.dma", 100]}]}, "buy_at_most": 10}]}   |
	Then I will be able to start testing 
	And I sleep for 70 seconds 
	
Scenario: zone id that exist in zone cache but does not exist it plan 
	When I send 11 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} to UAS 
	Then The response code is 200 
	And The responses has impression-urls 
	
Scenario: valid banner that not pass all predicates with existing zone 
	When I send 1 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} and zone limitation dma=11 to UAS 
	Then The response code is 200 
	And The banner to passback ratio for banner {968473} should be 100% 
	
Scenario: valid banner that pass all predicates with existing zone 
	When I send 1 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} and zone limitation dma=55 to UAS 
	Then The response code is 200 
	And The banner to passback ratio for banner {968473} should be 100% 
	
Scenario: banner with buy_at_most limitation 
	When I send 20 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} and zone limitation dma=100 to UAS 
	Then The response code is 200 
	And The banner to passback ratio for banner {15} should be 50% 
	
Scenario: Restore original plan to S3 
	Then I restore the original solver plan 
	And I will finish testing 
	And I sleep for 70 seconds
	