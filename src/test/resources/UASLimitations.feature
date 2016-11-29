@cli
@uas
@campaign
@Sanity
Feature: UAS limitations filtering
  Scenario: Upload new plan to S3
    Given I upload a new solver plan with the following slices
      | {"buying_strategy_id": -1, "slices": [{"zone_id":11457,"slice_id":"${guid}","banner_id":"${workflow.banner(Int-test-FF-targeted-banner)}","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",11457]}]},"buy_at_most":2000}]}   |
      | {"buying_strategy_id": -1, "slices": [{"zone_id":11457,"slice_id":"$SLICE_ID$","banner_id":"968380","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",11457]}]},"buy_at_most":2000}]}   |
      | {"buying_strategy_id": -1, "slices": [{"zone_id":11457,"slice_id":"$SLICE_ID$","banner_id":"968474","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",11457]}]},"buy_at_most":1}]}      |
      | {"buying_strategy_id": -1, "slices": [{"zone_id":37750,"slice_id":"$SLICE_ID$","banner_id":"968382","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",37750]}]},"buy_at_most":2000}]}   |
      | {"buying_strategy_id": -1, "slices": [{"zone_id":37750,"slice_id":"$SLICE_ID$","banner_id":"968380","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",37750]}]},"buy_at_most":2000}]}   |
      | {"buying_strategy_id": -1, "slices": [{"zone_id":37750,"slice_id":"$SLICE_ID$","banner_id":"968381","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",37750]}]},"buy_at_most":2000}]}   |
    And I sleep for 70 seconds
    Then I will be able to start testing

  Scenario: limitations testing - Single banner with limitation - positive test
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
    When I send 10 times an ad request for zone named {QA-INT01 - Half Page Ad 300x600 - INT01N - Half Page Ad (300 x 600)} to UAS
    Then The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {Int-test-FF-targeted-banner} 100% of the time

  Scenario: limitations testing - Single banner with limitation - negative test including non-default selection validation
    Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)} as user-agent string to send my requests to uas
    When I send 100 times an ad request for zone named {QA-INT01 - Half Page Ad 300x600 - INT01N - Half Page Ad (300 x 600)} to UAS
    Then The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {Int-test-IE-targeted-banner} 5% of the time
    And The passback ratio should be 95%

  Scenario: limitations testing - 2 banners with limitations - positive + negative tests
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
    When I send 10 times an ad request for zone named {QA-INT01 - Half Page Ad 300x600 - INT01N - Half Page Ad (300 x 600)} to UAS
    And  All requests are sent
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    When I send 10 additional ad requests for zone named {QA-INT01 - Half Page Ad 300x600 - INT01N - Half Page Ad (300 x 600)} to UAS
    And  All requests are sent
    Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)} as user-agent string to send my requests to uas
    When I send 10 additional ad requests for zone named {QA-INT01 - Half Page Ad 300x600 - INT01N - Half Page Ad (300 x 600)} to UAS
    Then The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {Int-test-FF-targeted-banner} 33% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {Int-test-CH-targeted-banner} 33% of the time
    And The passback ratio should be 33%

  Scenario: limitations testing - 3 banners, 2 of them with limitations
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
    When I send 50 times an ad request for zone named {QA-INT03 - Half Page Ad 300x600 - INT03AFP - Half Page Ad} to UAS
    And  All requests are sent
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    When I send 50 additional ad requests for zone named {QA-INT03 - Half Page Ad 300x600 - INT03AFP - Half Page Ad} to UAS
    And  All requests are sent
    Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)} as user-agent string to send my requests to uas
    When I send 50 additional ad requests for zone named {QA-INT03 - Half Page Ad 300x600 - INT03AFP - Half Page Ad} to UAS
    Then The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {Int-test-FF-targeted-banner} 17% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {Int-test-CH-targeted-banner} 17% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {Int-test-unlimited-banner} 66% of the time



  Scenario: Restore original plan to S3
    Then I restore the original solver plan
    And I sleep for 70 seconds
    And I will finish testing

