@HeaderBidding
@cli
@uas
@scheduled
@HB
@test1

Feature: Header Bidding flow support

  Scenario: send HB basic request
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Tablet-160x600}
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
    And all HB responses contains cpm with id 1
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Tablet-160x600-banner-1} 100% of the time

#  Scenario: send HB basic request with domain as array
#    Given i send 1 headerBidding post request for scenario {Send HB basic request with domain as array for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-HB-Tablet-160x600}
#    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
#    And all HB responses contains cpm with id 1
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Tablet-160x600-banner-1} 100% of the time

  Scenario: send HB request without publisherID configured
    Given i send 1 headerBidding post request for scenario {send HB request without publisherID configured for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The responses are passback

  Scenario: Send HB basic request
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HB request to optimizer
    Given i send 1 headerBidding post request for scenario {Send HB request to optimizer for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HB request with Empty domain
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty domain for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The responses are passback

  Scenario: Send HB request with Empty placementID
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty placementID for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HB request with Empty sizes
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with Empty timeout
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty timeout for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HB request with wrong values
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with one size
    Given i send 1 headerBidding post request for scenario {Send HB request with one size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}

  Scenario: Send HB request with no 1X1 size
    Given i send 1 headerBidding post request for scenario {Send HB request with no 1X1 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HBProg request with D first P selected
    Given i send 1 headerBidding post request for scenario {Send HBProg request with D first P selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Prog-PGC-1X1-1-banner-1}

  Scenario: Send HBProg request with No D, No response from Pwai
    Given i send 1 headerBidding post request for scenario {Send HBProg request with No D, No response from P publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=0}
    And The response code is 200
    And all HB responses contains adId with id 0

  Scenario: Send HBProg request D selected
    Given i send 1 headerBidding post request for scenario {Send HBProg request D selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Prog-Billboard-970X250-D-banner-1}

  Scenario: Send Price per platform request with 970X250
    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with 970X250} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Billboard-970X250}
    And all HB responses contains adId with id of entity named {campaign-HB-Billboard-970X250-banner-1}
    And all HB responses contains cpm with value {1.2}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Billboard-970X250-banner-1} 100% of the time

  Scenario: Send Price per platform request with 300X250
    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with 300X250} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Desktop-300X250}
    And all HB responses contains adId with id of entity named {campaign-HB-Desktop-300X250-banner-1}
    And all HB responses contains cpm with value {2.5}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Desktop-300X250-banner-1} 100% of the time

  Scenario: Send Price per platform request with 970X250, 300X250
    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with [970:250],[300:250]} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Desktop-300X250}
    And all HB responses contains adId with id of entity named {campaign-HB-Desktop-300X250-banner-1}
    And all HB responses contains cpm with value {2.5}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Desktop-300X250-banner-1} 100% of the time


    Scenario: header bidding multiple bids requests
      Given i send 3 headerBidding post request for scenario {Send HB Multiple bid request for publisher 3673 with [1:2],[160:600],[970:250],[300:250]} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
      And The response code is 200
      And The response contains script
      And i read all HB responses and map their bidId by adId
      And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 100% of the times
      And in HB responses bidid bid2 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 100% of the times
      And in HB responses bidid bid3 has entity of adId with name {campaign-HB-Desktop-300X250-banner-1} 100% of the times

#---frequency capping

  Scenario: header bidding frequency capping from mobile - user 1
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add cookie UTID with random value to my requests to uas
    Given i send 20 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 50% of the times
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 50% of the times
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=0}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from Desktop user 1
    Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add cookie UTID with value {8c09b6bc6fd7445ebff57d69687916b9} to my requests to uas
    Given i send 30 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 50% of the times
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 50% of the times
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=0}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from mobile - user 2
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add cookie UTID with random value to my requests to uas
    Given i send 20 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 50% of the times
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 50% of the times
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=0}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from Desktop user 2
    Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add cookie UTID with value {8c09b6bc6fd7445ebff57d69687916b9} to my requests to uas
    Given i send 30 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 50% of the times
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 50% of the times
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=0}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from mobile - user 2 after 5 minutes
    Given I sleep for 300 seconds
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given i send 20 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 50% of the times
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 50% of the times
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=0}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from Desktop user 2 - user 2 after 5 minutes
    Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add cookie UTID with value {8c09b6bc6fd7445ebff57d69687916b9} to my requests to uas
    Given i send 30 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 50% of the times
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 50% of the times
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=0}
    And all HB responses contains adId with value {0}
  

##------------------------------------------optimize flow---------------------------------------------------------------------------------------------------------------------------------------------------------

  Scenario: send HB request without params
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Tablet-160x600}
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
    And all HB responses contains cpm with id 1

  Scenario: send HB request without publisherID configured
    Given i send 1 headerBidding post request for scenario {send HB request without publisherID configured for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The responses are passback

  Scenario: Send HB basic request
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HB request to optimizer
    Given i send 1 headerBidding post request for scenario {Send HB request to optimizer for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HB request with Empty domain
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty domain for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The responses are passback

  Scenario: Send HB request with Empty placementID
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty placementID for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HB request with Empty sizes
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204

  Scenario: Send HB request with Empty timeout
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty timeout for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HB request with wrong values
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204

  Scenario: Send HB request with one size
    Given i send 1 headerBidding post request for scenario {Send HB request with one size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}

  Scenario: Send HB request with no 1X1 size
    Given i send 1 headerBidding post request for scenario {Send HB request with no 1X1 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HBProg request with D first P selected
    Given i send 1 headerBidding post request for scenario {Send HBProg request with D first P selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with one of: {campaign-HB-Prog-PGC-1X1-1-banner-1,campaign-HB-Prog-PGC-1X1-2-banner-1,campaign-HB-Prog-PGC-1X1-3-banner-1}

  Scenario: Send HBProg request with No D, No response from Pwai
    Given i send 1 headerBidding post request for scenario {Send HBProg request with No D, No response from P publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=1}
    And The response code is 200
    And all HB responses contains adId with id 0

  Scenario: Send HBProg request D selected
    Given i send 1 headerBidding post request for scenario {Send HBProg request D selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Prog-Billboard-970X250-D-banner-1}

  Scenario: Send Price per platform request with 970X250
    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with 970X250} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Billboard-970X250}
    And all HB responses contains adId with id of entity named {campaign-HB-Billboard-970X250-banner-1}
    And all HB responses contains cpm with value {1.2}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Billboard-970X250-banner-1} 100% of the time

  Scenario: Send Price per platform request with 300X250
    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with 300X250} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Desktop-300X250}
    And all HB responses contains adId with id of entity named {campaign-HB-Desktop-300X250-banner-1}
    And all HB responses contains cpm with value {2.5}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Desktop-300X250-banner-1} 100% of the time

  Scenario: Send Price per platform request with 970X250, 300X250
    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with [970:250],[300:250]} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Desktop-300X250}
    And all HB responses contains adId with id of entity named {campaign-HB-Desktop-300X250-banner-1}
    And all HB responses contains cpm with value {2.5}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Desktop-300X250-banner-1} 100% of the time

  Scenario: header bidding multiple bids requests
    Given i send 1 headerBidding post request for scenario {Send HB Multiple bid request for publisher 3673 with [1:2],[160:600],[970:250],[300:250]} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 100% of the times
    And in HB responses bidid bid2 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 100% of the times
    And in HB responses bidid bid3 has entity of adId with name {campaign-HB-Desktop-300X250-banner-1} 100% of the times

#---frequency capping
  Scenario: header bidding frequency capping from mobile - user 1
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add cookie UTID with random value to my requests to uas
    Given i send 20 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 50% of the times
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 50% of the times
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=1}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from Desktop user 1
    Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add cookie UTID with value {8c09b6bc6fd7445ebff57d69687916b9} to my requests to uas
    Given i send 30 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 50% of the times
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 50% of the times
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=1}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from mobile - user 2
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add cookie UTID with random value to my requests to uas
    Given i send 20 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 50% of the times
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 50% of the times
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=1}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from Desktop user 2
    Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add cookie UTID with value {8c09b6bc6fd7445ebff57d69687916b9} to my requests to uas
    Given i send 30 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 50% of the times
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 50% of the times
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=1}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from mobile - user 2 after 5 minutes
    Given I sleep for 300 seconds
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given i send 20 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 50% of the times
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 50% of the times
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=1}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from Desktop user 2 - user 2 after 5 minutes
    Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add cookie UTID with value {8c09b6bc6fd7445ebff57d69687916b9} to my requests to uas
    Given i send 30 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 50% of the times
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 50% of the times
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3719 size [1,1],[1,2]} for publisher 3719 with domain {test.com} with extra params {&unlimited=1&optimize=1}
    And all HB responses contains adId with value {0}



#  Scenario: disabled all HB campaigns
#    Given i update campaign data by name
#      |Campaign Name                        |status      |
#      |campaign-HB-Tablet-160x600           |1           |
#      |campaign-HB-See-Through-1X2          |1           |
#      |campaign-HB-See-Through-1X2          |1           |
#      |campaign-HB-Prog-PGC-1X1-1           |1           |
#      |campaign-HB-Prog-PGC-1X1-2           |1           |
#      |campaign-HB-Prog-See-Through-1X2-1   |1           |
#      |campaign-HB-Prog-See-Through-1X2-2   |1           |
#      |campaign-HB-Prog-See-Through-1X2-3   |1           |
#      |campaign-HB-Prog-SS-1X1-P            |1           |
#      |campaign-HB-Prog-SS-1X1-D            |1           |
