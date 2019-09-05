#@NdqFilteringTL
#@scheduled
#@uas
#
#Feature: NDQ Filtering Test Level
#
#  Scenario: 0: reset the data
#    Given i disable all tests except 1993
#    Given i set test 1993 status to 1
#    Given i set test 1994 status to 1
#    And I set test id of test_strategy named {height} to {1994}
#    And I set test id of test_strategy named {low} to {1993}
#
#  Scenario 1: Test level, zone request, make sure ndq feature navigates requests according to strategy traffic portion
#    And I send 100 times an ad request with query parameters for zone named {zone-zoneset-campaign-NDQfiltering2TL-ST-1} to UAS
#    And The response code is 200
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2TL-ST-1-banner-1} 98% of the time
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2TL-ST-2-banner-1} 2% of the time
#
#  Scenario 2: Test level, DT request, make sure ndq feature navigates requests according to strategy traffic portion
#    Then i send 100 times Dynamic Tag synchronized ad request with tag id 291 to UAS for publisher 3708 with domain {NDQfiltering&unlimited=1&optimize=1}
#    And The response code is 200
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2TL-ST-1-banner-1} 98% of the time
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2TL-ST-2-banner-1} 2% of the time
#
#
#  Scenario 3: Test level, HB request, make sure ndq feature navigates requests according to strategy traffic portion
#    Given i send 100 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {NDQfiltering} with extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2TL-ST-1-banner-1} 98% of the time
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2TL-ST-2-banner-1} 2% of the time
#
#  Scenario: end: restore the data
#    Given i disable all tests except 53
#    Given i set test 53 status to 1
#
#
