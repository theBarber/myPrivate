  @Integration
  @cli
  @uas
  @stable
  Feature: Programmatic flow support
  
    Scenario: verify programmatic guarantee Ad delivered & win price written to UAS
        Given banner_id 1157881 linked to deal_id 10000 with IO 62355
        And banner_id 1157881 exist in s3 banner cache
        And banner_id 1157881 exist in ramp-lift-services banner cache
        Given I Delete req logs
        When I send 10 times an ad request with parameter {loc=test1.com} for zone named {INT829AMEX - Filmstrip 300x600} to UAS
        And The response has impression-url
        Then The response code is 200
        And The response contains script
        And The impressionUrl has bannerid field matching the id of the banner named {290505-10000-59-ramp-lift-programmatic-banner1-test} 100% of the time
        When I send impression requests to UAS
        Then I read the latest req log file from uas
        Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
        And The field bidNumebr in the 59 column of the req log is {2.000000}
        And The field isProgrammaticflag in the 60 column of the req log is {1}
        And The field domain in the 62 column of the req log is {test1.com}
