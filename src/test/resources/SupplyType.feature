@scheduled
@HeaderBidding
@SupplyType
Feature: Supply type flow support

  Scenario: verify when HB first
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,2]} for publisher 3719 with domain {testing.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-SupplyType-ST-HB-banner-1}
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 228 to UAS for publisher 3719 with domain {testing.com&unlimited=1&optimize=0}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-ST-Direct-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-SupplyType-ST-Direct} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-ST-Direct-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-SupplyType-ST-ALL} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-ST-ALL-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-SupplyType-ST-HB} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: verify when Direct first
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1]} for publisher 3719 with domain {testing.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-SupplyType-SS-HB-banner-1}
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 229 to UAS for publisher 3719 with domain {testing.com&unlimited=1&optimize=0}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-SS-Direct-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-SupplyType-SS-Direct} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-SS-Direct-banner-1} 100% of the time


  Scenario: verify when All first
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [300,250]} for publisher 3719 with domain {testing.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-SupplyType-Desktop-ALL-banner-1}
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 231 to UAS for publisher 3719 with domain {testing.com&unlimited=1&optimize=0}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-Desktop-ALL-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-SupplyType-Desktop-ALL} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-Desktop-ALL-banner-1} 100% of the time


#  -----------------------------------------------------Optimize-------------------------------------------------------------------
  @optimize
  Scenario: verify when HB first
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,2]} for publisher 3719 with domain {testing.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-SupplyType-ST-HB-banner-1}
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 228 to UAS for publisher 3719 with domain {testing.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-ST-Direct-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1&optimize=1} for zone named {zone-zoneset-SupplyType-ST-Direct} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-ST-Direct-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1&optimize=1} for zone named {zone-zoneset-SupplyType-ST-ALL} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-ST-ALL-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1&optimize=1} for zone named {zone-zoneset-SupplyType-ST-HB} to UAS
    And The response code is 200
    And The responses are passback
  @optimize
  Scenario: verify when Direct first
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1]} for publisher 3719 with domain {testing.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-SupplyType-SS-HB-banner-1}
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 229 to UAS for publisher 3719 with domain {testing.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-SS-Direct-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1&optimize=1} for zone named {zone-zoneset-SupplyType-SS-Direct} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-SS-Direct-banner-1} 100% of the time

  @optimize
  Scenario: verify when All first
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [300,250]} for publisher 3719 with domain {testing.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-SupplyType-Desktop-ALL-banner-1}
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 231 to UAS for publisher 3719 with domain {testing.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-Desktop-ALL-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1&optimize=1} for zone named {zone-zoneset-SupplyType-Desktop-ALL} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-Desktop-ALL-banner-1} 100% of the time

