@GDPR
@UtConsent
@NoGdprParam
@hbNoGdprParam
@hbConsent
@parallel
Feature: GDPR - Header Bidding Reqs - Europe Delivery Logic - No Param Is Specified In URL

  @hbNoGdprParamEu
  Scenario: hb req - no params are specified - request from Eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for gdpr entities
    Then I expect hbl gdpr passback

  @hbNoGdprParamNotEu
  Scenario: hb req - no params are specified - request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for gdpr entities
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}
