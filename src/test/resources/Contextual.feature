@parallel
@contextualScenarios
@contextual
@request_service
Feature: contextual targeting tests

  Background: health check
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    And I add header of {X-Forwarded-For} with value {78.31.205.183}
    And The response code is 200

  Scenario: 0. setup - populating cache
    Given I send 1 times an ad request with parameter {optimize=1&loc=https%3A%2F%2Fdisney.com} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And I send 1 times an ad request with parameter {optimize=1&bundleid=com.outfit7.mytalkingtomfree} for zone named {zone-zoneset-dv-zoneLevelLimit-brand-safety-ST} to UAS
    And I send 1 times an ad request with parameter {optimize=1&loc=https%3A%2F%2Fdrugs.com} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And I send 1 times an ad request with parameter {optimize=1&loc=https://edition.cnn.com/sport} for zone named {zone-zoneset-CT-ST-1} to UAS
    And I send 1 times an ad request with parameter {optimize=1&loc=http://cnn.com} for zone named {zone-zoneset-CT-ST-1} to UAS

  Scenario:1.a contextual targeting by dv - inapp - PART ONE - Delivery Expected
    When I print local time
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&bundleid=com.outfit7.mytalkingtomfree} for zone named {zone-zoneset-dv-zoneLevelLimit-brand-safety-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-dv-zoneLevelLimit-brand-safety-ST-banner-1} 100% of the time

  Scenario:1.b contextual targeting by dv - inapp - PART TWO - Passback Expected
    When I print local time
    Given I use {Mozilla/5.0 (Linux; U; Android 2.2) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&bundleid=com.outfit7.mytalkingtomfree} for zone named {zone-zoneset-WL-ST-2} to UAS
    And The response code is 200
    And The responses are passback

  Scenario:3.a contextual targeting by dv - campaign level limitation domain exclude -  PART ONE - Passback Expected
    When I print local time
    When I send 1 times an ad request with parameter {optimize=1&loc=https%3A%2F%2Fdisney.com} for zone named {zone-zoneset-dv-campaignLevelLimit-exclude-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario:3.b contextual targeting by dv - campaign level limitation domain exclude - PART TWO - Passback Expected
    When I print local time
    When I send 1 times an ad request with parameter {optimize=1&loc=https%3A%2F%2Fwww.military.com%2Fequipment%2Fweapons} for zone named {zone-zoneset-dv-campaignLevelLimit-exclude-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario:3.c contextual targeting by dv - campaign level limitation domain exclude - PART THREE - Passback Expected
    When I print local time
    When I send 1 times an ad request with parameter {optimize=1&loc=http://one.co.il} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario:4.a contextual targeting by dv - campaign level limitation - PART ONE - Delivery Expected
    When I print local time
    When I send 1 times an ad request with parameter {optimize=1&loc=https%3A%2F%2Fdisney.com} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    When I send 1 times an ad request with parameter {optimize=1&loc=https%3A%2F%2Fdisney.com} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-dv-campaignLevelLimit-ST-banner-1} 100% of the time

  Scenario:4.b contextual targeting by dv - campaign level limitation - PART TWO - Passback Expected
    When I print local time
    When I send 1 times an ad request with parameter {optimize=1&loc=https%3A%2F%2Fdrugs.com} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario:4.c contextual targeting by dv - campaign level limitation - PART THREE - Passback Expected
    When I print local time
    When I send 1 times an ad request with parameter {optimize=1&loc=https%3A%2F%2Fwww.military.com%2Fequipment%2Fweapons} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario:4.d contextual targeting by dv - campaign level limitation - PART FOUR - Passback Expected
    When I print local time
    When I send 1 times an ad request with parameter {optimize=1&loc=http://one.co.il} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario:5.a contextual targeting - peer 39 banner level limitation backward compatibility - PART ONE - Delivery Expected
    When I print local time
    When I send 1 times an ad request with parameter {optimize=1&loc=https://edition.cnn.com/sport} for zone named {zone-zoneset-CT-ST-1} to UAS
    When I send 1 times an ad request with parameter {optimize=1&loc=https://edition.cnn.com/sport} for zone named {zone-zoneset-CT-ST-1} to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CT-ST-1-banner-1} 100% of the time

  Scenario:5.b contextual targeting - peer 39 banner level limitation backward compatibility - PART TWO - Delivery Expected
    When I print local time
    When I send 1 times an ad request with parameter {optimize=1&loc=http://cnn.com} for zone named {zone-zoneset-CT-ST-1} to UAS
    When I send 1 times an ad request with parameter {optimize=1&loc=http://cnn.com} for zone named {zone-zoneset-CT-ST-1} to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CT-ST-1-banner-1} 100% of the time

  Scenario:5.c contextual targeting - peer 39 banner level limitation backward compatibility - PART THREE - Passback Expected
    When I print local time
    When I send 1 times an ad request with parameter {optimize=1&loc=http://one.co.il} for zone named {zone-zoneset-CT-ST-1} to UAS
    And The response code is 200
    And The responses are passback

  Scenario:6.a contextual targeting - peer 39 banner level limitation  - PART ONE - Delivery Expected
    When I print local time
    When I send 1 times an ad request with parameter {optimize=1&loc=http://cnn.com} for zone named {zone-zoneset-CT-ST-1} to UAS
    When I send 1 times an ad request with parameter {optimize=1&loc=http://cnn.com} for zone named {zone-zoneset-CT-ST-1} to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CT-ST-1-banner-1} 100% of the time

  Scenario:6.b contextual targeting - peer 39 banner level limitation - PART TWO - Passback Expected
    When I print local time
    When I send 1 times an ad request with parameter {optimize=1&loc=http://one.co.il} for zone named {zone-zoneset-CT-ST-1} to UAS
    And The response code is 200
    And The responses are passback