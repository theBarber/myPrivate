@CCPA
@UtConsent
@NoCcpaParam
@ZoneReqNoCcpaParam
@ZoneReqCcpaConsent
@parallel
Feature: CCPA - Zone Reqs - California Delivery Logic - No Param Is Specified In URL

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @ZoneReqNoCcpaParamCa
  Scenario:1.0 zone req - no params are specified - request from Ca
    Given I add {CA} ip header
    And I send 1 times an ad request for consent entities to UAS
    And I expect delivery

  @ZoneReqNoCcpaParamNotCa
  Scenario:2.0 zone req - no params are specified - request not from Ca
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS
    Then I expect delivery