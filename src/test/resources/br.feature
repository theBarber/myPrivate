Feature: Brand reveal new

  Scenario: send request expect delivery
    And I send 1 times an ad request for zone named {zone-zoneset-NewBrandReveal-BR-Direct} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
