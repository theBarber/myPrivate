@GDPR
@UtConsent
@ZoneReqSingleGdprParam
@ZoneReqConsent
@parallel
Feature: GDPR - Zone Reqs - Europe Delivery Logic - Single Gdpr Param Is Specified In URL

  @gdpr
  @GdprTrueParamEu
  Scenario: gdpr=1 - zone request from Eu
    Given I add {UK} ip header
    And I send 1 times an ad request with parameter {gdpr=1} for gdpr entities to UAS
    Then I expect req gdpr passback

  @gdpr
  @GdprTrueParamNotEu
  Scenario: gdpr=1 - zone request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request with parameter {gdpr=1} for gdpr entities to UAS
    Then I expect req gdpr passback

  @gdpr
  @GdprFalseParamEu
  Scenario: gdpr=0 - zone request from Eu
    Given I add {UK} ip header
    And I send 1 times an ad request with parameter {gdpr=0} for gdpr entities to UAS
    Then I expect delivery

  @gdpr
  @GdprFalseParamNotEu
  Scenario: gdpr=0 - zone request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request with parameter {gdpr=0} for gdpr entities to UAS
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrUtIdUtPurposesIncludedEu
  Scenario: gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for gdpr entities to UAS with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrUtIdUtPurposesIncludedNotEu
  Scenario: gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for gdpr entities to UAS with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrUtIdIncludedUtPurposeIdsExcludedEu
  Scenario: gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for gdpr entities to UAS with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then I expect req gdpr passback

  @gdprstr
  @ZoneReqGdprStrUtIdIncludedUtPurposeIdsExcludedNotEu
  Scenario: gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for gdpr entities to UAS with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrUtIdExcludedUtPurposeIdsIncludedEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for gdpr entities to UAS with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then I expect req gdpr passback


  @gdprstr
  @ZoneReqGdprStrUtIdExcludedUtPurposeIdsIncludedNotEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for gdpr entities to UAS with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then I expect delivery


  @gdprstr
  @ZoneReqGdprStrUtIdExcludedUtPurposeIdsExcludedEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for gdpr entities to UAS with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then I expect req gdpr passback

  @gdprstr
  @ZoneReqGdprStrUtIdExcludedUtPurposeIdsExcludedNotEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for gdpr entities to UAS with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrEmptyStringEu
  Scenario: gdprstr=empty_string - zone request from eu
    Given I add {UK} ip header
    And I send 1 times an ad request for gdpr entities to UAS with an empty gdprstr
    Then I expect req gdpr passback

  @gdprstr
  @ZoneReqGdprStrEmptyStringNotEu
  Scenario: gdprstr=empty_string - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for gdpr entities to UAS with an empty gdprstr
    Then I expect delivery
