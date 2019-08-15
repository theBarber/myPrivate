@GDPR
@UtConsent
Feature: GDPR - Zone Reqs - Europe Delivery Logic - Both Params Are Specified
  Scenario: gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - request from eu
  Scenario: gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_INCLUDED - request not from eu

  Scenario: gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_EXCLUDED - request from eu
  Scenario: gdpr=1 and gdprstr=UT_ID_AND_PURPOSE_ARE_EXCLUDED - request not from eu

  Scenario: gdpr=1 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - request from eu
  Scenario: gdpr=1 and gdprstr=UT_ID_INCLUDED_AND_PURPOSE_EXCLUDED - request not from eu
  Scenario: gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - request from eu
  Scenario: gdpr=1 and gdprstr=UT_ID_EXCLUDED_AND_PURPOSE_INCLUDED - request not from eu
  Scenario: gdpr=1 and gdprstr=EMPTY_STRING - request from eu
  Scenario: gdpr=1 and gdprstr=EMPTY_STRING - request not from eu


