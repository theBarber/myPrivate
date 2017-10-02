@ABTesting
@campaign
@hardcoded
@ramp_admin_db 
@cli
@uas
#@Integration
#we currently don't need to execute all tests, only test 1. jira item - UT-4338
Feature: A/B testing functionality 

Background: setup
	Given I setup the db
	
@Sanity	@Integration
Scenario: 1. Single experiment group scenario
	Given I set the activation status of experiment group named {rampLift_single_experiment_group_scenario} and his experiments to {active}
	And I sleep for 120 seconds
	And I Delete req logs
	When I send 500 times an ad request for zone id {156242} to UAS 
	Then The response code is 200 
	And I calculate the values distribution from log req and column 47 
	And Experiment named {rampLift_single_experiment_group_scenario_control} was selected {33} percent of the time 
	And Experiment named {rampLift_single_experiment_group_scenario_test} was selected {33} percent of the time 
	And Default experiment was selected {34} percent of the time
	
Scenario: 2. 2 identical groups scenario including activation/deactivation experiment 
	Given I set the activation status of experiment group named {rampLift_2_identical_groups_scenario_1} and his experiments to {active}
	Given I set the activation status of experiment group named {rampLift_2_identical_groups_scenario_2} and his experiments to {active}
	And I sleep for 120 seconds
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
	And I sleep for 120 seconds 
	And I Delete req logs 
	And I send 500 times an ad request for zone id {156242} to UAS 
	Then The response code is 200 
	And I calculate the values distribution from log req and column 47 
	And Experiment named {rampLift_2_identical_groups_scenario_test_1} was selected {20} percent of the time 
	And Experiment named {rampLift_2_identical_groups_scenario_control_1} was selected {20} percent of the time 
	And Default experiment was selected {60} percent of the time 

Scenario: 3. Single experiment group with multiple zone types - the experiment selected
	Given I set the activation status of experiment group named {rampLift_multiple_zone_types_scenario_1} and his experiments to {active}
	And I sleep for 120 seconds
	And I Delete req logs 
	When I send 500 times an ad request for zone id {156242} to UAS 
	Then The response code is 200 
	And I calculate the values distribution from log req and column 47 
	And Experiment named {rampLift_multiple_zone_types_scenario_test_1} was selected {20} percent of the time
	And Experiment named {rampLift_multiple_zone_types_scenario_control_1} was selected {20} percent of the time
	And Default experiment was selected {60} percent of the time

Scenario: 4. Single experiment group with multiple zone types - the experiment wasn't selected
	Given I set the activation status of experiment group named {rampLift_multiple_zone_types_scenario_2} and his experiments to {active}
	And I sleep for 120 seconds
	And I Delete req logs 
	When I send 500 times an ad request for zone id {156242} to UAS 
	Then The response code is 200 
	And I calculate the values distribution from log req and column 47 
	And Default experiment was selected {100} percent of the time
	
Scenario: 5. Single experiment group - the zone not apply for Ad_unit condition - the experiment wasn't selected
	Given I set the activation status of experiment group named {rampLift_adUnit_scenario} and his experiments to {active}
	And I sleep for 120 seconds
	And I Delete req logs 
	When I send 500 times an ad request for zone id {156242} to UAS 
	Then The response code is 200 
	And I calculate the values distribution from log req and column 47
	And Default experiment was selected {100} percent of the time

