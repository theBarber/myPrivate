@GDPR
@UtConsent
@DynTagBothGdprParams
@parallel
Feature: GDPR - DynTag - Europe Delivery Logic - Both Params Are Specified

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @gdprgdprstr
  Scenario:1.0 gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - DT request - Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which includes ut vendor id and includes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which includes ut vendor id and includes ut purpose ids for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time


  @gdprgdprstr
  Scenario:2.0 gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - DT request - city limitation - passback expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which includes ut vendor id and includes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which includes ut vendor id and includes ut purpose ids for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The responses are passback


  @gdprgdprstr
  Scenario:3.0 gdpr=1 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - DT request - Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which includes ut vendor id and excludes ut purpose ids
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which includes ut vendor id and excludes ut purpose ids for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time

  @gdprgdprstr
  Scenario:4.0 gdpr=1 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - DT request - city limitation - passback expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which includes ut vendor id and excludes ut purpose ids
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which includes ut vendor id and excludes ut purpose ids for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The responses are passback


  @gdprgdprstr
  Scenario:5.0 gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - DT request - Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which excludes ut vendor id and includes ut purpose ids
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which excludes ut vendor id and includes ut purpose ids for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time




  @gdprgdprstr
  Scenario:6.0 gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - DT request - city limitation - passback expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which excludes ut vendor id and includes ut purpose ids
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which excludes ut vendor id and includes ut purpose ids for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The responses are passback


  @gdprgdprstr
  Scenario:7.0 gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - DT request - Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which excludes ut vendor id and excludes ut purpose ids
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which excludes ut vendor id and excludes ut purpose ids for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time


  @gdprgdprstr
  Scenario:8.0 gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - DT request - city limitation - passback expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which excludes ut vendor id and excludes ut purpose ids
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which excludes ut vendor id and excludes ut purpose ids for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The responses are passback

  @gdprgdprstr
  Scenario:9.0 gdpr=1 and gdprstr=empty_string - DT request - Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with an empty gdprstr
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with an empty gdprstr for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time


  @gdprgdprstr
  Scenario:10.0 gdpr=1 and gdprstr=empty_string - DT request - city limitation - passback expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with an empty gdprstr
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with an empty gdprstr for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The responses are passback



  @gdprgdprstr
  Scenario:11.0 gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_INCLUDED - DT request - Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which includes ut vendor id and includes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which includes ut vendor id and includes ut purpose ids for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time



  @gdprgdprstr
  Scenario:12.0 gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_INCLUDED - DT request - city limitation - script expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which includes ut vendor id and includes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which includes ut vendor id and includes ut purpose ids for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-San-Francisco-city-banner-1} 100% of the time


  @gdprgdprstr
  Scenario:13.0 gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - DT request - Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which includes ut vendor id and excludes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which includes ut vendor id and excludes ut purpose ids for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time



  @gdprgdprstr
  Scenario:14.0 gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - DT request - city limitation - script expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which includes ut vendor id and excludes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which includes ut vendor id and excludes ut purpose ids for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-San-Francisco-city-banner-1} 100% of the time


  @gdprgdprstr
  Scenario:15.0 gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED -  DT request - Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which excludes ut vendor id and includes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which excludes ut vendor id and includes ut purpose ids for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time



  @gdprgdprstr
  Scenario:16.0 gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - DT request - city limitation - script expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which excludes ut vendor id and includes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which excludes ut vendor id and includes ut purpose ids for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-San-Francisco-city-banner-1} 100% of the time

  @gdprgdprstr
  Scenario:17.0 gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - DT request - Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which excludes ut vendor id and excludes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which excludes ut vendor id and excludes ut purpose ids for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time



  @gdprgdprstr
  Scenario:18.0 gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - DT request - city limitation - script expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which excludes ut vendor id and excludes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which excludes ut vendor id and excludes ut purpose ids for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-San-Francisco-city-banner-1} 100% of the time

  @gdprgdprstr
  Scenario:19.0 gdpr=0 and gdprstr=empty_string - DT request - Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with an empty gdprstr
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with an empty gdprstr for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time


  @gdprgdprstr
  Scenario:20.0 gdpr=0 and gdprstr=empty_string - DT request - city limitation - script expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with an empty gdprstr
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with an empty gdprstr for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-San-Francisco-city-banner-1} 100% of the time


