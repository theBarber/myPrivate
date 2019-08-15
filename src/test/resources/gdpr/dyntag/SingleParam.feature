@GDPR
@UtConsent
@DynTagSingleGdprParam
Feature: GDPR - Zone Reqs - Europe Delivery Logic - Single Gdpr Param Is Specified In URL

  @DynTagGdprTrueParamEu
  Scenario: gdpr=1 - dyntag request from Eu
    Given I reset the http headers sent to uas
    And I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with parameter {gdpr=1}
    Then I expect gdpr passback

  @DynTagGdprTrueParamNotEu
  Scenario: gdpr=1 - dyntag request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with parameter {gdpr=1}
    Then I expect gdpr passback

  @DynTagGdprFalseParamEu
  Scenario: gdpr=0 - dyntag request from Eu
    Given I reset the http headers sent to uas
    And I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with parameter {gdpr=0}
    Then I expect delivery

  @DynTagGdprFalseParamNotEu
  Scenario: gdpr=0 - dyntag request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with parameter {gdpr=0}
    Then I expect delivery

 # אtodo - gdprstr