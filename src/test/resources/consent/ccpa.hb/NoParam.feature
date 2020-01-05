@parallel
Feature: CCPA - Header Bidding Reqs - California Delivery Logic - No Param Is Specified In URL

  @hbNoCcpaParamCa
  Scenario: Ccpa Opt-Out={Y} - zone request from Ca
    Given I add {CA} ip header
    And I send 1 times an ad request for consent entities to UAS with us privacy string containing opt-out=Y
    Then I expect delivery