@GDPR
@UtConsent
@ZoneReqSingleGdprParam
Feature: GDPR - Zone Reqs - Europe Delivery Logic - Single Gdpr Param Is Specified In URL

  @GdprTrueParamEu
  Scenario: gdpr=1 - zone request from Eu
    Given I add {UK} ip header
    And I send 1 times an ad request with parameter {gdpr=1} for gdpr entities to UAS
    Then I expect gdpr passback
    And I reset the http headers sent to uas

  @GdprTrueParamNotEu
  Scenario: gdpr=1 - zone request not from Eu
    Given I send 1 times an ad request with parameter {gdpr=1} for gdpr entities to UAS
    Then I expect gdpr passback
    And I reset the http headers sent to uas

  @GdprFalseParamEu
  Scenario: gdpr=0 - zone request from Eu
    Given I add {UK} ip header
    And I send 1 times an ad request with parameter {gdpr=0} for gdpr entities to UAS
    Then I expect delivery
    And I reset the http headers sent to uas

  @GdprFalseParamNotEu
  Scenario: gdpr=0 - zone request not from Eu
    Given I send 1 times an ad request with parameter {gdpr=0} for gdpr entities to UAS
    Then I expect delivery

 # אtodo - gdprstr