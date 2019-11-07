@Sanity
@CrossDeviceCapping
@userinfo
@userhistory
@headerBidding
@uas
@parallel
Feature: Cross Device Capping Experiment

  Background:
    Given I delete the history of 1.20qxblv735tk3q7yq7nzy8mjm from users bucket
    Given I delete the history of 1.314dzessmqqc5lby3bhzxcxtf from users bucket
    Given I delete the history of 1.41hun7qe6bn47gfxgfbzwh938 from users bucket
    Given I delete the history of 2.yanivCappingTest from users bucket
    Given I delete the history of 1.20qxblv735tk3q7yq7nzy8mjm from user logs bucket
    Given I delete the history of 1.314dzessmqqc5lby3bhzxcxtf from user logs bucket
    Given I delete the history of 1.41hun7qe6bn47gfxgfbzwh938 from user logs bucket
    Given I delete the history of 2.yanivCappingTest from user logs bucket
    Given I clear all cookies from uas requests

  Scenario: verify line items capping enforced when sending zone requests from same user (different cookies)
    Given I add device 1.20qxblv735tk3q7yq7nzy8mjm with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"}, {"udid":"1.314dzessmqqc5lby3bhzxcxtf"}]}}> to user info
    Given I add device 1.314dzessmqqc5lby3bhzxcxtf with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"}, {"udid":"1.314dzessmqqc5lby3bhzxcxtf"}]}}> to user info
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    When I send 3 times an ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1} for zone named {INT3708-zone-zoneset-DeviceLiCapping-ST-8} to UAS
    And I send impression requests to UAS immediately
    Then The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceLiCapping-ST-8-banner-1} 100% of the time
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {33333333333333333333333333333333} to my requests to uas
    And I sleep for 1 seconds
    When I send 3 times an ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1} for zone named {INT3708-zone-zoneset-DeviceLiCapping-ST-8} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: verify campaign session capping enforced when sending zone requests from user - in time frame
    Given I add device 1.20qxblv735tk3q7yq7nzy8mjm with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"},{"udid":"2.41hun7qe6bn47gfxgfbzwh938"}]}}> to user info
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    And I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-DeviceSessionCapping-ST-1} to UAS
    Then The response contains {script}
    Then The response contains {has_capping=1}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceSessionCapping-ST-1-banner-1} 100% of the time
    And I send impression requests to UAS immediately
    And I sleep for 1 seconds
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-DeviceSessionCapping-ST-1} to UAS
    Then The response contains {script}
    Then The response contains {has_capping=1}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceSessionCapping-ST-1-banner-1} 100% of the time
    And I send impression requests to UAS immediately
    Given I sleep for 10 seconds
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-DeviceSessionCapping-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: verify campaign session capping enforced when sending zone requests from user using inapp - in time frame
    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1&deviceid=yanivCappingTest} for zone named {INT3708-zone-zoneset-DeviceSessionCapping-Inapp-ST-9} to UAS
    Then The response contains {script}
    Then The response contains {has_capping=1}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceSessionCapping-Inapp-ST-9-banner-1} 100% of the time
    And I send impression requests to UAS immediately
    And I sleep for 1 seconds
    When I send 1 times an ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1&deviceid=yanivCappingTest} for zone named {INT3708-zone-zoneset-DeviceSessionCapping-Inapp-ST-9} to UAS
    Then The response contains {script}
    Then The response contains {has_capping=1}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceSessionCapping-Inapp-ST-9-banner-1} 100% of the time
    And I send impression requests to UAS immediately
    Given I sleep for 10 seconds
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1&deviceid=yanivCappingTest} for zone named {INT3708-zone-zoneset-DeviceSessionCapping-Inapp-ST-9} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: verify campaign session capping enforced when sending zone requests from same user (different cookies)
    Given I add device 1.20qxblv735tk3q7yq7nzy8mjm with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"}, {"udid":"1.314dzessmqqc5lby3bhzxcxtf"}]}}> to user info
    Given I add device 1.314dzessmqqc5lby3bhzxcxtf with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"}, {"udid":"1.314dzessmqqc5lby3bhzxcxtf"}]}}> to user info
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    And I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceSessionCapping-ST-2} to UAS
    Then The response contains {script}
    Then The response contains {has_capping=1}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceSessionCapping-ST-2-banner-1} 100% of the time
    And I send impression requests to UAS immediately
    And I sleep for 1 seconds
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceSessionCapping-ST-2} to UAS
    Then The response contains {script}
    Then The response contains {has_capping=1}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceSessionCapping-ST-2-banner-1} 100% of the time
    And I send impression requests to UAS immediately
    Given I sleep for 10 seconds
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {33333333333333333333333333333333} to my requests to uas
    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceSessionCapping-ST-2} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: verify campaign lifetime capping enforced when sending zone requests from user
    Given I add device 1.20qxblv735tk3q7yq7nzy8mjm with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"}]}}> to user info
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    And I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-DeviceLifetimeCapping-ST-3} to UAS
    Then The response contains {script}
    Then The response contains {has_capping=1}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceLifetimeCapping-ST-3-banner-1} 100% of the time
    And I send impression requests to UAS immediately
    And I sleep for 1 seconds
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-DeviceLifetimeCapping-ST-3} to UAS
    Then The response contains {script}
    Then The response contains {has_capping=1}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceLifetimeCapping-ST-3-banner-1} 100% of the time
    And I send impression requests to UAS immediately
    Given I sleep for 1 seconds
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-DeviceLifetimeCapping-ST-3} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: verify campaign lifetime capping enforced when sending zone requests from same user (different cookies)
    Given I add device 1.20qxblv735tk3q7yq7nzy8mjm with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"}, {"udid":"1.314dzessmqqc5lby3bhzxcxtf"}]}}> to user info
    Given I add device 1.314dzessmqqc5lby3bhzxcxtf with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"}, {"udid":"1.314dzessmqqc5lby3bhzxcxtf"}]}}> to user info
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    And I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceLifetimeCapping-ST-4} to UAS
    And I send impression requests to UAS immediately
    Then The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceLifetimeCapping-ST-4-banner-1} 100% of the time
    And I sleep for 1 seconds
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceLifetimeCapping-ST-4} to UAS
    And I send impression requests to UAS immediately
    Then The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceLifetimeCapping-ST-4-banner-1} 100% of the time
    Given I sleep for 1 seconds
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {33333333333333333333333333333333} to my requests to uas
    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceLifetimeCapping-ST-4} to UAS
    Then The response code is 200
    And The responses are passback


##-----#  Scenario: New device (cookie) at first time for new user - capping enforced at device level
###    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
###    And I add unlimited query parameter with value {1} to send my requests to uas
###    And I add optimize query parameter with value {1} to send my requests to uas
###    When I send 3 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceCapping-ST-1} to UAS
###    And I send impression requests to UAS immediately
###    Then The response contains {script}
###    And The responses has impression-urls
###    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceCapping-ST-1-banner-1} 100% of the time
###
###    And I sleep for 3 seconds
###
###    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceCapping-ST-1} to UAS
###    Then The response code is 200
###    And The responses are passback
##
#
  Scenario: Request from browser without a cookie - verify no capping is enforced & ad is being delivered
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    When I send 4 times an ad request for zone named {INT3708-zone-zoneset-DeviceSessionCapping-ST-1} to UAS
    And I send impression requests to UAS immediately
    Then The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceSessionCapping-ST-1-banner-1} 100% of the time

  Scenario: header bidding frequency capping from mobile - user 1
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    #Given I add cookie UTID with random value to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    Then The response contains {ut.has_capping='1'}
    #And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS
    Given I sleep for 3 seconds
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    Then The response contains {ut.has_capping='1'}
    #And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from Desktop user 1
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS
    Given I sleep for 3 seconds
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS
    Given I sleep for 3 seconds
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from mobile - user 2
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
    #Given I add cookie UTID with random value to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS
    Given I sleep for 3 seconds
    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS
    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from Desktop user 2
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS
    Given I sleep for 3 seconds
    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS
    Given I sleep for 3 seconds
    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And all HB responses contains adId with value {0}

  Scenario: header bidding - no capping
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 10 headerBidding post request for scenario {send basic HB request for publisher 3470} for publisher 3470 with domain {ranker.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    Then The response contains {ut.has_capping='0'}