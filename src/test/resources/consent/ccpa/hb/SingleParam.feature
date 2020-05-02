@CCPA
@UtConsent
@SingleCcpaParam
@hbSingleCcpaParam
@hbCcpaConsent
@parallel
Feature: CCPA - Header Bidding Reqs - California Delivery Logic - Us Privacy String Param Specified In URL

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutTrue
  @ccpaOptOutTrueCa
  Scenario:1.0 Ccpa Opt-Out={Y} - HB request - Country limitation --> from Canada
#    Given I add {CA} ip header
#    And I send 1 times Header Bidding request for consent entities with us privacy string containing opt-out=Y
#    Then The response code is 200
#    And The response contains {"publisherId": 3836,"bidRequestId": "21b46f0d859b35"}
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    Given I send 1 times Header Bidding request for consent entities for publisher 3708 with size - h1:1 w1:2, with domain {geo4} with us privacy string containing opt-out=Y
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}


  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutTrue
  @ccpaOptOutTrueNotCa
  Scenario:2.0 Ccpa Opt-Out={Y} - HB request - city limitation - passback expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Header Bidding request for consent entities with us privacy string containing opt-out=Y
#    Then The response code is 204
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    Given I send 1 times Header Bidding request for consent entities for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com} with us privacy string containing opt-out=Y
    Then The response code is 204
    And The responses are passback

  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutFalse
  @ccpaOptOutTrueCa
  Scenario:3.0 Ccpa Opt-Out={N} - HB request - Country limitation --> from Canada - script expected
#    Given I add {CA} ip header
#    And I send 1 times Header Bidding request for consent entities with us privacy string containing opt-out=N
#    Then The response code is 200
#    And The response contains {"publisherId": 3836,"bidRequestId": "21b46f0d859b35"}
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    Given I send 1 times Header Bidding request for consent entities for publisher 3708 with size - h1:1 w1:2, with domain {geo4} with us privacy string containing opt-out=N
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}

  @ccpa
  @ccpaUtValid
  @ccpaOptOut
  @ccpaOptOutFalse
  @ccpaOptOutTrueNotCa
  Scenario:4.0 Ccpa Opt-Out={N} - HB request - city limitation - script expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Header Bidding request for consent entities with us privacy string containing opt-out=N
#    Then The response code is 200
#    And The response contains {"publisherId": 3836,"bidRequestId": "21b46f0d859b35"}
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    Given I send 1 times Header Bidding request for consent entities for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com} with us privacy string containing opt-out=N
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-San-Francisco-city}
    And all HB responses contains adId with id of entity named {campaign-San-Francisco-city-banner-1}

  @ccpa
  @ccpaUtInvalid
  @ccpaOptOutNotApplicable
  @ccpaOptOutNotApplicableCa
  Scenario: Ccpa Opt-Out={-} - HB request - Country limitation --> from Canada - script expected
#    Given I add {CA} ip header
#    And I send 1 times Header Bidding request for consent entities with us privacy string containing opt-out=NOT_APPLICABLE
#    Then The response code is 200
#    And The response contains {"publisherId": 3836,"bidRequestId": "21b46f0d859b35"}
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    Given I send 1 times Header Bidding request for consent entities for publisher 3708 with size - h1:1 w1:2, with domain {geo4} with us privacy string containing opt-out=NOT_APPLICABLE
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}

  @ccpa
  @ccpaUtInvalid
  @ccpaOptOutNotApplicable
  @ccpaOptOutNotApplicableNotCa
  Scenario:5.0 Ccpa Opt-Out={-} - HB request - city limitation - script expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Header Bidding request for consent entities with us privacy string containing opt-out=NOT_APPLICABLE
#    Then The response code is 200
#    And The response contains {"publisherId": 3836,"bidRequestId": "21b46f0d859b35"}
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    Given I send 1 times Header Bidding request for consent entities for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com} with us privacy string containing opt-out=NOT_APPLICABLE
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-San-Francisco-city}
    And all HB responses contains adId with id of entity named {campaign-San-Francisco-city-banner-1}