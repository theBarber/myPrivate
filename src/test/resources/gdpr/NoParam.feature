@GDPR
@UtConsent
@NoGdprParam
Feature: GDPR - Europe Delivery Logic - No Param Is Specified In URL

  Scenario: no params are specified - request from Eu
    Given I add header of {X-Forwarded-For} with value {193.117.138.126}
    And I send 1 times an ad request for zone id {2} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: no params are specified - request not from Eu
    Given I send 1 times an ad request for zone id {2} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
