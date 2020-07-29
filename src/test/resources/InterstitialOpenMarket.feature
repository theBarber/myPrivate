@parallel
@agnostic1


Feature: Agnostic Header bidding feature

  Background: health check
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    When Sending a healthcheck request to UAS
    And I add {NY} ip header
    Then The response code is 200


  Scenario:1 send standard to interstitial Direct zone request
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-interstitial-standard-PG-Direct} to UAS
    Then The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {interstitial-standard-PG-Direct-banner-1} 100% of the time


  Scenario:2 send standard to interstitial Programmatic zone request
    Given I send 1 times an ad request with parameter {unlimited=1&requestid=Automation-OM} for zone named {zone-zoneset-interstitial-standard-PG-Programmatic} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {interstitial-standard-PG-Programmatic-banner-1} 100% of the time
    And The response contains {ut_interstitial.min.js}
    And The response contains {ut_tag}
  ##################ut_interstitial.min.js

#  Scenario:3 send request expect delivery NonGuaranteed300x600
#    Given I send 1 times an ad request with parameter {unlimited=1&requestid=OX_BrandReveal} for zone named {zone-zoneset-NewBrandReveal-BR-PROG-NonGuaranteed300x600} to UAS
#    Then The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {NewBrandReveal-BR-PROG-NonGuaranteed300x600-banner-1} 100% of the time
