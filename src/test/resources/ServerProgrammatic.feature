@appnexus
@scheduled
@HeaderBidding
Feature: Programmatic flow support
  Scenario: 1. basic Call to Programmatic GW - zone tag
    When I send 1 times an ad request with parameter {requestid=systemTestA&optimize=0&unlimited=1} for zone named {zone-zoneset-server-prog-SS} to UAS
    Then The response code is 200
    And The response contains script
    And The response has impression-url
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 2. basic Call to Programmatic GW - dynamic tag
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 196 to UAS for publisher 3711 with domain {test.com&requestid=systemTestA&unlimited=1&optimize=0}
    And The synchronized response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 3. basic Call to Programmatic GW - Header bidding
    Given i send 1 headerBidding post request for scenario {Send HB request for publisher 3711 - 1X1} for publisher 3711 with domain {test.com} with extra params {&unlimited=1&optimize=0&requestid=systemTestA}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-server-prog-SS-1-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time

  Scenario: 4. Call Programmatic GW, GW doing auction, last ad selected - zone tag
    When I send 1 times an ad request with parameter {requestid=systemTestB&optimize=0&unlimited=1} for zone named {zone-zoneset-server-prog-PGC} to UAS
    Then The response code is 200
    And The response contains script
    And The response has impression-url
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-PGC-2-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 5. Call Programmatic GW, GW doing auction, last ad selected - dynamic tag
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 197 to UAS for publisher 3711 with domain {test.com&requestid=systemTestB&unlimited=1&optimize=0}
    And The synchronized response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-PGC-2-banner-1} 100% of the time
    When I send impression requests to UAS

   Scenario: 6. Call Programmatic GW, GW doing auction, last ad selected - zone tag
    When I send 1 times an ad request with parameter {requestid=systemTestC&optimize=0&unlimited=1} for zone named {zone-zoneset-server-prog-ST} to UAS
    Then The response code is 200
    And The response contains script
    And The response has impression-url
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-ST-4-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 7. Call Programmatic GW, GW doing auction, last ad selected - dynamic tag
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 198 to UAS for publisher 3711 with domain {test.com&requestid=systemTestC&unlimited=1&optimize=0}
    And The synchronized response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-ST-4-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 8. basic Call to Programmatic GW, GW doing auction, last ad selected - Header bidding
    Given i send 1 headerBidding post request for scenario {Send HB request for publisher 3711 - 1X2} for publisher 3711 with domain {test.com} with extra params {&unlimited=1&requestid=systemTestC&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-server-prog-ST-4-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-ST-4-banner-1} 100% of the time



#    Scenario: disabled all HB campaigns
#    Given i update campaign data by name
#      |Campaign Name                        |status      |
#      |campaign-server-prog-SS-1            |1           |
#      |campaign-server-prog-SS-2            |1           |
#      |campaign-server-prog-SS-3            |1           |
#      |campaign-server-prog-SS-4            |1           |
#      |campaign-server-prog-PGC-1           |1           |
#      |campaign-server-prog-PGC-2           |1           |
#      |campaign-server-prog-PGC-3           |1           |
#      |campaign-server-prog-PGC-4           |1           |
#      |campaign-server-prog-ST-1            |1           |
#      |campaign-server-prog-ST-1            |1           |