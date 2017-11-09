@DinamicTag
Feature: Dynamic Tag flow support
    
Scenario: creating test 1 entities
    Given i remove all zones related to web_section id 289
    Then i update daily capping for publisher id 199 with product id 120 to be 1
    Then i update daily capping for publisher id 199 with product id 124 to be 1
    Then i update daily capping for publisher id 199 with product id 151 to be 1
    Then i create new zone named {DT-test1-SS} with limitation {[]} with adUnitId 69 and web_section id 289
    And i create new zone named {DT-test1-pgm} with limitation {[]} with adUnitId 75 and web_section id 289
    And i create new zone named {DT-test1-pgc} with limitation {[]} with adUnitId 61 and web_section id 289
    And i create new Campaign named {DT-SS-high-priority-test-1} for LineItem 210722 associated to creative 159 with zoneset named {DT-test1-SS} with priority {-2}
    And  I update the created campaign named {DT-SS-high-priority-test-1} status to be 0 in the DB
    And i create new Campaign named {DT-SS-low-priority-test-1} for LineItem 210722 associated to creative 159 with zoneset named {DT-test1-SS} with priority {-1}
    And  I update the created campaign named {DT-SS-low-priority-test-1} status to be 0 in the DB
    And i create new Campaign named {DT-pgm-high-priority-test-1} for LineItem 210722 associated to creative 1000 with zoneset named {DT-test1-pgm} with priority {-2}
    And  I update the created campaign named {DT-pgm-high-priority-test-1} status to be 0 in the DB
    And i create new Campaign named {DT-pgm-low-priority-test-1} for LineItem 210722 associated to creative 1000 with zoneset named {DT-test1-pgm} with priority {-1}
    And  I update the created campaign named {DT-pgm-low-priority-test-1} status to be 0 in the DB
    And i create new Campaign named {DT-pgc-high-priority-test-1} for LineItem 210722 associated to creative 210 with zoneset named {DT-test1-pgc} with priority {-2}
    And  I update the created campaign named {DT-pgc-high-priority-test-1} status to be 0 in the DB
    And i create new Campaign named {DT-pgc-low-priority-test-1} for LineItem 210722 associated to creative 210 with zoneset named {DT-test1-pgc} with priority {-1}
    And  I update the created campaign named {DT-pgc-high-priority-test-1} status to be 0 in the DB
#Scenario: creating test 2 entities
#    Given i remove all zones related to web_section id 126
#    Then i update daily capping for publisher id 37 with product id 120 to be 2
#    Then i update daily capping for publisher id 37 with product id 124 to be 2
#    Then i update daily capping for publisher id 37 with product id 151 to be 2
#    Then i create new zone named {DT-test2-SS-US-limitation} with limitation {[[[5,"=~","us"]} with adUnitId 69 and web_section id 289
#    And i create new zone named {DT-test2-pgm} with limitation {[]} with adUnitId 75 and web_section id 289
#    And i create new zone named {DT-test2-pgc} with limitation {[]} with adUnitId 61 and web_section id 289
#    And i create new Campaign named {DT-SS-high-priority-test2} for LineItem 210722 associated to creative 159 with zoneset named {DT-test2-SS-US-limitation} with priority {-2}
#    And i create new Campaign named {DT-SS-low-priority-test2} for LineItem 210722 associated to creative 159 with zoneset named {DT-test2-SS-US-limitation} with priority {-1}
#    And i create new Campaign named {DT-pgm-high-priority-test-2} for LineItem 210722 associated to creative 1000 with zoneset named {DT-test2-pgm} with priority {-2}
#    And i create new Campaign named {DT-pgm-low-priority-test-2} for LineItem 210722 associated to creative 1000 with zoneset named {DT-test2-pgm} with priority {-1}
#    And i create new Campaign named {DT-pgc-high-priority-test-2} for LineItem 210722 associated to creative 210 with zoneset named {DT-test2-pgc} with priority {-2}
#    And i create new Campaign named {DT-pgc-low-priority-test-2} for LineItem 210722 associated to creative 210 with zoneset named {DT-test2-pgc} with priority {-1}
#
#Scenario: creating test 3 entities
#    Given i remove all zones related to web_section id 118
#    Then i update daily capping for publisher id 46 with product id 120 to be 1
#    Then i update daily capping for publisher id 46 with product id 124 to be 0
#    Then i update daily capping for publisher id 46 with product id 151 to be 1
#    Then i create new zone named {DT-test3-SS} with limitation {[]} with adUnitId 69 and web_section id 289
#    And i create new zone named {DT-test3-pgm} with limitation {[]} with adUnitId 75 and web_section id 289
#    And i create new zone named {DT-test3-pgc} with limitation {[]} with adUnitId 61 and web_section id 289
#    And i create new Campaign named {DT-SS-first-priority-test-3} for LineItem 210722 associated to creative 159 with zoneset named {DT-test3-SS} with priority {-4}
#    And i create new Campaign named {DT-pgm-second-priority-test-3} for LineItem 210722 associated to creative 1000 with zoneset named {DT-test3-pgm} with priority {-2}
#    And i create new Campaign named {DT-pgc-third-priority-test-3} for LineItem 210722 associated to creative 210 with zoneset named {DT-test3-pgc} with priority {-1}
Scenario: refresh zone cache
    Given I refresh the zone Cache

Scenario:1. Basic DT flow
    Then i send 3 times Dynamic Tag ad request to UAS for publisher 199 with domain {bostonherald.com}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-SS-high-priority-test-1-banner-1} 33% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {DT-pgm-high-priority-test-1-banner-1} 33% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {DT-pgc-high-priority-test-1-banner-1} 33% of the time
    Then i send 3 times Dynamic Tag ad request to UAS for publisher 199 with domain {bostonherald.com}
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {DT-SS-low-priority-test-1-banner-1} 33% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {DT-pgm-low-priority-test-1-banner-1} 33% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {DT-pgc-low-priority-test-1-banner-1} 33% of the time


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
#
#Scenario:3. Basic DT logic with no product daily cap
#    Then i send 100 times Dynamic Tag ad request to UAS for publisher 46 with domain {salon.com}
#    And The response contains script
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DT-SS-first-priority-test-3-banner-1} 1% of the time
#    And The impressionUrl has bannerid field matching the id of the banner named {DT-pgm-second-priority-test-3-banner-1} 99% of the time