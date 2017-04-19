@Sanity
@UASBuyAtMost
@Integration
@hardcoded
Feature: UAS buy at most

  Scenario: Upload new plan to S3
    Given I upload a new solver plan with the following slices
      | {"buying_strategy_id": -1, "slices": [{"zone_id":${workflow.zone(INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test)},"slice_id":"${guid}","banner_id":"${workflow.banner(75396-197420-270477-Medium Rectangle 300x250-ramp-lift-auto-banner1-test)}","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",${workflow.zone(INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test)}      ]}]},"buy_at_most":500}]}   |
    And I sleep for 70 seconds
    Then I will be able to start testing

  Scenario: buy at most testing - Single banner - positive test
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko with BuyAtMostTest} as user-agent string to send my requests to uas
    When  I send ad requests I sleep 150 millis
    And I add optimize query parameter with value {1} to send my requests to uas
    When I send 500 times an ad request with query parameters for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} to UAS
    And I send impression requests to UAS immediately!
    Then The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {75396-197420-270477-Medium Rectangle 300x250-ramp-lift-auto-banner1-test} 100% of the time
    And I sleep for 20 seconds
    When I send 20 times an ad request with query parameters for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} to UAS
    And I send impression requests to UAS immediately
    And I sleep for 20 seconds
    When I send 100 times an ad request with query parameters for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: Restore original plan to S3
    Then I restore the original solver plan