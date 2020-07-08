@testlocally

Feature: test1

  Background:
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    When Sending a healthcheck request to UAS
    Then The response code is 200




#  Scenario: zone req - no params are specified - request from Eu
#    Given I add {UK} ip header
#    And I send 1 times an ad request for consent entities to UAS
#    Then I expect req consent passback

#  Scenario: 1.0 just test video zone request
#    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
#    When I send 1 times an ad request for zone id 192494 to UAS
#    Then The response code is 200
#    And The response contains {float: 'bottom-right'}
#    And The response contains {placement: '98'}
#
  Scenario: 3. non outstream entitiy - should not contain float string
    #Given I reset metering bucket record of campaign campaign-D-DailyPacing-ST-2
    And I sleep for 1 seconds
    When I send 15 times an ad request with parameter {unlimited=1&domain=pacing.houry.direct&optimize=1} for zone named {zone-zoneset-D-DailyPacing-ST-2} to UAS
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-D-DailyPacing-ST-2-banner-1} 100% of the time
    And I send impression requests to UAS
    And I sleep for 1 seconds
    When I send 1 times an ad request with parameter {unlimited=1&domain=pacing.houry.direct&optimize=1} for zone named {zone-zoneset-D-DailyPacing-ST-2} to UAS
    And The response code is 200
    And The responses are passback

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
