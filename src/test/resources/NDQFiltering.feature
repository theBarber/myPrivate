@NDQFiltering
@Integration
@campaign
@hardcoded
@ramp_admin_db
@workflow_db
@cli
@uas	
Feature: NDQ filtering validation

Background: inactive all the experiments and experiment groups
	Given I set the activation status of experiment group named {rampLift_NDQ2_scenario} and his experiments to {inactive}
	Given I set the activation status of experiment group named {rampLift_NDQ_scenario} and his experiments to {active}
	Given I set the {units} of campaign name {ramp-lift-auto-campaign1-test} to {1700}
	Given I set the {impressions} in {campaign_lifetime_stats} of campaign name {ramp-lift-auto-campaign1-test} to {0}
	Given I set the {impressions} in {campaign_today_stats} of campaign name {ramp-lift-auto-campaign1-test} to {0}
	And zoneCache refreshed by cmd
	And I sleep for 400 seconds 
	
Scenario: verify NDQ filtering on test experiment level 
    Given I compute the NDQ of campaign name {ramp-lift-auto-campaign1-test}
	When I send 100 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} to UAS
	And I send the same amount of impressions url as the number of NDQ
	
Scenario: verify NDQ filtering on control experiment level 
	Given I set the {units} of campaign name {ramp-lift-auto-campaign1-test} to {2500}	
	Given I set the activation status of experiment group named {rampLift_NDQ_scenario} and his experiments to {inactive}
	Given I set the activation status of experiment group named {rampLift_NDQ2_scenario} and his experiments to {active}
	And I sleep for 400 seconds 
	Given I set the {impressions} in {campaign_lifetime_stats} of campaign name {ramp-lift-auto-campaign1-test} to {0}
	Given I set the {impressions} in {campaign_today_stats} of campaign name {ramp-lift-auto-campaign1-test} to {0}
	And zoneCache refreshed by cmd
    Given I compute the NDQ of campaign name {ramp-lift-auto-campaign1-test}
	When I send 100 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} to UAS
	And I send the same amount of impressions url as the number of NDQ
	Given I set the {units} of campaign name {ramp-lift-auto-campaign1-test} to {-1}	