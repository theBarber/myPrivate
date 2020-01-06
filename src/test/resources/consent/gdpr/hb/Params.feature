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
  Scenario: gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for consent entities with gdpr=1 and gdprstr which includes ut vendor id and includes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - hb request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities with gdpr=1 and gdprstr which includes ut vendor id and includes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for consent entities with gdpr=1 and gdprstr which includes ut vendor id and excludes ut purpose ids
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - hb request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities with gdpr=1 and gdprstr which includes ut vendor id and excludes ut purpose ids
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for consent entities with gdpr=1 and gdprstr which excludes ut vendor id and includes ut purpose ids
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - hb request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities with gdpr=1 and gdprstr which excludes ut vendor id and includes ut purpose ids
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for consent entities with gdpr=1 and gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities with gdpr=1 and gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=empty_string - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for consent entities with gdpr=1 and an empty gdprstr
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=empty_string - hb request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities with gdpr=1 and an empty gdprstr
    Then The response code is 204

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for consent entities with gdpr=0 and gdprstr which includes ut vendor id and includes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - hb request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities with gdpr=0 and gdprstr which includes ut vendor id and includes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for consent entities with gdpr=0 and gdprstr which includes ut vendor id and excludes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - hb request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities with gdpr=0 and gdprstr which includes ut vendor id and excludes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for consent entities with gdpr=0 and gdprstr which excludes ut vendor id and includes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - hb request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities with gdpr=0 and gdprstr which excludes ut vendor id and includes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for consent entities with gdpr=0 and gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_EXCLUDED - zone request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities with gdpr=0 and gdprstr which excludes ut vendor id and excludes ut purpose ids
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprgdprstr
  Scenario: gdpr=0 and gdprstr=empty_string - hb request from eu
    Given I add {UK} ip header
    And I send 1 times Header Bidding request for consent entities with gdpr=0 and an empty gdprstr
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}

  @gdprgdprstr
  Scenario: gdpr=1 and gdprstr=empty_string - hb request not from eu
    Given I reset the http headers sent to uas
    And I send 1 times Header Bidding request for consent entities with gdpr=0 and an empty gdprstr
    Then all HB responses contains bidRequestId with value {"21b46f0d859b35"}
    And all HB responses contains publisherId with value {3836}