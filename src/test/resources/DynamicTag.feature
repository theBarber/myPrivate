# new feature
# Tags: optional
    
Feature: Dynamic Tag flow support

    Scenario: setting the entities Data
        Given I update daily capping for publishers:
        |   publisher_id   |    product_id  | daily_cap_per_user   |
        |   3470           |    120         |       1              |
        |   3470           |    124         |       1              |
        |   3470           |    151         |       1              |
        |   3605           |    120         |       1              |
        |   3605           |    124         |       0              |
        |   3605           |    151         |       1              |
        |   3323           |    120         |       1              |
        |   3323           |    124         |       0              |
        |   3323           |    151         |       1              |

    And i remove all zones from publishers: {3470,3605,3323}, apart from zones:{170943,170947,170970,171069,171089,171071,171072,171073}

    Scenario: refresh zone cache
        Given I refresh the zone Cache

    Scenario: 1. Basic DT flow
    Given I add cookie UTID with random value to my requests to uas
    Then i send 2 times Dynamic Tag synchronized ad request to UAS for publisher 3470 with domain {ranker.com&ct=1&unlimited=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-SS-Test-1-campaign-high-priority-banner-1} 50% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGM-Test-1-campaign-high-priority-banner-1} 50% of the time
    Then i send 1 times Dynamic Tag synchronized ad request to UAS for publisher 3470 with domain {ranker.com&ct=1unlimited=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGC-Test-1-campaign-low-priority-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag synchronized ad request to UAS for publisher 3470 with domain {ranker.com&ct=1unlimited=1}
    And The responses are passback

Scenario:2. Basic DT logic with zone level filtering
    Given I add cookie UTID with random value to my requests to uas
    Then i send 2 times Dynamic Tag ad request to UAS for publisher 3605 with domain {puckermom.com&ct=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGM-Test-2-campaign-low-priority-banner-1} 100% of the time
    Then i send 2 times Dynamic Tag ad request to UAS for publisher 3605 with domain {puckermom.com&unlimited=1&ct=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGM-Test-2-campaign-high-priority-banner-1} 100% of the time

Scenario:3. Basic DT logic with no product daily cap
    Given I add cookie UTID with random value to my requests to uas
    Then i send 100 times Dynamic Tag ad request to UAS for publisher 3323 with domain {therichest.com&unlimited=1&ct=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-SS-Test-3-campaign-first-priority-banner-1} 1% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGM-Test-3-campaign-second-priority-banner-1} 99% of the time
