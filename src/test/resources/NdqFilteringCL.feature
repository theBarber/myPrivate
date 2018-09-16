@NdqFilteringCL
@scheduled
@uas

Feature: NDQ Filtering Campaign Level
  Scenario 1: Campaign level, zone request, verify NDQ filtering obeys to skip daily goal flag when flag = false
    And I send 100 times an ad request with query parameters for zone named {zone-zoneset-NDQfiltering2-ST-1} to UAS
    And The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2-ST-1-banner-1} 100% of the time
    And I send 5 times an ad request with query parameters for zone named {zone-zoneset-NDQfiltering2-ST-1} to UAS
    And The response code is 200
    And The responses are passback

  Scenario 2: Campaign level, DT request, verify NDQ filtering obeys to skip daily goal flag when flag = false
    Given I use {http://NDQfiltering} as referer string to send my requests to uas
    Then i send 100 times Dynamic Tag synchronized ad request with tag id 291 to UAS for publisher 3708 with domain {NDQfiltering&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2-ST-2-banner-1} 100% of the time
    Given I use {http://NDQfiltering} as referer string to send my requests to uas
    Then i send 5 times Dynamic Tag synchronized ad request with tag id 291 to UAS for publisher 3708 with domain {NDQfiltering&unlimited=1&optimize=1}
    And The response code is 200
    And The responses are passback

  Scenario 3: Campaign level, HB request, verify NDQ filtering obeys to skip daily goal flag when flag = false
    Given I use {http://NDQfiltering} as referer string to send my requests to uas
    Given i send 100 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {NDQfiltering} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-DomainT-1-banner-1}
    Given i send 5 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {cnn.com} with extra params {&unlimited=1&optimize=0}
    And The responses are passback
    Given I use {http://cnn.com} as referer string to send my requests to uas

  Scenario 4: Campaign level, zone request, verify NDQ filtering obeys to skip daily goal flag when flag = true
    Given i disable all tests Groups except 56
    Given i set test Group 56 status to 1
    And I send 110 times an ad request with query parameters for zone named {zone-zoneset-NDQfiltering2-ST-1} to UAS
    And The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2-ST-1-banner-1} 100% of the time

  Scenario 5: Campaign level, DT request, verify NDQ filtering obeys to skip daily goal flag when flag = true
    Given I use {http://NDQfiltering} as referer string to send my requests to uas
    Then i send 110 times Dynamic Tag synchronized ad request with tag id 291 to UAS for publisher 3708 with domain {NDQfiltering&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2-ST-2-banner-1} 100% of the time
    Given I use {http://NDQfiltering} as referer string to send my requests to uas

  Scenario 6: Campaign level, HB request, verify NDQ filtering obeys to skip daily goal flag when flag = false
    Given I use {http://NDQfiltering} as referer string to send my requests to uas
    Given i send 110 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {NDQfiltering} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-DomainT-1-banner-1}

  Scenario 7: Strategy level, zone request, verify NDQ filtering navigates requests according to strategy traffic portion

