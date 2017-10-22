@UASIntegrationWithAdSelector
@Integration
Feature: UAS Integration with Ad Selector 

Background: setup
	Given I setup the db
	
Scenario: Upload new plan to S3 
	Given I upload a new solver plan with the following slices 
		|{"buying_strategy_id": -1, "slices": [{"banner_id": 1038966, "weight": 1000, "slice_id": "$SLICE_ID$", "start_time": 1477872001, "zone_id": 155605, "end_time": 1477958399, "predicates": {"AND": [{"==": ["body.features.zone_id", 155605]}]}, "buy_at_most": 10}]}|
		|{"buying_strategy_id": -1, "slices": [{"banner_id": 1040820, "weight": 10000, "slice_id": "$SLICE_ID$", "start_time": 1477872001, "zone_id": 156242, "end_time": 1477958399, "predicates": {"AND": [{"==": ["body.features.zone_id", 156242]}, {"==": ["body.features.dma", 99999]}]}, "buy_at_most": 100}]}|
		|{"buying_strategy_id": -1, "slices": [{"banner_id": 1040820, "weight": 10000, "slice_id": "$SLICE_ID$", "start_time": 1477872001, "zone_id": 156242, "end_time": 1477958399, "predicates": {"AND": [{"==": ["body.features.zone_id", 156242]}, {"==": ["body.features.dma", 55]}]}, "buy_at_most": 100}]}   |
		|{"buying_strategy_id": -1, "slices": [{"banner_id": 1040819, "weight": 1000000, "slice_id": "$SLICE_ID$", "start_time": 1477872001, "zone_id": 156242, "end_time": 1477958399, "predicates": {"AND": [{"==": ["body.features.zone_id", 156242]}, {"==": ["body.features.dma", 100]}]}, "buy_at_most": 10}]}   |
	And I sleep for 70 seconds 
	
Scenario: zone id that exist in zone cache but does not exist in plan 
	When I send 11 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} to UAS 
	Then The response code is 200 
	And The responses has impression-urls 
	
Scenario: valid banner that not pass all predicates with existing zone 
	When I send 1 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} and zone limitation dma=11 to UAS 
	Then The response code is 200 
	And The banner to passback ratio for banner {1038966} should be 100% 
	
Scenario: valid banner that pass all predicates with existing zone 
	When I send 1 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone2-test-2banners} and zone limitation dma=55 to UAS 
	Then The response code is 200 
	And The banner to passback ratio for banner {1040820} should be 100% 
	
Scenario: Restore original plan to S3 

	