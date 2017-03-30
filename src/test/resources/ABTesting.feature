@ABTesting
@Integration
@campaign
@hardcoded
@ramp_admin_db 
@cli
@uas	
Feature: A/B testing functionality 

Background: inactive all the experiments and experiment groups
	Given I set the activation status of experiment group named {rampLift_single_experiment_group_scenario} and his experiments to {inactive}
	Given I set the activation status of experiment group named {rampLift_2_identical_groups_scenario_1} and his experiments to {inactive}
	Given I set the activation status of experiment group named {rampLift_2_identical_groups_scenario_2} and his experiments to {inactive}
	Given I set the activation status of experiment group named {rampLift_test_experiment_group} and his experiments to {inactive}

@Sanity	
Scenario: Single experiment group scenario
	Given I set the activation status of experiment group named {rampLift_single_experiment_group_scenario} and his experiments to {active}
	And I sleep for 300 seconds 
	And I Delete req logs
	When I send 1000 times an ad request for zone id {156242} to UAS 
	Then The response code is 200 
	And I calculate the values distribution from log req and column 47 
	And Experiment named {rampLift_single_experiment_group_scenario_control} was selected {33} percent of the time 
	And Experiment named {rampLift_single_experiment_group_scenario_test} was selected {33} percent of the time 
	And Default experiment was selected {34} percent of the time
	
Scenario: 2 identical groups scenario including activation/deactivation experiment 
	Given I set the activation status of experiment group named {rampLift_2_identical_groups_scenario_1} and his experiments to {active}
	Given I set the activation status of experiment group named {rampLift_2_identical_groups_scenario_2} and his experiments to {active}
	And I sleep for 300 seconds 
	And I Delete req logs 
	When I send 500 times an ad request for zone id {156242} to UAS 
	Then The response code is 200 
	And I calculate the values distribution from log req and column 47 
	And Experiment named {rampLift_2_identical_groups_scenario_test_1} was selected {20} percent of the time
	And Experiment named {rampLift_2_identical_groups_scenario_control_1} was selected {20} percent of the time
	And Experiment named {rampLift_2_identical_groups_scenario_test_2} was selected {10} percent of the time
	And Experiment named {rampLift_2_identical_groups_scenario_control_2} was selected {10} percent of the time
	And Default experiment was selected {40} percent of the time
	And I set the activation status of experiment named {rampLift_2_identical_groups_scenario_test_2} to {0}
	And I set the activation status of experiment named {rampLift_2_identical_groups_scenario_control_2} to {0}
	And I sleep for 300 seconds 
	And I Delete req logs 
	And I send 500 times an ad request for zone id {156242} to UAS 
	Then The response code is 200 
	And I calculate the values distribution from log req and column 47 
	And Experiment named {rampLift_2_identical_groups_scenario_test_1} was selected {20} percent of the time 
	And Experiment named {rampLift_2_identical_groups_scenario_control_1} was selected {20} percent of the time 
	And Default experiment was selected {60} percent of the time 
	
#	
#Scenario: 2 different ad-units + 2 groups scenario 
##	Given I create new experiment groups with the following fields 
##		|name						  			 |active|startDate            |endDate              |adUnits|zoneTypes|lbTraffic|
##		|rampLift_system_tests_experiment_group_1|1     |2017-01-01 00:00:00  |2020-01-01 00:00:00  |10      |Test     |2        |
##		|rampLift_system_tests_experiment_group_2|1     |2017-01-01 00:00:00  |2020-01-01 00:00:00  |2      |One-Off  |2        |
##	And I create new experiments for group named {rampLift_system_tests_experiment_group_1} with the following fields 
##		|name						  	           |active|allocation|isControl|isDefault|
##		|rampLift_system_tests_experiment_test_1   |1     |40        |0        |0        |
##		|rampLift_system_tests_experiment_control_1|1     |20        |1        |0        |
##	And I create new experiments for group named {rampLift_system_tests_experiment_group_2} with the following fields 
##		|name						  	           |active|allocation|isControl|isDefault|
##		|rampLift_system_tests_experiment_test_2   |1     |50        |0        |0        |
##		|rampLift_system_tests_experiment_control_2|1     |25        |1        |0        |
#	And I sleep for 100 seconds 
#	And I Delete req logs 
#	When I send 500 times an ad request for zone id {2} to UAS 
#	Then The response code is 200 
#	And I send 500 times an ad request for zone id {3} to UAS 
#	Then The response code is 200 
#	And I calculate the values distribution from log req and column 47 
#	And Experiment named {rampLift_system_tests_experiment_test_1} was selected {20} percent of the time 
#	And Experiment named {rampLift_system_tests_experiment_control_1} was selected {10} percent of the time 
#	And Experiment named {rampLift_system_tests_experiment_test_2} was selected {25} percent of the time 
#	And Experiment named {rampLift_system_tests_experiment_control_2} was selected {12} percent of the time 
#	And Default experiment was selected {33} percent of the time


