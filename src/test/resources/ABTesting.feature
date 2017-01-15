@uas
@ramp_admin_db

Feature: A/B testing functionality
	
Scenario: Single experiment group scenario
	Given I create new experiment groups with the following fields
		|name						  			 |active|startDate            |endDate              |adUnits|zoneTypes|lbTraffic|
		|rampLift_system_tests_experiment_group_1|1     |2017-01-01 00:00:00  |2020-01-01 00:00:00  |1      |RON      |2        |
	And I create new experiments for group named {rampLift_system_tests_experiment_group_1} with the following fields
		|name						  	           |active|allocation|isControl|isDefault|
		|rampLift_system_tests_experiment_test_5   |1     |33        |0        |0        |
		|rampLift_system_tests_experiment_control_5|1     |33        |1        |0        |
	And I set the activation status of experiment named {rampLift_system_tests_experiment_test_5} to {0}
	And I clean the created experiments
	And I clean the created experiment groups


