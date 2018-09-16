@NdqFilteringSL
@scheduled
@uas

Feature: NDQ Filtering 2
  Scenario 1: Strategy level, zone request, make sure ndq feature navigates requests according to strategy traffic portion
    And I send 100 times an ad request with query parameters for zone named {zone-zoneset-NDQfiltering2SL-ST-1} to UAS
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NDQfiltering2SL-ST-1-banner-1} 98% of the time
