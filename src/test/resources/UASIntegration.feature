@uas
Feature: UASIntegration 
@Sanity
Scenario: Send request to UAS and parse result from AdSelector 
#	Given zone 2 is a test zone
#	Given Manually zone 2 has banner 15 as eligible ad
#	
#	
#	
	Given Campaign Manager with hardcoded campaign
##	Given Campaign Manager api
#	Given Publisher Manager with hardcoded zones
##	Given Publisher Manager api
#
	When I send an ad request for zone {qa.undertone.com - Full Banner} to UAS
#	When I send 40 times an ad-request for zone {qa.undertone.com - Full Banner} to UAS
	
##   When I send an ad-request for zone {pacing 200} is sent to UAS 
	Then The response code is 200 
#	And The response has an impression-url 
#	And The impressionUrl requests have bannerid field for {Test Banner1} 100% of the times 
#	
#	
#    