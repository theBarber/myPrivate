@GDPR
@UtConsent
@NoGdprParam
@hbNoGdprParam
@hbConsent
@parallel
Feature: GDPR - Header Bidding Reqs - Europe Delivery Logic - No Param Is Specified In URL

  @HbNoGdprParamEu
  Scenario: hb req - no params are specified - request from Eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request to UAS for gdpr entities
    Then I expect hbl gdpr passback

  @HbNoGdprParamNotEu
  Scenario: hb req - no params are specified - request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request to UAS for gdpr entities
    Then I expect gdpr hb ad response