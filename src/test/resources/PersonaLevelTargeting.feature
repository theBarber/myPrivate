@PLT
@parallel
@scheduled
@noAA
@daniellaPLT
@PersonaLevelTargetingFeature
@request_service
Feature: Persona level targeting

  Background: health check
    When Sending a healthcheck request to UAS
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    And I add {NY} ip header
    Then The response code is 200

  Scenario: 0. injection to cb
    #Given I inject profile doc for scenario {1. PLPT is active, zone req. 1 users - 2 devices - one app one web} to users bucket
    And I inject profile doc for scenario {1.1 PLPT is active, zone req. 1 users - 2 devices - one app one web} to users bucket
    #And I inject profile doc for scenario {2. PLPT is active, zone req. 1 users, 1 device that has both profiles} to users bucket
    #And I inject profile doc for scenario {2.1 PLPT is active, zone req. 1 users, 1 device that has both profiles} to users bucket
    #And I inject profile doc for scenario {3. PLPT is not active, zone req. 1 users - 2 devices - one app one web} to users bucket
    #And I inject profile doc for scenario {3.1 PLPT is not active, zone req. 1 users - 2 devices - one app one web} to users bucket
    #And I inject profile doc for scenario {4. PLPT is not active, zone req. 1 users, 1 device that has both profiles} to users bucket
    And I inject profile doc for scenario {4.1 PLPT is not active, zone req. 1 users, 1 device that has both profiles} to users bucket

  Scenario: 1. PLPT is active, zone req. 1 users - 2 devices - one app one web.
    Given I Delete req logs
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {bundleid=PLT-YesPersonaL&deviceid=12300000-0000-0000-0000-000000000123} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
    Then The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PLT-YesPersonaL-ST-1-banner-1} 100% of the time
    And The responses has click-urls
    When I send impression requests to UAS
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a2b3c8faf45446dcbba3248ce123c2bb} to my requests to uas
    When I send 1 times an ad request with parameter {domain=PLT-YesPersonaL} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
    Then The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PLT-YesPersonaL-ST-1-banner-1} 100% of the time

#  Scenario: 1.1 PLPT is active, zone req. 1 users - 2 devices - one app one web.
#    Given I Delete req logs
#    Given I clear all cookies from uas requests
#    When I send 1 times an ad request with parameter {bundleid=PLT-YesPersonaL&deviceid=12300000-0000-0000-0000-000000000123} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
#    Then The response code is 200
#    And The response contains {script}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PLT-YesPersonaL-ST-1-banner-1} 100% of the time
#    And The responses has click-urls
#    When I send impression requests to UAS
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {a2b3c8faf45446dcbba3248ce123c2bb} to my requests to uas
#    When I send 1 times an ad request with parameter {domain=PLT-YesPersonaL} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
#    Then The response code is 200
#    And The response contains {script}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PLT-YesPersonaL-ST-1-banner-1} 100% of the time
#
#  Scenario: 2. PLPT is active, zone req. 1 users, 1 device that has both profiles
#    Given I clear all cookies from uas requests
#    Given I Delete req logs
#    When I send 1 times an ad request with parameter {bundleid=daniellaAppPLT&deviceid=12345600-0000-0000-0000-000000000123} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
#    Then The response code is 200
#    And The response contains {script}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PLT-YesPersonaL-ST-1-banner-1} 100% of the time
#
#  Scenario: 2.1 PLPT is active, zone req. 1 users, 1 device that has both profiles
#    Given I clear all cookies from uas requests
#    Given I Delete req logs
#    When I send 1 times an ad request with parameter {bundleid=daniellaAppPLT&deviceid=12345600-0000-0000-0000-000000000123} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
#    Then The response code is 200
#    And The response contains {script}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PLT-YesPersonaL-ST-1-banner-1} 100% of the time
#
#  Scenario: 3. PLPT is not active, zone req. 1 users - 2 devices - one app one web.
#    Given I clear all cookies from uas requests
#    When I send 1 times an ad request with parameter {bundleid=PLT-NotPersonaL&deviceid=12300000-0000-0000-0000-000000000123} for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
#    Then The response code is 200
#    And The responses are passback
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {a2b3c8faf45446dcbba3248ce123c2bb} to my requests to uas
#    When I send 1 times an ad request for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
#    Then The response code is 200
#    And The responses are passback
#
#  Scenario: 3.1 PLPT is not active, zone req. 1 users - 2 devices - one app one web.
#    Given I clear all cookies from uas requests
#    When I send 1 times an ad request with parameter {bundleid=PLT-NotPersonaL&deviceid=12300000-0000-0000-0000-000000000123} for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
#    Then The response code is 200
#    And The responses are passback
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {a2b3c8faf45446dcbba3248ce123c2bb} to my requests to uas
#    When I send 1 times an ad request for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
#    Then The response code is 200
#    And The responses are passback
#
#  Scenario: 4. PLPT is not active, zone req. 1 users, 1 device that has both profiles
#    Given I clear all cookies from uas requests
#    When I send 1 times an ad request with parameter {bundleid=PLT-NotPersonaL&deviceid=12345600-0000-0000-0000-000000000123} for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
#    Then The response code is 200
#    And The response contains {script}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PLT-NotPersonaL-ST-1-banner-1} 100% of the time
#
#  Scenario: 4.1 PLPT is not active, zone req. 1 users, 1 device that has both profiles
#    Given I clear all cookies from uas requests
#    When I send 1 times an ad request with parameter {bundleid=PLT-NotPersonaL&deviceid=12345600-0000-0000-0000-000000000123} for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
#    Then The response code is 200
#    And The response contains {script}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PLT-NotPersonaL-ST-1-banner-1} 100% of the time