@DinamicTag

Feature: Dynamic Tag flow support with API

  Scenario: 1. Basic DT flow
    Given I add cookie UTID with random value to my requests to uas
    Then i send 2 times Dynamic Tag synchronized ad request to UAS for publisher 3701 with domain {HbAndDT&unlimited=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Screen-Shift-1-banner-1} 50% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Smartphone-interstitial-1-banner-1} 50% of the time
    And I sleep for 5 seconds
    Then i send 1 times Dynamic Tag synchronized ad request to UAS for publisher 3701 with domain {HbAndDT&unlimited=1}
    And The response contains script
    And The responses has impression-urls
    And I sleep for 5 seconds
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-PGC-2-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag synchronized ad request to UAS for publisher 3701 with domain {HbAndDT&unlimited=1}
    And The responses are passback

  Scenario:2. Basic DT logic with no product daily cap
    Given I add cookie UTID with random value to my requests to uas
    Then i send 100 times Dynamic Tag ad request to UAS for publisher 3701 with domain {HbAndDT&unlimited=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-SS-Test-3-campaign-first-priority-banner-1} 1% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGM-Test-3-campaign-second-priority-banner-1} 99% of the time
#
#  Scenario:3. Basic DT logic with zone level filtering
#    Given I add cookie UTID with random value to my requests to uas
#    Then i send 2 times Dynamic Tag ad request to UAS for publisher 3675 with domain {dynamic3.com}
#    And The response contains script
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGM-Test-2-campaign-low-priority-banner-1} 100% of the time
#    Then i send 2 times Dynamic Tag ad request to UAS for publisher 3675 with domain {dynamic3.com&unlimited=1}
#    And The response contains script
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGM-Test-2-campaign-high-priority-banner-1} 100% of the time