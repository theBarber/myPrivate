@parallel
@PiiTest
Feature: Pii

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200


#    I run all profile limitation scenarios with pii not allowed - all should return passback
  Scenario: 1. PLPT is active, zone req. 1 users - 2 devices - one app one web - gdpr = 1.
    Given I add {NY} ip header
    Then I inject profile doc for scenario {1. PLPT is active, zone req. 1 users - 2 devices - one app one web} to users bucket
    And I sleep for 1 seconds
    Given I Delete req logs
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {bundleid=PLT-YesPersonaL&deviceid=12300000-0000-0000-0000-000000000123&gdpr=1} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a2b3c8faf45446dcbba3248ce123c2bb} to my requests to uas
    When I send 1 times an ad request with parameter {domain=PLT-YesPersonaL&gdpr=1} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 1.1 PLPT is active, zone req. 1 users - 2 devices - one app one web - ccpa forbidden.
    Given I add {NY} ip header
    Then I inject profile doc for scenario {1.1 PLPT is active, zone req. 1 users - 2 devices - one app one web} to users bucket
    And I sleep for 1 seconds
    Given I Delete req logs
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {bundleid=PLT-YesPersonaL&deviceid=12300000-0000-0000-0000-000000000123&ccpa=1YYN} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a2b3c8faf45446dcbba3248ce123c2bb} to my requests to uas
    When I send 1 times an ad request with parameter {domain=PLT-YesPersonaL&ccpa=1YYN} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 2. PLPT is active, zone req. 1 users, 1 device that has both profiles - gdpr = 1.
    Given I add {NY} ip header
    Then I inject profile doc for scenario {2. PLPT is active, zone req. 1 users, 1 device that has both profiles} to users bucket
    And I sleep for 1 seconds
    Given I clear all cookies from uas requests
    Given I Delete req logs
    When I send 1 times an ad request with parameter {bundleid=daniellaAppPLT&deviceid=12345600-0000-0000-0000-000000000123&gdpr=1} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 2.1 PLPT is active, zone req. 1 users, 1 device that has both profiles - ccpa forbidden.
    Given I add {NY} ip header
    Then I inject profile doc for scenario {2.1 PLPT is active, zone req. 1 users, 1 device that has both profiles} to users bucket
    And I sleep for 1 seconds
    Given I clear all cookies from uas requests
    Given I Delete req logs
    When I send 1 times an ad request with parameter {bundleid=daniellaAppPLT&deviceid=12345600-0000-0000-0000-000000000123&ccpa=1YYN} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 3. PLPT is not active, zone req. 1 users - 2 devices - one app one web - gdpr = 1.
    Given I add {NY} ip header
    Then I inject profile doc for scenario {3. PLPT is not active, zone req. 1 users - 2 devices - one app one web} to users bucket
    And I sleep for 1 seconds
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {bundleid=PLT-NotPersonaL&deviceid=12300000-0000-0000-0000-000000000123&gdpr=1} for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a2b3c8faf45446dcbba3248ce123c2bb&gdpr=1} to my requests to uas
    When I send 1 times an ad request for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 3.1 PLPT is not active, zone req. 1 users - 2 devices - one app one web - ccpa forbidden.
    Given I add {NY} ip header
    Then I inject profile doc for scenario {3.1 PLPT is not active, zone req. 1 users - 2 devices - one app one web} to users bucket
    And I sleep for 1 seconds
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {bundleid=PLT-NotPersonaL&deviceid=12300000-0000-0000-0000-000000000123&ccpa=1YYN} for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a2b3c8faf45446dcbba3248ce123c2bb&ccpa=1YYN} to my requests to uas
    When I send 1 times an ad request for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 4. PLPT is not active, zone req. 1 users, 1 device that has both profiles - gdpr = 1.
    Given I add {NY} ip header
    Then I inject profile doc for scenario {4. PLPT is not active, zone req. 1 users, 1 device that has both profiles} to users bucket
    And I sleep for 1 seconds
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {bundleid=PLT-NotPersonaL&deviceid=12345600-0000-0000-0000-000000000123&gdpr=1} for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 4.1 PLPT is not active, zone req. 1 users, 1 device that has both profiles - ccpa forbidden
    Given I add {NY} ip header
    Then I inject profile doc for scenario {4.1 PLPT is not active, zone req. 1 users, 1 device that has both profiles} to users bucket
    And I sleep for 1 seconds
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {bundleid=PLT-NotPersonaL&deviceid=12345600-0000-0000-0000-000000000123&ccpa=1YYN} for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  # GEO Targeting scenarios
  Scenario: 5. zone req sent from the targeted city/region/state, PB ex for city banner excpected for country and region- gdpr = 1 (zone-city limit)
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {190.181.32.176}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo1&gdpr=1} for zone named {zone-zoneset-city-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback
    Given I clear all headers from uas requests
    Given I add header of {x-forwarded-for} with value {66.87.207.155}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo2&gdpr=1} for zone named {zone-zoneset-region-bannerLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-region-bannerLevelLimit-ST-banner-1} 100% of the time
    Given I clear all headers from uas requests
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo3&gdpr=1} for zone named {zone-zoneset-state-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-zoneLevelLimit-ST-banner-1} 100% of the time
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    When I send 1 times an ad request with parameter {optimize=1&domain=geo4&gdpr=1} for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time


  Scenario: 6. DT req sent from the targeted city/region/state, PB ex for city banner excpected for country and region - ccpa forbidden
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    Given I add header of {x-forwarded-for} with value {190.181.32.176}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo1&tagid=170&optimize=1&ccpa=1YYN}
    And The response code is 200
    And The responses are passback
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {66.87.207.155}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo2&tagid=170&optimize=1&ccpa=1YYN}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-region-bannerLevelLimit-ST-banner-1} 100% of the time
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo4&tagid=170&optimize=1&ccpa=1YYN}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {23.17.255.255}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo3&tagid=170&optimize=1&ccpa=1YYN}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-zoneLevelLimit-ST-banner-1} 100% of the time

