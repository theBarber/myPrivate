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
  Scenario:1.0 gdpr=1 - zone request Country limitation --> Canada
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    When I send 1 times an ad request with parameter {gdpr=1} for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    Then I expect delivery


  @gdpr
  @GdprTrueParamNotEu
  Scenario:2.0 gdpr=1 - zone request - city limitation
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    When I send 1 times an ad request with parameter {gdpr=1} for zone named {zone-zoneset-city-limitation} to UAS
    Then The response code is 200
    And The responses are passback


  @gdpr
  @GdprFalseParamEu
  Scenario:3.0 gdpr=0 - zone request Country limitation --> Canada
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    When I send 1 times an ad request with parameter {gdpr=0} for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    Then I expect delivery



  @gdpr
  @GdprFalseParamNotEu
  Scenario:4.0 gdpr=0 - zone request - city limitation
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    When I send 1 times an ad request with parameter {gdpr=0} for zone named {zone-zoneset-city-limitation} to UAS
    Then I expect delivery


  @gdprstr
  @ZoneReqGdprStrUtIdUtPurposesIncludedEu
  Scenario:5.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - Country limitation --> Canada
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times an ad request for consent entities to UAS with gdprstr which includes ut vendor id and includes ut purpose ids for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    Then I expect delivery


  @gdprstr
  @ZoneReqGdprStrUtIdUtPurposesIncludedNotEu
  Scenario:6.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_INCLUDED - city limitation  (no gdpr param --> banner expected)
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times an ad request for consent entities to UAS with gdprstr which includes ut vendor id and includes ut purpose ids for zone named {zone-zoneset-city-limitation} to UAS
    Then I expect delivery



  @gdprstr
  @ZoneReqGdprStrUtIdIncludedUtPurposeIdsExcludedEu
  Scenario:7.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - Country limitation --> Canada
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times an ad request for consent entities to UAS with gdprstr which includes ut vendor id and excludes ut purpose ids for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    Then I expect delivery



  @gdprstr
  @ZoneReqGdprStrUtIdIncludedUtPurposeIdsExcludedNotEu
  Scenario:8.0 gdprstr=UT_ID_INCLUDED_UT_PURPOSE_IDS_EXCLUDED - city limitation (no gdpr param --> banner expected)
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times an ad request for consent entities to UAS with gdprstr which includes ut vendor id and excludes ut purpose ids for zone named {zone-zoneset-city-limitation} to UAS
    Then I expect delivery



  @gdprstr
  @ZoneReqGdprStrUtIdExcludedUtPurposeIdsIncludedEu
  Scenario:9.0 gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - Country limitation --> Canada
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times an ad request for consent entities to UAS with gdprstr which excludes ut vendor id and includes ut purpose ids for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    Then I expect delivery



  @gdprstr
  @ZoneReqGdprStrUtIdExcludedUtPurposeIdsIncludedNotEu
  Scenario:10.0 gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_INCLUDED - city limitation (no gdpr param --> banner expected)
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times an ad request for consent entities to UAS with gdprstr which excludes ut vendor id and includes ut purpose ids for zone named {zone-zoneset-city-limitation} to UAS
    Then I expect delivery


  @gdprstr
  @ZoneReqGdprStrUtIdExcludedUtPurposeIdsExcludedEu
  Scenario:11.0 gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - Country limitation --> Canada
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times an ad request for consent entities to UAS with gdprstr which excludes ut vendor id and excludes ut purpose ids for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrUtIdExcludedUtPurposeIdsExcludedNotEu
  Scenario:12.0 gdprstr=UT_ID_EXCLUDED_UT_PURPOSE_IDS_EXCLUDED - city limitation (no gdpr param --> banner expected)
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times an ad request for consent entities to UAS with gdprstr which excludes ut vendor id and excludes ut purpose ids for zone named {zone-zoneset-city-limitation} to UAS
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrEmptyStringEu
  Scenario:13.0 gdprstr=empty_string -  Country limitation --> Canada
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.206.151.131}
    And I send 1 times an ad request for consent entities to UAS with an empty gdprstr for zone named {zone-zoneset-state-bannerLevelLimit-ST} to UAS
    Then I expect delivery

  @gdprstr
  @ZoneReqGdprStrEmptyStringNotEu
  Scenario:14.0 gdprstr=empty_string -  city limitation (no gdpr param --> banner expected)
    Given I reset the http headers sent to uas
    Given I add header of {x-forwarded-for} with value {192.241.221.98}
    And I send 1 times an ad request for consent entities to UAS with an empty gdprstr for zone named {zone-zoneset-city-limitation} to UAS
    Then I expect delivery



