@testeitan

Feature: just testing

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: For a publisher 3708 which has single domain with 15s video duration & skippable = Yes - zone tag request
    Given I send 1 times an ad request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-large-D-skip-Y-CS-Video} to UAS
    Then The response code is 200