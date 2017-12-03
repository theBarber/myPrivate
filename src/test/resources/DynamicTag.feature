# new feature
# Tags: optional
    
Feature: Dynamic Tag flow support

#    Scenario: setting the entities Data
#        Given I update daily capping for publishers:
#        |   publisher_id   |    product_id  | daily_cap_per_user   |
#        |   3674           |    120         |       1              |
#        |   3674           |    124         |       1              |
#        |   3674           |    151         |       1              |
#        |   3666           |    120         |       1              |
#        |   3666           |    124         |       0              |
#        |   3666           |    151         |       1              |
#        |   3675           |    120         |       1              |
#        |   3675           |    124         |       0              |
#        |   3675           |    151         |       1              |

#    And i remove all zones from publishers: {3674,3666,3675}, apart from zones:{174077,174076,174075,174080,174079,174078,174082,174081}
#
#    Scenario: refresh zone cache
#        Given I refresh the zone Cache

    Scenario: 1. Basic DT flow
    Given I add cookie UTID with random value to my requests to uas
    Then i send 2 times Dynamic Tag synchronized ad request to UAS for publisher 3674 with domain {dynamic1.com&ct=1&unlimited=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-SS-Test-1-campaign-high-priority-banner-1} 50% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGM-Test-1-campaign-high-priority-banner-1} 50% of the time
    Then i send 1 times Dynamic Tag synchronized ad request to UAS for publisher 3674 with domain {dynamic1.com&ct=1&unlimited=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGC-Test-1-campaign-low-priority-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag synchronized ad request to UAS for publisher 3674 with domain {dynamic1.com&ct=1&unlimited=1}
    And The responses are passback

  Scenario:2. Basic DT logic with no product daily cap
    Given I add cookie UTID with random value to my requests to uas
    Then i send 100 times Dynamic Tag ad request to UAS for publisher 3666 with domain {dynamic2.com&unlimited=1&ct=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-SS-Test-3-campaign-first-priority-banner-1} 1% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGM-Test-3-campaign-second-priority-banner-1} 99% of the time

Scenario:3. Basic DT logic with zone level filtering
    Given I add cookie UTID with random value to my requests to uas
    Then i send 2 times Dynamic Tag ad request to UAS for publisher 3675 with domain {dynamic3.com&ct=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGM-Test-2-campaign-low-priority-banner-1} 100% of the time
    Then i send 2 times Dynamic Tag ad request to UAS for publisher 3675 with domain {dynamic3.com&ct=1&unlimited=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGM-Test-2-campaign-high-priority-banner-1} 100% of the time

