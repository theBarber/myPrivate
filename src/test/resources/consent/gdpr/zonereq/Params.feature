@GDPR
@UtConsent
@ZoneReqBothGdprParams
@ZoneReqConsent
@parallel
Feature: GDPR - Zone Reqs - Europe Delivery Logic - Both Params Are Specified

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @gdprgdprstr
  Scenario:1.0 gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdpr=1 and with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario:2.0 gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with gdpr=1 and with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario:3.0 gdpr=1 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - zone request from eu - country
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdpr=1 and with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  Scenario:4.0 gdpr=1  - zone request - city limitation on banner level
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    When I send 1 times an ad request with parameter {gdpr=1} for zone named {zone-zoneset-city-limitation} to UAS
    Then The response code is 200
    And The responses are passback


  @gdprgdprstr
  Scenario:5.0 gdpr=1  - zone request not from eu - from --> CANADA
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    When I send 1 times an ad request with parameter {gdpr=1} for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    Then I expect delivery

  @gdprgdprstr
  Scenario:6.0 gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdpr=1 and with gdprstr which excludes ut vendor id and includes ut purpose ids
    #Then The response code is 204
    Then I expect delivery

  @gdprgdprstr
  Scenario:7.0 gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with gdpr=1 and with gdprstr which excludes ut vendor id and includes ut purpose ids
   # Then The response code is 204
    Then I expect delivery

  @gdprgdprstr
  Scenario:8.0 gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdpr=1 and with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario:9.0 gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with gdpr=1 and with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario:10.0 gdpr=1 and gdprstr=empty_string - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdpr=1 and with an empty gdprstr
    Then I expect delivery

  @gdprgdprstr
  Scenario:11.0 gdpr=1 and gdprstr=empty_string - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with gdpr=1 and with an empty gdprstr
    Then I expect delivery


  Scenario:12.0 gdpr=0 - zone request - city limitation
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    When I send 1 times an ad request with parameter {gdpr=0} for zone named {zone-zoneset-city-limitation} to UAS
    Then I expect delivery


  @gdprgdprstr
  Scenario:13.0 gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_INCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdpr=0 and with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario:14.0 gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_INCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with gdpr=0 and with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario:15.0 gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdpr=0 and with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then I expect delivery


  @gdprgdprstr
  Scenario:16.0 gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with gdpr=0 and with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario:17.0 gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdpr=0 and with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario:18.0 gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with gdpr=0 and with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario:19.0 gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdpr=0 and with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario:20.0 gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with gdpr=0 and with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario:21.0 gdpr=0 and gdprstr=empty_string - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdpr=0 and with an empty gdprstr
    Then I expect delivery

  @gdprgdprstr
  Scenario:22.0 gdpr=0 and gdprstr=empty_string - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with gdpr=0 and with an empty gdprstr
    Then I expect delivery
