@warfle
@parallel
@scheduled
@noAA




Feature: warfle tests - wurfl limitation in campaign and zone level

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: Wurfl limitations
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=daniellaHamalka.com} for zone named {zone-zoneset-WL-ST-2} to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-WL-ST-2-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Linux; U; Android 2.2) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=daniellaHamalka.com} for zone named {zone-zoneset-WL-ST-2} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: Wurfl limitations - zone limitations
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=daniellaHamalka.com} for zone named {zone-zoneset-WL-ST-3} to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-WL-ST-3-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (iPhone; CPU iPhone OS 11_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.0 Mobile/15E148 Safari/604.1} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=daniellaHamalka.com} for zone named {zone-zoneset-WL-ST-3} to UAS
    And The response code is 200
    And The responses are passback