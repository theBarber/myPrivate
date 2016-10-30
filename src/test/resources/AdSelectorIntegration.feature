@cli @uas
Feature:
  Background:
    Given Loading test_plan thePlan to S3 directory ramp-optimization/runtime/hourly/solver
    Scenario: valid banner that pass all predicates (with existing zone)
      Given using zone id 11457 which includes in zone cache
      When sending request with new zone id 11457 to UAS
      Then get valid response from UAS
