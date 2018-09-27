@NdqFilteringTL
@scheduled
@uas

Feature: NDQ Filtering Test Level
  Scenario 1: Test level, zone request, make sure ndq feature navigates requests according to strategy traffic portion
    And I send 100 times an ad request with query parameters for zone named {zone-zoneset-NDQfiltering2TL-ST-1} to UAS
    And The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2TL-ST-1-banner-1} 98% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2TL-ST-1-banner-2} 2% of the time

  Scenario 2: Test level, DT request, make sure ndq feature navigates requests according to strategy traffic portion
    Then i send 100 times Dynamic Tag synchronized ad request with tag id 291 to UAS for publisher 3708 with domain {NDQfiltering&unlimited=1&optimize=1}
    And The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2TL-ST-2-banner-1} 98% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2TL-ST-2-banner-2} 2% of the time


  Scenario 3: Test level, HB request, make sure ndq feature navigates requests according to strategy traffic portion
    Given i send 100 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {NDQfiltering} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2TL-ST-3-banner-1} 98% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2TL-ST-3-banner-2} 2% of the time




