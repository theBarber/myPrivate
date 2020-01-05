@CCPA
@UtConsent
@ZoneReqSingleCcpaParam
@ZoneReqCcpaConsent
@parallel
Feature: CCPA - Zone Reqs - California Delivery Logic - Us Privacy String Param Is Specified In URL

  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutTrue
  @ccpaOptOutTrueCa
  Scenario: Ccpa Opt-Out={Y} - zone request from Ca
    Given I add {CA} ip header
    And I send 1 times an ad request for consent entities to UAS with us privacy string containing opt-out=Y
    Then I expect req consent passback

  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutTrue
  @ccpaOptOutTrueNotCa
  Scenario: Ccpa Opt-Out={Y} - zone request not from Ca
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with us privacy string containing opt-out=Y
    Then The response code is 204


  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutFalse
  @ccpaOptOutFalseCa
  Scenario: Ccpa Opt-Out={N} - zone request from Ca
    Given I add {CA} ip header
    And I send 1 times an ad request for consent entities to UAS with us privacy string containing opt-out=N
    Then I expect delivery


  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutFalse
  @ccpaOptOutFalseNotCa
  Scenario: Ccpa Opt-Out={N} - zone request not from Ca
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with us privacy string containing opt-out=N
    Then I expect delivery

  @ccpa
  @ccpaUtInvalid
  @ccpaOptOut
  @ccpaOptOutNotApplicable
  @ccpaOptOutNotApplicableCa
  Scenario: Ccpa Opt-Out={-} - zone request from Ca
    Given I add {CA} ip header
    And I send 1 times an ad request for consent entities to UAS with us privacy string containing opt-out=NOT_APPLICABLE
    Then The response code is 204


  @ccpa
  @ccpaUtInvalid
  @ccpaOptOut
  @ccpaOptOutNotApplicable
  @ccpaOptOutNotApplicableNotCa
  Scenario: Ccpa Opt-Out={-} - zone request not from Ca
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with us privacy string containing opt-out=NOT_APPLICABLE
    Then The response code is 204

