Feature: Brand reveal new

  Scenario: try to consume all impressions
    And I send 1000 times an ad request for zone named {zone-zoneset-NewBrandReveal-BR-Direct} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
