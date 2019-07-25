@PLT
@parallel
@scheduled
@noAA
@HB
@DHB
@doron
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

  Scenario: Publisher with fixed bid price, Campaign with fixed HB
    #Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-no-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-direct-no-margin-MR-ES-1-banner-1}
    And all HB responses contains cpm with value {10.0}
    #Campaign Reserved
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin1.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-dpm-reserved-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-reserved-margin-MR-ES-1-banner-1}
    And all HB responses contains cpm with value {10.0}
    #Campaign Non-Reserved
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin2.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-dpm-non-reserved-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-non-reserved-margin-MR-ES-1-banner-1}
    And all HB responses contains cpm with value {10.0}


  Scenario: Publisher with dynamic bid price, Campaign with dynamic HB
    #Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-direct-margin-MR-ES-1-banner-1}
    And all HB responses contains cpm with value {CPM*(1-MARGIN)}
    #Campaign Reserved
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin1.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-dpm-reserved-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-reserved-margin-MR-ES-1-banner-1}
    And all HB responses contains cpm with value {CPM*(1-MARGIN)}
    #Campaign Non-Reserved - how to get rt price?
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin2.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-dpm-non-reserved-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-non-reserved-margin-MR-ES-1-banner-1}
    And all HB responses contains cpm with value {SSP_BID_PR_RESP*MARGIN}

  Scenario: Publisher with dynamic bid price, Campaign with fixed HB
    #Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-direct-margin-MR-ES-1-banner-1}
    And all HB responses contains cpm with value {PUB_FLOOR_PRICE}
    #Campaign Reserved
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin1.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-dpm-reserved-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-reserved-margin-MR-ES-1-banner-1}
    And all HB responses contains cpm with value {PUB_FLOOR_PRICE}
    #Campaign Non-Reserved
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3836 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin2.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-non-reserved-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-non-reserved-margin-MR-ES-1-banner-1}
    And all HB responses contains cpm with value {PUB_FLOOR_PRICE}

  Scenario: Publisher with fixed bid price, Campaign with dynamic HB
    #Campaign Direct
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-direct-margin-MR-ES-1-banner-1}
    And all HB responses contains cpm with value {PO_LI_PRICE}
    #Campaign Reserved
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin1.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-dpm-reserved-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-reserved-margin-MR-ES-1-banner-1}
    And all HB responses contains cpm with value {PO_LI_PRICE}
    #Campaign Non-Reserved
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 300 size2 = 250, with domain {DynamicPricingWithMargin2.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-dpm-non-reserved-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-non-reserved-margin-MR-ES-1-banner-1}
    And all HB responses contains cpm with value {PO_LI_PRICE}



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