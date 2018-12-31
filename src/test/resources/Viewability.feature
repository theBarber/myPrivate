@viewability
@scheduled
#@parallel
@noAA
#@expected viewability 0.40437552

  Feature: Viewability

  Scenario:
    When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-viewability-1-a} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-1-a-viewability-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-viewability-2-a} to UAS
    Then The response code is 200
    And The responses are passback
