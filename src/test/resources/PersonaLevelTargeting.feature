@PLT
@parallel
@scheduled
@noAA
@daniellaPLT

Feature: Persona level targeting

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: injecting to users bucket
    Then i inject new profile doc with udId {2.12300000-0000-0000-0000-000000000123} on users bucket, where platform = {app}, profile type = {udmp_p}, profile num = 123, and reduce 0 days from epoc time stamp and extra devices string = "upid": "66.3.45b46d3d9ae4015fa47f2076c315ea23", "devices": [{"udid": "2.12300000-0000-0000-0000-000000000123"},{"udid": "1.9mrjt7trg1a57yd4pv1e7zxdn"}]
    Then i inject new profile doc with udId {1.9mrjt7trg1a57yd4pv1e7zxdn} on users bucket, where platform = {desktop}, profile type = {udmp_p}, profile num = 456, and reduce 0 days from epoc time stamp and extra devices string = "upid": "66.3.45b46d3d9ae4015fa47f2076c315ea23", "devices": [{"udid": "2.12300000-0000-0000-0000-000000000123"},{"udid": "1.9mrjt7trg1a57yd4pv1e7zxdn"}]
    Then i inject new profile doc with two udmp_p profiles with udId {2.12345600-0000-0000-0000-000000000123} on users bucket, where platform = {app}. First p = 123 with 0 days reduce. Second profile = 456 with 0 days reduce
    Then i inject new profile doc with udId {2.171192000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {udmp_p}, profile num = 123, and reduce 0 days from epoc time stamp and extra devices string = "upid": "66.3.45b46d3d9ae4015fa47f2076c315ea23", "devices": [{"udid": "2.171192000-0000-0000-0000-000000000000"},{"udid": "2.171100000-0000-0000-0000-000000000000"}]

#UTID=a2b3c8faf45446dcbba3248ce123c2bb is encoded to=9mrjt7trg1a57yd4pv1e7zxdn

  Scenario: sleeping
    And I sleep for 3 seconds


  Scenario: 1. PLPT is active, zone req. 1 users - 2 devices - one app one web.
    Given I Delete req logs
    Given I clear all cookies from uas requests
    And I sleep for 1 seconds
    When I send 1 times an ad request with parameter {bundleid=PLT-YesPersonaL&deviceid=12300000-0000-0000-0000-000000000123} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PLT-YesPersonaL-ST-1-banner-1} 100% of the time
    And The responses has click-urls
    When I send impression requests to UAS
    And I sleep for 1 seconds
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a2b3c8faf45446dcbba3248ce123c2bb} to my requests to uas
    When I send 1 times an ad request with parameter {domain=PLT-YesPersonaL} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PLT-YesPersonaL-ST-1-banner-1} 100% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PLT-YesPersonaL-ST-1-banner-1} 100% of the time


  Scenario: 2. PLPT is active, zone req. 1 users, 1 device that has both profiles
    And I sleep for 1 seconds
   Given I clear all cookies from uas requests
    Given I Delete req logs
    When I send 1 times an ad request with parameter {bundleid=daniellaAppPLT&deviceid=12345600-0000-0000-0000-000000000123} for zone named {zone-zoneset-PLT-YesPersonaL-ST-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PLT-YesPersonaL-ST-1-banner-1} 100% of the time

  Scenario: 3. PLPT is not active, zone req. 1 users - 2 devices - one app one web.
    And I sleep for 1 seconds
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {bundleid=PLT-NotPersonaL&deviceid=12300000-0000-0000-0000-000000000123} for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback
    And I sleep for 1 seconds
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a2b3c8faf45446dcbba3248ce123c2bb} to my requests to uas
    When I send 1 times an ad request for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 4. PLPT is not active, zone req. 1 users, 1 device that has both profiles
    And I sleep for 1 seconds
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {bundleid=PLT-NotPersonaL&deviceid=12345600-0000-0000-0000-000000000123} for zone named {zone-zoneset-PLT-NotPersonaL-ST-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PLT-NotPersonaL-ST-1-banner-1} 100% of the time


