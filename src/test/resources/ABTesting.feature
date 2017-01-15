@uas
@campaign
@cli
@ramp_admin_db

Background: zones and campaigns etc, exists
Given Zoneset named {hwu zonesets}
Given Zone named {qa.undertone.com - Full Banner} is in the zoneset named {hwu zonesets}
Given Zone named {qa.undertone.com - Half Banner} is in the zoneset named {hwu zonesets}

Feature: A/B testing functionality
	
Scenario: Single experiment group scenario
	Given I create new experiment groups with the following fields
		|name						  			 |active|startDate            |endDate              |adUnits|zoneTypes|lbTraffic|
		|rampLift_system_tests_experiment_group_1|1     |2017-01-01 00:00:00  |2020-01-01 00:00:00  |1      |RON      |2        |
	And I create new experiments for group named {rampLift_system_tests_experiment_group_1} with the following fields
		|name						  	           |active|allocation|isControl|isDefault|
		|rampLift_system_tests_experiment_test_1   |1     |33        |0        |0        |
		|rampLift_system_tests_experiment_control_1|1     |33        |1        |0        |
	And I Delete req logs
	When I send 100 times an ad request for zone named {qa.undertone.com - Full Banner} to UAS
	And I calculate the values distribution from log req and column 47
	#And I set the activation status of experiment named {rampLift_system_tests_experiment_test_5} to {0}
	#Then value {1} from column 47 appears {33} percent of the time
	#And  value {2} from column 47 appears {33} percent of the time
	And I clean the created experiments
	And I clean the created experiment groups


