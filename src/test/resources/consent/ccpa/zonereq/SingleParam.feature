@CCPA
@UtConsent
@ZoneReqSingleCcpaParam
@ZoneReqCcpaConsent
@parallel
Feature: CCPA - Zone Reqs - Canada Delivery Logic - Us Privacy String Param Is Specified In URL

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutTrue
  @ccpaOptOutTrueCa
  Scenario:1.0 Ccpa Opt-Out={Y} - zone request from Canada
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    Given I send 1 times an ad request for consent entities to UAS with us privacy string containing opt-out=Y for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    Then I expect delivery

    @ccpa
    @ccpaUtValid
    @ccpaOptOut
    @ccpaOptOutTrue
    @ccpaOptOutTrueNotCa
    Scenario:2.0 Ccpa Opt-Out={Y} - zone request from city
      Given I reset the http headers sent to uas
      Given I add header of {x-forwarded-for} with value {192.241.221.98}
      Given I send 1 times an ad request for consent entities to UAS with us privacy string containing opt-out=Y for zone named {zone-zoneset-city-limitation} to UAS
      And The response code is 200
      And The responses are passback



  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutFalse
  @ccpaOptOutFalseCa
  Scenario:3.0 Ccpa Opt-Out={N} - zone request from Canada
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    Given I send 1 times an ad request for consent entities to UAS with us privacy string containing opt-out=N for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    Then I expect delivery



  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutFalse
  @ccpaOptOutFalseNotCa
  Scenario:4.0 Ccpa Opt-Out={N} - zone request from city
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    Given I send 1 times an ad request for consent entities to UAS with us privacy string containing opt-out=N for zone named {zone-zoneset-city-limitation} to UAS
    Then I expect delivery

  @ccpa
  @ccpaUtInvalid
  @ccpaOptOut
  @ccpaOptOutNotApplicable
  @ccpaOptOutNotApplicableCa
  Scenario:5.0 Ccpa Opt-Out={-} - zone request from Canada
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    Given I send 1 times an ad request for consent entities to UAS with us privacy string containing opt-out=NOT_APPLICABLE for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    Then I expect delivery




  @ccpa
  @ccpaUtInvalid
  @ccpaOptOut
  @ccpaOptOutNotApplicable
  @ccpaOptOutNotApplicableNotCa
  Scenario:6.0 Ccpa Opt-Out={-} - zone request from city
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    Given I send 1 times an ad request for consent entities to UAS with us privacy string containing opt-out=NOT_APPLICABLE for zone named {zone-zoneset-city-limitation} to UAS
    Then I expect delivery

