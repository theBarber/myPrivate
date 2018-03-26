@appnexus
Feature: Programmatic flow support
  Scenario: 1.basic Call to Programmatic GW - zone tag
    When I send 1 times an ad request with parameter {requestid=systemTestA} for zone named {zone-zoneset-server-prog-SS} to UAS
    And The response has impression-url
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 2.basic Call to Programmatic GW - dynamic tag
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 153 to UAS for publisher 2434 with domain {requestid=systemTestA&DynamicTagInline.com&unlimited=1}
    And The response has impression-url
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 3. Call Programmatic GW, GW doing auction, last ad selected - zone tag
    When I send 1 times an ad request with parameter {requestid=systemTestB} for zone named {zone-zoneset-server-prog-PGC} to UAS
    And The response has impression-url
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 4. Call Programmatic GW, GW doing auction, last ad selected - dynamic tag
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 153 to UAS for publisher 2434 with domain {requestid=systemTestB&DynamicTagInline.com&unlimited=1}
    And The response has impression-url
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 5. Call AppNexus and then call to Programmatic GW
    When I send 1 times an ad request for zone named {zone-zoneset-server-prog-ST} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has dsp-url
    Then i simulate appnexus passback response from the responses and send them to the UAS
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-ST-2} 100% of the time

#check
#  Scenario: 5. Call AppNexus and then call to Programmatic GW
#    When I send 1 times an ad request for zone id {179906} to UAS
#    Then The response code is 200
#    And The response contains script
#    And The responses has dsp-url
#    Then i simulate appnexus passback response from the responses and send them to the UAS
#    Then The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-ST-2} 100% of the time

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