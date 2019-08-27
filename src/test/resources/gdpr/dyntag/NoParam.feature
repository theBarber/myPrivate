@GDPR
@UtConsent
@NoGdprParam
@DynTagNoGdprParam
@parallel
Feature: GDPR - DynTag - Europe Delivery Logic - No Param Is Specified In URL

  @DynTagNoGdprParamEu
  Scenario: DynTag - no params are specified - request from Eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities
    Then I expect req gdpr passback

  @DynTagNoGdprParamNotEu
  Scenario: DynTag - no params are specified - request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities
    Then I expect delivery


