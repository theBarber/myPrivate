@uas
@campaign
Feature: UAS E2E Ad request flows (unknown zones) 

@Sanity
Background:
	Given Campaign named {Test Advertiser - Remnant Campaign}
	And Campaign named {Test Advertiser - Remnant Campaign} has a creative with banner named {Test Banner1}
	And Campaign named {Test Advertiser - Remnant Campaign} has a creative with banner named {Test Banner2}
	And Campaign named {Test Advertiser - Remnant Campaign} is in the zoneset named {hwu zonesets}
	Given Zone named {qa.undertone.com - Full Banner} is in the zoneset named {hwu zonesets}
	#	Given Zone named {qa.undertone.com - Half Banner} is in the zoneset named {hwu zonesets}
	
Scenario: Send an ad request to UAS and parse impression url 
	When I send 40 times an ad request for zone named {qa.undertone.com - Full Banner} to UAS
	
	##   When I send an ad-request for zone {pacing 200} is sent to UAS 
	Then The response code is 200
	And The responses has impression-urls
	And The impressionUrl has bannerid field matching the id of the banner named {Test Banner1} 100% of the time
	And The impressionUrl has zoneid field matching the id of the zone named {qa.undertone.com - Full Banner} 100% of the time
	And The impressionUrl has campaignid field matching the id of the campaign named {Test Advertiser - Remnant Campaign} 100% of the time
	
Scenario:
	Send ad requests to UAS and parse impression url - 2 banners without limitations
	Given Zone named {qa.undertone.com - Half Banner} is in the zoneset named {hwu zonesets}
	When I send 550 times an ad request for zone named {qa.undertone.com - Half Banner} to UAS
	Then The response code is 200
	# And The responses has impression-urls
	And The impressionUrl has bannerid field matching the id of the banner named {Test Banner1} 50% of the time 
	And The impressionUrl has bannerid field matching the id of the banner named {Test Banner2} 50% of the time 
	And The impressionUrl has zoneid field matching the id of the zone named {qa.undertone.com - Half Banner} 100% of the time 
	And The impressionUrl has campaignid field matching the id of the campaign named {Test Advertiser - Remnant Campaign} 100% of the time 
	And The responses has click-urls 
	And The clickUrl has bannerid field matching the id of the banner named {Test Banner} 50% of the time 
	And The clickUrl has bannerid field matching the id of the banner named {Test Banner1} 50% of the time 
	
	#
@cli 
Scenario: Send an ad request to UAS and parse logs 
	Given Zone named {qa.undertone.com - Full Banner}
	When I send 1 times an ad request for zone named {qa.undertone.com - Full Banner} to UAS 
	And The response has impression-url 
	And The response has click-url 
	When I send impression requests to UAS 
	And I sleep for 120 seconds 
	
	Then I read the latest req log file from uas 
	Then I filter in the req log to the lines where id at column 1 is the same as in impression-url 
	And The field zoneid in the 4 column of the req log is the same as in impression-url 
	And The field bannerid in the 5 column of the req log is the same as in impression-url 
	And The field campaignid in the 6 column of the req log is the same as in impression-url 
	
	Then I read the latest imp log file from uas 
	And I filter in the imp log to the lines where id at column 1 is the same as in impression-url 
	When I send click requests to UAS 
	Then I read the latest clk log file from uas 
	And I filter in the clk log to the lines where id at column 1 is the same as in impression-url 
