@NdqFilteringSL
@scheduled
@uas

Feature: NDQ Filtering Strategy Level
  Scenario 1: Strategy level, zone request, make sure ndq feature navigates requests according to strategy traffic portion
    And I send 100 times an ad request with query parameters for zone named {zone-zoneset-NDQfiltering2SL-ST-1} to UAS
    And The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2SL-ST-1-banner-1} 98% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2SL-ST-1-banner-2} 2% of the time

  Scenario 2: Strategy level, DT request, make sure ndq feature navigates requests according to strategy traffic portion
    Given I use {http://NDQfiltering} as referer string to send my requests to uas
    Then i send 100 times Dynamic Tag synchronized ad request with tag id 291 to UAS for publisher 3708 with domain {NDQfiltering&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2SL-ST-2-banner-1} 98% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2SL-ST-2-banner-2} 2% of the time


  Scenario 3: Strategy level, HB request, make sure ndq feature navigates requests according to strategy traffic portion
    Given I use {http://NDQfiltering} as referer string to send my requests to uas
    Given i send 100 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {NDQfiltering} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2SL-ST-3-banner-1} 98% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2SL-ST-3-banner-2} 2% of the time


