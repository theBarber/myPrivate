@DOT
@HeaderBidding
@scheduled
Feature: Domain Targeting tests
  Scenario: 1.a send zone requests
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I send 1 times an ad request with query parameters for zone named {zone-zoneset-DomainT-1} to UAS
    And The responses are passback
    Given I use {http://www.cnn.com} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I send 1 times an ad request with query parameters for zone named {zone-zoneset-DomainT-1} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-1-banner-1} 100% of the time
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I send 1 times an ad request with query parameters for zone named {zone-zoneset-DomainT-2} to UAS
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I send 1 times an ad request with query parameters for zone named {zone-zoneset-DomainT-2} to UAS
    And The responses are passback
    Given I use {http://cnn.co.il} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I send 1 times an ad request with query parameters for zone named {zone-zoneset-DomainT-2} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    Given I use {http://cnn.co.il} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I send 1 times an ad request with query parameters for zone named {zone-zoneset-DomainT-3} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-3-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I send 1 times an ad request with query parameters for zone named {zone-zoneset-DomainT-3} to UAS
    And The responses are passback
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I send 1 times an ad request with query parameters for zone named {zone-zoneset-DomainT-3} to UAS
    And The responses are passback

  Scenario: 1.b send zone requests with domains in the requests - white list {sahar.cnn.com}
    When I send 1 times an ad request with parameter {unlimited=1&domain=sahar.cnn.com&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&domain=sahar.cnn.com&loc=cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&domain=cnn.com&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&domain=cnn.co.il&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: 1.c send zone requests with domains in the requests - black list {sahar.cnn.com}
    When I send 1 times an ad request with parameter {unlimited=1&domain=sahar.ynet.co.il&loc=sahar.ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-2} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&domain=sahar.ynet.co.il&loc=ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-2} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&domain=ynet.co.il&loc=sahar.ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-2} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&domain=ynet.co.il&loc=ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-2} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-2-banner-1} 100% of the time


  Scenario: 1.d send zone requests with domains in the requests - white list {cnn.com}
    When I send 1 times an ad request with parameter {unlimited=1&domain=cnn.com&loc=cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-3} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-3-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&domain=sahar.cnn.com&loc=cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-3} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-3-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&domain=cnn.com&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-3} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-3-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&domain=cnn.co.il&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-3} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 1.e send zone requests with domains in the requests - black list {ynet.co.il}
    When I send 1 times an ad request with parameter {unlimited=1&domain=ynet.co.il&loc=ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-4} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&domain=sahar.ynet.co.il&loc=ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-4} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&domain=ynet.co.il&loc=sahar.ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-4} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&domain=cnn.co.il&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-4} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-4-banner-1} 100% of the time

  Scenario: 2. send Dynamic Tag requests for sub domain sahar.cnn.com, black list {sahar.cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The synchronized responses are passback

  Scenario: 3. send Dynamic Tag requests for domain cnn.com, black list {sahar.cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-1-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-1-banner-1} 100% of the time

  Scenario: 4. send Dynamic Tag requests for domain sahar.cnn.com, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The synchronized responses are passback

  Scenario: 5. send Dynamic Tag requests for domain cnn.com, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The synchronized responses are passback

  Scenario: 5. send Dynamic Tag requests for domain ynet.co.il, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time

  Scenario: 6. send Dynamic Tag requests with black list {sahar.cnn.com,cnn.com,ynet.co.il}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 175 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 175 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 175 to UAS for publisher 3708 with domain {http://walla.co.il&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-3-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 175 to UAS for publisher 3708 with domain {http://cnn.co.il&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-3-banner-1} 100% of the time

  Scenario: 7. send Dynamic Tag requests with black list {cnn.com} (1 campaign with 2 zones)
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 177 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-4-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 177 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The synchronized responses are passback

  Scenario: 8. send HB requests
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {sahar.cnn.com} with extra params {&unlimited=1&optimize=0}
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {cnn.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-DomainT-1-banner-1}


#  -----------------------------------------------------Include-----------------------------------------------------------

  Scenario: 1. send zone requests
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I send 1 times an ad request with query parameters for zone named {zone-zoneset-DomainT-5-BB} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    Given I use {http://www.cnn.com} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I send 1 times an ad request with query parameters for zone named {zone-zoneset-DomainT-5-BB} to UAS
    And The responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I send 1 times an ad request with query parameters for zone named {zone-zoneset-DomainT-5-BB} to UAS
    And The responses are passback
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I send 1 times an ad request with query parameters for zone named {zone-zoneset-DomainT-6-Desktop} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I send 1 times an ad request with query parameters for zone named {zone-zoneset-DomainT-6-Desktop} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time

  Scenario: 2. send Dynamic Tag requests for sub domain sahar.cnn.com, white list {sahar.cnn.com} referer changes
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 226 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id ??? to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 226 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id ??? to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 226 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id ??? to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time

  Scenario: 3. send Dynamic Tag requests for domain cnn.com, white list {sahar.cnn.com} referer changes
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 226 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    #    Then i send 1 times Dynamic Tag synchronized ad request with tag id ??? to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 226 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 226 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The synchronized responses are passback

  Scenario: 4. send Dynamic Tag requests for domain sahar.cnn.com, white list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time

  Scenario: 5. send Dynamic Tag requests for domain cnn.com, white list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time

  Scenario: 6. send Dynamic Tag requests for domain ynet.co.il, white list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The synchronized responses are passback


  Scenario: 8. send HB requests
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB 300x250 request for publisher 3708} for publisher 3708 with domain {sahar.cnn.com} with extra params {&unlimited=1&optimize=0}
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB 300x250 request for publisher 3708} for publisher 3708 with domain {cnn.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-DomainT-Desktop-6-banner-1}


    #  -----------------------------------------------------Optimize exclude-----------------------------------------------------------


  Scenario: 1.a send zone requests
    When I send 1 times an ad request with parameter {unlimited=1&loc=http://sahar.cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-1} to UAS
    And The responses are passback
    Given I use {http://www.cnn.com} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    When I send 1 times an ad request with parameter {unlimited=1&loc=http://www.cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-1} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&loc=http://sahar.cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-2} to UAS
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Given I add unlimited query parameter with value {1} to send my requests to uas
    When I send 1 times an ad request with parameter {unlimited=1&loc=http://cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-2} to UAS
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&loc=http://cnn.co.il&optimize=1} for zone named {zone-zoneset-DomainT-2} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&loc=http://cnn.co.il&optimize=1} for zone named {zone-zoneset-DomainT-3} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-3-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&loc=http://ynet.co.il&optimize=1} for zone named {zone-zoneset-DomainT-3} to UAS
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&loc=http://sahar.cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-3} to UAS
    And The responses are passback


  Scenario: 1.b send zone requests with domains in the requests - white list {sahar.cnn.com}
    When I send 1 times an ad request with parameter {unlimited=1&domain=sahar.cnn.com&loc=sahar.cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&domain=sahar.cnn.com&loc=cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&domain=cnn.com&loc=sahar.cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&domain=cnn.co.il&loc=sahar.cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: 1.c send zone requests with domains in the requests - black list {sahar.cnn.com}
    When I send 1 times an ad request with parameter {unlimited=1&domain=sahar.ynet.co.il&loc=sahar.ynet.co.il&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-2} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&domain=sahar.ynet.co.il&loc=ynet.co.il&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-2} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&domain=ynet.co.il&loc=sahar.ynet.co.il&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-2} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&domain=ynet.co.il&loc=ynet.co.il&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-2} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-2-banner-1} 100% of the time


  Scenario: 1.d send zone requests with domains in the requests - white list {cnn.com}
    When I send 1 times an ad request with parameter {unlimited=1&domain=cnn.com&loc=cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-3} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-3-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&domain=sahar.cnn.com&loc=cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-3} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-3-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&domain=cnn.com&loc=sahar.cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-3} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-3-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&domain=cnn.co.il&loc=sahar.cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-3} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 1.e send zone requests with domains in the requests - black list {ynet.co.il}
    When I send 1 times an ad request with parameter {unlimited=1&domain=ynet.co.il&loc=ynet.co.il&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-4} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&domain=sahar.ynet.co.il&loc=ynet.co.il&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-4} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&domain=ynet.co.il&loc=sahar.ynet.co.il&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-4} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&domain=cnn.co.il&loc=sahar.cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-ZoneTag-4} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-4-banner-1} 100% of the time

  Scenario: 2. send Dynamic Tag requests for sub domain sahar.cnn.com, black list {sahar.cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback

  Scenario: 3. send Dynamic Tag requests for domain cnn.com, black list {sahar.cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1&optimize=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-1-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1&optimize=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-1-banner-1} 100% of the time

  Scenario: 4. send Dynamic Tag requests for domain sahar.cnn.com, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback

  Scenario: 5. send Dynamic Tag requests for domain cnn.com, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback

  Scenario: 5. send Dynamic Tag requests for domain ynet.co.il, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time

  Scenario: 6. send Dynamic Tag requests with black list {sahar.cnn.com,cnn.com,ynet.co.il}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 175 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 175 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 175 to UAS for publisher 3708 with domain {http://walla.co.il&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-3-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 175 to UAS for publisher 3708 with domain {http://cnn.co.il&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-3-banner-1} 100% of the time

  Scenario: 7. send Dynamic Tag requests with black list {cnn.com} (1 campaign with 2 zones)
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 177 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1&optimize=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-4-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 177 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback

  Scenario: 8. send HB requests
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {sahar.cnn.com} with extra params {&unlimited=1&optimize=0&optimize=1}
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {cnn.com} with extra params {&unlimited=1&optimize=0&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-DomainT-1-banner-1}


#  -----------------------------------------------------Optimize Include-----------------------------------------------------------
@optimize
  Scenario: 1. send zone requests
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    When I send 1 times an ad request with parameter {unlimited=1&loc=http://sahar.cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-5-BB} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&loc=http://www.cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-5-BB} to UAS
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&loc=http://ynet.co.il&optimize=1} for zone named {zone-zoneset-DomainT-5-BB} to UAS
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&loc=http://sahar.cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-6-Desktop} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&loc=http://cnn.com&optimize=1} for zone named {zone-zoneset-DomainT-6-Desktop} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time


  @optimize
  Scenario: 2. send Dynamic Tag requests for sub domain sahar.cnn.com, white list {sahar.cnn.com} referer changes
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 226 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id ??? to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 226 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id ??? to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 226 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id ??? to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
  @optimize
  Scenario: 3. send Dynamic Tag requests for domain cnn.com, white list {sahar.cnn.com} referer changes
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 226 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1&optimize=1}
    #    Then i send 1 times Dynamic Tag synchronized ad request with tag id ??? to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 226 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 226 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback
  @optimize
  Scenario: 4. send Dynamic Tag requests for domain sahar.cnn.com, white list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
  @optimize
  Scenario: 5. send Dynamic Tag requests for domain cnn.com, white list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
  @optimize
  Scenario: 6. send Dynamic Tag requests for domain ynet.co.il, white list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 227 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1&optimize=1}
    And The synchronized responses are passback

  @optimize
  Scenario: 8. send HB requests
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB 300x250 request for publisher 3708} for publisher 3708 with domain {sahar.cnn.com} with extra params {&unlimited=1&optimize=1}
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB 300x250 request for publisher 3708} for publisher 3708 with domain {cnn.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-DomainT-Desktop-6-banner-1}


