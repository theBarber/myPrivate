@uas
@headerBidding
@scheduled
@NdqFilteringCL

Feature: NDQ Filtering Campaign Level

  Scenario: Send Zone request and verify strategy
    Given i disable all tests except 100
    Given i set test 100 status to 1
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36} as user-agent string to send my requests to uas
    And I send generic request 10 times until I get strategy {random}
    And I send 1 times an ad request for gdpr entities to UAS
    Then I expect req gdpr passback
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
#    And The response contains script
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
#    And The response contains script
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
#    And The response contains script
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfilteringCL-ST-5-banner-1} 100% of the time
#    Given I use {http://NDQfiltering} as referer string to send my requests to uas
#
#  Scenario: 6 Campaign level, HB request, verify NDQ filtering obeys to skip daily goal flag when flag = false
#    Given I use {http://NDQfiltering} as referer string to send my requests to uas
#    Given i send 110 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {NDQfiltering} with extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-NDQfilteringCL-ST-6-banner-1}
#
