@vcr1
@parallel

Feature: VCR feature

  Background: health check
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    And I add header of {x-forwarded-For} with value {78.31.205.183}
    When Sending a healthcheck request to UAS
    Then The response code is 200



  Scenario:1 Low VCR (10%) - expected Delivery
    When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-VCR-10} to UAS
    Then The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-IAS-low-viewability-banner-1} 100% of the time

  Scenario:2 High VCR (90%)  - expected Passback
    When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-VCR-90} to UAS
    Then The response code is 200
    And The responses are passback



