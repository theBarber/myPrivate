@cli
Feature: Strategy service test
  Scenario: Send an ad request to UAS and parse impression url
    When I send 100 times an ad request for zone id {2} to UAS
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-210722-278956-See Through-RampLift-1} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {INT2434 - See Through - RAMP Lift Test 1} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {75396-210722-ramp-lift-Test 1} 100% of the time
    And The responses has click-urls
    And The clickUrl has bannerid field matching the id of the banner named {75396-210722-278956-See Through-RampLift-1} 100% of the time