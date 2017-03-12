@uas
@Sanity
Feature: UAS connectivity to other components
@Sanity-basic
Scenario: 1. UAS is up 
	When Sending a healthceck request to UAS 
	Then The response code is 200 
	
Scenario: 2. Uas is connected to RabbitMQ 
	When Sending a healthceck request of RabbitMQ to UAS 
	Then The response code is 200 
	
Scenario: 3. Uas is connected to Couchbase 
	When Sending a healthceck request of Couchbase to UAS 
	Then The response code is 200 
	
Scenario: 4. Uas is connected to Redis 
	When Sending a healthceck request of Redis to UAS 
	Then The response code is 200 
	
Scenario: 5. Uas is connected to Workflow 
	When Sending a healthceck request of Workflow to UAS 
	Then The response code is 200 
	
@campaign 
@hardcoded
@Sanity 
Scenario: 6. Uas is responsive to zone request 
	#Given Campaign named {Test Advertiser - Remnant Campaign} 
	#Given Creative named "Billboard 970x250 - Automation Test 1" with adunitId {58}, similar to {HTML1326} 
	#And Campaign named {Test Advertiser - Remnant Campaign} has an assosiation to the creative named {Billboard 970x250 - Automation Test 1} which gives the banner named {Test Banner1}  
	#And Campaign named {Test Advertiser - Remnant Campaign} has an assosiation to the creative named {Billboard 970x250 - Automation Test 1} which gives the banner named {Test Banner2}
	#And Campaign named {Test Advertiser - Remnant Campaign} has a creative with banner named {Test Banner1} 
	#And Campaign named {Test Advertiser - Remnant Campaign} has a creative with banner named {Test Banner2} 
	#And Campaign named {Test Advertiser - Remnant Campaign} is in the zoneset named {hwu zonesets} 
	#And Zone named {qa.undertone.com - Full Banner} is in the zoneset named {hwu zonesets} 
	When I send 1 times an ad request for zone named {INT2434 - Medium Rectangle 300x250 - ramp-lift-auto-zone1-test} to UAS 
	Then The response code is 200 
	And The response contains script 
	And The response has impression-url 
	And The response has click-url 
	
	
#Scenario: 6. Uas is responsive to zone request 
#	Given Campaign named {Test Advertiser - 75396-198082-Billboard-1} 
#	And Campaign named {Test Advertiser - Remnant Campaign} has a creative with banner named {Test Banner1} 
#	And Campaign named {Test Advertiser - Remnant Campaign} has a creative with banner named {Test Banner2} 
#	And Campaign named {Test Advertiser - Remnant Campaign} is in the zoneset named {hwu zonesets} 
#	And Zone named {qa.undertone.com - Full Banner} is in the zoneset named {hwu zonesets} 
#	When I send 1 times an ad request for zone named {qa.undertone.com - Full Banner} to UAS 
#	Then The response code is 200 
#	And The response contains script 
#	And The response has impression-url 
#	And The response has click-url 
#		
