@CacheProcessVerification
@Integration
Feature: cache process verification 
Scenario: verify UAS* zone cash updated - after updated in limitations 
#	Given We have a connection to WF DB 
	When limitations for zoneId 155605 updated to {[[[41,"=~","Firefox"]]]} in Workflow DB 
	Then limitations for zoneId 155605 is {[[[41,"=~","Firefox"]]]} in Workflow DB 
	When limitations for zoneId 155605 updated to {[[[41,"=~","Opera"]]]} in Workflow DB 
	And zoneCache refreshed by cmd 
	Then limitation for zone 155605 in zoneCache contains {Opera} 
	When limitations for zoneId 155605 updated to {[]} in Workflow DB 
