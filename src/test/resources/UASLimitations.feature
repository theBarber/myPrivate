@uas 
@campaign 
@Sanity 
Feature: UAS limitations filtering 


Background: 
	Given Campaign named {Int-test-FF-targeted}
	Given Campaign named {Int-test-FF-targeted} limitations are {[[~200fgbnsjdfisiodf]]} 
	And Campaign named {Int-test-FF-targeted} is in the zoneset named {Undertone_Testing}
	And Campaign named {Int-test-FF-targeted} has a creative with banner named {Int-test-FF-targeted-banner}
	
	Given Campaign named {Int-test-CH-targeted}
	And Campaign named {Int-test-CH-targeted} is in the zoneset named {Undertone_Testing}
	And Campaign named {Int-test-CH-targeted} has a creative with banner named {Int-test-CH-targeted-banner}
	
	Given Campaign named {Int-test-no-limit}
	And Campaign named {Int-test-no-limit} is in the zoneset named {Undertone_Testing}
	And Campaign named {Int-test-no-limit} has a creative with banner named {Int-test-unlimited-banner}
	
	Given Campaign named {Int-test-check-adselector-default-2}
	And Campaign named {Int-test-check-adselector-default-2} is in the zoneset named {Undertone_Testing}
	And Campaign named {Int-test-check-adselector-default-2} has a creative with banner named {Int-test-adselctor-default-value-2}
	
	Given Campaign named {Int-test-IE-targeted}
	And Campaign named {Int-test-IE-targeted} is in the zoneset named {Undertone_Testing}
	And Campaign named {Int-test-IE-targeted} has a creative with banner named {Int-test-IE-targeted-banner}
	
	Given Zone named {INT2434 - Tracking Pixel (1x1) - _40243_Nexage} is in the zoneset named {Undertone_Testing}
	Given Zone named {INT2434 - Tracking Pixel (1x1) - _40243_Brightroll} is in the zoneset named {Undertone_Testing}
	
Scenario: Upload new plan to S3 
	Given I upload a new solver plan with the following slices 
		| {"buying_strategy_id": -1, "slices": [{"zone_id":${workflow.zone(INT2434 - Tracking Pixel (1x1) - _40243_Nexage)}         ,"slice_id":"${guid}","banner_id":"${workflow.banner(Int-test-FF-targeted-banner)}","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",${workflow.zone(INT2434 - Tracking Pixel (1x1) - _40243_Nexage)}      ]}]},"buy_at_most":2000}]}   |
		| {"buying_strategy_id": -1, "slices": [{"zone_id":${workflow.zone(INT2434 - Tracking Pixel (1x1) - _40243_Nexage)}         ,"slice_id":"${guid}","banner_id":"${workflow.banner(Int-test-CH-targeted-banner)}","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",${workflow.zone(INT2434 - Tracking Pixel (1x1) - _40243_Nexage)}      ]}]},"buy_at_most":2000}]}   |
		| {"buying_strategy_id": -1, "slices": [{"zone_id":${workflow.zone(INT2434 - Tracking Pixel (1x1) - _40243_Nexage)}         ,"slice_id":"${guid}","banner_id":"${workflow.banner(Int-test-IE-targeted-banner)}","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",${workflow.zone(INT2434 - Tracking Pixel (1x1) - _40243_Nexage)}      ]}]},"buy_at_most":1}]}      |
		| {"buying_strategy_id": -1, "slices": [{"zone_id":${workflow.zone(INT2434 - Tracking Pixel (1x1) - _40243_Brightroll)}     ,"slice_id":"${guid}","banner_id":"${workflow.banner(Int-test-FF-targeted-banner)}","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",${workflow.zone(INT2434 - Tracking Pixel (1x1) - _40243_Brightroll)}  ]}]},"buy_at_most":2000}]}   |
		| {"buying_strategy_id": -1, "slices": [{"zone_id":${workflow.zone(INT2434 - Tracking Pixel (1x1) - _40243_Brightroll)}     ,"slice_id":"${guid}","banner_id":"${workflow.banner(Int-test-CH-targeted-banner)}","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",${workflow.zone(INT2434 - Tracking Pixel (1x1) - _40243_Brightroll)}  ]}]},"buy_at_most":2000}]}   |
		| {"buying_strategy_id": -1, "slices": [{"zone_id":${workflow.zone(INT2434 - Tracking Pixel (1x1) - _40243_Brightroll)}     ,"slice_id":"${guid}","banner_id":"${workflow.banner(Int-test-IE-targeted-banner)}","weight":10,"start_time":1478044800,"end_time":1478131199,"predicates":{"AND":[{"==":["body.features.zone_id",${workflow.zone(INT2434 - Tracking Pixel (1x1) - _40243_Brightroll)}  ]}]},"buy_at_most":2000}]}   |
	And I sleep for 70 seconds 
	Then I will be able to start testing 
	
Scenario: limitations testing - Single banner with limitation - positive test 
	Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas 
	When I send 10 times an ad request for zone named {INT2434 - Tracking Pixel (1x1) - _40243_Nexage} to UAS 
	Then The response code is 200 
	And The responses has impression-urls 
	And The impressionUrl has bannerid field matching the id of the banner named {Int-test-FF-targeted-banner} 100% of the time 
	
Scenario: 
	limitations testing - Single banner with limitation - negative test including non-default selection validation 
	Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)} as user-agent string to send my requests to uas 
	When I send 100 times an ad request for zone named {INT2434 - Tracking Pixel (1x1) - _40243_Nexage} to UAS 
	Then The response code is 200 
	And The impressionUrl has bannerid field matching the id of the banner named {Int-test-IE-targeted-banner} 5% of the time 
	And The passback ratio should be 95% 
	
Scenario: 
	limitations testing - 2 banners with limitations - positive + negative tests
	# depends on previous scenario
	 
	Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas 
	When I send 10 times an ad request for zone named {INT2434 - Tracking Pixel (1x1) - _40243_Nexage} to UAS 
	And  All requests are sent 
	Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas 
	When I send 10 additional ad requests for zone named {INT2434 - Tracking Pixel (1x1) - _40243_Nexage} to UAS 
	And  All requests are sent 
	Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)} as user-agent string to send my requests to uas 
	When I send 10 additional ad requests for zone named {INT2434 - Tracking Pixel (1x1) - _40243_Nexage} to UAS 
	Then The response code is 200 
	And The impressionUrl has bannerid field matching the id of the banner named {Int-test-FF-targeted-banner} 33% of the time 
	And The impressionUrl has bannerid field matching the id of the banner named {Int-test-CH-targeted-banner} 33% of the time 
	And The passback ratio should be 33% 
	
Scenario: limitations testing - 3 banners, 2 of them with limitations 
	Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas 
	When I send 50 times an ad request for zone named {INT2434 - Tracking Pixel (1x1) - _40243_Brightroll} to UAS 
	And  All requests are sent 
	Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas 
	When I send 50 additional ad requests for zone named {INT2434 - Tracking Pixel (1x1) - _40243_Brightroll} to UAS 
	And  All requests are sent 
	Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)} as user-agent string to send my requests to uas 
	When I send 50 additional ad requests for zone named {INT2434 - Tracking Pixel (1x1) - _40243_Brightroll} to UAS 
	Then The response code is 200 
	And The responses has impression-urls 
	And The impressionUrl has bannerid field matching the id of the banner named {Int-test-FF-targeted-banner} 17% of the time 
	And The impressionUrl has bannerid field matching the id of the banner named {Int-test-CH-targeted-banner} 17% of the time 
	And The impressionUrl has bannerid field matching the id of the banner named {Int-test-unlimited-banner} 66% of the time 
	
	
	
Scenario: Restore original plan to S3 
	Then I restore the original solver plan 
	And I sleep for 70 seconds 
	And I will finish testing 
	
