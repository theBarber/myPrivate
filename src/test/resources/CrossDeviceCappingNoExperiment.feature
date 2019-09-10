@Sanity
@CrossDeviceCapping
@userinfo
@userhistory
@uas
Feature: Cross Device Capping No Experiment
  Background:
    Given I delete the history of 20qxblv735tk3q7yq7nzy8mjm from users bucket
    Given I delete the history of 314dzessmqqc5lby3bhzxcxtf from users bucket
    Given I delete the history of 41hun7qe6bn47gfxgfbzwh938 from users bucket
    Given I clear all cookies from uas requests
  Scenario: test old uas logic
    Given I change IO id {75396} cross device Capping to {active}
    Given I set the activation status of experiment group named {rampLift_NDQ_scenario} and his experiments to {inactive}
    Given I set the activation status of experiment group named {rampLift_capping_scenario} and his experiments to {inactive}
    Then I refresh staging delivery engine data cache

#UTID 44444444444444444444444444444444 to 41hun7qe6bn47gfxgfbzwh938
#UTID 22222222222222222222222222222222 to deviceId 20qxblv735tk3q7yq7nzy8mjm
#UTID 33333333333333333333333333333333 to deviceId 314dzessmqqc5lby3bhzxcxtf
  Scenario: verify campaign capping enforced when sending zone requests from same user (different cookies) - in time frame
    Given I add device 20qxblv735tk3q7yq7nzy8mjm with record <{"upid":"11111111111111111111111111111111", "devices":[{"udid":"20qxblv735tk3q7yq7nzy8mjm"}, {"udid":"314dzessmqqc5lby3bhzxcxtf"}]}> to user info
    Given I add device 314dzessmqqc5lby3bhzxcxtf with record <{"upid":"11111111111111111111111111111111", "devices":[{"udid":"20qxblv735tk3q7yq7nzy8mjm"}, {"udid":"314dzessmqqc5lby3bhzxcxtf"}]}> to user info
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    And I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    When I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    And I send impression requests to UAS immediately
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time
    And I sleep for 1 seconds
    When I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    And I send impression requests to UAS immediately
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time

    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {33333333333333333333333333333333} to my requests to uas
    When I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    And I send impression requests to UAS immediately
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time
    And I sleep for 2 seconds
    When I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: verify campaign capping enforced when sending zone requests from same user (different cookies) - out time frame
    Given I add cookie UTID with value {33333333333333333333333333333333} to my requests to uas
    And I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    And I add stid query parameter with value {1} to send my requests to uas
    When I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    And I send impression requests to UAS immediately
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time


    Given I sleep for 70 seconds

    When I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    And I send impression requests to UAS immediately
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time
    And I send impression requests to UAS immediately
    Given I sleep for 70 seconds

    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    When I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: verify line items capping enforced when sending zone requests from same user (different cookies)
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    And I add zoneid query parameter with value {160092} to send my requests to uas
    And I add ct query parameter with value {1} to send my requests to uas
    And I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    And I add stid query parameter with value {1} to send my requests to uas
    When I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    And I send impression requests to UAS immediately
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {33333333333333333333333333333333} to my requests to uas
    And I add zoneid query parameter with value {160093} to send my requests to uas
    And I sleep for 1 seconds
    When I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift3} to UAS
    And I send impression requests to UAS immediately
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209942-277923-See Through-RampLift-1} 100% of the time

    Given I sleep for 70 seconds

    When I send 2 times an ad request for zone named {INT2434 - See Through - Test-Lift3} to UAS
    And I send impression requests to UAS immediately
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209942-277923-See Through-RampLift-1} 100% of the time
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    And I add zoneid query parameter with value {160092} to send my requests to uas
    And I sleep for 2 seconds
    When I send 2 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    And I send impression requests to UAS immediately
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time
    Given I sleep for 2 seconds
    Given I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: New device (cookie) at first time for new user - capping enforced at device level
    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
    And I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    When I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    And I send impression requests to UAS immediately
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time

    And I sleep for 3 seconds

    When I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: New device (cookie) at first time-> device graph loading weekly process)-> device linked to exiting user->  (send another request  capping enforced at user level
    Given I delete user info record of 41hun7qe6bn47gfxgfbzwh938 from user info
    Given I add cookie UTID with value {44444444444444444444444444444444} to my requests to uas
    And I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    When I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    And I send impression requests to UAS immediately
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time

    And I sleep for 70 seconds

    When I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    And I send impression requests to UAS immediately
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time

    And I sleep for 70 seconds

    When I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: Request from browser without a cookie - verify no capping is enforced & ad is being delivered
    Given I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    When I send 4 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    And I send impression requests to UAS immediately
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time

  Scenario: verify campaign capping enforced when sending zone requests from same user (same cookie) - in time frame
    Given I change IO id {75396} cross device Capping to {inactive}
    Then I refresh staging delivery engine data cache
    And I sleep for 140 seconds

    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    And I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    When I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    And I send impression requests to UAS immediately
    And I sleep for 1 seconds
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time
    Given I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response code is 200
    And The responses are passback



    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {33333333333333333333333333333333} to my requests to uas
    And I send impression requests to UAS immediately
    And I sleep for 2 seconds
    When I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time

  Scenario: verify campaign capping enforced when sending zone requests from same user (same cookie) - out of time frame
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    And I add zoneid query parameter with value {160092} to send my requests to uas
    And I add ct query parameter with value {1} to send my requests to uas
    And I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    And I add stid query parameter with value {1} to send my requests to uas
    When I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time
    And I send impression requests to UAS immediately

    Given I sleep for 70 seconds

    When I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time
    And I send impression requests to UAS immediately
    Given I sleep for 70 seconds

    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {33333333333333333333333333333333} to my requests to uas
    When I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time
    And I send impression requests to UAS immediately

  Scenario: verify line items capping enforced when sending zone requests from same user (same cookie)
    Given I add cookie UTID with value {22222222222222222222222222222222} to my requests to uas
    And I add zoneid query parameter with value {160092} to send my requests to uas
    And I add ct query parameter with value {1} to send my requests to uas
    And I add unlimited query parameter with value {1} to send my requests to uas
    And I add optimize query parameter with value {1} to send my requests to uas
    And I add stid query parameter with value {1} to send my requests to uas
    When I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time
    And I send impression requests to UAS immediately
    And I add zoneid query parameter with value {160093} to send my requests to uas
    When I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift3} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209942-277923-See Through-RampLift-1} 100% of the time
    And I send impression requests to UAS immediately

    Given I sleep for 70 seconds

    And I add zoneid query parameter with value {160092} to send my requests to uas
    When I send 2 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time
    And I send impression requests to UAS immediately
    Given I add zoneid query parameter with value {160093} to send my requests to uas
    When I send 2 times an ad request for zone named {INT2434 - See Through - Test-Lift3} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209942-277923-See Through-RampLift-1} 100% of the time
    And I send impression requests to UAS immediately
    When I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift3} to UAS
    Then The responses are passback
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {33333333333333333333333333333333} to my requests to uas
    When I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift3} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209942-277923-See Through-RampLift-1} 100% of the time
    And I send impression requests to UAS immediately
