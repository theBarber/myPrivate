@Sanity
@CrossDeviceCapping
@userinfo
@userhistory
@uas
Feature: Cross Device Capping No Experiment
#  Background:
#    Given I delete the history of 1.20qxblv735tk3q7yq7nzy8mjm from users bucket
#    Given I delete the history of 1.314dzessmqqc5lby3bhzxcxtf from users bucket
#    Given I delete the history of 1.41hun7qe6bn47gfxgfbzwh938 from users bucket
#    Given I clear all cookies from uas requests
#
#  Scenario: test old uas logic
#    Given I change IO id {75396} cross device Capping to {active}
#    Given I set the activation status of experiment group named {rampLift_NDQ_scenario} and his experiments to {inactive}
#    Given I set the activation status of experiment group named {rampLift_capping_scenario} and his experiments to {inactive}
#    Then I refresh delivery-engine cache
#
#  Scenario: verify campaign session capping enforced when sending zone requests from user - in time frame
#    Given I add device 1.20qxblv735tk3q7yq7nzy8mjm with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"}]}}> to user info
#    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
#    And I add unlimited query parameter with value {1} to send my requests to uas
#    And I add optimize query parameter with value {1} to send my requests to uas
#    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-DeviceSessionCapping-ST-1} to UAS
#    And I send impression requests to UAS immediately
#    Then The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceSessionCapping-ST-1-banner-1} 100% of the time
#    And I sleep for 1 seconds
#    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-DeviceSessionCapping-ST-1} to UAS
#    And I send impression requests to UAS immediately
#    Then The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceSessionCapping-ST-1-banner-1} 100% of the time
#    Given I sleep for 70 seconds
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
#    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-DeviceSessionCapping-ST-1} to UAS
#    Then The response code is 200
#    And The responses are passback
#
#
#  Scenario: verify campaign session capping enforced when sending zone requests from same user (different cookies)
#    Given I delete the history of 1.20qxblv735tk3q7yq7nzy8mjm from users bucket
#    Given I add device 1.20qxblv735tk3q7yq7nzy8mjm with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"}, {"udid":"1.314dzessmqqc5lby3bhzxcxtf"}]}}> to user info
#    Given I add device 1.314dzessmqqc5lby3bhzxcxtf with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"}, {"udid":"1.314dzessmqqc5lby3bhzxcxtf"}]}}> to user info
#    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
#    And I add unlimited query parameter with value {1} to send my requests to uas
#    And I add optimize query parameter with value {1} to send my requests to uas
#    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceSessionCapping-ST-2} to UAS
#    And I send impression requests to UAS immediately
#    Then The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceSessionCapping-ST-2-banner-1} 100% of the time
#    And I sleep for 1 seconds
#    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceSessionCapping-ST-2} to UAS
#    And I send impression requests to UAS immediately
#    Then The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceSessionCapping-ST-2-banner-1} 100% of the time
#    Given I sleep for 70 seconds
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {33333333333333333333333333333333} to my requests to uas
#    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceSessionCapping-ST-2} to UAS
#    Then The response code is 200
#    And The responses are passback
#
#  Scenario: verify campaign lifetime capping enforced when sending zone requests from user
#    Given I delete the history of 1.20qxblv735tk3q7yq7nzy8mjm from users bucket
#    Given I add device 1.20qxblv735tk3q7yq7nzy8mjm with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"}]}}> to user info
#    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
#    And I add unlimited query parameter with value {1} to send my requests to uas
#    And I add optimize query parameter with value {1} to send my requests to uas
#    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-DeviceLifetimeCapping-ST-3} to UAS
#    And I send impression requests to UAS immediately
#    Then The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceLifetimeCapping-ST-3-banner-1} 100% of the time
#    And I sleep for 1 seconds
#    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-DeviceLifetimeCapping-ST-3} to UAS
#    And I send impression requests to UAS immediately
#    Then The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceLifetimeCapping-ST-3-banner-1} 100% of the time
#    Given I sleep for 1 seconds
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
#    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-DeviceLifetimeCapping-ST-3} to UAS
#    Then The response code is 200
#    And The responses are passback
#
#
#  Scenario: verify campaign lifetime capping enforced when sending zone requests from same user (different cookies)
#    Given I delete the history of 1.20qxblv735tk3q7yq7nzy8mjm from users bucket
#    Given I delete the history of 1.314dzessmqqc5lby3bhzxcxtf from users bucket
#    Given I add device 1.20qxblv735tk3q7yq7nzy8mjm with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"}, {"udid":"1.314dzessmqqc5lby3bhzxcxtf"}]}}> to user info
#    Given I add device 1.314dzessmqqc5lby3bhzxcxtf with record <{"user-graph": {"upid":"11111111111111111111111111111111", "devices":[{"udid":"1.20qxblv735tk3q7yq7nzy8mjm"}, {"udid":"1.314dzessmqqc5lby3bhzxcxtf"}]}}> to user info
#    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
#    And I add unlimited query parameter with value {1} to send my requests to uas
#    And I add optimize query parameter with value {1} to send my requests to uas
#    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceLifetimeCapping-ST-4} to UAS
#    And I send impression requests to UAS immediately
#    Then The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceLifetimeCapping-ST-4-banner-1} 100% of the time
#    And I sleep for 1 seconds
#    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceLifetimeCapping-ST-4} to UAS
#    And I send impression requests to UAS immediately
#    Then The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceLifetimeCapping-ST-4-banner-1} 100% of the time
#    Given I sleep for 1 seconds
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {33333333333333333333333333333333} to my requests to uas
#    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceLifetimeCapping-ST-4} to UAS
#    Then The response code is 200
#    And The responses are passback
#
#  Scenario: verify multiple campaigns lifetime capping enforced when sending zone requests from same user (different cookies)
#    Given I delete the history of 1.20qxblv735tk3q7yq7nzy8mjm from users bucket
#    Given I delete the history of 1.314dzessmqqc5lby3bhzxcxtf from users bucket
#    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
#    And I add unlimited query parameter with value {1} to send my requests to uas
#    And I add optimize query parameter with value {1} to send my requests to uas
#    And I add stid query parameter with value {1} to send my requests to uas
#    When I send 2 times an ad request for zone named {INT3708-zone-zoneset-DeviceCappingMultipleCampaigns-ST-5} to UAS
#    And I send impression requests to UAS immediately
#    Then The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceCappingMultipleCampaigns-ST-5-banner-1} 100% of the time
#    Given I sleep for 10 seconds
#    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-DeviceCappingMultipleCampaigns-ST-5} to UAS
#    And I send impression requests to UAS immediately
#    Then The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceCappingMultipleCampaigns-ST-6-banner-1} 100% of the time
#    And I send impression requests to UAS immediately
#    Given I sleep for 10 seconds
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {33333333333333333333333333333333} to my requests to uas
#    When I send 10 times an ad request for zone named {INT3708-zone-zoneset-DeviceCappingMultipleCampaigns-ST-5} to UAS
#    And I send impression requests to UAS immediately
#    Then The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceCappingMultipleCampaigns-ST-7-banner-1} 100% of the time
#
#  Scenario: verify line items capping enforced when sending zone requests from same user (different cookies)
#    Given I delete the history of 1.20qxblv735tk3q7yq7nzy8mjm from users bucket
#    Given I delete the history of 1.314dzessmqqc5lby3bhzxcxtf from users bucket
#    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
#    When I send 3 times an ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1} for zone named {INT3708-zone-zoneset-DeviceLiCapping-ST-8} to UAS
#    #And I add zoneid query parameter with value {160092} to send my requests to uas
#    #And I add ct query parameter with value {1} to send my requests to uas
#    #And I add unlimited query parameter with value {1} to send my requests to uas
#    #And I add optimize query parameter with value {1} to send my requests to uas
#    #And I add stid query parameter with value {1} to send my requests to uas
#    #When I send 3 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceCapping-ST-1} to UAS
#    And I send impression requests to UAS immediately
#    Then The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceLiCapping-ST-8-banner-1} 100% of the time
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {33333333333333333333333333333333} to my requests to uas
#    #And I add zoneid query parameter with value {160093} to send my requests to uas
#    And I sleep for 1 seconds
#    When I send 3 times an ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1} for zone named {INT3708-zone-zoneset-DeviceLiCapping-ST-8} to UAS
#    Then The response code is 200
#    And The responses are passback
#
##  Scenario: New device (cookie) at first time for new user - capping enforced at device level
##    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
##    And I add unlimited query parameter with value {1} to send my requests to uas
##    And I add optimize query parameter with value {1} to send my requests to uas
##    When I send 3 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceCapping-ST-1} to UAS
##    And I send impression requests to UAS immediately
##    Then The response contains {script}
##    And The responses has impression-urls
##    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceCapping-ST-1-banner-1} 100% of the time
##
##    And I sleep for 3 seconds
##
##    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceCapping-ST-1} to UAS
##    Then The response code is 200
##    And The responses are passback
#
##  Scenario: New device (cookie) at first time-> device graph loading weekly process)-> device linked to exiting user->  (send another request  capping enforced at user level
##    Given I delete user info record of 1.41hun7qe6bn47gfxgfbzwh938 from user info
##    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
##    And I add unlimited query parameter with value {1} to send my requests to uas
##    And I add optimize query parameter with value {1} to send my requests to uas
##    When I send 3 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceCapping-ST-1} to UAS
##    And I send impression requests to UAS immediately
##    Then The response contains {script}
##    And The responses has impression-urls
##    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceCapping-ST-1-banner-1} 100% of the time
##
##    And I sleep for 70 seconds
##
##    When I send 3 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceCapping-ST-1} to UAS
##    And I send impression requests to UAS immediately
##    Then The response contains {script}
##    And The responses has impression-urls
##    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceCapping-ST-1-banner-1} 100% of the time
##
##    And I sleep for 70 seconds
##
##    When I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceCapping-ST-1} to UAS
##    Then The response code is 200
##    And The responses are passback
#
#  Scenario: Request from browser without a cookie - verify no capping is enforced & ad is being delivered
#    Given I add unlimited query parameter with value {1} to send my requests to uas
#    And I add optimize query parameter with value {1} to send my requests to uas
#    When I send 4 times an ad request for zone named {INT3708-zone-zoneset-DeviceSessionCapping-ST-1} to UAS
#    And I send impression requests to UAS immediately
#    Then The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DeviceSessionCapping-ST-1-banner-1} 100% of the time
#
##  Scenario: verify campaign capping enforced when sending zone requests from same user (same cookie) - in time frame
##    Given I change IO id {75396} cross device Capping to {inactive}
##    Then I refresh delivery-engine cache
##    And I sleep for 140 seconds
##
##    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
##    And I add unlimited query parameter with value {1} to send my requests to uas
##    And I add optimize query parameter with value {1} to send my requests to uas
##    When I send 3 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceCapping-ST-1} to UAS
##    And I send impression requests to UAS immediately
##    And I sleep for 1 seconds
##    Then The response contains {script}
##    And The responses has impression-urls
##    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceCapping-ST-1-banner-1} 100% of the time
##    Given I send 1 times an ad request for zone named {INT3708-zone-zoneset-CrossDeviceCapping-ST-1} to UAS
##    Then The response code is 200
##    And The responses are passback