@GDPR
@UtConsent
Feature: GDPR - Europe Delivery Logic - No Gdpr Params Are Specified
  Scenario: zone request from Europe
    Given I send 1 times an ad request for zone id {2} to UAS
    Then The responses are passback
