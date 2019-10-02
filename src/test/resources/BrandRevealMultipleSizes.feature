@parallel
Feature: Brand reveal new

  Scenario: send request expect delivery Direct
    And I send an ad request for zone named {zone-zoneset-NewBrandReveal-BR-Direct} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls


  Scenario: send request expect delivery NonGuaranteed
    And I send an ad request for zone named {zone-zoneset-NewBrandReveal-BR-PROG-NonGuaranteed} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls


  Scenario: send request expect delivery NonGuaranteed600x600
    And I send an ad request for zone named {zone-zoneset-NewBrandReveal-BR-PROG-NonGuaranteed600x600} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls