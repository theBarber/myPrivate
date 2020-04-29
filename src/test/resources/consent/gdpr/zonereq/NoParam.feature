@GDPR
@UtConsent
@NoGdprParam
@ZoneReqNoGdprParam
@ZoneReqConsent
@parallel
Feature: GDPR - Zone Reqs - Europe Delivery Logic - No Param Is Specified In URL

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @ZoneReqNoGdprParamEu
  Scenario: zone req - no params are specified - request from Eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS
    Then I expect delivery


  Scenario: zone req - no params are specified - request from outside EU with city limitation
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    When I send 1 times an ad request for zone named {zone-zoneset-city-limitation} to UAS
    Then I expect delivery


  @ZoneReqNoGdprParamNotEu
  Scenario: zone req - no params are specified - request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS
    Then I expect delivery