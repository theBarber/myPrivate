@OpenMarket1
@parallel

Feature: Open Market Testing

  Background: health check
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    And I add header of {x-forwarded-For} with value {78.31.205.183}
    When Sending a healthcheck request to UAS
    Then The response code is 200


  Scenario: 1.a   R(AN) ---  R(OX) --- OM      Open Market banner expected to return in first iteration
    When I send 1 times an ad request with parameter {optimize=1&requestid=Automation-OM} for zone named {zone-zoneset-test-OM-PG} to UAS
    And The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-OPEN-MARKET-1-banner-1} 100% of the time


  Scenario: 2.a   R(AN) ---  R(OX) --- OM     OpenX banner expected to return in second iteration
    When I send 1 times an ad request with parameter {optimize=1&requestid=Automation-OX} for zone named {zone-zoneset-test-OM-PG} to UAS
    And The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-reserve-OX-iter-2-banner-1} 100% of the time


  Scenario: 3.a   R(AN) ---  NR(AN) --- D --- OM     Open Market banner expected to return in first iteration
    When I send 1 times an ad request with parameter {optimize=1&requestid=Automation-OM} for zone named {zone-zoneset-test-OM-WIN} to UAS
    And The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-OPEN-MARKET-1-chosen-banner-1} 100% of the time

  Scenario: 3.b   R(AN) ---  NR(AN) --- D --- OM     App-nexus NR banner expected to return in second iteration
    When I send 1 times an ad request with parameter {optimize=1&requestid=AN-PGA-Render} for zone named {zone-zoneset-test-OM-WIN} to UAS
    And The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-non-reserve-1-banner-1} 100% of the time

  Scenario: 4   D --- OM     Direct banner expected to return in first iteration (the PGW not even get approached)
    When I send 1 times an ad request with parameter {optimize=1&requestid=Automation-OM} for zone named {zone-zoneset-test-Direct} to UAS
    And The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-direct-must-be-chosen-banner-1} 100% of the time