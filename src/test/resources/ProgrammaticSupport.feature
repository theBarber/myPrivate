  @cli
  @uas
  @stable
  Feature: Programmatic flow support
    Scenario: 1. verify programmatic guarantee Ad delivered & written in uas logs
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
                And I sleep for 5 seconds
                Then I read the latest req log file from uas
                Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
                And The field bidNumebr in the 59 column of the req log is {2.000000}
                And The field isProgrammaticflag in the 60 column of the req log is {1}
                And The field domain in the 62 column of the req log is {test1.com}

    Scenario: 2. programmatic guarantee ad vs nonGuarantee ad with the same priority,score and bid - verify guarantee has been selected
                Given I Delete req logs
                When I send 5 times an ad request with parameter {loc=test2.com} for zone id {171718} to UAS
                And The response has impression-url
                Then The response code is 200
                And The response contains script
                And The response contains 1158454
                And I sleep for 5 seconds
                Then I read the latest req log file from uas
                And The field isProgrammaticflag in the 60 column of the req log is {1}

    Scenario: 3. programmatic nonGuarantee ad 1 with bid:1 vs nonGuarantee 2 ad with bid:2 with the same priority,score - verify nonGuarantee 2 has been selected
                Given I Delete req logs
                When I send 5 times an ad request with parameter {loc=test3.com} for zone id {171730} to UAS
                And The response has impression-url
                Then The response code is 200
                And The response contains script
                And The response contains 1158520
                And I sleep for 5 seconds
                Then I read the latest req log file from uas
                And The field isProgrammaticflag in the 60 column of the req log is {1}

    Scenario: 4. programmatic guarantee ad 1 with bid:1 with high priority vs guarantee 2 ad with bid:2 with low priority with the same score - verify first ad (1158519) selected
                Given I Delete req logs
                When I send 5 times an ad request with parameter {loc=test4.com} for zone id {171731} to UAS
                Then The response code is 200
                And The response contains script
                And The response contains 1158519
                And I sleep for 5 seconds
                Then I read the latest req log file from uas
                And The field isProgrammaticflag in the 60 column of the req log is {1}

    Scenario: 5. programmatic direct ad 1 with bid:2 vs guarantee 2 ad with bid:1 that has higher priority - verify guarantee has been selected
                Given I Delete req logs
                When I send 5 times an ad request with parameter {loc=test5.com} for zone id {171732} to UAS
                And The response has impression-url
                Then The response code is 200
                And The response contains script
                And The response contains 1158476
                And I sleep for 5 seconds
                Then I read the latest req log file from uas
                And The field isProgrammaticflag in the 60 column of the req log is {1}

    Scenario: 6. programmatic direct ad 1 with bid:1 vs guarantee 2 ad with bid:0 that has higher priority - verify direct has been selected
                Given I Delete req logs
                When I send 5 times an ad request with parameter {loc=test6.com} for zone id {171732} to UAS
                And The response has impression-url
                Then The response code is 200
                And The response contains script
                And The response contains 1158475
                And I sleep for 5 seconds
                Then I read the latest req log file from uas
                And The field isProgrammaticflag in the 60 column of the req log is {1}


