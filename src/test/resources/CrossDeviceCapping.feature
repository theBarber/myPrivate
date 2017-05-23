@Sanity
@CrossDeviceCapping
@userinfo
Feature: Cross Device Capping

  Scenario: Upload user graph to couchbase
    Given I add device 32629a89c46d4d25897386d79d089add with record <{"upid":"10.1.799ba2d329ab2a2fb8a7863a0fa209f2", "devices":[{"udid":"3f9e8d60b5764f2e939722a46a4d7c79"}, {"udid":"32629a89c46d4d25897386d79d089add"}, {"udid":"3f9e8d60b5764f2e939722a46a4d7c79"}]}> to user info graph
