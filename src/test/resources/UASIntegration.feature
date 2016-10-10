@uas 
Feature: UAS Integration with Ad Selector 
@Sanity 
Scenario: Send an ad request to UAS and parse impression url 
#	Given zone 2 is a test zone
#	Given Manually zone 2 has banner 15 as eligible ad
#	
#	
#	
	Given Campaign Manager with hardcoded campaign 
	##	Given Campaign Manager api
	##	Given Campaign Manager database
	
	#	When I send an ad request for zone named {qa.undertone.com - Full Banner} to UAS 
	
	#	#zone 3	
	#	When I send an ad request for zone named {qa.undertone.com - Half Banner} to UAS
	
	When I send 40 times an ad request for zone named {qa.undertone.com - Full Banner} to UAS 
	
	##   When I send an ad-request for zone {pacing 200} is sent to UAS 
	Then The response code is 200 
	And The responses has impression-urls 
	And The responses has impression-urls 
	And The responses has impression-urls 
#	And The impressionUrl have bannerid field matching the banner id of the banner named {Test Banner1} 100% of the times 
	#	And The impressionUrl have zone field matching the zone id of the zone named {qa.undertone.com - Full Banner} 100% of the times
	#	And The impressionUrl have campaignid field matching the campaign id of the campaign named {999-undefined-undefined-NaN} 100% of the times
	
	#	
	#	
	#    