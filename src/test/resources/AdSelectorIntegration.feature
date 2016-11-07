@cli
@uas
@campaign
@hardcoded
Feature: UAS Integration with Ad Selector
	Scenario: Upload new plan to S3
		Given I upload a new solver plan with the following slices
	|{"buying_strategy_id": -1, "slices": [{"banner_id": 968381, "weight": 1000, "slice_id": "$SLICE_ID$", "start_time": 1477872001, "zone_id": 37750, "end_time": 1477958399, "predicates": {"AND": [{"==": ["body.features.zone_id", 37750]}]}, "buy_at_most": 10}]}|
	|{"buying_strategy_id": -1, "slices": [{"banner_id": 968473, "weight": 1000000, "slice_id": "$SLICE_ID$", "start_time": 1477872001, "zone_id": 11457, "end_time": 1477958399, "predicates": {"AND": [{"==": ["body.features.zone_id", 11457]}, {"==": ["body.features.dma", 99999]}]}, "buy_at_most": 100}]}|
	|{"buying_strategy_id": -1, "slices": [{"banner_id": 968473, "weight": 1000000, "slice_id": "$SLICE_ID$", "start_time": 1477872001, "zone_id": 11457, "end_time": 1477958399, "predicates": {"AND": [{"==": ["body.features.zone_id", 11457]}, {"==": ["body.features.dma", 55]}]}, "buy_at_most": 100}]}   |
		Then I will be able to start testing

	Scenario: zone id that exist in zone cache but does not exist it plan
		When I send 11 times an ad request for zone named {qa.undertone.com - Full Banner} to UAS
		Then The response code is 200
		And The responses has impression-urls
		And The impressionUrl has bannerid field matching the id of the banner named {Test Banner1} 100% of the time

	Scenario: valid banner that not pass all predicates with existing zone
		When I send 1 times an ad request for zone named {QA-INT01 - Half Page Ad 300x600 - INT01N - Half Page Ad (300 x 600)} and zone limitation dma=11 to UAS
		Then The response code is 200
		And The banner to passback ratio for banner {968473} should be 100%

	Scenario: valid banner that pass all predicates with existing zone
		When I send 1 times an ad request for zone named {QA-INT01 - Half Page Ad 300x600 - INT01N - Half Page Ad (300 x 600)} and zone limitation dma=55 to UAS
		Then The response code is 200
		And The banner to passback ratio for banner {968473} should be 100%

	Scenario: banner with buy_at_most limitation
		When I send 20 times an ad request for zone named {QA-INT03 - Half Page Ad 300x600 - INT03AFP - Half Page Ad} to UAS
		Then The response code is 200
		And The banner to passback ratio for banner {968381} should be 50%

	Scenario: Restore original plan to S3
		Then I restore the original solver plan
		And I will finish testing
