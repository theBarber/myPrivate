@uas 
Feature: UAS health checks
#UAS should be able to test its connectivity to other components and log failures (if any)

@Sanity 
Scenario: 1. UAS is up 
	When Sending a healthceck request to UAS 
	Then The response code is 200 
	
@Sanity 
Scenario: 2. Uas is connected to RabbitMQ 
	When Sending a healthceck request of RabbitMQ to UAS 
	Then The response code is 200 
	
@Sanity 
Scenario: 3. Uas is connected to Couchbase 
	When Sending a healthceck request of Couchbase to UAS 
	Then The response code is 200 
	
@Sanity 
Scenario: 4. Uas is connected to Redis 
	When Sending a healthceck request of Redis to UAS 
	Then The response code is 200 
	
@Sanity 
Scenario: 5. Uas is connected to Workflow 
	When Sending a healthceck request of Workflow to UAS 
	Then The response code is 200 
	
	
@uas-health-regression 
Scenario: 6. Uas is responsive to zone request 
	When Sending an zone request for 2 to UAS 
	Then The response code is 200 
	And The response contains script 
	And The response has an impression-url 
	And The response has a click-url 
	
	
