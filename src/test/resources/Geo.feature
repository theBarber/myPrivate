@geoLimit
@scheduled
@uas
@parallel
@noAA

Feature: Geo limitation targeting
#  |campaign-city-zoneLevelLimit-ST          |city = paris
#  |campaign-region-bannerLevelLimit-ST      |state = Germany
#  |campaign-state-zoneLevelLimit-ST         |region = ?
#  |campaign-state-bannerLevelLimit-ST       |state = canada = 23.17.255.255

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200


  Scenario: 1. zone req sent from the targeted city/region/state, banner ex
   Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {190.181.32.176}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo1} for zone named {zone-zoneset-city-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-city-zoneLevelLimit-ST-banner-1} 100% of the time
    Given I clear all headers from uas requests
    Given I add header of {x-forwarded-for} with value {66.87.207.155}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo2} for zone named {zone-zoneset-region-bannerLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-region-bannerLevelLimit-ST-banner-1} 100% of the time
    Given I clear all headers from uas requests
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo3} for zone named {zone-zoneset-state-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-zoneLevelLimit-ST-banner-1} 100% of the time
    And I sleep for 20 seconds
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo4} for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time


  Scenario: 2. zone req sent not from the targeted city/region/state, passback ex
    Given I clear all headers from uas requests
    When I send 1 times an ad request with parameter {optimize=1&domain=geo1} for zone named {zone-zoneset-city-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {optimize=1&domain=geo2} for zone named {zone-zoneset-region-bannerLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {optimize=1&domain=geo3} for zone named {zone-zoneset-state-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {optimize=1&domain=geo4} for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 3. DT req sent from the targeted city/region/state, banner ex
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    Given I add header of {x-forwarded-for} with value {190.181.32.176}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo1&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-city-zoneLevelLimit-ST-banner-1} 100% of the time
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {66.87.207.155}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo2&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-region-bannerLevelLimit-ST-banner-1} 100% of the time
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo3&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-zoneLevelLimit-ST-banner-1} 100% of the time


  Scenario: 4. DT req sent not from the targeted city/region/state, pb ex
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo1&tagid=170&optimize=1}
    And The response code is 200
    And The responses are passback
    Given I clear all cookies from uas requests
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo2&tagid=170&optimize=1}
    And The response code is 200
    And The responses are passback
    Given I clear all cookies from uas requests
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo3&tagid=170&optimize=1}
    And The response code is 200
    And The responses are passback
    Given I clear all cookies from uas requests
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The responses are passback
