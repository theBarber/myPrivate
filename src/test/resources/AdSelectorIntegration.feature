@cli
@uas
@campaign
Feature: UAS Integration with Ad Selector
  Background:

@campaign
  @hardcoded
    Scenario: zone id that exist in zone cache but does not exist it plan
      Given Campaign Manager with hardcoded campaign
      When I send 11 times an ad request for zone named {qa.undertone.com - Full Banner} to UAS
      Then The response code is 200
      And The responses has impression-urls
      And The impressionUrl has bannerid field matching the id of the banner named {Test Banner1} 100% of the time
  @campaign
  @hardcoded
  Scenario: zone id that exist in zone cache and in plan
    Given Campaign Manager with hardcoded campaign and zone name {QA-INT03 - Half Page Ad 300x600 - INT03AFP - Half Page Ad}
    When I send 20 times an ad request for zone named {QA-INT03 - Half Page Ad 300x600 - INT03AFP - Half Page Ad} to UAS
    Then The response code is 200
    And The passback ratio should be 50%