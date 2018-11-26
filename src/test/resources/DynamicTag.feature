@cli
@uas
@scheduled
@DT
@parallel
@noAA
@DANIELLA

Feature: Dynamic Tag flow support

Scenario: 1. Basic DT flow
    Given I add cookie UTID with random value to my requests to uas
      Then i send 2 times Dynamic Tag synchronized ad request to UAS for publisher 3674 with domain {dynamic1.com&unlimited=1&optimize=0}
    And The synchronized response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-SS-1-t-1-banner-1} 50% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-SI-1-t-1-banner-1} 50% of the time
    And I sleep for 5 seconds
    Then i send 1 times Dynamic Tag synchronized ad request to UAS for publisher 3674 with domain {dynamic1.com&unlimited=1&optimize=0}
    And The synchronized response code is 200
    And The response contains script
    And The responses has impression-urls
    And I sleep for 5 seconds
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-PGC-2-t-1-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag synchronized ad request to UAS for publisher 3674 with domain {dynamic1.com&unlimited=1&optimize=0}
    And The synchronized response code is 200
    And The synchronized responses are passback

  Scenario:2. Basic DT logic with no product daily cap
    Given I add cookie UTID with random value to my requests to uas
    Then i send 100 times Dynamic Tag ad request to UAS for publisher 3666 with domain {dynamic2.com&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-SS-1-t-2-banner-1} 1% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-SI-2-t-2-banner-1} 99% of the time

Scenario:3. Basic DT logic with zone level filtering
    Given I add cookie UTID with random value to my requests to uas
    Then i send 2 times Dynamic Tag ad request to UAS for publisher 3675 with domain {dynamic3.com&optimize=0}
    And The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-SI-2-t-3-banner-1} 100% of the time
    Then i send 2 times Dynamic Tag ad request to UAS for publisher 3675 with domain {dynamic3.com&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-SI-1-t-3-L-banner-1} 100% of the time


#  -----------------------------------------------------Optimize-------------------------------------------------------------------
  @optimize
  Scenario: 1. Basic DT flow
    Given I add cookie UTID with random value to my requests to uas
    Then i send 2 times Dynamic Tag synchronized ad request to UAS for publisher 3674 with domain {dynamic1.com&unlimited=1&optimize=1}
    And The synchronized response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-SS-1-t-1-banner-1} 50% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-SI-1-t-1-banner-1} 50% of the time
    And I sleep for 5 seconds
    Then i send 1 times Dynamic Tag synchronized ad request to UAS for publisher 3674 with domain {dynamic1.com&unlimited=1&optimize=1}
    And The synchronized response code is 200
    And The response contains script
    And The responses has impression-urls
    And I sleep for 5 seconds
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-PGC-2-t-1-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag synchronized ad request to UAS for publisher 3674 with domain {dynamic1.com&unlimited=1&optimize=1}
    And The synchronized response code is 200
    And The synchronized responses are passback
  @optimize
  Scenario:2. Basic DT logic with no product daily cap
    Given I add cookie UTID with random value to my requests to uas
    Then i send 100 times Dynamic Tag ad request to UAS for publisher 3666 with domain {dynamic2.com&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-SS-1-t-2-banner-1} 1% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-SI-2-t-2-banner-1} 99% of the time
  @optimize
  Scenario:3. Basic DT logic with zone level filtering
    Given I add cookie UTID with random value to my requests to uas
    Then i send 2 times Dynamic Tag ad request to UAS for publisher 3675 with domain {dynamic3.com&optimize=1}
    And The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-SI-2-t-3-banner-1} 100% of the time
    Then i send 2 times Dynamic Tag ad request to UAS for publisher 3675 with domain {dynamic3.com&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-SI-1-t-3-L-banner-1} 100% of the time