#@parallel
@NDQFilteringTest

Feature: NDQ Filtering Campaign Level

  Scenario: Set Strategy 50-50 random-empty
    Given i disable all tests except 100
    Given i set test 100 status to 1

  Scenario Outline: try to consume all impressions
    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
    And I send 1 additional ad requests for zone named <zone> to UAS
    And The response code is 200
    Then The response contains {script}
    And I send impression requests to UAS immediately!

    Examples:
      | zone                               |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |
      | {zone-zoneset-NDQfilteringTL-ST-1} |

  Scenario Outline: try to consume all impressions with HB
    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send synchronized 1 basic headerBidding secure post request for publisher 3843 with size - h1:1 w1:2, with domain <url>, placmentID group = {3843001} and extra params {&unlimited=1&optimize=1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS

    Examples:
      | url                      |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |
      | {100directions.com} |

  Scenario: check
    Then The synchronized response code is 200 50 of the times

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
#    Given i send 100 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {NDQfiltering} with extra params {&unlimited=1&optimize=1}
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
#    Given i send 110 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {NDQfiltering} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains adId with id of entity named {campaign-NDQfilteringCL-ST-6-banner-1}
#
