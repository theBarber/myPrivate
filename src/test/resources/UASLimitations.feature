@cli
@uas
@campaign
@hardcoded
Feature: UAS limitations filtering
  Background:
    Given Campaign Manager with hardcoded campaigns
    Given I load a new solver plan with the following slices
      | {"buying_strategy_id": -1, "slices": [{"zone_id":11457,"slice_id":"$SLICE_ID$","banner_id":"968382","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",11457]}]},"buy_at_most":100}]}   |
      | {"buying_strategy_id": -1, "slices": [{"zone_id":37750,"slice_id":"$SLICE_ID$","banner_id":"968381","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",37750]}]},"buy_at_most":100}]}   |

  Scenario: limitations testing - Single banner with limitation (positive test)
    Given that I work on Firefox browser
    When I send 10 times an ad request for zone named {	QA-INT01 - Half Page Ad 300x600 - INT01N - Half Page Ad (300 x 600)} to UAS
    Then The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {Int-test-FF-targeted} 100% of the time

  Scenario: limitations testing - Single banner with limitation (negative test)
    Given that I work on Chrome browser
    When I send 10 times an ad request for zone named {	QA-INT01 - Half Page Ad 300x600 - INT01N - Half Page Ad (300 x 600)} to UAS
    Then The response code is 200
    And The passback ratio should be 100%
