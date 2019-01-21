@PLT
@parallel
@noAA
@HB

Feature: Dynamic HB bid price

  Scenario: 1. campaign with fix bid price, should take cpm from po line item
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB-basicTest1} and extra params {&unlimited=1,optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-1}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-1-banner-1}
    And all HB responses contains cpm with value {0.4}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-DynamicPrice-1-banner-1} 100% of the time
    And all HB responses contains cpm with value {0.4}


  Scenario: 2. campaign with dynamic bid price, campign < po line item ,should take cpm from po line item
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB-basicTest2} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-2}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-2-banner-1}
    And all HB responses contains cpm with value {0.4}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-DynamicPrice-2-banner-1} 100% of the time
    And all HB responses contains cpm with value {0.4}

  Scenario: 3. campaign with dynamic bid price, campign > po line item ,should take cpm from campaign
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB-basicTest3} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-3}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-3-banner-1}
    And all HB responses contains cpm with value {0.6}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-DynamicPrice-3-banner-1} 100% of the time
    And all HB responses contains cpm with value {0.6}

  Scenario: 4. campaign with dynamic bid price, campign desktop > po line item > campaign mobile
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB-basicTest4} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-4}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-4-banner-1}
    And all HB responses contains cpm with value {0.4}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-DynamicPrice-4-banner-1} 100% of the time
    And all HB responses contains cpm with value {0.4}
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB-basicTest4} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-4}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-4-banner-1}
    And all HB responses contains cpm with value {0.5}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-DynamicPrice-4-banner-1} 100% of the time
    And all HB responses contains cpm with value {0.5}


  Scenario: 5. publisher with dynamic bid price for adsize 1*2 = 9, fixed price for adsize 300*250
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {DHB-basicTest5} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-ST-1x2-5a}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-ST-1x2-5a-banner-1}
    And all HB responses contains cpm with value {0.6}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-DynamicPrice-ST-1x2-5a-banner-1} 100% of the time
    And all HB responses contains cpm with value {0.6}
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 300 size2 = 250, with domain {DHB-basicTest5} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-Desktop-300X250-5b}
    And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-Desktop-300X250-5b-banner-1}
    And all HB responses contains cpm with value {0.3}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-DynamicPrice-Desktop-300X250-5b-banner-1} 100% of the time
    And all HB responses contains cpm with value {0.3}




