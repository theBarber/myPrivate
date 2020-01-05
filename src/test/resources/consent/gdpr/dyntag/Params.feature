@GDPR
@UtConsent
@DynTagBothGdprParams
@parallel
Feature: GDPR - DynTag - Europe Delivery Logic - Both Params Are Specified

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=empty_string - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with an empty gdprstr
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=empty_string - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=1 and with an empty gdprstr
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_INCLUDED - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_INCLUDED - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then I expect delivery


  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=empty_string - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with an empty gdprstr
    Then I expect delivery

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=empty_string - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for consent publisher's entities with gdpr=0 and with an empty gdprstr
    Then I expect delivery
