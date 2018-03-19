@DOT
@HeaderBidding
@scheduled
Feature: Domain Targeting tests


  Scenario: 1. send zone requests
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

  Scenario: 2. send Dynamic Tag requests for sub domain sahar.cnn.com, black list {sahar.cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The responses are passback

  Scenario: 3. send Dynamic Tag requests for domain cnn.com, black list {sahar.cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 170 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The responses are passback
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
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The responses are passback

  Scenario: 5. send Dynamic Tag requests for domain cnn.com, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://sahar.cnn.com&unlimited=1}
    And The responses are passback

  Scenario: 5. send Dynamic Tag requests for domain ynet.co.il, black list {cnn.com}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 176 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time

  Scenario: 6. send Dynamic Tag requests with black list {sahar.cnn.com,cnn.com,ynet.co.il}
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 175 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The responses are passback
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 175 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The responses are passback
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 175 to UAS for publisher 3708 with domain {http://walla.co.il&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-3-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 175 to UAS for publisher 3708 with domain {http://cnn.co.il&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-3-banner-1} 100% of the time

  Scenario: 7. send Dynamic Tag requests with black list {cnn.com} (1 campaign with 2 zones)
    Given I use {http://ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 177 to UAS for publisher 3708 with domain {http://ynet.co.il&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-4-banner-1} 100% of the time
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 177 to UAS for publisher 3708 with domain {http://cnn.com&unlimited=1}
    And The responses are passback

  Scenario: 8. send HB requests
    Given I use {http://sahar.cnn.com} as referer string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {sahar.cnn.com} with extra params {&unlimited=1&optimize=0&tagid=170}
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {cnn.com} with extra params {&unlimited=1&optimize=0&tagid=170}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-DomainT-1-banner-1}


#  Scenario: disabled all DT campaigns
#    And i update campaign data by name
#      |Campaign Name       |status       |
#      |campaign-DomainT-1  |1            |
#      |campaign-DomainT-2  |1            |
#      |campaign-DomainT-3  |1            |
#      |campaign-DomainT-4  |1            |