@GDPR
@cli
Feature: Gdpr test

  Scenario: zone request from European user with - device id + tsid + hhid
    Given I Delete req logs
    Given I Delete clk logs
    Given I Delete imp logs
    Given I add header of {x-forwarded-for} with value {2.15.255.254}
    When I send 5 times an ad request with parameter {deviceid=device_test1&tsid=ts_test1&hhid=hh_test1} for zone named {zone-zoneset-GDPR-1-a} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And I send impression requests to UAS immediately!
    And I send click requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-1-a-GDPR-banner-1} 100% of the time
    Then I read the latest req log file from uas
    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
    And The field zoneid in the 4 column of the req log is the same as in impression-url
    And The field User_identifier in the 3 column of the req log is "0"
    And The field IP in the 7 column of the req log is "0.0.0.0"
    And The field Referrer_URL in the 10 column of the req log is "\N"
    And The field Latitude in the 31 column of the req log is "0.000000"
    And The field Longitude in the 32 column of the req log is "0.000000"
    And The field Country_Code in the 35 column of the req log is "\N"
    And The field Region in the 36 column of the req log is "\N"
    And The field City in the 37 column of the req log is "\N"
    And The field DMA_Code in the 38 column of the req log is "-1"
    And The field Zip_Code in the 39 column of the req log is "\N"
    And The field GMT_offset in the 40 column of the req log is "0"
    And The field Netspeed in the 41 column of the req log is "\N"
    And The field ISP in the 42 column of the req log is "\N"
    And The field Contextual_category_id in the 26 column of the req log is "{}"
    And The field Contextual_language in the 27 column of the req log is "\N"
    And The field Contextual_status_code in the 28 column of the req log is "0"
    And The field Profile_ids in the 19 column of the req log is "{}"
#    And The field hhid in the 54 column of the req log is "{}"
    And The field Context_API in the 58 column of the req log is "{}"
    Then I read the latest imp log file from uas
    And The field User_identifier in the 3 column of the imp log is "0"
    And The field hhid in the 8 column of the imp log is "{}"
    Then I read the latest clk log file from uas
    And The field User_identifier in the 3 column of the clk log is "0"
    And The field IP in the 6 column of the clk log is "0.0.0.0"
    And The field Latitude in the 16 column of the clk log is "0"
    And The field Longitude in the 17 column of the clk log is "0"
    And The field Country_Code in the 19 column of the clk log is "\N"
    And The field Region in the 20 column of the clk log is "\N"
    And The field City in the 21 column of the clk log is "\N"
    And The field DMA_Code in the 22 column of the clk log is "-1"
    And The field Zip_Code in the 23 column of the clk log is "\N"
    And The field GMT_offset in the 24 column of the clk log is "0"
    And The field Netspeed in the 25 column of the clk log is "\N"
    And The field ISP in the 26 column of the clk log is "0.0.0.0"
    And The field Contextual_category_id in the 13 column of the clk log is "{}"
    And The field Contextual_language in the 14 column of the clk log is "\N"


#
#  Scenario: zone request from Non-European user with device id + tsid + hhid
#    Given I add header of {x-forwarded-for} with value {5.4.5.4}
#    When I send 5 times an ad request with parameter {unlimited=1&deviceid=dsnb&tsid=mfsds&hhid=mdn} for zone named {------?} to UAS
#    Then The response code is 200
#    And The response contains script
#    And The responses has impression-urls
#    And I send impression requests to UAS immediately!
#    And The impressionUrl has bannerid field matching the id of the banner named {-----?} 100% of the time
#    Then I read the latest req log file from uas
#    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
#    And The field zoneid in the 4 column of the req log is the same as in impression-url
#    And The field User_identifier in the 4 column of the req log is not "0"
#    And The field IP in the 8 column of the req log is not "0.0.0.0"
#    And The field Referrer_URL in the 11 column of the req log is not "\N"
#    And The field Latitude in the 32 column of the req log is not "0"
#    And The field Longitude in the 33 column of the req log is not "0"
#    And The field Country_Code in the 36 column of the req log is not "\N"
#    And The field Region in the 37 column of the req log is not "\N"
#    And The field City in the 38 column of the req log is not "\N"
#    And The field DMA_Code in the 39 column of the req log is not "-1"
#    And The field Zip_Code in the 40 column of the req log is not "\N"
#    And The field GMT_offset in the 41 column of the req log is not "0"
#    And The field Netspeed in the 42 column of the req log is not "\N"
#    And The field ISP in the 43 column of the req log is not "0.0.0.0"
#    And The field Contextual_category_id in the 27 column of the req log is not "{}"
#    And The field Contextual_language in the 28 column of the req log is not "\N"
#    And The field Contextual_status_code in the 29 column of the req log is not "0"
#    And The field Profile_ids in the 20 column of the req log is not "{}"
#    And The field hhid in the 55 column of the req log is not "???"
#    And The field Context_API in the 59 column of the req log is not "???"
#    Then I read the latest imp log file from uas
#    And The field User_identifier in the 4 column of the req log is not "0"
#    And The field hhid in the 9 column of the req log is not "???"
#    Then I read the latest clk log file from uas
#    And The field User_identifier in the 4 column of the req log is not "0"
#    And The field IP in the 7 column of the req log is not "0.0.0.0"
#    And The field Latitude in the 17 column of the req log is not "0"
#    And The field Longitude in the 18 column of the req log is not "0"
#    And The field Country_Code in the 20 column of the req log is not "\N"
#    And The field Region in the 21 column of the req log is not "\N"
#    And The field City in the 22 column of the req log is not "\N"
#    And The field DMA_Code in the 23 column of the req log is not "-1"
#    And The field Zip_Code in the 24 column of the req log is not "\N"
#    And The field GMT_offset in the 25 column of the req log is not "0"
#    And The field Netspeed in the 26 column of the req log is not "\N"
#    And The field ISP in the 27 column of the req log is not "0.0.0.0"
#    And The field Contextual_category_id in the 14 column of the req log is not "{}"
#    And The field Contextual_language in the 15 column of the req log is not "\N"
#
#  Scenario: zone request from European user without device id + tsid + hhid
#    Given I add header of {x-forwarded-for} with value {5.4.5.4}
#    When I send 5 times an ad request with parameter {unlimited=1} for zone named {------?} to UAS
#    Then The response code is 200
#    And The response contains script
#    And The responses has impression-urls
#    And I send impression requests to UAS immediately!
#    And The impressionUrl has bannerid field matching the id of the banner named {-----?} 100% of the time
#    Then I read the latest req log file from uas
#    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
#    And The field zoneid in the 4 column of the req log is the same as in impression-url
#    And The field User_identifier in the 4 column of the req log is "0"
#    And The field IP in the 8 column of the req log is "0.0.0.0"
#    And The field Referrer_URL in the 11 column of the req log is "\N"
#    And The field Latitude in the 32 column of the req log is "0"
#    And The field Longitude in the 33 column of the req log is "0"
#    And The field Country_Code in the 36 column of the req log is "\N"
#    And The field Region in the 37 column of the req log is "\N"
#    And The field City in the 38 column of the req log is "\N"
#    And The field DMA_Code in the 39 column of the req log is "-1"
#    And The field Zip_Code in the 40 column of the req log is "\N"
#    And The field GMT_offset in the 41 column of the req log is "0"
#    And The field Netspeed in the 42 column of the req log is "\N"
#    And The field ISP in the 43 column of the req log is "0.0.0.0"
#    And The field Contextual_category_id in the 27 column of the req log is "{}"
#    And The field Contextual_language in the 28 column of the req log is "\N"
#    And The field Contextual_status_code in the 29 column of the req log is "0"
#    And The field Profile_ids in the 20 column of the req log is "{}"
#    And The field hhid in the 55 column of the req log is "???"
#    And The field Context_API in the 59 column of the req log is "???"
#    Then I read the latest imp log file from uas
#    And The field User_identifier in the 4 column of the req log is "0"
#    And The field hhid in the 9 column of the req log is "???"
#    Then I read the latest clk log file from uas
#    And The field User_identifier in the 4 column of the req log is "0"
#    And The field IP in the 7 column of the req log is "0.0.0.0"
#    And The field Latitude in the 17 column of the req log is "0"
#    And The field Longitude in the 18 column of the req log is "0"
#    And The field Country_Code in the 20 column of the req log is "\N"
#    And The field Region in the 21 column of the req log is "\N"
#    And The field City in the 22 column of the req log is "\N"
#    And The field DMA_Code in the 23 column of the req log is "-1"
#    And The field Zip_Code in the 24 column of the req log is "\N"
#    And The field GMT_offset in the 25 column of the req log is "0"
#    And The field Netspeed in the 26 column of the req log is "\N"
#    And The field ISP in the 27 column of the req log is "0.0.0.0"
#    And The field Contextual_category_id in the 14 column of the req log is "{}"
#    And The field Contextual_language in the 15 column of the req log is "\N"
#
#  Scenario: zone request from Non-European user without device id + tsid + hhid
#    Given I add header of {x-forwarded-for} with value {5.4.5.4}
#    When I send 5 times an ad request with parameter {unlimited=1} for zone named {------?} to UAS
#    Then The response code is 200
#    And The response contains script
#    And The responses has impression-urls
#    And I send impression requests to UAS immediately!
#    And The impressionUrl has bannerid field matching the id of the banner named {-----?} 100% of the time
#    Then I read the latest req log file from uas
#    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
#    And The field zoneid in the 4 column of the req log is the same as in impression-url
#    And The field User_identifier in the 4 column of the req log is not "0"
#    And The field IP in the 8 column of the req log is not "0.0.0.0"
#    And The field Referrer_URL in the 11 column of the req log is not "\N"
#    And The field Latitude in the 32 column of the req log is not "0"
#    And The field Longitude in the 33 column of the req log is not "0"
#    And The field Country_Code in the 36 column of the req log is "israel"
#    And The field Region in the 37 column of the req log is not "\N"
#    And The field City in the 38 column of the req log is not "\N"
#    And The field DMA_Code in the 39 column of the req log is not "-1"
#    And The field Zip_Code in the 40 column of the req log is not "\N"
#    And The field GMT_offset in the 41 column of the req log is not "0"
#    And The field Netspeed in the 42 column of the req log is not "\N"
#    And The field ISP in the 43 column of the req log is not "0.0.0.0"
#    And The field Contextual_category_id in the 27 column of the req log is not "{}"
#    And The field Contextual_language in the 28 column of the req log is not "\N"
#    And The field Contextual_status_code in the 29 column of the req log is not "0"
#    And The field Profile_ids in the 20 column of the req log is not "{}"
#    And The field hhid in the 55 column of the req log is not "???"
#    And The field Context_API in the 59 column of the req log is not "???"
#    Then I read the latest imp log file from uas
#    And The field User_identifier in the 4 column of the req log is not "0"
#    And The field hhid in the 9 column of the req log is not "???"
#    Then I read the latest clk log file from uas
#    And The field User_identifier in the 4 column of the req log is not "0"
#    And The field IP in the 7 column of the req log is not "0.0.0.0"
#    And The field Latitude in the 17 column of the req log is not "0"
#    And The field Longitude in the 18 column of the req log is not "0"
#    And The field Country_Code in the 20 column of the req log is not "\N"
#    And The field Region in the 21 column of the req log is not "\N"
#    And The field City in the 22 column of the req log is not "\N"
#    And The field DMA_Code in the 23 column of the req log is not "-1"
#    And The field Zip_Code in the 24 column of the req log is not "\N"
#    And The field GMT_offset in the 25 column of the req log is not "0"
#    And The field Netspeed in the 26 column of the req log is not "\N"
#    And The field ISP in the 27 column of the req log is not "0.0.0.0"
#    And The field Contextual_category_id in the 14 column of the req log is not "{}"
#    And The field Contextual_language in the 15 column of the req log is not "\N"
#
#  Scenario: zone request for server programmatic flow from Non-European user
#    Given I add header of {x-forwarded-for} with value {5.4.5.4}
#    When I send 5 times an ad request with parameter {unlimited=1} for zone named {------?} to UAS
#    Then The response code is 200
#    And The response contains script
#    And The responses has impression-urls
#    And I send impression requests to UAS immediately!
#    And The impressionUrl has bannerid field matching the id of the banner named {-----?} 100% of the time
#    Then I read the latest req log file from uas
#    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
#    And The field zoneid in the 4 column of the req log is the same as in impression-url
#    And The field User_identifier in the 4 column of the req log is "0"
#    And The field IP in the 8 column of the req log is "0.0.0.0"
#    And The field Referrer_URL in the 11 column of the req log is "\N"
#    And The field Latitude in the 32 column of the req log is "0"
#    And The field Longitude in the 33 column of the req log is "0"
#    And The field Country_Code in the 36 column of the req log is "\N"
#    And The field Region in the 37 column of the req log is "\N"
#    And The field City in the 38 column of the req log is "\N"
#    And The field DMA_Code in the 39 column of the req log is "-1"
#    And The field Zip_Code in the 40 column of the req log is "\N"
#    And The field GMT_offset in the 41 column of the req log is "0"
#    And The field Netspeed in the 42 column of the req log is "\N"
#    And The field ISP in the 43 column of the req log is "0.0.0.0"
#    And The field Contextual_category_id in the 27 column of the req log is "{}"
#    And The field Contextual_language in the 28 column of the req log is "\N"
#    And The field Contextual_status_code in the 29 column of the req log is "0"
#    And The field Profile_ids in the 20 column of the req log is "{}"
#    And The field hhid in the 55 column of the req log is "???"
#    And The field Context_API in the 59 column of the req log is "???"
#    Then I read the latest imp log file from uas
#    And The field User_identifier in the 4 column of the req log is "0"
#    And The field hhid in the 9 column of the req log is "???"
#    Then I read the latest clk log file from uas
#    And The field User_identifier in the 4 column of the req log is "0"
#    And The field IP in the 7 column of the req log is "0.0.0.0"
#    And The field Latitude in the 17 column of the req log is "0"
#    And The field Longitude in the 18 column of the req log is "0"
#    And The field Country_Code in the 20 column of the req log is "\N"
#    And The field Region in the 21 column of the req log is "\N"
#    And The field City in the 22 column of the req log is "\N"
#    And The field DMA_Code in the 23 column of the req log is "-1"
#    And The field Zip_Code in the 24 column of the req log is "\N"
#    And The field GMT_offset in the 25 column of the req log is "0"
#    And The field Netspeed in the 26 column of the req log is "\N"
#    And The field ISP in the 27 column of the req log is "0.0.0.0"
#    And The field Contextual_category_id in the 14 column of the req log is "{}"
#    And The field Contextual_language in the 15 column of the req log is "\N"
#
#  Scenario: zone request for server programmatic flow from European user
#    Given I add header of {x-forwarded-for} with value {5.4.5.4}
#    When I send 5 times an ad request with parameter {unlimited=1} for zone named {------?} to UAS
#    Then The response code is 200
#    And The response contains script
#    And The responses has impression-urls
#    And I send impression requests to UAS immediately!
#    And The impressionUrl has bannerid field matching the id of the banner named {-----?} 100% of the time
#    Then I read the latest req log file from uas
#    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
#    And The field zoneid in the 4 column of the req log is the same as in impression-url
#    And The field User_identifier in the 4 column of the req log is not "0"
#    And The field IP in the 8 column of the req log is not "0.0.0.0"
#    And The field Referrer_URL in the 11 column of the req log is not "\N"
#    And The field Latitude in the 32 column of the req log is not "0"
#    And The field Longitude in the 33 column of the req log is not "0"
#    And The field Country_Code in the 36 column of the req log is not "\N"
#    And The field Region in the 37 column of the req log is not "\N"
#    And The field City in the 38 column of the req log is not "\N"
#    And The field DMA_Code in the 39 column of the req log is not "-1"
#    And The field Zip_Code in the 40 column of the req log is not "\N"
#    And The field GMT_offset in the 41 column of the req log is not "0"
#    And The field Netspeed in the 42 column of the req log is not "\N"
#    And The field ISP in the 43 column of the req log is not "0.0.0.0"
#    And The field Contextual_category_id in the 27 column of the req log is not "{}"
#    And The field Contextual_language in the 28 column of the req log is not "\N"
#    And The field Contextual_status_code in the 29 column of the req log is not "0"
#    And The field Profile_ids in the 20 column of the req log is not "{}"
#    And The field hhid in the 55 column of the req log is not "???"
#    And The field Context_API in the 59 column of the req log is not "???"
#    Then I read the latest imp log file from uas
#    And The field User_identifier in the 4 column of the req log is not "0"
#    And The field hhid in the 9 column of the req log is not "???"
#    Then I read the latest clk log file from uas
#    And The field User_identifier in the 4 column of the req log is not "0"
#    And The field IP in the 7 column of the req log is not "0.0.0.0"
#    And The field Latitude in the 17 column of the req log is not "0"
#    And The field Longitude in the 18 column of the req log is not "0"
#    And The field Country_Code in the 20 column of the req log is not "\N"
#    And The field Region in the 21 column of the req log is not "\N"
#    And The field City in the 22 column of the req log is not "\N"
#    And The field DMA_Code in the 23 column of the req log is not "-1"
#    And The field Zip_Code in the 24 column of the req log is not "\N"
#    And The field GMT_offset in the 25 column of the req log is not "0"
#    And The field Netspeed in the 26 column of the req log is not "\N"
#    And The field ISP in the 27 column of the req log is not "0.0.0.0"
#    And The field Contextual_category_id in the 14 column of the req log is not "{}"
#    And The field Contextual_language in the 15 column of the req log is not "\N"

#  ---------------------------------------------------------------------------------

#   Scenario: DT request from European user with - device id + tsid + hhid
#     Given I add header of {x-forwarded-for} with value {176.31.84.249}
#    Then i send 5 times Dynamic Tag ad request to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&deviceid=device_test1&tsid=ts_test1&hhid=hh_test1}
#     Then The response code is 200
#     And The response contains script
#     And The responses has impression-urls
#     And I send impression requests to UAS immediately!
#     And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-SS-1-banner-1} 100% of the time
#     Then I read the latest req log file from uas
#     Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
#     And The field zoneid in the 4 column of the req log is the same as in impression-url
#     And The field User_identifier in the 4 column of the req log is "0"
#     And The field IP in the 8 column of the req log is "0.0.0.0"
#     And The field Referrer_URL in the 11 column of the req log is "\N"
#     And The field Latitude in the 32 column of the req log is "0"
#     And The field Longitude in the 33 column of the req log is "0"
#     And The field Country_Code in the 36 column of the req log is "\N"
#     And The field Region in the 37 column of the req log is "\N"
#     And The field City in the 38 column of the req log is "\N"
#     And The field DMA_Code in the 39 column of the req log is "-1"
#     And The field Zip_Code in the 40 column of the req log is "\N"
#     And The field GMT_offset in the 41 column of the req log is "0"
#     And The field Netspeed in the 42 column of the req log is "\N"
#     And The field ISP in the 43 column of the req log is "0.0.0.0"
#     And The field Contextual_category_id in the 27 column of the req log is "{}"
#     And The field Contextual_language in the 28 column of the req log is "\N"
#     And The field Contextual_status_code in the 29 column of the req log is "0"
#     And The field Profile_ids in the 20 column of the req log is "{}"
#     And The field hhid in the 55 column of the req log is "???"
#     And The field Context_API in the 59 column of the req log is "???"
#     Then I read the latest imp log file from uas
#     And The field User_identifier in the 4 column of the req log is "0"
#     And The field hhid in the 9 column of the req log is "???"
#     Then I read the latest clk log file from uas
#     And The field User_identifier in the 4 column of the req log is "0"
#     And The field IP in the 7 column of the req log is "0.0.0.0"
#     And The field Latitude in the 17 column of the req log is "0"
#     And The field Longitude in the 18 column of the req log is "0"
#     And The field Country_Code in the 20 column of the req log is "\N"
#     And The field Region in the 21 column of the req log is "\N"
#     And The field City in the 22 column of the req log is "\N"
#     And The field DMA_Code in the 23 column of the req log is "-1"
#     And The field Zip_Code in the 24 column of the req log is "\N"
#     And The field GMT_offset in the 25 column of the req log is "0"
#     And The field Netspeed in the 26 column of the req log is "\N"
#     And The field ISP in the 27 column of the req log is "0.0.0.0"
#     And The field Contextual_category_id in the 14 column of the req log is "{}"
#     And The field Contextual_language in the 15 column of the req log is "\N"
##
#  Scenario: DT request from Non-European user with device id + tsid + hhid
#    #    Given
#  Scenario: DT request from European user without device id + tsid + hhid
##    Given
#
#  Scenario: DT request from Non-European user without device id + tsid + hhid
##    Given
#
#  Scenario: DT request for server programmatic flow from European user
##    Given
#
#  Scenario: DT request for server programmatic flow from Non-European user
##    Given
#
#
#
###  ---------------------------------------------------------------------------------
##
#  Scenario: HB request from European user with - device id + tsid + hhid
#    Given I add header of {x-forwarded-for} with value {176.31.84.249}
#    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-HB-Tablet-160x600}
#    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
#    Then I read the latest req log file from uas
#    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
#    And The field zoneid in the 4 column of the req log is the same as in impression-url
#    And The field User_identifier in the 4 column of the req log is "0"
#    And The field IP in the 8 column of the req log is "0.0.0.0"
#    And The field Referrer_URL in the 11 column of the req log is "\N"
#    And The field Latitude in the 32 column of the req log is "0"
#    And The field Longitude in the 33 column of the req log is "0"
#    And The field Country_Code in the 36 column of the req log is "\N"
#    And The field Region in the 37 column of the req log is "\N"
#    And The field City in the 38 column of the req log is "\N"
#    And The field DMA_Code in the 39 column of the req log is "-1"
#    And The field Zip_Code in the 40 column of the req log is "\N"
#    And The field GMT_offset in the 41 column of the req log is "0"
#    And The field Netspeed in the 42 column of the req log is "\N"
#    And The field ISP in the 43 column of the req log is "0.0.0.0"
#    And The field Contextual_category_id in the 27 column of the req log is "{}"
#    And The field Contextual_language in the 28 column of the req log is "\N"
#    And The field Contextual_status_code in the 29 column of the req log is "0"
#    And The field Profile_ids in the 20 column of the req log is "{}"
#    And The field hhid in the 55 column of the req log is "???"
#    And The field Context_API in the 59 column of the req log is "???"
#    Then I read the latest imp log file from uas
#    And The field User_identifier in the 4 column of the req log is "0"
#    And The field hhid in the 9 column of the req log is "???"
#    Then I read the latest clk log file from uas
#    And The field User_identifier in the 4 column of the req log is "0"
#    And The field IP in the 7 column of the req log is "0.0.0.0"
#    And The field Latitude in the 17 column of the req log is "0"
#    And The field Longitude in the 18 column of the req log is "0"
#    And The field Country_Code in the 20 column of the req log is "\N"
#    And The field Region in the 21 column of the req log is "\N"
#    And The field City in the 22 column of the req log is "\N"
#    And The field DMA_Code in the 23 column of the req log is "-1"
#    And The field Zip_Code in the 24 column of the req log is "\N"
#    And The field GMT_offset in the 25 column of the req log is "0"
#    And The field Netspeed in the 26 column of the req log is "\N"
#    And The field ISP in the 27 column of the req log is "0.0.0.0"
#    And The field Contextual_category_id in the 14 column of the req log is "{}"
#    And The field Contextual_language in the 15 column of the req log is "\N"
#
#  Scenario: HB request from Non-European user with device id + tsid + hhid
##    Given
#
#  Scenario: HB request from European user without device id + tsid + hhid
##    Given
#
#  Scenario: HB request from Non-European user without device id + tsid + hhid
##    Given
#
#  Scenario: HB request for server programmatic flow from European user
##    Given
#
#  Scenario: HB request for server programmatic flow from Non-European user
##    Given
#
#
####  ---------------------------------------------------------------------------------
#
#  Scenario: Web event logging (wel) request from European user
#    Given I add header of {x-forwarded-for} with value {176.31.84.249}
#    Given I send 5 times an wel request with parameters {trackerid=5499&cb=870589&unlimited=0&replay=1} to UAS
#
#
#
#
#  Scenario: Web event logging (wel) request from Non-European user
##    Given
#    Given I send 5 times an wel request with parameters {trackerid=5499&cb=870589&unlimited=0&replay=1} to UAS
#
#  Scenario: Profile requests (prf) request from European user
##    Given
#    Given I send 5 times an profiles request with parameters {fdsfds} to UAS
#
#  Scenario: Profile requests (prf) request from Non-European user
##    Given
#    Given I send 5 times an profiles request with parameters {action_id=3&participant_id=431&rd=https://preferences-mgr.truste.com&nocache=0.5302127382325236&unlimited=0&replay=1} to UAS
#
#  Scenario: events requests (evt) request from European user
##    Given
#    Given I send 5 times an event log request with parameters {bannerid=1213419&campaignid=300008&zoneid=178707&clang=en&ccat=2261,3802,5198,5248,5252,7432,7435,7496,7510,7526,7528,7529,7531,7541,7545,7546,7548,7549,7553,7554,9448,10288,12393,12752,12940,13475,15963,16621,16951,17114,17183,17186,17191,17433,17764,17845,17869,18161,18208,18853,19047,20812,20838,21314,21316,21318,21319,24146,24184,25086,32793,32851,33128&cb=323bc19ef9784d82b8b1c905d7bb0243&bk=p6r9eb&id=2fnr92i6abl9yws97kypzwot3&stid=109&uasv=v22&st=https%3A%2F%2Fwww.blackpoolgazette.co.uk%2Fnews%2Fcrime%2Fresort-police-surround-house-after-man-stabbed-1-9101170&e=MOAT.full-measurable&ord=1523004007976&unlimited=0&replay=1} to UAS
#
#  Scenario: events requests (evt) request from Non-European user
##    Given
#  Given I send 5 times an event log request with parameters {fdsfds} to UAS


##  ---------------------------------------------------------------------------------

