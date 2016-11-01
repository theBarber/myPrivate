@cli
Feature:cache process verification
  @Sanity
  Scenario:verify UAS* zone cash updated - after updated in zone delivery limitations
    Given We have a connection to WF DB
    Then limitations for zoneId 112211 updated to Firefox in Workflow DB
    And limitations for zoneId 112211 is Firefox in Workflow DB
    When limitations for zoneId 112211 updated to Opera in Workflow DB
    When zoneCache refreshed by cmd
    And limitation for zone 112211 in zoneCache is Opera

