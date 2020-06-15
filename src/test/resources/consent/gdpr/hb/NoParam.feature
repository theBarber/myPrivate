@GDPR
@UtConsent
@NoGdprParam
@hbNoGdprParam
@hbConsent
@parallel
@request_service
Feature: GDPR - Header Bidding Reqs - Europe Delivery Logic - No Param Is Specified In URL

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @hbNoGdprParamEu
  Scenario:1.0 hb req - no params are specified - HB request - Country limitation --> Canada
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for consent entities
    Then The response code is 200
    And The response contains {"publisherId":3836,"bidRequestId":"21b46f0d859b35"}

  @hbNoGdprParamNotEu
  Scenario:2.0 hb req - no params are specified - request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities
    Then The response code is 200
    And The response contains {"publisherId":3836,"bidRequestId":"21b46f0d859b35"}
