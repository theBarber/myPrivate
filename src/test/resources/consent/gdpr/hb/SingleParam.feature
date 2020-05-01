@GDPR
@UtConsent
@hbSingleGdprParam
@hbConsent
@parallel
Feature: GDPR - Header Bidding Reqs - Europe Delivery Logic - Single Gdpr Param Is Specified In URL

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @gdpr
  @GdprTrueParamEu
  Scenario:1.0 gdpr=1 - hb request Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    Given i send synchronized 1 basic headerBidding secure post request for publisher 3708 with size - h1:1 w1:2, with domain {geo4}, placmentID group = {blabla} and extra params {&gdpr=1} cookies false
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}

  @gdpr
  @GdprTrueParamNotEu
  Scenario:2.0 gdpr=1 - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    Given i send synchronized 1 basic headerBidding secure post request for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com}, placmentID group = {blabla} and extra params {&gdpr=1} cookies false
    Then The response code is 200
    And The responses are passback

  @gdpr
  @GdprFalseParamEu
  Scenario:3.0 gdpr=0 - hb request Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    Given i send synchronized 1 basic headerBidding secure post request for publisher 3708 with size - h1:1 w1:2, with domain {geo4}, placmentID group = {blabla} and extra params {&gdpr=0} cookies false
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}


  @gdpr
  @GdprFalseParamNotEu
  Scenario:4.0 gdpr=0 - hb request not from Eu - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    Given i send synchronized 1 basic headerBidding secure post request for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com}, placmentID group = {blabla} and extra params {&gdpr=0} cookies false
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-San-Francisco-city}
    And all HB responses contains adId with id of entity named {campaign-San-Francisco-city-banner-1}


  @gdprstr
  @hbGdprStrUtIdUtPurposesIncludedEu
  Scenario:5.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - hb request - Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with gdprstr which includes ut vendor id and includes ut purpose ids for publisher 3708 with size - h1:1 w1:2, with domain {geo4}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}

  @gdprstr
  @hbGdprStrUtIdUtPurposesIncludedNotEu
  Scenario:6.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with gdprstr which includes ut vendor id and includes ut purpose ids for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com}
    Then The response code is 200
    And The responses are passback


  @gdprstr
  @hbGdprStrUtIdIncludedUtPurposeIdsExcludedEu
  Scenario:7.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - hb request - Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with gdprstr which includes ut vendor id and excludes ut purpose ids for publisher 3708 with size - h1:1 w1:2, with domain {geo4}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}


  @gdprstr
  @hbGdprStrUtIdIncludedUtPurposeIdsExcludedNotEu
  Scenario:8.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with gdprstr which includes ut vendor id and excludes ut purpose ids for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com}
    Then The response code is 200
    And The responses are passback


  @gdprstr
  @hbGdprStrUtIdExcludedUtPurposeIdsIncludedEu
  Scenario:9.0 gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - hb request - Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with gdprstr which excludes ut vendor id and includes ut purpose ids for publisher 3708 with size - h1:1 w1:2, with domain {geo4}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}



  @gdprstr
  @hbGdprStrUtIdExcludedUtPurposeIdsIncludedNotEu
  Scenario:10.0 gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with gdprstr which excludes ut vendor id and includes ut purpose ids for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com}
    Then The response code is 200
    And The responses are passback



  @gdprstr
  @hbGdprStrUtIdExcludedUtPurposeIdsExcludedEu
  Scenario:11.0 gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - hb request - Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with gdprstr which excludes ut vendor id and excludes ut purpose ids for publisher 3708 with size - h1:1 w1:2, with domain {geo4}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}



  @gdprstr
  @hbGdprStrUtIdExcludedUtPurposeIdsExcludedNotEu
  Scenario:12.0 gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with gdprstr which excludes ut vendor id and excludes ut purpose ids for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com}
    Then The response code is 200
    And The responses are passback


  @gdprstr
  @hbGdprStrEmptyStringEu
  Scenario:13.0 gdprstr=empty_string - hb request - Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with an empty gdprstr for publisher 3708 with size - h1:1 w1:2, with domain {geo4}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}


  @gdprstr
  @hbGdprStrEmptyStringNotEu
  Scenario:14.0 gdprstr=empty_string - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with an empty gdprstr for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com}
    Then The response code is 200
    And The responses are passback