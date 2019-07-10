@warfle
@parallel
@scheduled
@noAA




Feature: warfle tests - wurfl limitation in campaign and zone level, contextual targeting

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: contextual targeting by dv - zone level limitation brand safety
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdisney.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-brand-safety-ST} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-dv-campaignLevelLimit-brand-safety-ST-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fporn.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-brand-safety-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: contextual targeting by dv - campaign level limitation domain exclude
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdisney.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-exclude-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fwww.military.com%2Fequipment%2Fweapons%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-exclude-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=notarealweblala.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: contextual targeting by dv - campaign level limitation
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdisney.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-dv-campaignLevelLimit-ST-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdrugs.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fwww.military.com%2Fequipment%2Fweapons%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=notarealweblala.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: contextual targeting - peer 39 banner level limitation backward compatibility
    When I send 1 times an ad request with parameter {optimize=0&loc=https://edition.cnn.com/sport} for zone named {zone-zoneset-CT-ST-1} to UAS
    When I send 1 times an ad request with parameter {optimize=0&loc=http://www.cnn.com} for zone named {zone-zoneset-CT-ST-1} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CT-ST-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0&loc=notarealweblala.com} for zone named {zone-zoneset-CT-ST-1} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: contextual targeting - peer 39 banner level limitation
    When I send 1 times an ad request with parameter {optimize=0&loc=http://www.cnn.com} for zone named {zone-zoneset-CT-ST-1} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CT-ST-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0&loc=notarealweblala.com} for zone named {zone-zoneset-CT-ST-1} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: contextual targeting by dv - zone level limitation
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdisney.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-dv-zoneLevelLimit-ST-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdrugs.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fwww.military.com%2Fequipment%2Fweapons%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=notarealweblala.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: contextual targeting by dv & peer 39 - zone level limitation
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdisney.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-peer-ST} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-dv-zoneLevelLimit-peer-ST-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdrugs.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-peer-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fwww.military.com%2Fequipment%2Fweapons%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-peer-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=notarealweblala.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-peer-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: Wurfl limitations
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0&domain=daniellaHamalka.com} for zone named {zone-zoneset-WL-ST-2} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-WL-ST-2-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Linux; U; Android 2.2) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0&domain=daniellaHamalka.com} for zone named {zone-zoneset-WL-ST-2} to UAS
    And The response code is 200
    And The responses are passback