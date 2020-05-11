@appnexus
@scheduled
@HeaderBidding
@parallel
@noAA
@pgwfeature
@request_service
Feature: Programmatic flow support

  Background: health check
    When Sending a healthcheck request to UAS
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    And I add {NY} ip header
    Then The response code is 200

  Scenario: 1. basic Call to Programmatic GW - zone tag
    When I send 1 times an ad request with parameter {requestid=systemTestA&optimize=1&unlimited=1} for zone named {zone-zoneset-server-prog-SS} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 3. basic Call to Programmatic GW - Header bidding
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request for publisher 3711 - 1X1} for publisher 3711 with domain {test.com} with extra params {&unlimited=1&optimize=1&requestid=systemTestA}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-server-prog-SS-1-banner-1}
    And all HB responses contains campaignId with id of entity named {campaign-server-prog-SS-1}
    And all HB responses contains cpm with value {1.0}

  Scenario: 5. Call Programmatic GW, GW doing auction, last ad selected - dynamic tag
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 197 to UAS for publisher 3711 with domain {test.com&requestid=systemTestB&unlimited=1&optimize=1}
    And The synchronized response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-PGC-2-banner-1} 100% of the time

  Scenario: 6. Call Programmatic GW, GW doing auction, last ad selected - zone tag
    When I send 1 times an ad request with parameter {requestid=systemTestC&optimize=1&unlimited=1&domain=remove} for zone named {zone-zoneset-server-prog-ST} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-ST-3-banner-1} 100% of the time

  Scenario: 7. Call Programmatic GW, GW doing auction, last ad selected - dynamic tag
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 198 to UAS for publisher 3711 with domain {test.com&requestid=systemTestC&unlimited=1&optimize=1}
    And The synchronized response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-ST-3-banner-1} 100% of the time

  Scenario: 8. basic Call to Programmatic GW, GW doing auction, last ad selected - Header bidding
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request for publisher 3711 - 1X2} for publisher 3711 with domain {test.com} with extra params {&unlimited=1&requestid=systemTestC&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-server-prog-ST-3-banner-1}

    #web Burl
  Scenario: 9b. basic Call to Programmatic GW web, zone request, make sure b-url is sent
    When I send 1 times an ad request with parameter {requestid=BUrlTest&optimize=1&unlimited=1} for zone named {zone-zoneset-server-prog-SS} to UAS
    Then The response code is 200
    And The response contains {<script type="text/javascript">new Image().src="http://ramplift-s-ut-ramp-uas-us-east-1-k8s-internal.ramp-ut.io/burl"</script>}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time

    #inApp Burl
  Scenario: 9b. basic Call to Programmatic GW InApp, zone request, make sure b-url is sent
    When I send 1 times an ad request with parameter {requestid=BUrlTestInApp&unlimited=1&bundleid=app1} for zone named {zone-zoneset-server-prog-inApp-ST} to UAS
    And The response code is 200
    And The response contains {script}
    And The response contains {<script type="text/javascript">new Image().src="http://ramplift-s-ut-ramp-uas-us-east-1-k8s-internal.ramp-ut.io/burl"</script>}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-inApp-ST-1-banner-1} 100% of the time