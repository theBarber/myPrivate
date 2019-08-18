@GDPR
@UtConsent
@NoGdprParam
@ZoneReqNoGdprParam
Feature: GDPR - Zone Reqs - Europe Delivery Logic - No Param Is Specified In URL

  @ZoneReqNoGdprParamEu
  Scenario: zone req - no params are specified - request from Eu
    Given I add {UK} ip header
    And I send 1 times an ad request for gdpr entities to UAS
    Then I expect gdpr passback
    And I reset the http headers sent to uas

  @ZoneReqNoGdprParamNotEu
  Scenario: zone req - no params are specified - request not from Eu
    Given I send 1 times an ad request for gdpr entities to UAS
    Then I expect delivery
    And I reset the http headers sent to uas
