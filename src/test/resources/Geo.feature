@geoLimit
@scheduled
@uas
@parallel
@noAA
@GeoLimitationTargetingFeature
@request_service
Feature: Geo limitation targeting

  Background: health check
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: 1.a zone req sent from the targeted city/region/state, banner ex - PART ONE
    Given I add header of {x-forwarded-for} with value {78.31.205.183}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo1} for zone named {zone-zoneset-city-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-city-zoneLevelLimit-ST-banner-1} 100% of the time

  Scenario: 1.b zone req sent from the targeted city/region/state, banner ex - PART TWO
    Given I add header of {x-forwarded-for} with value {66.87.207.155}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo2} for zone named {zone-zoneset-region-bannerLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-region-bannerLevelLimit-ST-banner-1} 100% of the time

  Scenario: 1.c zone req sent from the targeted city/region/state, banner ex - PART THREE
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo3} for zone named {zone-zoneset-state-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-zoneLevelLimit-ST-banner-1} 100% of the time

  Scenario: 1.d zone req sent from the targeted city/region/state, banner ex - PART FOUR
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo4} for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time


  Scenario: 2.a zone req sent not from the targeted city/region/state, passback ex - PART ONE
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo1} for zone named {zone-zoneset-city-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 2.b zone req sent not from the targeted city/region/state, passback ex - PART TWO
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo2} for zone named {zone-zoneset-region-bannerLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 2.c zone req sent not from the targeted city/region/state, passback ex - PART THREE
    Given I add header of {x-forwarded-for} with value {78.31.205.183}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo3} for zone named {zone-zoneset-state-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 2.d zone req sent not from the targeted city/region/state, passback ex - PART FOUR
    Given I add header of {x-forwarded-for} with value {78.31.205.183}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo4} for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 3.a DT req sent from the targeted city/region/state, banner ex - PART ONE
    Given I add header of {x-forwarded-for} with value {78.31.205.183}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo1&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-city-zoneLevelLimit-ST-banner-1} 100% of the time

  Scenario: 3.b DT req sent from the targeted city/region/state, banner ex - PART TWO
    Given I add header of {x-forwarded-for} with value {66.87.207.155}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {autoshopper.com&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-region-bannerLevelLimit-ST-banner-1} 100% of the time

  Scenario: 3.c DT req sent from the targeted city/region/state, banner ex - PART THREE
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time

  Scenario: 3.d DT req sent from the targeted city/region/state, banner ex - PART FOUR
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo3&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-zoneLevelLimit-ST-banner-1} 100% of the time

  Scenario: 4.a DT req sent not from the targeted city/region/state, pb ex - PART ONE
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo1&tagid=170&optimize=1}
    And The response code is 200
    And The responses are passback

  Scenario: 4.b DT req sent not from the targeted city/region/state, pb ex - PART TWO
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {autoshopper.com&tagid=170&optimize=1}
    And The response code is 200
    And The responses are passback

  Scenario: 4.c DT req sent not from the targeted city/region/state, pb ex - PART THREE
    Given I add header of {x-forwarded-for} with value {78.31.205.183}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo3&tagid=170&optimize=1}
    And The response code is 200
    And The responses are passback

  Scenario: 4.d DT req sent not from the targeted city/region/state, pb ex - PART FOUR
    Given I add header of {x-forwarded-for} with value {78.31.205.183}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The responses are passback