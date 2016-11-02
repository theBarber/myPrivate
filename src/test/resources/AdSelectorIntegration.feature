@cli
@uas
@campaign
Feature: UAS Integration with Ad Selector
@Sanity
@campaign
  @hardcoded
  Scenario: zone id that exist in zone cache but does not exist it plan
  Given Campaign Manager with hardcoded campaigns
  Given Loading test_plan thePlan to S3 directory ramp-optimization/runtime/hourly/solver

      When I send 11 times an ad request for zone named {qa.undertone.com - Full Banner} to UAS
      Then The response code is 200
      And The responses has impression-urls
      And The impressionUrl has bannerid field matching the id of the banner named {Test Banner1} 100% of the time
