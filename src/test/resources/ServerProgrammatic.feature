Feature: Programmatic flow support
  Scenario: 1.basic Call to Programmatic GW
    When I send 1 times an ad request with parameter {requestid=test1} for zone named {zone-zoneset-server-prog-1} to UAS
    And The response has impression-url
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 2. Call Programmatic GW, GW doing auction, last ad selected
    When I send 1 times an ad request with parameter {requestid=test2} for zone named {zone-zoneset-server-prog-1} to UAS
    And The response has impression-url
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 3. Call AppNexus and then call to Programmatic GW
    When I send 1 times an ad request for zone named {zone-zoneset-server-prog-ST} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has dsp-url
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time

    When I send impression requests to UAS
