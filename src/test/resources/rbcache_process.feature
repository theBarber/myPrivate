@cli
Feature:cache process verification
Background: Campaign Manager with hardcoded campaign
  @Sanity
  Scenario:verify UAS* zone cash updated - after updated in zone delivery limitations
    Given We have a connection to WF DB
    Then limitations for zoneId 112211 updated to Firefox in Workflow DB
    And limitations for zoneId 112211 is Firefox in Workflow DB
    When limitations for zoneId 112211 updated to Opera in Workflow DB
    When zoneCache refreshed by cmd
    And limitation for zone {INT03 - Billboard 970x250 - HBO Series - HBO The Brink} in zoneCache is Opera

