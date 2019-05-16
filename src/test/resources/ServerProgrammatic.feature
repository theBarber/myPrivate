@appnexus
@scheduled
@HeaderBidding
@parallel
@noAA

Feature: Programmatic flow support

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: wait more for banner cache to be updated in memory
    Given I sleep for 1 seconds

  Scenario: 1. basic Call to Programmatic GW - zone tag
    When I send 1 times an ad request with parameter {requestid=systemTestA&optimize=0&unlimited=1&domain=remove} for zone named {zone-zoneset-server-prog-SS} to UAS
    Then The response code is 200
    And The response contains script
    And The response has impression-url
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 2. basic Call to Programmatic GW - dynamic tag
    Then I sleep for 1 seconds
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 196 to UAS for publisher 3711 with domain {test.com&requestid=systemTestA&unlimited=1&optimize=0}
    And The synchronized response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 3. basic Call to Programmatic GW - Header bidding
    Then I sleep for 1 seconds
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request for publisher 3711 - 1X1} for publisher 3711 with domain {test.com} with extra params {&unlimited=1&optimize=0&requestid=systemTestA}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-server-prog-SS-1-banner-1}
    And all HB responses contains cpm with value {1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time

  Scenario: 4. Call Programmatic GW, GW doing auction, last ad selected - zone tag
    Then I sleep for 1 seconds
    When I send 1 times an ad request with parameter {requestid=systemTestB&optimize=0&unlimited=1&domain=remove} for zone named {zone-zoneset-server-prog-PGC} to UAS
    Then The response code is 200
    And The response contains script
    And The response has impression-url
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-PGC-2-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 5. Call Programmatic GW, GW doing auction, last ad selected - dynamic tag
    Then I sleep for 1 seconds
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 197 to UAS for publisher 3711 with domain {test.com&requestid=systemTestB&unlimited=1&optimize=0}
    And The synchronized response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-PGC-2-banner-1} 100% of the time
    When I send impression requests to UAS

   Scenario: 6. Call Programmatic GW, GW doing auction, last ad selected - zone tag
     Then I sleep for 1 seconds
    When I send 1 times an ad request with parameter {requestid=systemTestC&optimize=0&unlimited=1&domain=remove} for zone named {zone-zoneset-server-prog-ST} to UAS
    Then The response code is 200
    And The response contains script
    And The response has impression-url
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-ST-3-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 7. Call Programmatic GW, GW doing auction, last ad selected - dynamic tag
    Then I sleep for 1 seconds
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 198 to UAS for publisher 3711 with domain {test.com&requestid=systemTestC&unlimited=1&optimize=0}
    And The synchronized response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-ST-3-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 8. basic Call to Programmatic GW, GW doing auction, last ad selected - Header bidding
    Then I sleep for 1 seconds
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request for publisher 3711 - 1X2} for publisher 3711 with domain {test.com} with extra params {&unlimited=1&requestid=systemTestC&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-server-prog-ST-3-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-ST-3-banner-1} 100% of the time

    #web Burl
  Scenario: 9b. basic Call to Programmatic GW web, zone request, make sure b-url is sent
    When I send 1 times an ad request with parameter {requestid=BUrlTest&optimize=0&unlimited=1} for zone named {zone-zoneset-server-prog-SS} to UAS
    Then The response code is 200
    And The response contains <script type="text/javascript">new Image().src="http://ads-s-us-east-1.undertone.com/burl"</script>
    And The response has impression-url
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

    #inApp Burl
  Scenario: 9b. basic Call to Programmatic GW InApp, zone request, make sure b-url is sent
    Then I sleep for 1 seconds
    When I send 1 times an ad request with parameter {requestid=BUrlTestInApp&unlimited=1&bundleid=app1} for zone named {zone-zoneset-server-prog-inApp-ST} to UAS
    And The response code is 200
    And The response contains script
    And The response contains <script type="text/javascript">new Image().src="http://ads-s-us-east-1.undertone.com/burl"</script>
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-inApp-ST-1-banner-1} 100% of the time


     #SP multibids in the json // goes to mock SP-MultiBids-ST_1.json
  Scenario: 10. send HB req with multi bid to SP
    Then I sleep for 1 seconds
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3711 with multi bids. first bid - bidreqID={SP-MultiBids-1*1}, h:1 w:1, sec bid - bidreqID={SP-MultiBids-1*2}, h:1 w:2 with domain {server-prog-MultiBids-DNU-1} and extra params {&unlimited=1&hb_test=1}
    And The response code is 200
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid dani1 has entity of adId with name {campaign-server-prog-MultiBids-SS-1-banner-1} 100% of the times
    And in HB responses bidid dani2 has entity of adId with name {campaign-server-prog-MultiBids-ST-2-banner-1} 100% of the times
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-MultiBids-SS-1-banner-1} 50% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-MultiBids-ST-2-banner-1} 50% of the time


#  -----------------------------------------------------Optimize-------------------------------------------------------------------
  @optimize
  Scenario: 1. basic Call to Programmatic GW - zone tag
    Then I sleep for 1 seconds
    When I send 1 times an ad request with parameter {requestid=systemTestA&optimize=1&unlimited=1} for zone named {zone-zoneset-server-prog-SS} to UAS
    Then The response code is 200
    And The response contains script
    And The response has impression-url
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS
  @optimize
  Scenario: 2. basic Call to Programmatic GW - dynamic tag
    Then I sleep for 1 seconds
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 196 to UAS for publisher 3711 with domain {test.com&requestid=systemTestA&unlimited=1&optimize=1}
    And The synchronized response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS
  @optimize
  Scenario: 3. basic Call to Programmatic GW - Header bidding
    Then I sleep for 1 seconds
    Given i send 1 headerBidding post request for scenario {Send HB request for publisher 3711 - 1X1} for publisher 3711 with domain {test.com} with extra params {&unlimited=1&optimize=1&requestid=systemTestA}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-server-prog-SS-1-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
  @optimize
  Scenario: 4. Call Programmatic GW, GW doing auction, last ad selected - zone tag
    Then I sleep for 1 seconds
    When I send 1 times an ad request with parameter {requestid=systemTestB&optimize=1&unlimited=1} for zone named {zone-zoneset-server-prog-PGC} to UAS
    Then The response code is 200
    And The response contains script
    And The response has impression-url
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-PGC-2-banner-1} 100% of the time
    When I send impression requests to UAS
  @optimize
  Scenario: 5. Call Programmatic GW, GW doing auction, last ad selected - dynamic tag
    Then I sleep for 1 seconds
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 197 to UAS for publisher 3711 with domain {test.com&requestid=systemTestB&unlimited=1&optimize=1}
    And The synchronized response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-PGC-2-banner-1} 100% of the time
    When I send impression requests to UAS
  @optimize
  Scenario: 6. Call Programmatic GW, GW doing auction, last ad selected - zone tag
    Then I sleep for 1 seconds
    When I send 1 times an ad request with parameter {requestid=systemTestC&optimize=1&unlimited=1} for zone named {zone-zoneset-server-prog-ST} to UAS
    Then The response code is 200
    And The response contains script
    And The response has impression-url
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-ST-4-banner-1} 100% of the time
    When I send impression requests to UAS
  @optimize
  Scenario: 7. Call Programmatic GW, GW doing auction, last ad selected - dynamic tag
    Then I sleep for 1 seconds
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 198 to UAS for publisher 3711 with domain {test.com&requestid=systemTestC&unlimited=1&optimize=1}
    And The synchronized response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-ST-4-banner-1} 100% of the time
    When I send impression requests to UAS
  @optimize
  Scenario: 8. basic Call to Programmatic GW, GW doing auction, last ad selected - Header bidding
    Then I sleep for 1 seconds
    Given i send 1 headerBidding post request for scenario {Send HB request for publisher 3711 - 1X2} for publisher 3711 with domain {test.com} with extra params {&unlimited=1&requestid=systemTestC&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-server-prog-ST-4-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-ST-4-banner-1} 100% of the time
