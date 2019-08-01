@HeaderBidding
@PLT
@parallel
@scheduled
@noAA
@HB
@DHB
@HB
Feature: Dynamic HB bid price

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: 1. IO line item with fix bid price, should take cpm from po line item
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB.basicTest1} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-1}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-1-banner-1}
    And all HB responses contains cpm with value {0.4}


  Scenario: 2. Publisher with dynamic bid price, campaign CPM < PO line item ,should take cpm from PO line item
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB.basicTest2} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-2}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-2-banner-1}
    And all HB responses contains cpm with value {0.4}

  Scenario: 3. Publisher with dynamic bid price, campaign CPM > PO line item ,should take cpm from campaign
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB.basicTest3} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-3}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-3-banner-1}
    And all HB responses contains cpm with value {0.6}


  Scenario: 4. campaign with dynamic bid price, campaign desktop > po line item > campaign mobile
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB.basicTest4} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-4}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-4-banner-1}
    And all HB responses contains cpm with value {0.4}
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB.basicTest4} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-4}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-4-banner-1}
    And all HB responses contains cpm with value {0.5}


  Scenario: 5a. + 5b. publisher with dynamic bid price for adsize 1*2 = 9, fixed price for adsize 300*250
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB.basicTest5} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-ST-1x2-5a}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-ST-1x2-5a-banner-1}
    And all HB responses contains cpm with value {0.6}
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 300 size2 = 250, with domain {DHB.basicTest5} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-Desktop-300X250-5b}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-Desktop-300X250-5b-banner-1}
    And all HB responses contains cpm with value {0.3}

#  Scenario: Publisher with fixed bid price, Campaign with fixed HB
#    Set fixed HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#    Set floor price
#    Given i update floor_price for publisher = 3836 for adunit = 10 to be 4
#    Campaign Direct
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin.com} and extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-no-margin-MR-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-direct-no-margin-MR-ES-banner-1}
#    And all HB responses contains cpm with value {10}

  Scenario: Publisher with fixed bid price, Campaign with fixed HB
    Given I Delete hbl logs
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with fixed bid price for campaign with fixed HB} for publisher 3836 with domain {DynamicPricingWithMargin.com} with extra params {&unlimited=1&optimize=0&sim_geo=1&country=us}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-no-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-direct-no-margin-MR-ES-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-dpm-direct-no-margin-MR-ES}
    And all HB responses contains cpm with id 10
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
#    And I send impression requests to UAS
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-dpm-direct-no-margin-MR-ES-banner-1} 100% of the time
#    And The impressionUrl has campaignid field matching the id of the campaign named {campaign-dpm-direct-no-margin-MR-ES-banner-1} 100% of the time
#    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-dpm-direct-no-margin-MR-ES} 100% of the time
#    And I read the latest hbl log file from uas
#    And The field bannerid in the 12 column of the hbl log is the same as in impression-url
#    And The field campaignid in the 13 column of the hbl log is the same as in impression-url
#    And The field zoneid in the 14 column of the hbl log is the same as in impression-url
#    And The field bid_request_id in the 30 column of the hbl log is: 21b46f0d859b34
#    And The field Bid_price in the 15 column of the hbl log is: 1.00
#    And The field Publisher_id in the 3 column of the hbl log is: 3836
#    And The field Domain in the 5 column of the hbl log is: DynamicPricingWithMargin.com
#



#  Scenario: Publisher with fixed bid price, Campaign Reserved with fixed HB
#    #Set fixed HB
#    #Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#    #Set floor price
#    #Given i update floor_price for publisher = 3836 for adunit = 10 to be 4
#    #Campaign Reserved
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin1.com} and extra params {&requestid=OX-und-meow123&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-reserved-no-margin-MR-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-reserved-no-margin-MR-ES-banner-1}
#    And all HB responses contains cpm with value {10}

  Scenario: Publisher with fixed bid price, Campaign with fixed HB
    Given I Delete hbl logs
    Given i send 1 headerBidding post request for scenario {Send HB request for publisher 3836 with fixed bid price for campaign Reserved with fixed HB with fixed HB} for publisher 3836 with domain {DynamicPricingWithMargin1.com} with extra params {&unlimited=1&optimize=0&sim_geo=1&country=us}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-dpm-reserved-no-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-reserved-no-margin-MR-ES-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-dpm-reserved-no-margin-MR-ES}
    And all HB responses contains cpm with id 10
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script

#  Scenario: Publisher with fixed bid price, Campaign Non-Reserved with fixed HB
#    #Set fixed HB
#    #Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#    #Set floor price
#    #Given i update floor_price for publisher = 3836 for adunit = 10 to be 4
#    #Campaign Non-Reserved
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin2.com} and extra params {&requestid=OX-und-meow124&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-non-reserved-no-margin-MR-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-non-reserved-no-margin-MR-ES-banner-1}
#    And all HB responses contains cpm with value {10}
#    And I sleep for 5 seconds
#    Given I read the latest hbl log file from uas
#    And For bidID bid1 The field bid_request_id in the 30 column of the hbl log is: bid1
#    And For bidID bid1 The field Selected_Ad_Size in the 6 column of the hbl log is: [[1,2],[160,600]]
#    And For bidID bid1 The field Bid_price in the 15 column of the hbl log is: 1.00
#    And For bidID bid1 The field Publisher_id in the 3 column of the hbl log is: 3673
#    And For bidID bid1 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com


#  Scenario: Publisher with dynamic bid price, Campaign with dynamic HB
#    #Set dynamic HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 1
#    #floor price
#    #Given i update floor_price for publisher = 3836 for adunit = 10 to be 4
#    #Campaign Direct
#    #set margin for campaign
#    Given I set desktop margin 20% for campaign campaign-dpm-direct-margin-MR-ES
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin3.com} and extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-margin-MR-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-direct-margin-MR-ES-banner-1}
#    And all HB responses contains cpm with value {8}
#    #Campaign Reserved
#    #set margin for campaign
#    Given I set desktop margin 20% for campaign campaign-dpm-reserved-margin-MR-ES
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin4.com} and extra params {&requestid=OX-und-AG3aTv&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-reserved-margin-MR-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-reserved-margin-MR-ES-banner-1}
#    And all HB responses contains cpm with value {8}
#    #Campaign Non-Reserved
#    #set margin for campaign
#    Given I set desktop margin 20% for campaign campaign-dpm-non-reserved-margin-MR-ES
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin5.com} and extra params {&requestid=OX-und-AG3aTv&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-non-reserved-margin-MR-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-non-reserved-margin-MR-ES-banner-1}
#    And all HB responses contains cpm with value {8}
#
#  Scenario: Publisher with dynamic bid price, Campaign with fixed HB
#    #Set fixed HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#    #Set floor price
#    #Given i update floor_price for publisher = 3836 for adunit = 10 to be 4
#    #Campaign Direct
#    #set margin for campaign
#    Given I set desktop margin 90% for campaign campaign-dpm-direct-margin-MR-ES
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin.com} and extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-margin-MR-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-direct-margin-MR-ES-banner-1}
#    And all HB responses contains cpm with value {4}
#    #Campaign Reserved
#    #set margin for campaign
#    Given I set desktop margin 90% for campaign campaign-dpm-reserved-margin-MR-ES
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin1.com} and extra params {&requestid=OX-und-AG3aTv&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-reserved-margin-MR-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-reserved-margin-MR-ES-banner-1}
#    And all HB responses contains cpm with value {4}
#    #Campaign Non-Reserved
#    #set margin for campaign
#    Given I set desktop margin 90% for campaign campaign-non-reserved-margin-MR-ES
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin2.com} and extra params {&requestid=OX-und-AG3aTv&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-non-reserved-margin-MR-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-non-reserved-margin-MR-ES-banner-1}
#    And all HB responses contains cpm with value {4}
#
#  Scenario: Publisher with fixed bid price, Campaign with dynamic HB
#    #Set dynamic HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 1
#    #Set floor price
#    #Given i update floor_price for publisher = 3836 for adunit = 10 to be 4
#    #Campaign Direct
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin3.com} and extra params {&requestid=OX-und-AG3aTv&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-margin-MR-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-direct-margin-MR-ES-banner-1}
#    And all HB responses contains cpm with value {10}
#    #Campaign Reserved
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin4.com} and extra params {&requestid=OX-und-AG3aTv&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-reserved-margin-MR-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-reserved-margin-MR-ES-banner-1}
#    And all HB responses contains cpm with value {10}
#    #Campaign Non-Reserved
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin5.com} and extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-non-reserved-margin-MR-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-non-reserved-margin-MR-ES-banner-1}
#    And all HB responses contains cpm with value {10}



## PG tests
#  Scenario: 6a. + 6b. Server prog. publisher with dynamic bid price for adsize ST 1*2 = ?? , fixed price for adsize PGC 1*1 = ??. bidid price = 7.7 at mock
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3711 with size1 = 1 size2 = 2, with domain {HB-DynamicP-ServerPr} and extra params {&unlimited=1&optimize=0&requesrid=DynamicPriceHB-SP}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-HB-DP-ServerPr-ST-DynamicAtPub-6a}
#    And all HB responses contains adId with id of entity named {campaign-HB-DP-ServerPr-ST-DynamicAtPub-6a-banner-1}
#    And all HB responses contains cpm with value {0.6}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-DP-ServerPr-ST-DynamicAtPub-6a-banner-1} 100% of the time
#    And all HB responses contains cpm with value {0.6}
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3711 with size1 = 1 size2 = 1, with domain {HB-DynamicP-ServerPr} and extra params {&unlimited=1&optimize=0&requesrid=DynamicPriceHB-SP}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-HB-DP-ServerPr-PGC-6b}
#    And all HB responses contains adId with id of entity named {campaign-HB-DP-ServerPr-PGC-6b-banner-1}
#    And all HB responses contains cpm with value {0.2}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-DP-ServerPr-PGC-6b-banner-1} 100% of the time
#    And all HB responses contains cpm with value {0.2}