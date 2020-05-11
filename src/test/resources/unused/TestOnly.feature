@testlocally

Feature: for testing only

  Background: health check
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    And I add deviceid query parameter with value {19381945} to send my requests to uas




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
  Scenario: 2.0 gdpr=0  ---> geo limitation =  san francisco city entity
    When I send 3 times display ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1&bundleid=aaaq1} for zone id 193170 to UAS
    Then The response contains {bannerid}
    And The responses has impression-urls
    Then The response code is 200
    And I send impression requests to UAS



  Scenario: 3.0 gdpr=1
    Given I sleep for 1 seconds
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
#  Scenario: 1.b. verify line items capping enforced when sending zone requests from same user (different cookies) - Passback
    When I send 1 times display ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1&bundleid=aaaq1} for zone id 193170 to UAS
    Then The response code is 200
    Then The response contains {bannerid}

#  Scenario: 3.0
#    Given I delete the history of campaign campaign-D-DailyPacing-ST-2 from metering bucket
   # When I send 1 times an ad request with parameter {unlimited=1&deviceid=2189F809D99&optimize=1&cb=test} for zone named {zone-zoneset-Inapp-SI-5} to UAS
#    Then The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-5-banner-1} 100% of the time