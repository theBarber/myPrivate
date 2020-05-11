@testlocally

Feature: for testing only

  Background: health check
    #When Sending a healthcheck request to UAS
    When I send 1 times video ad request with parameter {domain=duration15_skip_yes.com} for zone id 189155 to UAS
    Then The response code is 200



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
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    When I send 1 times display ad request with parameter {optimize=1&gdpr=0} for zone id 192649 to UAS


  Scenario: 3.0 gdpr=1
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    When I send 1 times display ad request with parameter {domain=duration15_skip_yes.com} for zone id 192206 to UAS
    Then The response code is 200


#  Scenario: 3.0
#    Given I delete the history of campaign campaign-D-DailyPacing-ST-2 from metering bucket
   # When I send 1 times an ad request with parameter {unlimited=1&deviceid=2189F809D99&optimize=1&cb=test} for zone named {zone-zoneset-Inapp-SI-5} to UAS
#    Then The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-5-banner-1} 100% of the time