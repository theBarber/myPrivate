@ABTesting
@Integration
@campaign
@hardcoded
@ramp_admin_db 
Feature: A/B testing functionality 

@Sanity
@cli
@uas
Scenario: Single experiment group scenario 
#	Given I create new experiment groups with the following fields 
#		|name						  			 |active|startDate            |endDate              |adUnits|zoneTypes|lbTraffic|
#		|rampLift_system_tests_experiment_group_1|1     |2017-01-01 00:00:00  |2020-01-01 00:00:00  |1      |RON      |2        |
#	And I create new experiments for group named {rampLift_system_tests_experiment_group_1} with the following fields 
#		|name						  	           |active|allocation|isControl|isDefault|
#		|rampLift_system_tests_experiment_test_1   |1     |33        |0        |0        |
#		|rampLift_system_tests_experiment_control_1|1     |33        |1        |0        |

    Given I change the active flag of experiment group {rampLift_system_tests_experiment_group_1} to {active}   
	And I sleep for 40 seconds 
	And I Delete req logs 
	When I send 1000 times an ad request for zone id {155605} to UAS 
	Then The response code is 200 
	And I calculate the values distribution from log req and column 47 
	And Experiment named {rampLift_system_tests_experiment_test_1} was selected {33} percent of the time 
	And Experiment named {rampLift_system_tests_experiment_control_1} was selected {33} percent of the time 
	And Default experiment was selected {34} percent of the time
	Given I change the active flag of experiment group {rampLift_system_tests_experiment_group_1} to {deactive}
	
Scenario: 2 identical groups scenario including activation/deactivation experiment 
	Given I create new experiment groups with the following fields 
		|name						  			 |active|startDate            |endDate              |adUnits|zoneTypes|lbTraffic|
		|rampLift_system_tests_experiment_group_1|1     |2017-01-01 00:00:00  |2020-01-01 00:00:00  |1      |RON      |2        |
		|rampLift_system_tests_experiment_group_2|1     |2017-01-01 00:00:00  |2020-01-01 00:00:00  |1      |RON      |2        |
	And I create new experiments for group named {rampLift_system_tests_experiment_group_1} with the following fields 
		|name						  	           |active|allocation|isControl|isDefault|
		|rampLift_system_tests_experiment_test_1   |1     |20        |0        |0        |
		|rampLift_system_tests_experiment_control_1|1     |20        |1        |0        |
	And I create new experiments for group named {rampLift_system_tests_experiment_group_2} with the following fields 
		|name						  	           |active|allocation|isControl|isDefault|
		|rampLift_system_tests_experiment_test_2   |1     |10        |0        |0        |
		|rampLift_system_tests_experiment_control_2|1     |10        |1        |0        |
	And I sleep for 40 seconds 
	And I Delete req logs 
	When I send 500 times an ad request for zone id {155502} to UAS 
	Then The response code is 200 
	And I calculate the values distribution from log req and column 47 
	And Experiment named {rampLift_system_tests_experiment_test_1} was selected {20} percent of the time 
	And Experiment named {rampLift_system_tests_experiment_control_1} was selected {20} percent of the time 
	And Experiment named {rampLift_system_tests_experiment_test_2} was selected {10} percent of the time 
	And Experiment named {rampLift_system_tests_experiment_control_2} was selected {10} percent of the time 
	And Default experiment was selected {40} percent of the time 
	And I set the activation status of experiment named {rampLift_system_tests_experiment_test_1} to {0} 
	And I set the activation status of experiment named {rampLift_system_tests_experiment_control_1} to {0} 
	And I sleep for 40 seconds 
	And I Delete req logs 
	And I send 500 times an ad request for zone id {155502} to UAS 
	Then The response code is 200 
	And I calculate the values distribution from log req and column 47 
	And Experiment named {rampLift_system_tests_experiment_test_2} was selected {10} percent of the time 
	And Experiment named {rampLift_system_tests_experiment_control_2} was selected {10} percent of the time 
	And Default experiment was selected {80} percent of the time 
	
	
	
Scenario: 2 different ad-units + 2 groups scenario 
	Given I create new experiment groups with the following fields 
		|name						  			 |active|startDate            |endDate              |adUnits|zoneTypes|lbTraffic|
		|rampLift_system_tests_experiment_group_1|1     |2017-01-01 00:00:00  |2020-01-01 00:00:00  |1      |RON      |2        |
		|rampLift_system_tests_experiment_group_2|1     |2017-01-01 00:00:00  |2020-01-01 00:00:00  |2      |One-Off  |2        |
	And I create new experiments for group named {rampLift_system_tests_experiment_group_1} with the following fields 
		|name						  	           |active|allocation|isControl|isDefault|
		|rampLift_system_tests_experiment_test_1   |1     |40        |0        |0        |
		|rampLift_system_tests_experiment_control_1|1     |20        |1        |0        |
	And I create new experiments for group named {rampLift_system_tests_experiment_group_2} with the following fields 
		|name						  	           |active|allocation|isControl|isDefault|
		|rampLift_system_tests_experiment_test_2   |1     |50        |0        |0        |
		|rampLift_system_tests_experiment_control_2|1     |25        |1        |0        |
	And I sleep for 40 seconds 
	And I Delete req logs 
	When I send 500 times an ad request for zone id {2} to UAS 
	Then The response code is 200 
	And I send 500 times an ad request for zone id {3} to UAS 
	Then The response code is 200 
	And I calculate the values distribution from log req and column 47 
	And Experiment named {rampLift_system_tests_experiment_test_1} was selected {20} percent of the time 
	And Experiment named {rampLift_system_tests_experiment_control_1} was selected {10} percent of the time 
	And Experiment named {rampLift_system_tests_experiment_test_2} was selected {25} percent of the time 
	And Experiment named {rampLift_system_tests_experiment_control_2} was selected {12} percent of the time 
	And Default experiment was selected {33} percent of the time	
