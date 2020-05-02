@GDPR
@UtConsent
@DynTagSingleGdprParam
@parallel
Feature: GDPR - DynTag - Europe Delivery Logic - Single Gdpr Param Is Specified In URL

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @gdpr
  @DynTagGdprTrueParamEu
  Scenario:1.0 gdpr=1 - dyntag - request Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo4&tagid=170&optimize=1&gdpr=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time


  @gdpr
  @DynTagGdprTrueParamNotEu
  Scenario:2.0 gdpr=1 - dyntag request - city limitation - passback expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1&gdpr=1}
    And The response code is 200
    And The responses are passback


  @gdpr
  @DynTagGdprFalseParamEu
  Scenario:3.0 gdpr=0 - dyntag request Country limitation --> Canada - script expected
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo4&tagid=170&optimize=1&gdpr=0}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time


  @gdpr
  @DynTagGdprFalseParamNotEu
  Scenario:4.0 gdpr=0 - dyntag request - city limitation - script expected
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1&gdpr=0}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-San-Francisco-city-banner-1} 100% of the time


  @gdprstr
  @DynTagGdprStrUtIdUtPurposesIncludedEu
  Scenario:5.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - dyntag request Country limitation --> Canada - script expected
#    Given I reset the http headers sent to uas
#    And I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which includes ut vendor id and includes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which includes ut vendor id and includes ut purpose ids for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time


  @gdprstr
  @DynTagGdprStrUtIdUtPurposesIncludedNotEu
  Scenario:6.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - dyntag request - city limitation - script expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which includes ut vendor id and includes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which includes ut vendor id and includes ut purpose ids for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-San-Francisco-city-banner-1} 100% of the time


  @gdprstr
  @DynTagGdprStrUtIdIncludedUtPurposeIdsExcludedEu
  Scenario:7.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - dyntag request Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which includes ut vendor id and excludes ut purpose ids
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which includes ut vendor id and excludes ut purpose ids for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time


  @gdprstr
  @DynTagGdprStrUtIdIncludedUtPurposeIdsExcludedNotEu
  Scenario:8.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - dyntag request - city limitation - script expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which includes ut vendor id and excludes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which includes ut vendor id and excludes ut purpose ids for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-San-Francisco-city-banner-1} 100% of the time





  @gdprstr
  @DynTagGdprStrUtIdExcludedUtPurposeIdsIncludedEu
  Scenario:9.0 gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - dyntag request - Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which excludes ut vendor id and includes ut purpose ids
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which excludes ut vendor id and includes ut purpose ids for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time


  @gdprstr
  @DynTagGdprStrUtIdExcludedUtPurposeIdsIncludedNotEu
  Scenario:10.0 gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - dyntag request - city limitation - script expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which excludes ut vendor id and includes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which excludes ut vendor id and includes ut purpose ids for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-San-Francisco-city-banner-1} 100% of the time



  @gdprstr
  @DynTagGdprStrUtIdExcludedUtPurposeIdsExcludedEu
  Scenario:11.0 gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - dyntag request - Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which excludes ut vendor id and excludes ut purpose ids
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which excludes ut vendor id and excludes ut purpose ids for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time



  @gdprstr
  @DynTagGdprStrUtIdExcludedUtPurposeIdsExcludedNotEu
  Scenario:12.0 gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - dyntag request - city limitation - script expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which excludes ut vendor id and excludes ut purpose ids
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdprstr which excludes ut vendor id and excludes ut purpose ids for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-San-Francisco-city-banner-1} 100% of the time


  @gdprstr
  @DynTagGdprStrEmptyStringEu
  Scenario:13.0 gdprstr=empty_string - dyntag request -  Country limitation --> Canada - script expected
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with an empty gdprstr
#    Then The response code is 204
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with an empty gdprstr for publisher 3708 with extra params {geo4&tagid=170&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time

  @gdprstr
  @DynTagGdprStrEmptyStringNotEu
  Scenario:14.0 gdprstr=empty_string - dyntag request - city limitation - script expected
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with an empty gdprstr
#    Then I expect delivery
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}}
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with an empty gdprstr for publisher 2434 with extra params {consentweb.com&tagid=452&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-San-Francisco-city-banner-1} 100% of the time