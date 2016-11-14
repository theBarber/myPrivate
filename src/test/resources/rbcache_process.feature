@cli
Feature: cache process verification 
Scenario: verify UAS* zone cash updated - after updated in limitations
	Given We have a connection to WF DB 
	When limitations for zoneId 112211 updated to Firefox in Workflow DB 
	Then limitations for zoneId 112211 is Firefox in Workflow DB 
	When limitations for zoneId 112211 updated to Opera in Workflow DB 
	And zoneCache refreshed by cmd 
	Then limitation for zone 112211 in zoneCache is Opera 
	
