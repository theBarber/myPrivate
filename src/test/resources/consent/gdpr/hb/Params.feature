@GDPR
@UtConsent
@hbBothGdprParams
@hbConsent
@parallel
Feature: GDPR - Header Bidding Reqs - Europe Delivery Logic - Both Params Are Specified

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @gdprgdprstr
  Scenario:1.0 gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - hb request Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with gdprstr which includes ut vendor id and includes ut purpose ids for publisher 3708 with size - h1:1 w1:2, with domain {geo4&gdpr=1}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}


  @gdprgdprstr
  Scenario:2.0 gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with gdprstr which includes ut vendor id and includes ut purpose ids for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com&gdpr=1}
    Then The response code is 204
    And The responses are passback


  @gdprgdprstr
  Scenario:3.0 gdpr=1 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - hb request Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with gdprstr which includes ut vendor id and excludes ut purpose ids for publisher 3708 with size - h1:1 w1:2, with domain {geo4&gdpr=1}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}

  @gdprgdprstr
  Scenario:4.0 gdpr=1 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with gdprstr which includes ut vendor id and excludes ut purpose ids for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com&gdpr=1}
    Then The response code is 204
    And The responses are passback


  @gdprgdprstr
  Scenario:5.0 gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - hb request Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with gdprstr which excludes ut vendor id and includes ut purpose ids for publisher 3708 with size - h1:1 w1:2, with domain {geo4&gdpr=1}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}

  @gdprgdprstr
  Scenario:6.0 gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with gdprstr which excludes ut vendor id and includes ut purpose ids for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com&gdpr=1}
    Then The response code is 204
    And The responses are passback

  @gdprgdprstr
  Scenario:7.0 gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - hb request Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with gdprstr which excludes ut vendor id and excludes ut purpose ids for publisher 3708 with size - h1:1 w1:2, with domain {geo4&gdpr=1}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}

  @gdprgdprstr
  Scenario:8.0 gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with gdprstr which excludes ut vendor id and excludes ut purpose ids for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com&gdpr=1}
    Then The response code is 204
    And The responses are passback


  @gdprgdprstr
  Scenario:9.0 gdpr=1 and gdprstr=empty_string - hb request Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with an empty gdprstr for publisher 3708 with size - h1:1 w1:2, with domain {geo4&gdpr=1}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}


  @gdprgdprstr
  Scenario:10.0 gdpr=1 and gdprstr=empty_string - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with an empty gdprstr for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com&gdpr=1}
    Then The response code is 204
    And The responses are passback


  @gdprgdprstr
  Scenario:11.0 gdpr=0 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - hb request Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with gdprstr which includes ut vendor id and includes ut purpose ids for publisher 3708 with size - h1:1 w1:2, with domain {geo4&gdpr=0}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}



  @gdprgdprstr
  Scenario:12.0 gdpr=0 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with gdprstr which includes ut vendor id and includes ut purpose ids for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com&gdpr=0}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-San-Francisco-city}
    And all HB responses contains adId with id of entity named {campaign-San-Francisco-city-banner-1}


  @gdprgdprstr
  Scenario:13.0 gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - hb request Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with gdprstr which includes ut vendor id and excludes ut purpose ids for publisher 3708 with size - h1:1 w1:2, with domain {geo4&gdpr=0}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}

  @gdprgdprstr
  Scenario:14.0 gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with gdprstr which includes ut vendor id and excludes ut purpose ids for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com&gdpr=0}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-San-Francisco-city}
    And all HB responses contains adId with id of entity named {campaign-San-Francisco-city-banner-1}


  @gdprgdprstr
  Scenario:15.0 gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - hb request Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with gdprstr which excludes ut vendor id and includes ut purpose ids for publisher 3708 with size - h1:1 w1:2, with domain {geo4&gdpr=0}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}


  @gdprgdprstr
  Scenario:16.0 gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with gdprstr which excludes ut vendor id and includes ut purpose ids for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com&gdpr=0}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-San-Francisco-city}
    And all HB responses contains adId with id of entity named {campaign-San-Francisco-city-banner-1}


  @gdprgdprstr
  Scenario:17.0 gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - hb request Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with gdprstr which excludes ut vendor id and excludes ut purpose ids for publisher 3708 with size - h1:1 w1:2, with domain {geo4&gdpr=0}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}


  @gdprgdprstr
  Scenario:18.0 gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with gdprstr which excludes ut vendor id and excludes ut purpose ids for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com&gdpr=0}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-San-Francisco-city}
    And all HB responses contains adId with id of entity named {campaign-San-Francisco-city-banner-1}


  @gdprgdprstr
  Scenario:19.0 gdpr=0 and gdprstr=empty_string - hb request Country limitation --> Canada
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Header Bidding request for consent entities with an empty gdprstr for publisher 3708 with size - h1:1 w1:2, with domain {geo4&gdpr=0}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-state-bannerLevelLimit-ST}
    And all HB responses contains adId with id of entity named {campaign-state-bannerLevelLimit-ST-banner-1}

  @gdprgdprstr
  Scenario:20.0 gdpr=0 and gdprstr=empty_string - hb request - city limitation
    Given I clear all cookies from uas requests
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Header Bidding request for consent entities with an empty gdprstr for publisher 2434 with size - h1:1 w1:2, with domain {consentweb.com&gdpr=0}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-San-Francisco-city}
    And all HB responses contains adId with id of entity named {campaign-San-Francisco-city-banner-1}
