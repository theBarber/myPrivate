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

#   Scenario: 1. IO line item with dynamic bid price, should take cpm from floor price
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB.basicTest1} and extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-1}
#    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-1-banner-1}
#    And all HB responses contains cpm with value {1}
#
#  Scenario: 2. Publisher with fixed bid price, campaign CPM < PO line item ,should take cpm from PO line item
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB.basicTest2} and extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-2}
#    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-2-banner-1}
#    And all HB responses contains cpm with value {0.4}
#
#  Scenario: 3. Publisher with fixed bid price, campaign CPM > PO line item ,should take cpm from PO line item
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB.basicTest3} and extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-3}
#    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-3-banner-1}
#    And all HB responses contains cpm with value {0.4}
#
#  Scenario: 4. Publisher with fixed bid price, campaign desktop > po line item > campaign mobile
#    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB.basicTest4} and extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-4}
#    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-4-banner-1}
#    And all HB responses contains cpm with value {0.4}
#    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
#    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB.basicTest4} and extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-4}
#    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-4-banner-1}
#    And all HB responses contains cpm with value {0.4}
#
#
#  Scenario: 5a. + 5b. publisher with dynamic bid price for adsize 1*2 = 9, fixed price for adsize 300*250
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB.basicTest5} and extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-ST-1x2-5a}
#    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-ST-1x2-5a-banner-1}
#    And all HB responses contains cpm with value {0.6}
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 300 size2 = 250, with domain {DHB.basicTest5} and extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-Desktop-300X250-5b}
#    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-Desktop-300X250-5b-banner-1}
#    And all HB responses contains cpm with value {0.3}

  Scenario: Publisher with fixed bid price for BB, Campaign with no margin
#  Set fixed HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#  Set floor price
#    Given i update floor_price for publisher = 3836 for adunit = 10 to be 4
#  Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with fixed bid price for campaign with no margin} for publisher 3836 with domain {DynamicPricingWithMargin.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-fixed-no-margin-BB-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-direct-fixed-no-margin-BB-ES-banner-1}
    And all HB responses contains cpm with value {1}

  Scenario: Publisher with fixed bid price for BB, Campaign with margin
    Given I Delete hbl logs
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with fixed bid price for campaign with margin} for publisher 3836 with domain {DynamicPricingWithMargin1.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-fixed-margin-BB-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-direct-fixed-margin-BB-ES-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-dpm-direct-fixed-margin-BB-ES}
    And all HB responses contains cpm with value {1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-dpm-direct-fixed-margin-BB-ES-banner-1} 100% of the time
#    And The impressionUrl has campaignid field matching the id of the campaign named {campaign-dpm-direct-fixed-margin-BB-ES} 100% of the time
#    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-dpm-direct-fixed-margin-BB-ES} 100% of the time
#    And I read the latest hbl log file from uas
#    And The field bannerid in the 12 column of the hbl log is the same as in impression-url
#    And The field campaignid in the 13 column of the hbl log is the same as in impression-url
#    And The field zoneid in the 14 column of the hbl log is the same as in impression-url
#    And The field bid_request_id in the 30 column of the hbl log is: 21b46f0d859b35
#    And The field Bid_price in the 15 column of the hbl log is: 1.00
#    And The field Publisher_id in the 3 column of the hbl log is: 3836
#    And The field Domain in the 5 column of the hbl log is: DynamicPricingWithMargin1.com

  Scenario: Publisher with dynamic bid price for MR, Campaign with no margin
#  Set fixed HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#  Set floor price
# Given i update floor_price for publisher = 3836 for adunit = 10 to be 2
#  Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with dynamic bid price for campaign with no margin} for publisher 3836 with domain {DynamicPricingWithMargin8.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-dynamic-no-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-direct-dynamic-no-margin-MR-ES-banner-1}
    And all HB responses contains cpm with value {2}

  Scenario: Publisher with dynamic bid price for MR, Campaign with margin
#  Set fixed HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#  Set floor price
# Given i update floor_price for publisher = 3836 for adunit = 10 to be 1
#  Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with dynamic bid price for campaign with margin} for publisher 3836 with domain {DynamicPricingWithMargin9.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-dynamic-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-direct-dynamic-margin-MR-ES-banner-1}
    And all HB responses contains cpm with value {2}


  Scenario: Publisher with reserved fixed bid price for BB, Campaign with margin
#  Set fixed HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#  Set floor price
#    Given i update floor_price for publisher = 3836 for adunit = 10 to be 4
#  Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with reserved fixed bid price for campaign with margin} for publisher 3836 with domain {DynamicPricingWithMargin10.com} with extra params {&requestid=ANbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-reserved-fixed-margin-BB-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-reserved-fixed-margin-BB-ES-banner-1}
    And all HB responses contains cpm with value {1}

  Scenario: Publisher with reserved fixed bid price for BB, Campaign with no margin
#  Set fixed HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#  Set floor price
#    Given i update floor_price for publisher = 3836 for adunit = 10 to be 4
#  Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with reserved fixed bid price for campaign with no margin} for publisher 3836 with domain {DynamicPricingWithMargin11.com} with extra params {&requestid=ANbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-reserved-fixed-no-margin-BB-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-reserved-fixed-no-margin-BB-ES-banner-1}
    And all HB responses contains cpm with value {1}

  Scenario: Publisher with reserved dynamic bid price for MR, Campaign with margin
#  Set fixed HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#  Set floor price
# Given i update floor_price for publisher = 3836 for adunit = 10 to be 1
#  Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with reserved dynamic bid price for campaign with margin} for publisher 3836 with domain {DynamicPricingWithMargin12.com} with extra params {&requestid=ANbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-reserved-dynamic-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-reserved-dynamic-margin-MR-ES-banner-1}
    And all HB responses contains cpm with value {2.4}

  Scenario: Publisher with reserved dynamic bid price for MR, Campaign with no margin
#  Set fixed HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#  Set floor price
#   Given i update floor_price for publisher = 3836 for adunit = 10 to be 2
#  Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with reserved dynamic bid price for campaign with no margin} for publisher 3836 with domain {DynamicPricingWithMargin13.com} with extra params {&requestid=ANbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-reserved-dynamic-no-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-reserved-dynamic-no-margin-MR-ES-banner-1}
    And all HB responses contains cpm with value {2}


  Scenario: Publisher with non reserved fixed bid price for BB, Campaign with margin
#  Set fixed HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#  Set floor price
#    Given i update floor_price for publisher = 3836 for adunit = 10 to be 4
#  Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with non reserved fixed bid price for campaign with margin} for publisher 3836 with domain {DynamicPricingWithMargin4.com} with extra params {&requestid=OXbidDynMarg&unlimited=1&optimize=0&sim_geo=1&country=us}
    And The response code is 200
    And The responses are passback


  Scenario: Publisher with non reserved fixed bid price for BB, Campaign with no margin
#  Set fixed HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#  Set floor price
#    Given i update floor_price for publisher = 3836 for adunit = 10 to be 4
#  Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with non reserved fixed bid price for campaign with no margin} for publisher 3836 with domain {DynamicPricingWithMargin5.com} with extra params {&requestid=OXbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-non-reserved-fixed-no-margin-BB-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-non-reserved-fixed-no-margin-BB-ES-banner-1}
    And all HB responses contains cpm with value {1}

  Scenario: Publisher with non reserved dynamic bid price for MR, Campaign with margin
#  Set fixed HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#  Set floor price
# Given i update floor_price for publisher = 3836 for adunit = 10 to be 1
#  Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with non reserved dynamic bid price for campaign with margin} for publisher 3836 with domain {DynamicPricingWithMargin6.com} with extra params {&requestid=OXbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-margin-MR-ES-banner-1}
    And all HB responses contains cpm with value {2}

  Scenario: zonetag - po price < max price, Campaign with margin
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-dpm-direct-fixed-margin-BB-ES} to UAS
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-dpm-direct-fixed-margin-BB-ES-banner-1} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-dpm-direct-fixed-margin-BB-ES} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {campaign-dpm-direct-fixed-margin-BB-ES} 100% of the time

   Scenario: zonetag - po price > max price, Campaign with margin
     Given I add header of {x-forwarded-for} with value {207.246.116.162}
     When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-dpm-prog-non-reserved-fixed-margin-BB-ES} to UAS
     And The response code is 200
     And The responses are passback

  Scenario: Publisher with non reserved dynamic bid price for MR, Campaign with no margin
#  Set fixed HB
#    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
#  Set floor pric
# Given i update floor_price for publisher = 3836 for adunit = 10 to be 1
#  Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with non reserved dynamic bid price for campaign with no margin} for publisher 3836 with domain {DynamicPricingWithMargin7.com} with extra params {&requestid=OXbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-no-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-no-margin-MR-ES-banner-1}
    And all HB responses contains cpm with value {2}

#  Scenario: Publisher with non reserved dynamic bid price for HP, Campaign with margin
# #  Set fixed HB
# #    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
# #  Set floor pric
# # Given i update floor_price for publisher = 3836 for adunit = 29 to be 0
# #  Campaign Direct
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with non reserved dynamic bid price for campaign with margin HP} for publisher 3836 with domain {DynamicPricingWithMargin2.com} with extra params {&requestid=OXbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-margin-HP-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-margin-HP-ES-banner-1}
#    And all HB responses contains cpm with value {1.5}
#
#  Scenario: Publisher with non reserved dynamic bid price for MR, Campaign with mobile margin
# #  Set fixed HB
# #    Given i update bid_price_type for publisher = 3836 for adunit = 10 to be 0
# #  Set floor price
# # Given i update floor_price for publisher = 3836 for adunit = 10 to be 1
# #  Campaign Direct
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
#    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with non reserved dynamic bid price for campaign with mobile margin} for publisher 3836 with domain {DynamicPricingWithMargin3.com} with extra params {&requestid=OXbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-margin-MR-ES-mobile}
#    And all HB responses contains adId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-margin-MR-ES-mobile-banner-1}
#    And all HB responses contains cpm with value {2.4}


## PG tests
#  Scenario: 6a. + 6b. Server prog. publisher with dynamic bid price for adsize ST 1*2 = ?? , fixed price for adsize PGC 1*1 = ??. bidid price = 7.7 at mock
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3711 with size1 = 1 size2 = 2, with domain {HB-DynamicP-ServerPr} and extra params {&unlimited=1&optimize=0&requesrid=DynamicPriceHB-SP}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-HB-DP-ServerPr-ST-DynamicAtPub-6a}
#    And all HB responses contains adId with id of entity named {campaign-HB-DP-ServerPr-ST-DynamicAtPub-6a-banner-1}
#    And all HB responses contains cpm with value {0.6}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains {script}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-DP-ServerPr-ST-DynamicAtPub-6a-banner-1} 100% of the time
#    And all HB responses contains cpm with value {0.6}
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for publisher 3711 with size1 = 1 size2 = 1, with domain {HB-DynamicP-ServerPr} and extra params {&unlimited=1&optimize=0&requesrid=DynamicPriceHB-SP}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-HB-DP-ServerPr-PGC-6b}
#    And all HB responses contains adId with id of entity named {campaign-HB-DP-ServerPr-PGC-6b-banner-1}
#    And all HB responses contains cpm with value {0.2}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains {script}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-DP-ServerPr-PGC-6b-banner-1} 100% of the time
#    And all HB responses contains cpm with value {0.2}