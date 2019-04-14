@parallel
@noAA

Feature: video Adhision new ad unit tests

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: vidAd server prog test, zone req
    When I send 1 times an ad request with parameter {requestid=vidAd&optimize=0&unlimited=1&domain=dnu-tt} for zone named {zone-zoneset-vidAd-SP} to UAS
    Then The response code is 200
    And The response contains bannerid
    And The response has impression-url
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-vidAd-SP-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: vidAd server prog test, DT req
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 430 to UAS for publisher 3708 with domain {dnu-tt&requestid=vidAd&unlimited=1&optimize=0}
    And The synchronized response code is 200
    And The response contains bannerid
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-vidAd-SP-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: vidAd base test, zone req
    When I send 1 times an ad request with parameter {optimize=0&unlimited=1&domain=dnu-tt} for zone named {zone-zoneset-TN} to UAS
    Then The response code is 200
    And The response contains bannerid
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-TN-banner-1} 100% of the time

  Scenario: vidAd base test, DT req
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 430 to UAS for publisher 3708 with domain {dnu-tt&unlimited=1&optimize=0}
    And The synchronized response code is 200
    And The response contains bannerid
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-TN-banner-1} 100% of the time
    When I send impression requests to UAS
