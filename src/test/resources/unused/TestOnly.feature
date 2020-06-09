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



#  Scenario: 3.0 gdpr=1
#    #When I send 1 times an ad request with parameter {optimize=1} for zone named {INT2434 - Billboard 970x250 - zone234903} to UAS
#    When I send 4 times display ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1} for zone id 192206 to UAS
#    And The response code is 200
#    When I print local time
#    And The impressionUrl has bannerid field matching the id of the banner named {billboardTest-banner-1} 100% of the time

#    Given I clear all cookies from uas requests
#    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
#    Given I add cookie UTID with value {22222222222222222222222222222222} to my impression requests to tracking service
#    And I send impression requests to UAS


#    Given I delete the history of campaign campaign-D-DailyPacing-ST-2 from metering bucket
  #  &&&&&&&&&&&&&&&&&  Eitan need to fix 4
  Scenario: 4. InstreamVid, zone req, vpaid_support=1, not inapp. banner with moat wrapper expected
    When I send 1 times an ad video request with parameter {optimize=1&unlimited=1&domain=dnu-tt&vpaid_support=1&requestid=vidAd} for zone named {zone-zoneset-InstreamVid-View-SP} to UAS
    And The response has a moat wrapper with params advanced string with advertiserid = 22420, ioid = 407981, iolineitemid = 244699, bannername = {campaign-InstreamVid-View-SP-banner-1}, campaignname = {campaign-InstreamVid-View-SP}, zonename = {zone-zoneset-InstreamVid-View-SP}, MoatWEBID = 3708
    And The response contains {&zMoatWEBID=3708}