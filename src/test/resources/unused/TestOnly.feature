@testlocally

Feature: for testing only

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: 1.0 just test video zone request
    When I send 1 times video ad request with parameter {domain=duration15_skip_yes.com} for zone id 189155 to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The response contains {https://vast.adsafeprotected.com/vast}

  Scenario: 2.0 just test display zone request
    When I send 1 times display ad request with parameter {domain=abc1937.com} for zone id 189154 to UAS
    Then The response code is 200
    And The response contains {script}

