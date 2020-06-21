@viewability
@scheduled
@noAA
@parallel
@viewabilityScenarios
Feature: Viewability

  Background: health check
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    And I add header of {x-forwarded-For} with value {78.31.205.183}
    When Sending a healthcheck request to UAS
    Then The response code is 200


  Scenario:1.1 Low Viewability IAS configured - Delivery
    When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-viewability-IAS-low} to UAS
    Then The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-IAS-low-viewability-banner-1} 100% of the time

  Scenario:1.2 High Viewability IAS configured - Passback
    When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-viewability-IAS-high} to UAS
    Then The response code is 200
    And The responses are passback



  Scenario:2.1 Low Viewability DV configured - Delivery
    When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-viewability-DV-low} to UAS
    Then The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DV-low-viewability-banner-1} 100% of the time

  Scenario:2.2 High Viewability DV configured - Passback
    When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-viewability-DV-high} to UAS
    Then The response code is 200
    And The responses are passback