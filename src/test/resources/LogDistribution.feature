@cli 
Feature: test log fetch
Scenario: test log fetch
	Given Delete test_file logs
	And Send 100 request with zone 1111
	When I read req logs distribution at column 47
	Then The distribution should have 5% difference at most





	
