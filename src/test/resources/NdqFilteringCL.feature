#@parallel

Feature: NDQ Filtering Campaign Level

#  Scenario: Send Zone request and verify strategy
#    Given i disable all tests except 100
#    Given i set test 100 status to 1
#    Given I set campaign NDQfilteringTL-ST-1 for 100 days
#    And I send zone request 10 times for zone zone-zoneset-NDQfilteringTL-ST-1 until I get strategy random and I expect 55 impressions till I get NDQ passback
#    And I send 1 times an ad request for zone named {zone-zoneset-NDQfilteringTL-ST-1} to UAS
#    And The response code is 200
#    And The responses are passback
#    Given i disable all tests except 53
#    Given i set test 53 status to 1

  Scenario: create entities for NDQ filtering
    Given i disable campaigns by name on db
      | Campaign Name       |
      | NDQfilteringTL-ST-1 |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name       | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | NDQfilteringTL-ST-1 | 75396 | 210722   | false                 | 8158          | {zone-zoneset-NDQfilteringTL-ST-1} | []         | 93       | 15128          | 3708         | 67638           | []          | []          |

    Given I set campaign NDQfilteringTL-ST-1 for 10 days

    And i update campaign data by name
      | Campaign Name       | factor | units |
      | NDQfilteringTL-ST-1 | 0      | 100   |

    And i update zone data by name
      | Zone Name                        | is_secure |
      | zone-zoneset-NDQfilteringTL-ST-1 | 1         |

  Scenario: refresh caches
    And I refresh banner cache
    And I refresh zone cache
    And I restart {ramp-lift-services}
    And I restart {ut-programmatic-gw}

  Scenario: save entities to file
    And save all entities to json file

  Scenario: Set Strategy 50-50 random-empty
    Given i disable all tests except 100
    Given i set test 100 status to 1

  Scenario: try to consume all impressions
    Given I set campaign NDQfilteringTL-ST-1 for 10 days
    And I send 1 times an ad request for zone named {zone-zoneset-NDQfilteringTL-ST-1} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {NDQfilteringTL-ST-1-banner-1} 5% of the time

  Scenario: Set strategy to common one
    Given i disable all tests except 53
    Given i set test 53 status to 1

#  Scenario: 1. Campaign level, zone request, verify NDQ filtering obeys to skip daily goal flag when flag = false
#    Given i disable all tests except 100
#    Given i set test 100 status to 1
#    And I send 100 times an ad request with query parameters for zone named {zone-zoneset-campaign-NDQfilteringCL-ST-1} to UAS
#    And The response code is 200
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfilteringCL-ST-1-banner-1} 100% of the time
#    And I send 5 times an ad request with query parameters for zone named {zone-zoneset-NDQfilteringCL-ST-1} to UAS
#    And The response code is 200
#    And The responses are passback
#    Given i disable all tests except 53
#    Given i set test 53 status to 1

#
#  Scenario: 2. Campaign level, DT request, verify NDQ filtering obeys to skip daily goal flag when flag = false
#    Given I use {http://NDQfiltering} as referer string to send my requests to uas
#    Then i send 100 times Dynamic Tag synchronized ad request with tag id 291 to UAS for publisher 3708 with domain {NDQfiltering&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2-ST-2-banner-1} 100% of the time
#    Given I use {http://NDQfiltering} as referer string to send my requests to uas
#    Then i send 5 times Dynamic Tag synchronized ad request with tag id 291 to UAS for publisher 3708 with domain {NDQfiltering&unlimited=1&optimize=1}
#    And The response code is 200
#    And The responses are passback
#
#  Scenario: 3 Campaign level, HB request, verify NDQ filtering obeys to skip daily goal flag when flag = false
#    Given I use {http://NDQfiltering} as referer string to send my requests to uas
#    Given i send 100 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {NDQfiltering} with extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains adId with id of entity named {campaign-NDQfilteringCL-ST-3-banner-1}
#
#  Scenario: 4 Campaign level, zone request, verify NDQ filtering obeys to skip daily goal flag when flag = true
#    And I send 110 times an ad request with query parameters for zone named {zone-zoneset-campaign-NDQfilteringCL-ST-4} to UAS
#    And The response code is 200
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfilteringCL-ST-4-banner-1} 100% of the time
#
#  Scenario: 5 Campaign level, DT request, verify NDQ filtering obeys to skip daily goal flag when flag = true
#    Given I use {http://NDQfiltering} as referer string to send my requests to uas
#    Then i send 110 times Dynamic Tag synchronized ad request with tag id 291 to UAS for publisher 3708 with domain {NDQfiltering&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfilteringCL-ST-5-banner-1} 100% of the time
#    Given I use {http://NDQfiltering} as referer string to send my requests to uas
#
#  Scenario: 6 Campaign level, HB request, verify NDQ filtering obeys to skip daily goal flag when flag = false
#    Given I use {http://NDQfiltering} as referer string to send my requests to uas
#    Given i send 110 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {NDQfiltering} with extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains adId with id of entity named {campaign-NDQfilteringCL-ST-6-banner-1}
#
