@NDQFiltering
@campaign
@hardcoded
@ramp_admin_db
@workflow_db
@cli
@uas	
Feature: NDQ filtering validation

#Background: setup
#	Given I setup the db

Scenario: verify NDQ filtering on test experiment level
	Given Unable all experiment groups except experimentID 10
	Given I set the activation status of experiment named {ramp-lift-control-flow} to {0}
	And I set the activation status of experiment named {ramp-lift-optimize-flow} to {1}
	And I restart {ramp-lift-services}
	And I sleep for 60 seconds
	Given I set the {units} of campaign name {ramp-lift-auto-campaign1-test} to {3000}
	Given I set the {impressions} in {campaign_lifetime_stats} of campaign name {ramp-lift-auto-campaign1-test} to {0}
	Given I set the {impressions} in {campaign_today_stats} of campaign name {ramp-lift-auto-campaign1-test} to {0}
	And zoneCache refreshed by http
	And I update the s3 experiment data
	Then I refresh staging delivery engine data cache
	And I sleep for 150 seconds 
    Given I compute the NDQ of campaign name {ramp-lift-auto-campaign1-test}
	When I send 100 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} to UAS
	And I send the same amount of impressions url as the number of NDQ
	
Scenario: verify NDQ filtering on control experiment level
	Given Unable all experiment groups except experimentID 10
	Given I set the activation status of experiment named {ramp-lift-control-flow} to {1}
	And I set the activation status of experiment named {ramp-lift-optimize-flow} to {0}
	And I restart {ramp-lift-services}
	And I sleep for 60 seconds
	Given I set the {units} of campaign name {ramp-lift-auto-campaign1-test} to {4000}	
	Given I set the {impressions} in {campaign_lifetime_stats} of campaign name {ramp-lift-auto-campaign1-test} to {0}
	Given I set the {impressions} in {campaign_today_stats} of campaign name {ramp-lift-auto-campaign1-test} to {0}
	And zoneCache refreshed by http
	And I update the s3 experiment data
	Then I refresh staging delivery engine data cache
	And I sleep for 150 seconds 
    Given I compute the NDQ of campaign name {ramp-lift-auto-campaign1-test}
	When I send 100 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} to UAS
	And I send the same amount of impressions url as the number of NDQ
