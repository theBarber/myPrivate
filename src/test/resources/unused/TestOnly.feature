@testlocally

Feature: for testing only

#  Background: health check
#    Given I delete the history of 1.person6258 from user logs bucket
    #And I add deviceid query parameter with value {19381945} to send my requests to uas




#  Scenario: zone req - no params are specified - request from Eu
#    Given I add {UK} ip header
#    And I send 1 times an ad request for consent entities to UAS
#    Then I expect req consent passback

#  Scenario: 1.0 just test video zone request  -  193.117.138.126
#    When I send 1 times video ad request with parameter {domain=duration15_skip_yes.com} for zone id 189155 to UAS
#    Then The response code is 200
#    And The response contains {VASTAdTagURI}
#    And The response contains {https://vast.adsafeprotected.com/vast}
#
#  Scenario: 2.0 gdpr=0  ---> geo limitation =  san francisco city entity
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {92B1BB139A75C} to my requests to uas
#    When I send 4 times display ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1} for zone id 192206 to UAS
#    Then The response contains {bannerid}
#    And The responses has impression-urls
#    Then The response code is 200
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {92B1BB139A75C} to my impression requests to tracking service
#    And I send impression requests to UAS
#    #And I sleep for 3 seconds
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {92B1BB139A75C} to my requests to uas
#    When I send 4 times display ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1} for zone id 192206 to UAS
#    And The responses are passback



  Scenario: 3.0 gdpr=1
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    Then The response contains {1471678}
#    Given I clear all cookies from uas requests
#    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
#    Given I add cookie UTID with value {22222222222222222222222222222222} to my impression requests to tracking service
#    And I send impression requests to UAS

#  Scenario: 3.0
#    Given I delete the history of campaign campaign-D-DailyPacing-ST-2 from metering bucket
   # When I send 1 times an ad request with parameter {unlimited=1&deviceid=2189F809D99&optimize=1&cb=test} for zone named {zone-zoneset-Inapp-SI-5} to UAS
#    Then The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-5-banner-1} 100% of the time