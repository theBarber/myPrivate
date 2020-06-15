@district1
@parallel

Feature: District limitation targeting

  Background: health check
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    When Sending a healthcheck request to UAS
    Then The response code is 200

#  147.243.133.128 - WY-99 (zip code = 82001)
#  2.16.110.111 - CA-40 (zip code = 90011)
#  4.1.13.246 - CO-06 (zip code = 80112)

  Scenario: 1.a - single district - zone request from district WY-99 - banner expected
    Given I add header of {x-forwarded-for} with value {147.243.133.128}
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-WY99-district} to UAS
    And The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-WY99-District-banner-1} 100% of the time

  Scenario: 1.b - single district - zone request from outside district WY-99 - passback
    Given I add header of {x-forwarded-for} with value {2.16.110.111}
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-WY99-district} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: 2.a - two districts - zone request from district CA-40 - banner expected
    Given I add header of {x-forwarded-for} with value {2.16.110.111}
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-CA40-CO06-districts} to UAS
    And The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CA40-CO06-Districts-banner-1} 100% of the time


  Scenario: 2.b - two districts - zone request from district CO-06 - banner expected
    Given I add header of {x-forwarded-for} with value {4.1.13.246}
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-CA40-CO06-districts} to UAS
    And The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CA40-CO06-Districts-banner-1} 100% of the time


  Scenario: 2.c - two districts - zone request from outside two districts - passback
    Given I add header of {x-forwarded-for} with value {147.243.133.128}
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-CA40-CO06-districts} to UAS
    Then The response code is 200
    And The responses are passback