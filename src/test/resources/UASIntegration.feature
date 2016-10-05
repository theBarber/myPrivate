@UAS
Feature: UASIntegration
  @Sanity
  Scenario: Send request to UAS and parse result from AdSelector
    Given new request src/test/resources/input_files/req_zone_2.json with zone 2 to UASEndPoint
    When ad selected
    Then The response is correct