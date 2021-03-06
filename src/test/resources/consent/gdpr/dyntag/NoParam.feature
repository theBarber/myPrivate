@GDPR
@UtConsent
@NoGdprParam
@DynTagNoGdprParam
@parallel
@request_service
Feature: GDPR - DynTag - Europe Delivery Logic - No Param Is Specified In URL

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @DynTagNoGdprParamEu
  Scenario:1.0 DynTag - no params are specified - request from Eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities
    Then I expect delivery

  @DynTagNoGdprParamNotEu
  Scenario:2.0 DynTag - no params are specified - request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities
    Then I expect delivery



