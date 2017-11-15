# new feature
# Tags: optional
    
Feature: Dynamic Tag flow support
    
Scenario: 1. Basic DT flow
    Given I add cookie UTID with random value to my requests to uas
    Then i send 3 times Dynamic Tag ad request to UAS for publisher 3470 with domain {ranker.com&ct=1&unlimited=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-SS-Test-1-campaign-high-priority-banner-1} 33% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGM-Test-1-campaign-high-priority-banner-1} 33% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGC-Test-1-campaign-high-priority-banner-1} 33% of the time
    Then i send 3 times Dynamic Tag ad request to UAS for publisher 3470 with domain {ranker.com&unlimited=1}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-SS-Test-1-campaign-low-priority-banner-1} 33% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGM-Test-1-campaign-low-priority-banner-1} 33% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {DT-PGC-Test-1-campaign-low-priority-banner-1} 33% of the time

#Scenario:2. Basic DT logic with zone level filtering
#    Then i send 4 times Dynamic Tag ad request to UAS for publisher 37 with domain {washingtontimes.com}
#    And The response contains script
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DT-pgm-high-priority-test-2-banner-1} 50% of the time
#    And The impressionUrl has bannerid field matching the id of the banner named {DT-pgc-high-priority-test-2-banner-1} 50% of the time
#    Then i send 4 times Dynamic Tag ad request to UAS for publisher 37 with domain {washingtontimes.com}
#    And The response contains script
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DT-pgm-low-priority-test-2-banner-1} 50% of the time
#    And The impressionUrl has bannerid field matching the id of the banner named {DT-pgc-low-priority-test-2-banner-1} 50% of the time