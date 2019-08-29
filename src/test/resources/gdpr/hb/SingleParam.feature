@GDPR
@UtConsent
@hbSingleGdprParam
@hbConsent
@parallel
Feature: GDPR - Header Bidding Reqs - Europe Delivery Logic - Single Gdpr Param Is Specified In URL

  @gdpr
  @GdprTrueParamEu
  Scenario: gdpr=1 - hb request from Eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for gdpr entities with gdpr=1
    Then I expect hbl gdpr passback

  @gdpr
  @GdprTrueParamNotEu
  Scenario: gdpr=1 - hb request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for gdpr entities with gdpr=1
    Then I expect hbl gdpr passback

  @gdpr
  @GdprFalseParamEu
  Scenario: gdpr=0 - hb request from Eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for gdpr entities with gdpr=0
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdpr
  @GdprFalseParamNotEu
  Scenario: gdpr=0 - hb request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for gdpr entities with gdpr=0
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprstr
  @hbGdprStrUtIdUtPurposesIncludedEu
  Scenario: gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for gdpr entities with gdprstr which includes ut vendor id and includes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprstr
  @hbGdprStrUtIdUtPurposesIncludedNotEu
  Scenario: gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - hb request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for gdpr entities with gdprstr which includes ut vendor id and includes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprstr
  @hbGdprStrUtIdIncludedUtPurposeIdsExcludedEu
  Scenario: gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for gdpr entities with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then I expect hbl gdpr passback

  @gdprstr
  @hbGdprStrUtIdIncludedUtPurposeIdsExcludedNotEu
  Scenario: gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - hb request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for gdpr entities with gdprstr which includes ut vendor id and excludes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprstr
  @hbGdprStrUtIdExcludedUtPurposeIdsIncludedEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for gdpr entities with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then I expect hbl gdpr passback


  @gdprstr
  @hbGdprStrUtIdExcludedUtPurposeIdsIncludedNotEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - hb request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for gdpr entities with gdprstr which excludes ut vendor id and includes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprstr
  @hbGdprStrUtIdExcludedUtPurposeIdsExcludedEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for gdpr entities with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then I expect hbl gdpr passback

  @gdprstr
  @hbGdprStrUtIdExcludedUtPurposeIdsExcludedNotEu
  Scenario: gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - hb request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for gdpr entities with gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprstr
  @hbGdprStrEmptyStringEu
  Scenario: gdprstr=empty_string - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for gdpr entities with an empty gdprstr
    Then I expect hbl gdpr passback

  @gdprstr
  @hbGdprStrEmptyStringNotEu
  Scenario: gdprstr=empty_string - hb request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for gdpr entities with an empty gdprstr
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}
