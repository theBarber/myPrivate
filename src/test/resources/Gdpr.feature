@GDPR
@ConsentString

Feature: GDPR - Europe Delivery Logic
# no param is specified
  Scenario: no params are specified - request from eu
    Given I add header of {X-Forwarded-For} with value {207.246.116.162}
    And I send 1 times an ad request with parameter {gdpr=1} for zone id {2} to UAS
    Then i print the responses

  Scenario: no params are specified - request not from eu
    Given I send 1 times an ad request for zone id {2} to UAS
    Then i print the responses




# one param is specified, the other is not
  # # gdpr
  Scenario: one param is specified and the other is not - gdpr=1 - request from eu
  Scenario: one param is specified and the other is not - gdpr=1 - request not from eu
  Scenario: one param is specified and the other is not - gdpr=0 - request from eu
  Scenario: one param is specified and the other is not - gdpr=0 - request not from eu

   # # gdprstr
  Scenario: one param is specified and the other is not - gdprstr=empty-string - request from eu
  Scenario: one param is specified and the other is not - gdprstr=empty-string - request not from eu
  Scenario: one param is specified and the other is not - gdprstr=ut-purpose-included-while-vendor-id-is-excluded - request from eu
  Scenario: one param is specified and the other is not - gdprstr=ut-purpose-included-while-vendor-id-is-excluded - request not from eu
  Scenario: one param is specified and the other is not - gdprstr=ut-purpose-excluded-while-vendor-id-is-included - request from eu
  Scenario: one param is specified and the other is not - gdprstr=ut-purpose-excluded-while-vendor-id-is-included - request not from eu
  Scenario: one param is specified and the other is not - gdprstr=ut-purpose-and-vendor-ids-are-excluded - request from eu
  Scenario: one param is specified and the other is not - gdprstr=ut-purpose-and-vendor-ids-are-excluded - request not from eu


# both of params are specified
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
  # duplicate all of the above with gdpr=0