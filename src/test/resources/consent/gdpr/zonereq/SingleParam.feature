@GDPR
@UtConsent
@ZoneReqSingleGdprParam
@ZoneReqConsent
@parallel
Feature: GDPR - Zone Reqs - Europe Delivery Logic - Single Gdpr Param Is Specified In URL

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  @gdpr
  @GdprTrueParamEu
  Scenario:1.0 gdpr=1 - zone request from Eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdpr=1
    Then I expect delivery

  @gdpr
  @GdprTrueParamNotEu
  Scenario:2.0 gdpr=1 - zone request not from Eu
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    When I send 1 times an ad request with parameter {gdpr=1} for zone named {zone-zoneset-city-limitation} to UAS
    Then The response code is 200
    And The responses are passback
#    Given I reset the http headers sent to uas
#    And I send 1 times an ad request for consent entities to UAS with gdpr=1
#    Then The response code is 204

  @gdpr
  @GdprFalseParamEu
  Scenario:3.0 gdpr=0 - zone request from Eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdpr=0
    Then I expect delivery

  @gdpr
  @GdprFalseParamNotEu
  Scenario:4.0 gdpr=0 - zone request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with gdpr=0
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrUtIdUtPurposesIncludedEu
  Scenario:5.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrUtIdUtPurposesIncludedNotEu
  Scenario: gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrUtIdIncludedUtPurposeIdsExcludedEu
  Scenario:6.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then I expect delivery

#  @gdprstr
#  @ZoneReqGdprStrUtIdIncludedUtPurposeIdsExcludedNotEu
#  Scenario:7.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - zone request not from eu
#    Given I reset the http headers sent to uas
#    And I send 1 times an ad request for consent entities to UAS with gdprstr which includes ut vendor id and excludes ut purpose ids
#    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrUtIdIncludedUtPurposeIdsExcludedNotEu
  Scenario:7.0  zone request not from eu - zone request - city limitation on banner level - gdpr=0
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    When I send 1 times an ad request with parameter {gdpr=0} for zone named {zone-zoneset-city-limitation} to UAS
    Then I expect delivery


  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then I expect delivery


  @gdprstr
  @ZoneReqGdprStrUtIdExcludedUtPurposeIdsIncludedNotEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then I expect delivery


  @gdprstr
  @ZoneReqGdprStrUtIdExcludedUtPurposeIdsExcludedEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrUtIdExcludedUtPurposeIdsExcludedNotEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrEmptyStringEu
  Scenario: gdprstr=empty_string - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for consent entities to UAS with an empty gdprstr
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrEmptyStringNotEu
  Scenario: gdprstr=empty_string - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for consent entities to UAS with an empty gdprstr
    Then I expect delivery
