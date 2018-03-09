Feature: Domain Targeting tests


  Scenario: 1. send zone requests
    Given I use {sahar.cnn.com} as referer string to send my requests to uas
    And I send 1 times an ad request for zone named {zone-zoneset-DomainT-1} to UAS
    And The responses are passback
    Given I use {cnn.com} as referer string to send my requests to uas
    And I send 1 times an ad request for zone named {zone-zoneset-DomainT-1} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-1-banner-1} 100% of the time
    Given I use {sahar.cnn.com} as referer string to send my requests to uas
    And I send 1 times an ad request for zone named {zone-zoneset-DomainT-2} to UAS
    And The responses are passback
    Given I use {cnn.com} as referer string to send my requests to uas
    And I send 1 times an ad request for zone named {zone-zoneset-DomainT-2} to UAS
    And The responses are passback
    Given I use {cnn.co.il} as referer string to send my requests to uas
    And I send 1 times an ad request for zone named {zone-zoneset-DomainT-2} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    Given I use {cnn.co.il} as referer string to send my requests to uas
    And I send 1 times an ad request for zone named {zone-zoneset-DomainT-3} to UAS
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DomainT-2-banner-1} 100% of the time
    Given I use {ynet.co.il} as referer string to send my requests to uas
    And I send 1 times an ad request for zone named {zone-zoneset-DomainT-3} to UAS
    And The responses are passback
    Given I use {sahar.cnn.com} as referer string to send my requests to uas
    And I send 1 times an ad request for zone named {zone-zoneset-DomainT-3} to UAS
    And The responses are passback

  Scenario: 2. send Dynamic Tag requests for sub domain
    Given I use {sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 161 to UAS for publisher 3703 with domain {sahar.cnn.com}
    And The responses are passback
    Given I use {cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 161 to UAS for publisher 3703 with domain {sahar.cnn.com}
    And The responses are passback
    Given I use {ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 161 to UAS for publisher 3703 with domain {sahar.cnn.com}
    And The responses are passback

  Scenario: 2. send Dynamic Tag requests for domain
    Given I use {sahar.cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 161 to UAS for publisher 3703 with domain {cnn.com}
    And The responses are passback
    Given I use {cnn.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 161 to UAS for publisher 3703 with domain {cnn.com}
    And The responses are passback
    Given I use {ynet.co.il} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 161 to UAS for publisher 3703 with domain {cnn.com}
    And The responses are passback

  Scenario: 3. send HB requests
#    if the logic is changing i need to change it too
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 153 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1}
    And The response contains script
