@cli
Feature: Strategy service test
  Scenario: Send an ad request to UAS and parse impression url
    When I send 200 times an ad request for zone id {2} to UAS and geo params: {country=iceland, dma=456}
    Then I sleep for 5 seconds
    Then I get Strategy selection {999} {80%} of the time
    And I get Strategy selection {1000} {20%} of the time
