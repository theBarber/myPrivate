@CCPA
@UtConsent
@DynTagCCPA1
@parallel
Feature: CCPA - DynTag

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200


  Scenario:1.0   ccpa=1YYY - DT request - Country limitation --> from Canada - script expected
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo4&tagid=170&ccpa=1YYY}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time

  Scenario:2.0   ccpa=1YYY - DT request - city limitation - passback expected
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 2434 with extra params {consentweb.com&tagid=452&ccpa=1YYN}
    And The response code is 200
    And The responses are passback

  Scenario:3.0   ccpa=1NNN - DT request - Country limitation --> from Canada - script expected
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {geo4&tagid=170&ccpa=1NNN}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-state-bannerLevelLimit-ST-banner-1} 100% of the time


  Scenario:4.0   ccpa=1NNN - DT request - city limitation - script expected
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {192.241.221.98}}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 2434 with extra params {consentweb.com&tagid=452&ccpa=1NNN}
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-San-Francisco-city-banner-1} 100% of the time