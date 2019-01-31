@DOT
@HeaderBidding
@scheduled
@parallel
@noAA

Feature: Domain Targeting tests

  @id:14
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

  @id:15
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

  @id:16
  Scenario: 1.c send zone requests with domains in the requests - black list {sahar.ynet.co.il}
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

  @id:17
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

  @id:18
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

  @id:19
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

  @id:20
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

  @id:21
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

  @id:22
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

  @id:23
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

  @id:24
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

  @id:25
  Scenario: 7. send Dynamic Tag requests with black list {cnn.com} (1 campaign with 2 zones)
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 177 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-4-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 177 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The synchronized responses are passback

  @id:26
  Scenario: 8. send HB requests
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {sahar.cnn.com} with extra params {&unlimited=1&optimize=0}
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {cnn.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-DomainT-1-banner-1}

#    Scenarios for enc_url:
  @id:27
  Scenario: 9a. send zone requests with url_enc in the requests - white list {sahar.cnn.com}
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&loc=cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fcnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fcnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-1-banner-1} 100% of the time

  @id:28
  Scenario: 9b. send zone requests with url_enc in the requests - white list {sahar.cnn.com}
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fdaniella7634yey%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fdanienfhf5jh5huy4ey%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-1} to UAS
    Then The response code is 200
    And The responses are passback

  @id:29
  Scenario: 10. send zone requests with url_enc in the requests - black list {sahar.ynet.co.il}
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fsahar.ynet.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&loc=sahar.ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-2} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fsahar.ynet.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&loc=ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-2} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fynet.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&loc=sahar.ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-2} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fynet.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&loc=ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-2} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-2-banner-1} 100% of the time

  @id:30
  Scenario: 11. send zone requests with url_enc in the requests - white list {cnn.com}
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fcnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&loc=cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-3} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-3-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&loc=cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-3} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-3-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fcnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-3} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-3-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fcnn.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-3} to UAS
    Then The response code is 200
    And The responses are passback

  @id:31
  Scenario: 12. send zone requests with url_enc in the requests - black list {ynet.co.il}
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fynet.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&loc=ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-4} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fsahar.ynet.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&loc=ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-4} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fynet.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&loc=sahar.ynet.co.il} for zone named {zone-zoneset-DomainT-ZoneTag-4} to UAS
    Then The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&url_enc=https%3A%2F%2Fcnn.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&loc=sahar.cnn.com} for zone named {zone-zoneset-DomainT-ZoneTag-4} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-ZoneTag-4-banner-1} 100% of the time

  @id:32
  Scenario: 13. send Dynamic Tag requests for sub url_enc sahar.cnn.com, black list {sahar.cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=170}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=170}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=170}
    And The synchronized responses are passback

  @id:33
  Scenario: 14. send Dynamic Tag requests for url_enc cnn.com, black list {sahar.cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fcnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=170}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fcnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=170}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-1-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fcnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=170}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-1-banner-1} 100% of the time

  @id:34
  Scenario: 4. send Dynamic Tag requests for domain sahar.cnn.com, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The synchronized responses are passback

  @id:35
  Scenario: 5. send Dynamic Tag requests for domain cnn.com, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The synchronized responses are passback

  @id:36
  Scenario: 5. send Dynamic Tag requests for domain ynet.co.il, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fynet.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fynet.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fynet.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time

  @id:37
  Scenario: 15. send Dynamic Tag requests for url_enc sahar.cnn.com, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The synchronized responses are passback

  @id:38
  Scenario: 16. send Dynamic Tag requests forurl_enc cnn.com, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fsahar.cnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The synchronized responses are passback

  @id:39
  Scenario: 17. send Dynamic Tag requests for url_enc ynet.co.il, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fynet.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fynet.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fynet.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=176}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time

  @id:40
  Scenario: 18. send Dynamic Tag requests for url_enc with black list {sahar.cnn.com,cnn.com,ynet.co.il}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fcnn.com%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=175}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fwalla.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=175}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-3-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {url_enc=https%3A%2F%2Fcnn.co.il%2Fbills%2Fnews%2FbilpCN0y4oPaESRX6SabNoGmA%2Fm&unlimited=1&tagid=175}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-3-banner-1} 100% of the time
#  -----------------------------------------------------Include-----------------------------------------------------------

  @id:41
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

  @id:42
  Scenario: 2. send Dynamic Tag requests for sub domain sahar.cnn.com, white list {sahar.cnn.com} referer changes
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 288 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 288 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 288 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time

  @id:43
  Scenario: 3. send Dynamic Tag requests for domain cnn.com, white list {sahar.cnn.com} referer changes
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 288 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 288 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 288 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The synchronized responses are passback

  @id:44
  Scenario: 4. send Dynamic Tag requests for domain sahar.cnn.com, white list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time

  @id:45
  Scenario: 5. send Dynamic Tag requests for domain cnn.com, white list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time

  @id:46
  Scenario: 6. send Dynamic Tag requests for domain ynet.co.il, white list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The synchronized responses are passback

  @id:47
  Scenario: 8. send HB requests
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB 300x250 request for publisher 3708} for publisher 3708 with domain {sahar.cnn.com} with extra params {&unlimited=1&optimize=0}
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB 300x250 request for publisher 3708} for publisher 3708 with domain {cnn.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-DomainT-Desktop-6-banner-1}


    #  -----------------------------------------------------Optimize exclude-----------------------------------------------------------

  @id:48 @optimize
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

  @id:49 @optimize
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

  @id:50 @optimize
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

  @id:51 @optimize
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

  @id:52 @optimize
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

  @id:53 @optimize
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

  @id:54 @optimize
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

  @id:55 @optimize
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

  @id:56 @optimize
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

  @id:57 @optimize
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

  @id:58 @optimize
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

  @id:59 @optimize
  Scenario: 7. send Dynamic Tag requests with black list {cnn.com} (1 campaign with 2 zones)
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 177 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1&optimize=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-4-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 177 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback

  @id:60 @optimize
  Scenario: 8. send HB requests
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {sahar.cnn.com} with extra params {&unlimited=1&optimize=0&optimize=1}
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {cnn.com} with extra params {&unlimited=1&optimize=0&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-DomainT-1-banner-1}


#  -----------------------------------------------------Optimize Include-----------------------------------------------------------
  @id:61 @optimize
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

  @id:62 @optimize
  Scenario: 2. send Dynamic Tag requests for sub domain sahar.cnn.com, white list {sahar.cnn.com} referer changes
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 288 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 288 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 288 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
  @id:63 @optimize
  Scenario: 3. send Dynamic Tag requests for domain cnn.com, white list {sahar.cnn.com} referer changes
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 288 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-BB-5-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 288 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 288 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1&optimize=1}
    And The synchronized responses are passback
  @id:64 @optimize
  Scenario: 4. send Dynamic Tag requests for domain sahar.cnn.com, white list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
  @id:65 @optimize
  Scenario: 5. send Dynamic Tag requests for domain cnn.com, white list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-Desktop-6-banner-1} 100% of the time
  @id:66 @optimize
  Scenario: 6. send Dynamic Tag requests for domain ynet.co.il, white list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1&optimize=1}
    And The synchronized responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 289 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1&optimize=1}
    And The synchronized responses are passback

  @id:67 @optimize
  Scenario: 8. send HB requests
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB 300x250 request for publisher 3708} for publisher 3708 with domain {sahar.cnn.com} with extra params {&unlimited=1&optimize=1}
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB 300x250 request for publisher 3708} for publisher 3708 with domain {cnn.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-DomainT-Desktop-6-banner-1}