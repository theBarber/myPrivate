@GDPR
@UtConsent
@DynTagSingleGdprParam
@parallel
Feature: GDPR - DynTag - Europe Delivery Logic - Single Gdpr Param Is Specified In URL

  @gdpr
  @DynTagGdprTrueParamEu
  Scenario: gdpr=1 - dyntag request from Eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdpr=1
    Then I expect req gdpr passback

  @gdpr
  @DynTagGdprTrueParamNotEu
  Scenario: gdpr=1 - dyntag request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdpr=1
    Then I expect req gdpr passback

#  @gdpr
#  @DynTagGdprFalseParamEu
#  Scenario: gdpr=0 - dyntag request from Eu
#    Given I add {UK} ip header
#    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdpr=0
#    Then I expect delivery

#  @gdpr
#  @DynTagGdprFalseParamNotEu
#  Scenario: gdpr=0 - dyntag request not from Eu
#    Given I reset the http headers sent to uas
#    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdpr=0
#    Then I expect delivery

  @gdprstr
  @DynTagGdprStrUtIdUtPurposesIncludedEu
  Scenario: gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - dyntag request from eu
    Given I reset the http headers sent to uas
    And I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprstr
  @DynTagGdprStrUtIdUtPurposesIncludedNotEu
  Scenario: gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdprstr which includes ut vendor id and includes ut purpose ids
    Then I expect delivery

  @gdprstr
  @DynTagGdprStrUtIdIncludedUtPurposeIdsExcludedEu
  Scenario: gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then I expect req gdpr passback

  @gdprstr
  @DynTagGdprStrUtIdIncludedUtPurposeIdsExcludedNotEu
  Scenario: gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprstr
  @DynTagGdprStrUtIdExcludedUtPurposeIdsIncludedEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then I expect req gdpr passback


  @gdprstr
  @DynTagGdprStrUtIdExcludedUtPurposeIdsIncludedNotEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times an ad request for gdpr entities to UAS with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then I expect delivery


  @gdprstr
  @DynTagGdprStrUtIdExcludedUtPurposeIdsExcludedEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then I expect req gdpr passback

  @gdprstr
  @DynTagGdprStrUtIdExcludedUtPurposeIdsExcludedNotEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then I expect delivery

  @gdprstr
  @DynTagGdprStrEmptyStringEu
  Scenario: gdprstr=empty_string - dyntag request from eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with an empty gdprstr
    Then I expect req gdpr passback

  @gdprstr
  @DynTagGdprStrEmptyStringNotEu
  Scenario: gdprstr=empty_string - dyntag request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with an empty gdprstr
    Then I expect delivery