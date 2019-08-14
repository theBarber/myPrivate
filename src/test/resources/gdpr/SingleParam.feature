@GDPR
@UtConsent
@SingleGdprParam
Feature: GDPR - Europe Delivery Logic - Single Gdpr Param Is Specified In URL

  Scenario: gdpr=1 - zone request from Eu
    Given I add header of {X-Forwarded-For} with value {193.117.138.126}
    And I send 1 times an ad request with parameter {gdpr=1} for zone id {2} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: gdpr=1 - zone request not from Eu
    Given I send 1 times an ad request with parameter {gdpr=1} for zone id {2} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: gdpr=0 - request from Eu
    Given I
    And I send 1 times an ad request with parameter {gdpr=0} for zone id {2} to UAS
    Then The response code is 200
    And The response contains script

  Scenario: gdpr=0 - request not from Eu