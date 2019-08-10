@parallel
@scheduled
@noAA




Feature: Publisher blacklist tests

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200


  Scenario: For a publisher block advertiser - zone tag request
    Given I assign banner and zone supporting adunit 10 for publisher 3836 with a live campaign
    And I block io for publisher 3836
    When I send 1 time zone tag request with params {unlimited=1&optimize=0} to UAS
    Then The response code is 200
    And The responses are passback
    And I unblock io for publisher 3836
    When I send 1 times an ad request with parameter {unlimited=1&optimize=0&loc=toyota.com} for zone named {zone-zoneset-YesRunFalseDomain-69-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomain-69-1-banner-1} 100% of the time

  Scenario: For a publisher block advertiser - dynamic tag request
    Given I assign banner and zone supporting adunit 10 for publisher 3836 with a live campaign
    And I block io for publisher 3836
    When I send 1 time dynamic tag request with params {unlimited=1&optimize=0} to UAS
    Then The response code is 200
    And The responses are passback
    And I unblock io for publisher 3836
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3673 with extra params {daniellaRealDomain.test&tagid=352&unlimited=1&optimize=0}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomain-69-1-banner-1} 100% of the time

  Scenario: For a publisher block advertiser - HB request
    Given I assign banner and zone supporting adunit 10 for publisher 3836 with a live campaign
    And I block io for publisher 3836
    When I send 1 time HB request with params {unlimited=1&optimize=0} to UAS
    Then The response code is 200
    And The responses are passback
    And I unblock io for publisher 3836
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3673 with extra params {daniellaRealDomain.test&tagid=352&unlimited=1&optimize=0}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomain-69-1-banner-1} 100% of the time
