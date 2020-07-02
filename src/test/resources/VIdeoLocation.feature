@parallel
@videoDuration1

Feature: outstream video duration feature

  Background: health check
    When Sending a healthcheck request to UAS
    And I add {NY} ip header
    Then The response code is 200

# %%%%%%%%%%%%%%%%%%%%%%%%%%%  DESKTOP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  Scenario: 1.1.a. For a publisher 3708 which has single domain with 15s video duration & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-large-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback