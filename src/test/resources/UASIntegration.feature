@uas 
@campaign 
@hardcoded 
Feature: UAS E2E Ad request flows (unknown zones) 
Background: 
    Given Campaign Manager with hardcoded campaigns
	
@Sanity 
Scenario: Send an ad request to UAS and parse impression url 
#	Given zone 2 is a test zone
#	Given Manually zone 2 has banner 15 as eligible ad

##	Given Campaign Manager api
##	Given Campaign Manager database

#	When I send an ad request for zone named {qa.undertone.com - Full Banner} to UAS 

#	#zone 3	
#	When I send an ad request for zone named {qa.undertone.com - Half Banner} to UAS

	When I send 40 times an ad request for zone named {qa.undertone.com - Full Banner} to UAS 
	
	##   When I send an ad-request for zone {pacing 200} is sent to UAS 
	Then The response code is 200 
	And The responses has impression-urls 
	And The impressionUrl has bannerid field matching the id of the banner named {Test Banner1} 100% of the time 
	And The impressionUrl has zoneid field matching the id of the zone named {qa.undertone.com - Full Banner} 100% of the time 
	And The impressionUrl has campaignid field matching the id of the campaign named {999-undefined-undefined-NaN} 100% of the time 
	
@Sanity 
Scenario: Send an ad request to UAS and parse impression url (2 banners without limitations)
#	Given zone 3 is a test zone
#	Given Manually zone 3 has banners 15  and 17 as eligible ads


##	Given Campaign Manager api
##	Given Campaign Manager database

#	#zone 3	

	When I send 550 times an ad request for zone named {qa.undertone.com - Half Banner} to UAS 
	Then The response code is 200 
	And The responses has impression-urls 
	And The impressionUrl has bannerid field matching the id of the banner named {Test Banner} 50% of the time 
	And The impressionUrl has bannerid field matching the id of the banner named {Test Banner1} 50% of the time
	And The impressionUrl has zoneid field matching the id of the zone named {qa.undertone.com - Half Banner} 100% of the time 
	And The impressionUrl has campaignid field matching the id of the campaign named {999-undefined-undefined-NaN} 100% of the time 
	And The responses has click-urls 
	And The clickUrl has bannerid field matching the id of the banner named {Test Banner} 50% of the time 
	And The clickUrl has bannerid field matching the id of the banner named {Test Banner1} 50% of the time
	
	#
@Sanity 
@aharon 
@cli 
Scenario: Send an ad request to UAS and parse logs 
	When I send 1 times an ad request for zone named {qa.undertone.com - Full Banner} to UAS 
	And The responses has impression-urls 
	And I send impression requests to UAS 
	# And sleep for 70 seconds 
	Then I read the latest imp log file from uas 
#	Then ZoneRequestId at column 1 is the same as in impression-url
	Then I filter in the imp log to the lines where id at column 0 is the same as in impression-url 
	#	And zoneId with 2 exists in log in the 4 column
	#	And Banner with 15 exists in log in the 5 column
	#	And Campaign with 2 exists in log in the 6 column
	#	And experiment with 1234 exists in log in the 47 column
	#	When Reading the impression log files
	#	Then ZoneRequestId at column 1 is the same as in impression-url
	#	And experiment with 1234 exists in log in the 5 column
	#	When Reading the click log files
	#	Then ZoneRequestId at column 1 is the same as in impression-url
	#	And zoneId with 2 exists in log in the 4 column
	#	And Banner with 15 exists in log in the 5 column
	#	And experiment with 1234 exists in log in the 27 column
	#	#