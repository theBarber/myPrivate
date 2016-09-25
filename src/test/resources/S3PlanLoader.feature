@S3
Feature: S3Loader
@Sanity
  Scenario: Download plan file slices from S3
    Given Loading new aaaa to s3
    When the add selector check for new plan in s3
    Then The ad selector new plan lan.json should be lan.json

