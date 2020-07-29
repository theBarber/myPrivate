@parallel
@BrandReveal
@request_service
Feature: Brand reveal support new size 300X600

  Background:
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    And I add header of {X-Forwarded-For} with value {207.246.116.162}
    And Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario:1 send request expect delivery Direct
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-NewBrandReveal-BR-Direct} to UAS
    Then The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {NewBrandReveal-BR-Direct-banner-1} 100% of the time


  Scenario:2 send request expect delivery NonGuaranteed
    Given I send 1 times an ad request with parameter {unlimited=1&requestid=OX_BrandReveal} for zone named {zone-zoneset-NewBrandReveal-BR-PROG-NonGuaranteed} to UAS
    Then The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {NewBrandReveal-BR-PROG-NonGuaranteed-banner-1} 100% of the time


  Scenario:3 send request expect delivery NonGuaranteed300x600
    Given I send 1 times an ad request with parameter {unlimited=1&requestid=OX_BrandReveal} for zone named {zone-zoneset-NewBrandReveal-BR-PROG-NonGuaranteed300x600} to UAS
    Then The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {NewBrandReveal-BR-PROG-NonGuaranteed300x600-banner-1} 100% of the time
