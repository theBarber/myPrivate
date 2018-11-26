@Sanity
@uas_healthcheck
@Integration
@uas
@scheduled
@parallel
@noAA

Feature: UAS connectivity to other components
@stable
@Sanity-basic
Scenario: 1. UAS is up
	When Sending a healthcheck request to UAS
	Then The response code is 200
@stable
@Sanity-basic
Scenario: 2. Uas is connected to RabbitMQ
	When Sending a healthcheck request of RabbitMQ to UAS
	Then The response code is 200
@stable
@Sanity-basic
Scenario: 3. Uas is connected to Couchbase
	When Sending a healthcheck request of Couchbase to UAS
	Then The response code is 200
@stable
@Sanity-basic
Scenario: 4. Uas is connected to Redis
	When Sending a healthcheck request of Redis to UAS
	Then The response code is 200
@stable
@Sanity-basic
Scenario: 5. Uas is connected to Workflow
	When Sending a healthcheck request of Workflow to UAS
	Then The response code is 200

#	@campaign
#	@hardcoded
#	@Sanity
#	@stable
#	Scenario: delay
#		When I sleep for 100 seconds


#@campaign
#@hardcoded
#@Sanity
#@stable
#Scenario: 6. Uas is responsive to zone request
#	When I send 10 times an ad request with parameter {unlimited=1&requestid=yaniv} for zone named {INT2434 - See Through - RAMP Lift Test 1} to UAS
#	Then The response code is 200
#	And The response contains script
#	And The response has impression-url
#	And I send impression requests to UAS immediately!
#	And The response has click-url

#@campaign
#@hardcoded
#@Sanity
#@Stress
#Scenario: 7. Uas is responsive to a lot of zone requests
#	When I send 500 times an ad request with parameter {unlimited=1&requestid=yaniv} for zone named {INT2434 - See Through - RAMP Lift Test 1} to UAS
#	Then The response code is 200
#	And The response contains script
#	And The response has impression-url
#	And The response has click-url




