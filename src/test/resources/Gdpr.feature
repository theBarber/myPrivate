@GDPR
@HeaderBidding
@cli
@scheduled
Feature: Gdpr test

  Scenario: zone request from European user with - device id + tsid + hhid
    Given I Delete req logs
    Given I Delete clk logs
    Given I Delete imp logs
    Given I add header of {referer} with value {sahar.com}
    Given I add header of {x-forwarded-for} with value {2.15.255.254}
    When I send 5 times an ad request with parameter {deviceid=device_test1&tsid=ts_test1&hhid=hh_test1} for zone named {zone-zoneset-GDPR-1-a} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And I send impression requests to UAS
    And I send click requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-1-a-GDPR-banner-1} 100% of the time
    And I sleep for 2 seconds
    Then I read the latest req log file from uas
    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
    And The field zoneid in the 4 column of the req log is the same as in impression-url
    And The field User_identifier in the 3 column of the req log is: 0
    And The field IP in the 7 column of the req log is: 0.0.0.0
    And The field Referrer_URL in the 10 column of the req log is: \N
    And The field Latitude in the 31 column of the req log is: 0.000000
    And The field Longitude in the 32 column of the req log is: 0.000000
    And The field Country_Code in the 35 column of the req log is: \N
    And The field Region in the 36 column of the req log is: \N
    And The field City in the 37 column of the req log is: \N
    And The field DMA_Code in the 38 column of the req log is: -1
    And The field Zip_Code in the 39 column of the req log is: \N
    And The field GMT_offset in the 40 column of the req log is: 0
    And The field Netspeed in the 41 column of the req log is: \N
    And The field ISP in the 42 column of the req log is: \N
    And The field Contextual_category_id in the 26 column of the req log is: {}
    And The field Contextual_language in the 27 column of the req log is: \N
    And The field Contextual_status_code in the 28 column of the req log is: 0
    And The field Profile_ids in the 19 column of the req log is: {}
    And The field hhid in the 54 column of the req log is: {"source":"ts_test1","data":{}}
    And The field Context_API in the 58 column of the req log is: {}
    Then I read the latest imp log file from uas
    And The field User_identifier in the 3 column of the imp log is: 0
    And The field hhid in the 8 column of the imp log is: {"source":"ts_test1","data":{}}
    Then I read the latest clk log file from uas
    And The field User_identifier in the 3 column of the clk log is: 0
    And The field IP in the 6 column of the clk log is: 0.0.0.0
    And The field Latitude in the 16 column of the clk log is: 0.000000
    And The field Longitude in the 17 column of the clk log is: 0.000000
    And The field Country_Code in the 19 column of the clk log is: \N
    And The field Region in the 20 column of the clk log is: \N
    And The field City in the 21 column of the clk log is: \N
    And The field DMA_Code in the 22 column of the clk log is: -1
    And The field Zip_Code in the 23 column of the clk log is: \N
    And The field GMT_offset in the 24 column of the clk log is: 0
    And The field Netspeed in the 25 column of the clk log is: \N
    And The field ISP in the 26 column of the clk log is: \N
    And The field Contextual_category_id in the 13 column of the clk log is: {}
    And The field Contextual_language in the 14 column of the clk log is: \N


  Scenario: zone request from Non-European user with device id + tsid + hhid
    Given I add header of {x-forwarded-for} with value {3.127.0.0}
    Given I add header of {referer} with value {sahar.com}
    Given I Delete req logs
    Given I Delete clk logs
    Given I Delete imp logs
    When I send 5 times an ad request with parameter {deviceid=device_test1&tsid=ts_test1&hhid=hh_test1} for zone named {zone-zoneset-GDPR-1-a} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    Given I add cookie UTID with value {8c09b6bc6fd7445ebff57d69687916b8} to my requests to uas
    And I send impression requests to UAS
    And I send click requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-1-a-GDPR-banner-1} 100% of the time
    And I sleep for 2 seconds
    Then I read the latest req log file from uas
    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
    And The field zoneid in the 4 column of the req log is the same as in impression-url
    And The field User_identifier in the 3 column of the req log is not: 0
    And The field IP in the 7 column of the req log is not: 0.0.0.0
    And The field Latitude in the 31 column of the req log is not: 0.000000
    And The field Longitude in the 32 column of the req log is not: 0.000000
    And The field Country_Code in the 35 column of the req log is not: \N
    And The field Region in the 36 column of the req log is not: \N
    And The field City in the 37 column of the req log is not: \N
    And The field DMA_Code in the 38 column of the req log is not: -1
    And The field Zip_Code in the 39 column of the req log is not: \N
    And The field GMT_offset in the 40 column of the req log is not: 0
    And The field Netspeed in the 41 column of the req log is not: \N
    And The field ISP in the 42 column of the req log is not: \N
    And The field hhid in the 54 column of the req log is not: {source:ts_test1,data:{}}
    Then I read the latest imp log file from uas
    And The field User_identifier in the 3 column of the imp log is not: 0
    Then I read the latest clk log file from uas
    And The field User_identifier in the 3 column of the clk log is not: 0
    And The field IP in the 6 column of the clk log is not: 0.0.0.0
    And The field Latitude in the 16 column of the clk log is not: 0.000000
    And The field Longitude in the 17 column of the clk log is not: 0.000000
    And The field Country_Code in the 19 column of the clk log is not: \N
    And The field Region in the 20 column of the clk log is not: \N
    And The field City in the 21 column of the clk log is not: \N
    And The field DMA_Code in the 22 column of the clk log is not: -1
    And The field Zip_Code in the 23 column of the clk log is not: \N
    And The field GMT_offset in the 24 column of the clk log is not: 0
    And The field Netspeed in the 25 column of the clk log is not: \N
    And The field ISP in the 26 column of the clk log is not: \N


  Scenario: zone request from European user without device id + tsid + hhid
    Given I Delete req logs
    Given I Delete clk logs
    Given I Delete imp logs
    Given I add header of {referer} with value {sahar.com}
    Given I add header of {x-forwarded-for} with value {2.15.255.254}
    When I send 5 times an ad request for zone named {zone-zoneset-GDPR-1-a} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And I send impression requests to UAS
    And I send click requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-1-a-GDPR-banner-1} 100% of the time
    And I sleep for 2 seconds
    Then I read the latest req log file from uas
    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
    And The field zoneid in the 4 column of the req log is the same as in impression-url
    And The field User_identifier in the 3 column of the req log is: 0
    And The field IP in the 7 column of the req log is: 0.0.0.0
    And The field Referrer_URL in the 10 column of the req log is: \N
    And The field Latitude in the 31 column of the req log is: 0.000000
    And The field Longitude in the 32 column of the req log is: 0.000000
    And The field Country_Code in the 35 column of the req log is: \N
    And The field Region in the 36 column of the req log is: \N
    And The field City in the 37 column of the req log is: \N
    And The field DMA_Code in the 38 column of the req log is: -1
    And The field Zip_Code in the 39 column of the req log is: \N
    And The field GMT_offset in the 40 column of the req log is: 0
    And The field Netspeed in the 41 column of the req log is: \N
    And The field ISP in the 42 column of the req log is: \N
    And The field Contextual_category_id in the 26 column of the req log is: {}
    And The field Contextual_language in the 27 column of the req log is: \N
    And The field Contextual_status_code in the 28 column of the req log is: 0
    And The field Profile_ids in the 19 column of the req log is: {}
    And The field hhid in the 54 column of the req log is: {}
    And The field Context_API in the 58 column of the req log is: {}
    Then I read the latest imp log file from uas
    And The field User_identifier in the 3 column of the imp log is: 0
    And The field hhid in the 8 column of the imp log is: {}
    Then I read the latest clk log file from uas
    And The field User_identifier in the 3 column of the clk log is: 0
    And The field IP in the 6 column of the clk log is: 0.0.0.0
    And The field Latitude in the 16 column of the clk log is: 0.000000
    And The field Longitude in the 17 column of the clk log is: 0.000000
    And The field Country_Code in the 19 column of the clk log is: \N
    And The field Region in the 20 column of the clk log is: \N
    And The field City in the 21 column of the clk log is: \N
    And The field DMA_Code in the 22 column of the clk log is: -1
    And The field Zip_Code in the 23 column of the clk log is: \N
    And The field GMT_offset in the 24 column of the clk log is: 0
    And The field Netspeed in the 25 column of the clk log is: \N
    And The field ISP in the 26 column of the clk log is: \N
    And The field Contextual_category_id in the 13 column of the clk log is: {}
    And The field Contextual_language in the 14 column of the clk log is: \N


  Scenario: zone request from Non-European user without device id + tsid + hhid
    Given I add cookie UTID with random value to my requests to uas
    Given I add header of {x-forwarded-for} with value {9.128.0.2}
    Given I add header of {referer} with value {sahar.com}
    Given I Delete req logs
    Given I Delete clk logs
    Given I Delete imp logs
    When I send 5 times an ad request for zone named {zone-zoneset-GDPR-1-a} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And I send impression requests to UAS
    And I send click requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-API-1-a-GDPR-banner-1} 100% of the time
    And I sleep for 2 seconds
    Then I read the latest req log file from uas
    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
    And The field zoneid in the 4 column of the req log is the same as in impression-url
    And The field User_identifier in the 3 column of the req log is not: "0"
    And The field IP in the 7 column of the req log is not: "0.0.0.0"
    And The field Latitude in the 31 column of the req log is not: "0.000000"
    And The field Longitude in the 32 column of the req log is not: "0.000000"
    And The field Country_Code in the 35 column of the req log is not: "\N"
    And The field Region in the 36 column of the req log is not: "\N"
    And The field City in the 37 column of the req log is not: "\N"
    And The field DMA_Code in the 38 column of the req log is not: "-1"
    And The field Zip_Code in the 39 column of the req log is not: "\N"
    And The field GMT_offset in the 40 column of the req log is not: "0"
    And The field Netspeed in the 41 column of the req log is not: "\N"
    And The field ISP in the 42 column of the req log is not: "\N"
    And The field hhid in the 54 column of the req log is not: "{source:ts_test1,data:{}}"
    Then I read the latest imp log file from uas
    And The field User_identifier in the 3 column of the imp log is not: "0"
    Then I read the latest clk log file from uas
    And The field User_identifier in the 3 column of the clk log is not: "0"
    And The field IP in the 6 column of the clk log is not: "0.0.0.0"
    And The field Latitude in the 16 column of the clk log is not: "0.000000"
    And The field Longitude in the 17 column of the clk log is not: "0.000000"
    And The field Country_Code in the 19 column of the clk log is not: "\N"
    And The field Region in the 20 column of the clk log is not: "\N"
    And The field City in the 21 column of the clk log is not: "\N"
    And The field DMA_Code in the 22 column of the clk log is not: "-1"
    And The field Zip_Code in the 23 column of the clk log is not: "\N"
    And The field GMT_offset in the 24 column of the clk log is not: "0"
    And The field Netspeed in the 25 column of the clk log is not: "\N"
    And The field ISP in the 26 column of the clk log is not: "\N"

  Scenario: zone request for server programmatic flow from both Non-European\European user
    Given I add header of {x-forwarded-for} with value {1.23.186.0}
    When I send 1 times an ad request with parameter {requestid=systemTestA&optimize=0} for zone named {zone-zoneset-server-prog-SS} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And I send impression requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    Given I add header of {x-forwarded-for} with value {2.16.4.11}
    When I send 1 times an ad request with parameter {requestid=systemTestA&optimize=0} for zone named {zone-zoneset-server-prog-SS} to UAS
    Then The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-3-banner-1} 100% of the time


##  ---------------------------------------------------------------------------------

   Scenario: DT request from European user with - device id + tsid + hhid
      Given I Delete req logs
      Given I Delete clk logs
      Given I Delete imp logs
      Given I add header of {referer} with value {sahar.com}
      Given I add header of {x-forwarded-for} with value {2.16.108.43}
      Then i send 5 times Dynamic Tag ad request to UAS for publisher 3690 with domain {DynamicTagInline.com&deviceid=device_test1&tsid=ts_test1&hhid=hh_test1}
      Then The response code is 200
      And The response contains script
      And The responses has impression-urls
      And I send impression requests to UAS
      And I sleep for 2 seconds
      Then I read the latest req log file from uas
      Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
      And The field zoneid in the 4 column of the req log is the same as in impression-url
      And The field User_identifier in the 3 column of the req log is: 0
      And The field IP in the 7 column of the req log is: 0.0.0.0
      And The field Referrer_URL in the 10 column of the req log is: \N
      And The field Latitude in the 31 column of the req log is: 0.000000
      And The field Longitude in the 32 column of the req log is: 0.000000
      And The field Country_Code in the 35 column of the req log is: \N
      And The field Region in the 36 column of the req log is: \N
      And The field City in the 37 column of the req log is: \N
      And The field DMA_Code in the 38 column of the req log is: -1
      And The field Zip_Code in the 39 column of the req log is: \N
      And The field GMT_offset in the 40 column of the req log is: 0
      And The field Netspeed in the 41 column of the req log is: \N
      And The field ISP in the 42 column of the req log is: \N
      And The field Contextual_category_id in the 26 column of the req log is: {}
      And The field Contextual_language in the 27 column of the req log is: \N
      And The field Contextual_status_code in the 28 column of the req log is: 0
      And The field Profile_ids in the 19 column of the req log is: {}
      And The field hhid in the 54 column of the req log is: {"source":"ts_test1","data":{"pid":3690}}
      And The field Context_API in the 58 column of the req log is: {}
      Then I read the latest imp log file from uas
      And The field User_identifier in the 3 column of the imp log is: 0
      And The field hhid in the 8 column of the imp log is: {"source":"ts_test1","data":{"pid":3690}}



  Scenario: DT request from Non-European user with device id + tsid + hhid
    Given I Delete req logs
    Given I Delete clk logs
    Given I Delete imp logs
    Given I add header of {referer} with value {sahar.com}
    Given I add header of {x-forwarded-for} with value {9.128.0.2}
    Then i send 5 times Dynamic Tag ad request to UAS for publisher 3690 with domain {DynamicTagInline.com&loc=http://ads.undertone.com&deviceid=device_test1&tsid=ts_test1&hhid=hh_test1&ct=1}
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And I sleep for 2 seconds
    Then I read the latest req log file from uas
    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
    And The field zoneid in the 4 column of the req log is the same as in impression-url
    And The field User_identifier in the 3 column of the req log is not: 0
    And The field IP in the 7 column of the req log is not: 0.0.0.0
    And The field Referrer_URL in the 10 column of the req log is not: \N
    And The field Latitude in the 31 column of the req log is not: 0.000000
    And The field Longitude in the 32 column of the req log is not: 0.000000
    And The field Country_Code in the 35 column of the req log is not: \N
    And The field Region in the 36 column of the req log is not: \N
    And The field City in the 37 column of the req log is not: \N
    And The field DMA_Code in the 38 column of the req log is not: -1
    And The field Zip_Code in the 39 column of the req log is not: \N
    And The field GMT_offset in the 40 column of the req log is not: 0
    And The field Netspeed in the 41 column of the req log is not: \N
    And The field ISP in the 42 column of the req log is not: \N
    And The field hhid in the 54 column of the req log is not: {source:ts_test1,data:{}}


  Scenario: DT request from European user without device id + tsid + hhid
      Given I Delete req logs
      Given I Delete clk logs
      Given I Delete imp logs
      Given I add header of {referer} with value {sahar.com}
      Given I add header of {x-forwarded-for} with value {2.16.108.43}
      Then i send 5 times Dynamic Tag ad request to UAS for publisher 3690 with domain {DynamicTagInline.com}
      Then The response code is 200
      And The response contains script
      And The responses has impression-urls
      And I send impression requests to UAS
      And I send click requests to UAS
      And I sleep for 2 seconds
      Then I read the latest req log file from uas
      Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
      And The field zoneid in the 4 column of the req log is the same as in impression-url
      And The field User_identifier in the 3 column of the req log is: 0
      And The field IP in the 7 column of the req log is: 0.0.0.0
      And The field Referrer_URL in the 10 column of the req log is: \N
      And The field Latitude in the 31 column of the req log is: 0.000000
      And The field Longitude in the 32 column of the req log is: 0.000000
      And The field Country_Code in the 35 column of the req log is: \N
      And The field Region in the 36 column of the req log is: \N
      And The field City in the 37 column of the req log is: \N
      And The field DMA_Code in the 38 column of the req log is: -1
      And The field Zip_Code in the 39 column of the req log is: \N
      And The field GMT_offset in the 40 column of the req log is: 0
      And The field Netspeed in the 41 column of the req log is: \N
      And The field ISP in the 42 column of the req log is: \N
      And The field Contextual_category_id in the 26 column of the req log is: {}
      And The field Contextual_language in the 27 column of the req log is: \N
      And The field Contextual_status_code in the 28 column of the req log is: 0
      And The field Profile_ids in the 19 column of the req log is: {}
      And The field hhid in the 54 column of the req log is: {}
      And The field Context_API in the 58 column of the req log is: {}
      Then I read the latest imp log file from uas
      And The field User_identifier in the 3 column of the imp log is: 0
      And The field hhid in the 8 column of the imp log is: {}

  Scenario: DT request from Non-European user without device id + tsid + hhid
  Given I Delete req logs
    Given I Delete clk logs
    Given I Delete imp logs
    Given I add cookie UTID with random value to my requests to uas
    Given I add header of {referer} with value {sahar.com}
    Given I add header of {x-forwarded-for} with value {9.128.0.2}
    Then i send 5 times Dynamic Tag ad request to UAS for publisher 3690 with domain {DynamicTagInline.com&loc=http://ads.undertone.com&ct=1}
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And I send impression requests to UAS
    And I sleep for 2 seconds
    Then I read the latest req log file from uas
    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
    And The field zoneid in the 4 column of the req log is the same as in impression-url
    And The field IP in the 7 column of the req log is not: 0.0.0.0
    And The field Referrer_URL in the 10 column of the req log is not: \N
    And The field Latitude in the 31 column of the req log is not: 0.000000
    And The field Longitude in the 32 column of the req log is not: 0.000000
    And The field Country_Code in the 35 column of the req log is not: \N
    And The field Region in the 36 column of the req log is not: \N
    And The field City in the 37 column of the req log is not: \N
    And The field DMA_Code in the 38 column of the req log is not: -1
    And The field Zip_Code in the 39 column of the req log is not: \N
    And The field GMT_offset in the 40 column of the req log is not: 0
    And The field Netspeed in the 41 column of the req log is not: \N
    And The field ISP in the 42 column of the req log is not: \N
    And The field hhid in the 54 column of the req log is not: {source:ts_test1,data:{}}


  Scenario: DT request for server programmatic flow from European / non-European user
    Given I add header of {x-forwarded-for} with value {9.128.0.2}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3711 with domain {test.com&requestid=systemTestA&optimize=0&tagid=196}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    Given I add header of {x-forwarded-for} with value {2.16.108.43}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3711 with domain {test.com&requestid=systemTestA&optimize=0&tagid=196}
    Then The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-3-banner-1} 100% of the time

##  ---------------------------------------------------------------------------------
#
  Scenario: HB request from European user
    Given I Delete req logs
    Given I Delete clk logs
    Given I Delete imp logs
    Given I add header of {referer} with value {sahar.com}
    Given I add header of {x-forwarded-for} with value {2.22.232.123}
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&optimize=0}
    And The response code is 200
    And The response contains script
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    And I sleep for 2 seconds
    Then I read the latest req log file from uas
    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
    And The field zoneid in the 4 column of the req log is the same as in impression-url
    And The field User_identifier in the 3 column of the req log is: 0
    And The field IP in the 7 column of the req log is: 0.0.0.0
    And The field Referrer_URL in the 10 column of the req log is: \N
    And The field Latitude in the 31 column of the req log is: 0.000000
    And The field Longitude in the 32 column of the req log is: 0.000000
    And The field Country_Code in the 35 column of the req log is: \N
    And The field Region in the 36 column of the req log is: \N
    And The field City in the 37 column of the req log is: \N
    And The field DMA_Code in the 38 column of the req log is: -1
    And The field Zip_Code in the 39 column of the req log is: \N
    And The field GMT_offset in the 40 column of the req log is: 0
    And The field Netspeed in the 41 column of the req log is: \N
    And The field ISP in the 42 column of the req log is: \N
    And The field Contextual_category_id in the 26 column of the req log is: {}
    And The field Contextual_language in the 27 column of the req log is: \N
    And The field Contextual_status_code in the 28 column of the req log is: 0
    And The field Profile_ids in the 19 column of the req log is: {}
    And The field hhid in the 54 column of the req log is: {}
    And The field Context_API in the 58 column of the req log is: {}
    Then I read the latest imp log file from uas
    And The field User_identifier in the 3 column of the imp log is: 0
    And The field hhid in the 8 column of the imp log is: {}


  Scenario: HB request from Non-European user
    Given I Delete req logs
    Given I Delete clk logs
    Given I Delete imp logs
    Given I add cookie UTID with random value to my requests to uas
    Given I add header of {referer} with value {sahar.com}
    Given I add header of {x-forwarded-for} with value {9.128.0.2}
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&optimize=0&loc=test.com}
    And The response code is 200
    And The response contains script
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    And I sleep for 2 seconds
    Then I read the latest req log file from uas
    Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
    And The field zoneid in the 4 column of the req log is the same as in impression-url
    And The field User_identifier in the 3 column of the req log is not: 0
    And The field IP in the 7 column of the req log is not: 0.0.0.0
    And The field Country_Code in the 35 column of the req log is not: \N
    And The field Region in the 36 column of the req log is not: \N
    And The field City in the 37 column of the req log is not: \N
    And The field DMA_Code in the 38 column of the req log is not: -1
    And The field Zip_Code in the 39 column of the req log is not: \N
    And The field GMT_offset in the 40 column of the req log is not: 0
    And The field Netspeed in the 41 column of the req log is not: \N
    And The field ISP in the 42 column of the req log is not: \N


  Scenario: HB request for server programmatic flow from European\non-European user
    Given I add header of {x-forwarded-for} with value {9.128.0.2}
    Given I add header of {referer} with value {sahar.com}
    Given i send 1 headerBidding post request for scenario {Send HB request for publisher 3711 - 1X1} for publisher 3711 with domain {test.com} with extra params {&optimize=0&requestid=systemTestA}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-server-prog-SS-1-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    Given I add header of {x-forwarded-for} with value {2.22.232.123}
    Given i send 1 headerBidding post request for scenario {Send HB request for publisher 3711 - 1X1} for publisher 3711 with domain {test.com} with extra params {&optimize=0&requestid=systemTestA}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-server-prog-SS-3-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-3-banner-1} 100% of the time


###  ---------------------------------------------------------------------------------
#
  Scenario: Web event logging (wel) request from European user
    Given I Delete wel logs
    Given I add header of {referer} with value {sahar.com}
    Given I add header of {x-forwarded-for} with value {2.15.255.212}
    Given I send 5 times an wel request with parameters {trackerid=5499&cb=870589} to UAS
    Given I sleep for 2 seconds
    And I read the latest wel log file from uas
    And The field User_identifier in the 2 column of the wel log is: 0
    And The field IP in the 10 column of the wel log is: 0.0.0.0
    And The field Latitude in the 19 column of the wel log is: 0
    And The field Longitude in the 20 column of the wel log is: 0
    And The field Country_Code in the 22 column of the wel log is: \N
    And The field Region in the 23 column of the wel log is: \N
    And The field City in the 24 column of the wel log is: \N
    And The field DMA_Code in the 25 column of the wel log is: -1
    And The field Zip_Code in the 26 column of the wel log is: \N
    And The field GMT_offset in the 27 column of the wel log is: 0
    And The field Netspeed in the 28 column of the wel log is: \N
    And The field ISP in the 29 column of the wel log is: \N
    And The field Contextual_category_id in the 14 column of the wel log is: {}
    And The field Contextual_language in the 15 column of the wel log is: \N

  Scenario: Web event logging (wel) request from Non-European user
    Given I Delete wel logs
    Given I add cookie UTID with random value to my requests to uas
    Given I add header of {referer} with value {sahar.com}
    Given I add header of {x-forwarded-for} with value {3.128.44.22}
    Given I send 5 times an wel request with parameters {trackerid=5499&cb=870589} to UAS
    Given I sleep for 2 seconds
    And I read the latest wel log file from uas
    And The field User_identifier in the 2 column of the wel log is not: 0
    And The field IP in the 10 column of the wel log is not: 0.0.0.0
    And The field Latitude in the 19 column of the wel log is not: 0
    And The field Longitude in the 20 column of the wel log is not: 0
    And The field Country_Code in the 22 column of the wel log is not: \N
    And The field Region in the 23 column of the wel log is not: \N
    And The field City in the 24 column of the wel log is not: \N
    And The field DMA_Code in the 25 column of the wel log is not: -1"
    And The field Zip_Code in the 26 column of the wel log is not: \N
    And The field GMT_offset in the 27 column of the wel log is not: 0
    And The field Netspeed in the 28 column of the wel log is not: \N
    And The field ISP in the 29 column of the wel log is not: \N
#
  Scenario: Profile requests (prf) request from European user
    Given I add header of {referer} with value {sahar.com}
    Given I Delete prf logs
    Given I add header of {referer} with value {sahar.com}
    Given I add header of {x-forwarded-for} with value {2.15.255.212}
    Given I send 5 times an profiles request with parameters {pid=51310&cb=8XU48n} to UAS
    And I sleep for 5 seconds
    And I read the latest prf log file from uas
    And The field User_identifier in the 2 column of the prf log is: 0
    And The field IP in the 5 column of the prf log is: 0.0.0.0
    And The field Country_Code in the 7 column of the prf log is: \N

  Scenario: Profile requests (prf) request from Non-European user
    Given I add cookie UTID with random value to my requests to uas
    Given I Delete prf logs
    Given I add header of {referer} with value {sahar.com}
    Given I add header of {x-forwarded-for} with value {3.128.44.22}
    Given I send 5 times an profiles request with parameters {pid=51310&cb=8XU48n} to UAS
    And I sleep for 5 seconds
    And I read the latest prf log file from uas
    And The field User_identifier in the 2 column of the prf log is not: 0
    And The field IP in the 5 column of the prf log is not: 0.0.0.0
    And The field Country_Code in the 7 column of the prf log is not: \N

  Scenario: events requests (evt) request from European user
    Given I Delete evt logs
    Given I add header of {referer} with value {sahar.com}
    Given I add header of {x-forwarded-for} with value {2.15.255.212}
    Given I send 5 times an event log request with parameters {bannerid=1213419&campaignid=300008&zoneid=178707&clang=en&ccat=2261,3802,5198,5248,5252,7432,7435,7496,7510,7526,7528,7529,7531,7541,7545,7546,7548,7549,7553,7554,9448,10288,12393,12752,12940,13475,15963,16621,16951,17114,17183,17186,17191,17433,17764,17845,17869,18161,18208,18853,19047,20812,20838,21314,21316,21318,21319,24146,24184,25086,32793,32851,33128&cb=323bc19ef9784d82b8b1c905d7bb0243&bk=p6r9eb&id=2fnr92i6abl9yws97kypzwot3&stid=109&uasv=v22&st=https%3A%2F%2Fwww.blackpoolgazette.co.uk%2Fnews%2Fcrime%2Fresort-police-surround-house-after-man-stabbed-1-9101170&e=MOAT.full-measurable&ord=1523004007976&replay=1} to UAS
    And I sleep for 2 seconds
    Then I read the latest evt log file from uas
    And The field User_identifier in the 7 column of the evt log is: 0
    And The field IP in the 5 column of the evt log is: 0.0.0.0
    And The field Referrer_URL in the 15 column of the evt log is: \N
    And The field Latitude in the 17 column of the evt log is: 0.000000
    And The field Longitude in the 18 column of the evt log is: 0.000000
    And The field Country_Code in the 20 column of the evt log is: \N
    And The field Region in the 21 column of the evt log is: \N
    And The field City in the 22 column of the evt log is: \N
    And The field DMA_Code in the 23 column of the evt log is: -1
    And The field Zip_Code in the 24 column of the evt log is: \N
    And The field GMT_offset in the 25 column of the evt log is: 0
    And The field Netspeed in the 26 column of the evt log is: \N
    And The field ISP in the 27 column of the evt log is: \N
    And The field Contextual_category_id in the 9 column of the evt log is: {}
    And The field Contextual_language in the 10 column of the evt log is: \N
    And The field Profile_ids in the 8 column of the evt log is: {}


  Scenario: events requests (evt) request from Non-European user
    Given I Delete evt logs
    Given I add header of {referer} with value {sahar.com}
    Given I add header of {x-forwarded-for} with value {3.128.44.22}
    Given I send 5 times an event log request with parameters {bannerid=1213419&campaignid=300008&zoneid=178707&clang=en&ccat=2261,3802,5198,5248,5252,7432,7435,7496,7510,7526,7528,7529,7531,7541,7545,7546,7548,7549,7553,7554,9448,10288,12393,12752,12940,13475,15963,16621,16951,17114,17183,17186,17191,17433,17764,17845,17869,18161,18208,18853,19047,20812,20838,21314,21316,21318,21319,24146,24184,25086,32793,32851,33128&cb=323bc19ef9784d82b8b1c905d7bb0243&bk=p6r9eb&id=2fnr92i6abl9yws97kypzwot3&stid=109&uasv=v22&st=https%3A%2F%2Fwww.blackpoolgazette.co.uk%2Fnews%2Fcrime%2Fresort-police-surround-house-after-man-stabbed-1-9101170&e=MOAT.full-measurable&ord=1523004007976&replay=1} to UAS
    And I sleep for 2 seconds
    Then I read the latest evt log file from uas
    And The field IP in the 5 column of the evt log is not: 0.0.0.0
    And The field Latitude in the 17 column of the evt log is not: 0.000000
    And The field Longitude in the 18 column of the evt log is not: 0.000000
    And The field Country_Code in the 20 column of the evt log is not: \N
    And The field Region in the 21 column of the evt log is not: \N
    And The field City in the 22 column of the evt log is not: \N
    And The field DMA_Code in the 23 column of the evt log is not: -1
    And The field Zip_Code in the 24 column of the evt log is not: \N
    And The field GMT_offset in the 25 column of the evt log is not: 0
    And The field Netspeed in the 26 column of the evt log is not: \N
    And The field ISP in the 27 column of the evt log is not: \N
    And The field Contextual_category_id in the 9 column of the evt log is not: {}
    And The field Contextual_language in the 10 column of the evt log is not: \N


###  ---------------------------------------------------------------------------------
#
