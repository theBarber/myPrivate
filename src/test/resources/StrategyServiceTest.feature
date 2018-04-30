@cli
@uas
@strategy
Feature: Strategy service test

  Scenario: Send an ad request to UAS and parse impression url
    When I add unlimited query parameter with value {1} to send my requests to uas
    And I add sim_geo query parameter with value {1} to send my requests to uas
    And I add dma query parameter with value {777} to send my requests to uas
    When I Delete req logs
    Then I send 50 times an ad request with query parameters for zone id {2} to UAS
    And I calculate the values distribution from log req and column 47 for experiment
    Then I get for column 47 id {77} {40%}
    And I get for column 47 id {4} {60%}
