@S3
Feature: S3Loader
<<<<<<< HEAD
@Sanity123
=======
@Sanity
@cli
>>>>>>> 35a0fa87f690b981a1dc486eb39ac97ecf1496a5
  Scenario: Download plan file slices from S3
    Given Loading new src/test/resources/input_files/solver_plan_test_niv_20160926_150916.json to ramp-optimization/runtime/hourly/solver/solver_plan_test_niv_20160926_150916.json s3
    When the add selector check for new plan in s3
    Then The ad selector new plan should be solver_plan_test_niv_20160926_150916.json

