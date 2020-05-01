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
  Scenario: zone req - no params are specified - request from Country -> Canada
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times an ad request for consent entities to UAS with gdpr=1 and with an empty gdprstr for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    Then I expect delivery


  Scenario: zone req - no params are specified - city limitation
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    When I send 1 times an ad request for zone named {zone-zoneset-city-limitation} to UAS
    Then I expect delivery


  @ZoneReqNoGdprParamNotEu
  Scenario: zone req - no params are specified - request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS
    Then I expect delivery