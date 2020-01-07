@CCPA
@UtConsent
@NoCcpaParam
@hbNoCcpaParam
@hbCcpaConsent
@parallel
Feature: CCPA - Header Bidding Reqs - California Delivery Logic - No Param Is Specified In URL

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @hbNoCcpaParamCa
  Scenario: HB req - no params are specified - from Ca
    Given I add {CA} ip header
    And I send 1 times Header Bidding request for consent entities
    Then The response code is 200
    And all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @hbNoCcpaParamNotCa
  Scenario: HB req - no params are specified - not from Ca
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities
    Then The response code is 200
    And all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}