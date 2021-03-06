@CacheProcessVerification
@Integration
Feature: cache process verification 
Scenario: verify UAS* zone cash updated - after updated in limitations 
	When limitations for zoneId 155605 updated to {[[["=~","Firefox"]]]} in Workflow DB 
	Then limitations for zoneId 155605 is {[[["=~","Firefox"]]]} in Workflow DB 
	When limitations for zoneId 155605 updated to {[["=~","Opera"]]]} in Workflow DB 
	And zoneCache refreshed by cmd 
	Then limitation for zone 155605 in zoneCache contains {Opera} 
	When limitations for zoneId 155605 updated to {[]} in Workflow DB 
