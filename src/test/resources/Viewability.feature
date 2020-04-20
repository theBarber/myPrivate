@viewability
@scheduled
@noAA
@viewabilityScenarios
Feature: Viewability

  Scenario: Viewability - Delivery
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-viewability-1-a} to UAS
    Then The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-1-a-viewability-banner-1} 100% of the time

  Scenario: Viewability - Passback
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-viewability-2-a} to UAS
    Then The response code is 200
    And The responses are passback
