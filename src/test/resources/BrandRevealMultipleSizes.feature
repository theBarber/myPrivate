@parallel
@BrandReveal
Feature: Brand reveal support new size 300X600

  Scenario: send request expect delivery Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    And I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-NewBrandReveal-BR-Direct} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls


  Scenario: send request expect delivery NonGuaranteed
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    And I send 1 times an ad request with parameter {unlimited=1&requestid=OX_BrandReveal} for zone named {zone-zoneset-NewBrandReveal-BR-PROG-NonGuaranteed} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls


  Scenario: send request expect delivery NonGuaranteed600x600
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    And I send 1 times an ad request with parameter {unlimited=1&requestid=OX_BrandReveal} for zone named {zone-zoneset-NewBrandReveal-BR-PROG-NonGuaranteed600x600} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls