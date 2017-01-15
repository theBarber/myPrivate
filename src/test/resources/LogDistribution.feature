@cli 
Feature: test log fetch
Scenario: test log fetch
	Given I Delete req logs
	And I calculate the values distribution from log req and column 47
	And Send 100 request with zone 1111
	Then value {1} from column 47 appears {33} percent of the time
	And value {2} from column 47 appears {33} percent of the time





	
