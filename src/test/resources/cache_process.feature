Feature: cache process verification

  @Sanity
  Scenario: verify UAS* zone cash updated - after updated in zone delivery limitations
    Given We have a connection to WF DB
    And limitations for zoneId 112211 is Firefox in Workflow DB
    And limitations for zoneId 112211 updated to Opera in Workflow DB
    When zoneCache refreshed by cmd and wait for 2 seconds
    And sleep for 120 seconds
    Then limitation for zoneId 112211 in zoneCache is Opera
    And limitations for zoneId 112211 updated to Firefox in Workflow DB