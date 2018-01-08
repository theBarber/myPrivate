@ABTesting
@campaign
@hardcoded
@ramp_admin_db 
@cli
@uas
Feature: A/B testing functionality


@Sanity	@Integration
Scenario: 1. Single experiment group scenario
	Given Unable all experiment groups except experimentID 10
	Given I set the activation status of experiment group named {rampLift_single_experiment_group_scenario} and his experiments to {active}
	And I restart {ramp-lift-services}
	And I sleep for 60 seconds
	And I Delete req logs
#	this zones has banner?
	When I send 500 times an ad request for zone id {174272} to UAS
	Then The response code is 200
	And I calculate the values distribution from log req and column 47 
	And Experiment named {rampLift_single_experiment_group_scenario_control} was selected {33} percent of the time 
	And Experiment named {rampLift_single_experiment_group_scenario_test} was selected {33} percent of the time 
	And Default experiment was selected {34} percent of the time

Scenario: 2. 2 identical groups scenario including activation/deactivation experiment
	Given Unable all experiment groups except experimentID 10
	Given I set the activation status of experiment group named {rampLift_2_identical_groups_scenario_1} and his experiments to {active}
	Given I set the activation status of experiment group named {rampLift_2_identical_groups_scenario_2} and his experiments to {active}
	And I restart {ramp-lift-services}
	And I sleep for 60 seconds
	And I Delete req logs
	When I send 500 times an ad request for zone id {174272} to UAS
	Then The response code is 200
	And I calculate the values distribution from log req and column 47
	And Experiment named {rampLift_2_identical_groups_scenario_test_1} was selected {20} percent of the time
	And Experiment named {rampLift_2_identical_groups_scenario_control_1} was selected {20} percent of the time
	And Experiment named {rampLift_2_identical_groups_scenario_test_2} was selected {10} percent of the time
	And Experiment named {rampLift_2_identical_groups_scenario_control_2} was selected {10} percent of the time
	And Default experiment was selected {40} percent of the time
	And I set the activation status of experiment named {rampLift_2_identical_groups_scenario_test_2} to {0}
	And I set the activation status of experiment named {rampLift_2_identical_groups_scenario_control_2} to {0}
	And I restart {ramp-lift-services}
	And I sleep for 60 seconds
	And I Delete req logs
	And I send 500 times an ad request for zone id {174272} to UAS
	Then The response code is 200
	And I calculate the values distribution from log req and column 47
	And Experiment named {rampLift_2_identical_groups_scenario_test_1} was selected {20} percent of the time
	And Experiment named {rampLift_2_identical_groups_scenario_control_1} was selected {20} percent of the time
	And Default experiment was selected {60} percent of the time