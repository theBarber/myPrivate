@programmatic
    
Feature: Programmatic flow support

Background:  verify only campaign_id linked to zone_id
            verify deal_id exists in GW mock

    Scenario: verify programmatic guarantee Ad delivered & win price written to UAS
        Given banner_id 1157881 linked to deal_id 10000 with IO 62355
#        check if the banner exist in banner cache
        When I send 1 times an ad request for zone named {INT829AMEX - Filmstrip 300x600} to UAS
        Then The response code is 200
        And The response contains script
        And The impressionUrl has banner field matching the id of the banner named {290505-10000-59-ramp-lift-programmatic-banner1-test} 100% of the time
#        Given I Delete req logs
#        Then I read the latest req log file from uas
#        #verify win url for deal_id exists in UAS log
#        And I filter in the req log to the lines where id at column 53 is the same as in impression-url