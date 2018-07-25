	@Integration
	@cli
	@uas
    @stable
    @scheduled
	Feature: UAS Ad request flows
	@Sanity
	Scenario: Send an ad request to UAS and parse impression url
        When I send 10 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through - RAMP Lift Test 1} to UAS
		Then The response code is 200
	 	And The response contains script
		And The responses has impression-urls
		And The impressionUrl has bannerid field matching the id of the banner named {75396-210722-278956-See Through-RampLift-1} 100% of the time
		And The impressionUrl has zoneid field matching the id of the zone named {INT2434 - See Through - RAMP Lift Test 1} 100% of the time
		And The impressionUrl has campaignid field matching the id of the campaign named {75396-210722-ramp-lift-Test 1} 100% of the time
		And The responses has click-urls
		And The clickUrl has bannerid field matching the id of the banner named {75396-210722-278956-See Through-RampLift-1} 100% of the time

	Scenario: Send an ad request to UAS and parse logs
		Given I Delete req logs
		Given I Delete imp logs
		Given I clear all cookies from uas requests
		Given I add cookie UTID with value {d7a8b8faf42446dcbba4248cef7dc7bb} to my requests to uas
		When I send 11 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through - RAMP Lift Test 1} to UAS
		Then The response code is 200
		And The response has impression-url
		And The response has click-url
		When I send impression requests to UAS
		And I sleep for 5 seconds
		Then I read the latest req log file from uas
		Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
		And The field zoneid in the 4 column of the req log is the same as in impression-url
		And The field bannerid in the 5 column of the req log is the same as in impression-url
		And The field campaignid in the 6 column of the req log is the same as in impression-url
	    And The field Base36UTID in the 3 column of the req log is: crmqauo6r8fzyognwjt45rem3
		And I sleep for 5 seconds
		Then I read the latest imp log file from uas
		And I filter in the imp log to the lines where id at column 1 is the same as in impression-url
		And The field Base36UTID in the 3 column of the imp log is: crmqauo6r8fzyognwjt45rem3
		Given I Delete clk logs
		When I send click requests to UAS
		And I sleep for 5 seconds
		Then I read the latest clk log file from uas
		And I filter in the clk log to the lines where id at column 1 is the same as in impression-url
		And The field Base36UTID in the 3 column of the clk log is: crmqauo6r8fzyognwjt45rem3
        Given I Delete evt logs
        Given I send 2 times an event log request with parameters {bannerid=1213419&campaignid=300008&zoneid=178707&clang=en&ccat=2261,3802,5198,5248,5252,7432,7435,7496,7510,7526,7528,7529,7531,7541,7545,7546,7548,7549,7553,7554,9448,10288,12393,12752,12940,13475,15963,16621,16951,17114,17183,17186,17191,17433,17764,17845,17869,18161,18208,18853,19047,20812,20838,21314,21316,21318,21319,24146,24184,25086,32793,32851,33128&cb=323bc19ef9784d82b8b1c905d7bb0243&bk=p6r9eb&id=2fnr92i6abl9yws97kypzwot3&stid=109&uasv=v22&st=https%3A%2F%2Fwww.blackpoolgazette.co.uk%2Fnews%2Fcrime%2Fresort-police-surround-house-after-man-stabbed-1-9101170&e=MOAT.full-measurable&ord=1523004007976&replay=1} to UAS
        And I sleep for 2 seconds
        Then I read the latest evt log file from uas
        And The field Base36UTID in the 7 column of the evt log is: crmqauo6r8fzyognwjt45rem3

		Scenario: device id is written to the logs
          Given I Delete req logs
          Given I Delete imp logs
		  Given I add cookie UTID with value {d7a8y8ftf42446dcbba4248cef7dc7bb} to my requests to uas
          When I send 11 times an ad request with parameter {unlimited=1&deviceid=SaharTest} for zone named {INT2434 - See Through - RAMP Lift Test 1} to UAS
          Then The response code is 200
          And The response has impression-url
          And The response has click-url
          When I send impression requests to UAS
          And I sleep for 5 seconds
          Then I read the latest req log file from uas
          Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
          And The field zoneid in the 4 column of the req log is the same as in impression-url
          And The field bannerid in the 5 column of the req log is the same as in impression-url
          And The field campaignid in the 6 column of the req log is the same as in impression-url
          And The field deviceID in the 3 column of the req log is: SaharTest
          And I sleep for 5 seconds
          Then I read the latest imp log file from uas
          And I filter in the imp log to the lines where id at column 1 is the same as in impression-url
          And The field deviceID in the 3 column of the imp log is: SaharTest
          Given I Delete clk logs
          When I send click requests to UAS
          And I sleep for 5 seconds
          Then I read the latest clk log file from uas
          And I filter in the clk log to the lines where id at column 1 is the same as in impression-url
          And The field deviceID in the 3 column of the clk log is: SaharTest
          Given I Delete evt logs
          Given I send 2 times an event log request with parameters {deviceid=SaharTest&bannerid=1213419&campaignid=300008&zoneid=178707&clang=en&ccat=2261,3802,5198,5248,5252,7432,7435,7496,7510,7526,7528,7529,7531,7541,7545,7546,7548,7549,7553,7554,9448,10288,12393,12752,12940,13475,15963,16621,16951,17114,17183,17186,17191,17433,17764,17845,17869,18161,18208,18853,19047,20812,20838,21314,21316,21318,21319,24146,24184,25086,32793,32851,33128&cb=323bc19ef9784d82b8b1c905d7bb0243&bk=p6r9eb&id=2fnr92i6abl9yws97kypzwot3&stid=109&uasv=v22&st=https%3A%2F%2Fwww.blackpoolgazette.co.uk%2Fnews%2Fcrime%2Fresort-police-surround-house-after-man-stabbed-1-9101170&e=MOAT.full-measurable&ord=1523004007976&replay=1} to UAS
          And I sleep for 2 seconds
          Then I read the latest evt log file from uas
          And The field User_identifier in the 7 column of the evt log is: SaharTest

