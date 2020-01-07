@CCPA
@UtConsent
@SingleCcpaParam
@hbSingleCcpaParam
@hbCcpaConsent
@parallel
Feature: CCPA - Header Bidding Reqs - California Delivery Logic - Us Privacy String Param Specified In URL

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutTrue
  @ccpaOptOutTrueCa
  Scenario: Ccpa Opt-Out={Y} - HB from Ca
    Given I add {CA} ip header
    And I send 1 times Header Bidding request for consent entities with us privacy string containing opt-out=Y
    Then The response code is 204

  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutTrue
  @ccpaOptOutTrueNotCa
  Scenario: Ccpa Opt-Out={Y} - HB not from Ca
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities with us privacy string containing opt-out=Y
    Then The response code is 204

  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutFalse
  @ccpaOptOutTrueCa
  Scenario: Ccpa Opt-Out={N} - HB from Ca
    Given I add {CA} ip header
    And I send 1 times Header Bidding request for consent entities with us privacy string containing opt-out=N
    Then The response code is 200
    And all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutFalse
  @ccpaOptOutTrueNotCa
  Scenario: Ccpa Opt-Out={N} - HB not from Ca
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities with us privacy string containing opt-out=N
    Then The response code is 200
    And all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @ccpa
  @ccpaUtInvalid
  @ccpaOptOutNotApplicable
  @ccpaOptOutNotApplicableCa
  Scenario: Ccpa Opt-Out={-} - HB from Ca
    Given I add {CA} ip header
    And I send 1 times Header Bidding request for consent entities with us privacy string containing opt-out=NOT_APPLICABLE
    Then The response code is 200
    And all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @ccpa
  @ccpaUtInvalid
  @ccpaOptOutNotApplicable
  @ccpaOptOutNotApplicableNotCa
  Scenario: Ccpa Opt-Out={-} - HB not from Ca
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities with us privacy string containing opt-out=NOT_APPLICABLE
    Then The response code is 200
    And all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}
