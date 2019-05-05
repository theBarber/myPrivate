@HeaderBidding
@SupplyType
@scheduled
@parallel
@noAA

Feature: Supply type flow support

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @SupplyType
  Scenario: verify when HB first
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3728 size [1,2]} for publisher 3728 with domain {testing.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-SupplyType-ST-HB-banner-1}
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 236 to UAS for publisher 3728 with domain {testing.com&unlimited=1&optimize=0}
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

  @SupplyType
  Scenario: verify when Direct first
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3728 size [1,1]} for publisher 3728 with domain {testing.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-SupplyType-SS-HB-banner-1}
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 237 to UAS for publisher 3728 with domain {testing.com&unlimited=1&optimize=0}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-SS-Direct-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-SupplyType-SS-Direct} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-SS-Direct-banner-1} 100% of the time

  @SupplyType
  Scenario: verify when All first
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3728 size [300,250]} for publisher 3728 with domain {testing.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-SupplyType-Desktop-ALL-banner-1}
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 239 to UAS for publisher 3728 with domain {testing.com&unlimited=1&optimize=0}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-Desktop-ALL-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-SupplyType-Desktop-ALL} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-Desktop-ALL-banner-1} 100% of the time


#  -----------------------------------------------------Optimize-------------------------------------------------------------------
  @optimize
  Scenario: verify when HB first
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3728 size [1,2]} for publisher 3728 with domain {testing.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-SupplyType-ST-HB-banner-1}
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 236 to UAS for publisher 3728 with domain {testing.com&unlimited=1&optimize=1}
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
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3728 size [1,1]} for publisher 3728 with domain {testing.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-SupplyType-SS-HB-banner-1}
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 237 to UAS for publisher 3728 with domain {testing.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-SS-Direct-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1&optimize=1} for zone named {zone-zoneset-SupplyType-SS-Direct} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-SS-Direct-banner-1} 100% of the time

  @optimize
  Scenario: verify when All first
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3728 size [300,250]} for publisher 3728 with domain {testing.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-SupplyType-Desktop-ALL-banner-1}
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 239 to UAS for publisher 3728 with domain {testing.com&unlimited=1&optimize=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-Desktop-ALL-banner-1} 100% of the time
    Then I send 1 times an ad request with parameter {unlimited=1&optimize=1} for zone named {zone-zoneset-SupplyType-Desktop-ALL} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SupplyType-Desktop-ALL-banner-1} 100% of the time

