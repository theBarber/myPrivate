@CCPA
@UtConsent
@NoCcpaParam
@ZoneReqNoCcpaParam
@ZoneReqCcpaConsent
@parallel
Feature: CCPA - Zone Reqs - California Delivery Logic - No Param Is Specified In URL

  @ZoneReqNoCcpaParamCa
  Scenario: zone req - no params are specified - request from Ca
    Given I add {CA} ip header
    And I send 1 times an ad request for consent entities to UAS
    Then I expect delivery

  @ZoneReqNoCcpaParamNotCa
  Scenario: zone req - no params are specified - request not from Ca
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS
    Then I expect delivery