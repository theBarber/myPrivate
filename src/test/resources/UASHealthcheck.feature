@Sanity
@uas_healthcheck
@Integration
@uas
Feature: UAS connectivity to other components
	
@Sanity-basic
Scenario: 1. UAS is up 
	When Sending a healthceck request to UAS 
	Then The response code is 200 
@Sanity-basic
Scenario: 2. Uas is connected to RabbitMQ 
	When Sending a healthceck request of RabbitMQ to UAS 
	Then The response code is 200 
@Sanity-basic
Scenario: 3. Uas is connected to Couchbase 
	When Sending a healthceck request of Couchbase to UAS 
	Then The response code is 200 
@Sanity-basic
Scenario: 4. Uas is connected to Redis 
	When Sending a healthceck request of Redis to UAS 
	Then The response code is 200 
@Sanity-basic
Scenario: 5. Uas is connected to Workflow 
	When Sending a healthceck request of Workflow to UAS 
	Then The response code is 200 
	
@campaign 
@hardcoded
@Sanity 
Scenario: 6. Uas is responsive to zone request 
	Given I setup the db
	When I send 1 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} to UAS 
	Then The response code is 200 
	And The response contains script 
	And The response has impression-url 
	And The response has click-url		
