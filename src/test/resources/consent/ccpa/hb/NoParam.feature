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
  Scenario:1.0 HB req - no params are specified - from Ca
    Given I add {CA} ip header
    And I send 1 times Header Bidding request for consent entities
    Then The response code is 200
    And The response contains {"publisherId": 3836,"bidRequestId": "21b46f0d859b35"}

  @hbNoCcpaParamNotCa
  Scenario:2.0 HB req - no params are specified - not from Ca
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities
    Then The response code is 200
    And The response contains {"publisherId": 3836,"bidRequestId": "21b46f0d859b35"}