@parallel
@scheduled
@noAA
@WurflLimitationFeature
Feature: wurfl tests - wurfl limitation in campaign and zone level

  Background: health check
    When Sending a healthcheck request to UAS
    And I add {NY} ip header
    Then The response code is 200

  Scenario: Wurfl Limitations - Zone UAS Filtering - Delivery
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=zoneWurflDelivery.com} for zone named {zone-zoneset-WL-ST-3} to UAS
    Then The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-WL-ST-3-banner-1} 100% of the time

  Scenario: Wurfl Limitations - Zone UAS Filtering - Passback
    Given I use {Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=zoneWurflPassback.com} for zone named {zone-zoneset-WL-ST-3} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: Wurfl Limitaitions - Banner Demand Service Filtering - Delivery
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=bannerWurflDelivery.com} for zone named {zone-zoneset-WL-ST-2} to UAS
    Then The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-WL-ST-2-banner-1} 100% of the time

  Scenario: Wurfl Limitaitions - Banner Demand Service Filtering - Passback
    Given I use {Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=bannerWurflPassback.com} for zone named {zone-zoneset-WL-ST-2} to UAS
    Then The response code is 200
    And The responses are passback