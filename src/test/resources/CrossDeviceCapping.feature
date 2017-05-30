@Sanity
@CrossDeviceCapping
@userinfo
@userhistory
@uas
Feature: Cross Device Capping


  Scenario: verify campaign capping enforced when sending zone requests from same user (different cookies) - in time frame
    Given add user info record with uspid {uspid} with devices: {deviceId1, deviceId1}
    Given Set device id {deviceId1}
    Given Setting ad request with query parameters: zoneid={zoneid1}, ct={1}, unlimited={1}, optimize={1}, stid={1}
    When I send 6 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 50% of the time

# connect to above scenario
  Scenario: verify campaign capping enforced when sending zone requests from same user (different cookies) - out time frame
    When I sleep for 62 seconds
    And I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift3} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209942-277923-See Through-RampLift-1} 100% of the time
    When I sleep for 62 seconds
    And I send 3 times an ad request for zone named {INT2434 - See Through - Test-Lift3} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209942-277923-See Through-RampLift-1} 0% of the time


  Scenario: verify line items capping enforced when sending zone requests from same user (different cookies)
    Given I clear all cookies from uas requests
    Given I delete the history of uspid from user history
    Given Set device id {deviceId1}
    Given Setting ad request with query parameters: zoneid={zoneid1}, ct={1}, unlimited={1}, optimize={1}, stid={1}
    When I send 6 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 50% of the time
    Given I clear all cookies from uas requests
    Given Set device id {deviceId2}
    Given Setting ad request with query parameters: zoneid={zoneid2}, ct={1}, unlimited={1}, optimize={1}, stid={1}
    When I send 6 times an ad request for zone named {INT2434 - See Through - Test-Lift3} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209942-277923-See Through-RampLift-1} 50% of the time

    Given I sleep for 62 seconds
    When I send 2 times an ad request for zone named {INT2434 - See Through - Test-Lift3} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209942-277923-See Through-RampLift-1} 100% of the time
    Given I clear all cookies from uas requests
    Given Set device id {deviceId1}
    Given Setting ad request with query parameters: zoneid={zoneid1}, ct={1}, unlimited={1}, optimize={1}, stid={1}
    When I send 2 times an ad request for zone named {INT2434 - See Through - Test-Lift2} to UAS
    Then The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-209943-277924-See Through-RampLift-1} 100% of the time

    Given I sleep for 65 seconds
    When I send 1 times an ad request for zone named {INT2434 - See Through - Test-Lift3} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: Upload user graph to couchbase
#    Given I add device 32629a89c46d4d25897386d79d089add with record <{"upid":"10.1.799ba2d329ab2a2fb8a7863a0fa209f2", "devices":[{"udid":"3f9e8d60b5764f2e939722a46a4d7c79"}, {"udid":"32629a89c46d4d25897386d79d089add"}, {"udid":"3f9e8d60b5764f2e939722a46a4d7c79"}]}> to user info graph
#    Then I delete the history of 1591951 from user history
