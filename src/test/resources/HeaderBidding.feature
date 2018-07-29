@HeaderBidding
@cli
@uas
@scheduled
@HB
@test1
@userhistory

Feature: Header Bidding flow support

  Scenario: send HB basic request
    Given I Delete hbl logs
    Given i send 20 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Tablet-160x600}
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-Tablet-160x600}
    And all HB responses contains cpm with id 1
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Tablet-160x600-banner-1} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {campaign-HB-Tablet-160x600} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-HB-Tablet-160x600} 100% of the time
    And I read the latest hbl log file from uas
    And The field bannerid in the 12 column of the hbl log is the same as in impression-url
    And The field campaignid in the 13 column of the hbl log is the same as in impression-url
    And The field zoneid in the 14 column of the hbl log is the same as in impression-url
    And The field bid_request_id in the 30 column of the hbl log is: 21b46gfd59b33
    And The field Bid_price in the 15 column of the hbl log is: 1.00
    And The field Publisher_id in the 3 column of the hbl log is: 3673
    And The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com

  Scenario: send HB basic request with domain as array
    Given i send 1 headerBidding post request for scenario {Send HB basic request with domain as array for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Tablet-160x600}
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
    And all HB responses contains cpm with id 1
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Tablet-160x600-banner-1} 100% of the time

  Scenario: send HB request without publisherID configured
    Given i send 1 headerBidding post request for scenario {send HB request without publisherID configured for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The responses are passback

  Scenario: Send HB basic request
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
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

  Scenario: Send HB request with wrong values - sizes as string
    Given i send 1 headerBidding post request for scenario {Send HB request with sizes as string for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with wrong values - sizes as string array
    Given i send 1 headerBidding post request for scenario {Send HB request with string array sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with wrong values - everything is empty in parmeters
    Given i send 1 headerBidding post request for scenario {Send HB request with empty values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with wrong values - partial data
    Given i send 1 headerBidding post request for scenario {Send HB request with partial data for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with wrong values - empty data
    Given i send 1 headerBidding post request for scenario {Send HB request with empty for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with wrong values - empty data
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong format for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
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
      Given I Delete hbl logs
      Given i send 3 headerBidding post request for scenario {Send HB Multiple bid request for publisher 3673 with [1:2],[160:600],[970:250],[300:250]} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
      And The response code is 200
      And The response contains script
      And i read all HB responses and map their bidId by adId
      And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 100% of the times
      And in HB responses bidid bid2 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 100% of the times
      And in HB responses bidid bid3 has entity of adId with name {campaign-HB-Desktop-300X250-banner-1} 100% of the times
      Given I read the latest hbl log file from uas
      And For bidID bid1 The field bid_request_id in the 30 column of the hbl log is: bid1
      And For bidID bid1 The field Selected_Ad_Size in the 6 column of the hbl log is: [[1,2],[160,600]]
      And For bidID bid1 The field Bid_price in the 15 column of the hbl log is: 1.00
      And For bidID bid1 The field Publisher_id in the 3 column of the hbl log is: 3673
      And For bidID bid1 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
      And For bidID bid2 The field bid_request_id in the 30 column of the hbl log is: bid2
      And For bidID bid2 The field Selected_Ad_Size in the 6 column of the hbl log is: [[970,250]]
      And For bidID bid2 The field Bid_price in the 15 column of the hbl log is: 1.20
      And For bidID bid2 The field Publisher_id in the 3 column of the hbl log is: 3673
      And For bidID bid2 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
      And For bidID bid3 The field bid_request_id in the 30 column of the hbl log is: bid3
      And For bidID bid3 The field Selected_Ad_Size in the 6 column of the hbl log is: [[300,250]]
      And For bidID bid3 The field Bid_price in the 15 column of the hbl log is: 2.50
      And For bidID bid3 The field Publisher_id in the 3 column of the hbl log is: 3673
      And For bidID bid3 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
      And For bidID bid4 The field Ad_Size in the 7 column of the hbl log is: 0

##---frequency capping

  Scenario: header bidding frequency capping from mobile - user 1
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I delete the history of crmqauo6r8fzyogl4rxao3gsb from user history
    Given I add cookie UTID with value {d7a8b8faf42446dcbba3248cef7dc7bb} to my requests to uas
    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
#        And all HB responses contains adId with id 1259793
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
    And all HB responses contains cpm with value {3}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given I sleep for 3 seconds
    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
#    And all HB responses contains adId with id 1259790
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
    And all HB responses contains cpm with value {1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And all HB responses contains adId with value {0}

   Scenario: header bidding frequency capping from mobile - user 2 (other user)
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I delete the history of crmqauo6r8fzyogl4rxao3h6j from user history
    Given I add cookie UTID with value {d7a8b8faf42446dcbba3248cef7dc9bb} to my requests to uas
    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
    And all HB responses contains cpm with value {3}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given I sleep for 3 seconds
    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
     And all HB responses contains cpm with value {1}
     And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from Desktop user 3
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given I delete the history of crmqauo6r8fzyogl4rxao3jy3 from user history
    Given I add cookie UTID with value {d7a8b8faf42446dcbba3248cef7dd7bb} to my requests to uas
    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
    And all HB responses contains cpm with value {3}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given I sleep for 3 seconds
    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And I send impression requests to UAS
    Given I sleep for 3 seconds
    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And all HB responses contains adId with value {0}

  Scenario: reset requests and sleep
      Given i reset responses in the UAS
      Given I sleep for 200 seconds

  Scenario: header bidding frequency capping from mobile - user 2 after 3 minutes
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given I add cookie UTID with value {d7a8b8faf42446dcbba3248cef7dc9bb} to my requests to uas
    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
    And all HB responses contains cpm with value {3}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given I sleep for 3 seconds
    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And all HB responses contains adId with value {0}

  Scenario: header bidding frequency capping from Desktop user 3 after 3 minutes
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given I add cookie UTID with value {d7a8b8faf42446dcbba3248cef7dd7bb} to my requests to uas
    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
    And all HB responses contains cpm with value {3}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given I sleep for 3 seconds
    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    Given I sleep for 3 seconds
    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And all HB responses contains adId with value {0}


  Scenario: header bidding multiple domains - domain1
    Given I add cookie UTID with value {d7a8b9faf42446dcbca3748eef7d47bb} to my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Domain1 request for publisher 3673} for publisher 3673 with domain {HBTest1.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {HB-Tablet-160x600-D-1-a-1}
    And all HB responses contains adId with id of entity named {HB-Tablet-160x600-D-1-a-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-Tablet-160x600-D-1-a}
    And all HB responses contains cpm with id 1
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {HB-Tablet-160x600-D-1-a-1-banner-1} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {HB-Tablet-160x600-D-1-a-1} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-HB-Tablet-160x600-D-1-a} 100% of the time

  Scenario: header bidding multiple domains - domain2
    Given I add cookie UTID with value {d7a8b9faf42446dcbca3248kef7d47bb} to my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Domain2 request for publisher 3673} for publisher 3673 with domain {HBTest2.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {See-Through-1X2-D-2-a-1}
    And all HB responses contains adId with id of entity named {See-Through-1X2-D-2-a-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-See-Through-1X2-D-2-a}
    And all HB responses contains cpm with id 1
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {See-Through-1X2-D-2-a-1-banner-1} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {See-Through-1X2-D-2-a-1} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-HB-See-Through-1X2-D-2-a} 100% of the time


  Scenario: header bidding multiple domains - domain3
    Given I add cookie UTID with value {d7a8b9faf42446dlbca3248eef7d47bb} to my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Domain3 request for publisher 3673} for publisher 3673 with domain {HBTest3.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {HB-Tablet-160x600-D-3-a-1}
    And all HB responses contains adId with id of entity named {HB-Tablet-160x600-D-3-a-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-Tablet-160x600-D-3-a}
    And all HB responses contains cpm with id 1
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {HB-Tablet-160x600-D-3-a-1-banner-1} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {HB-Tablet-160x600-D-3-a-1} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-HB-Tablet-160x600-D-3-a} 100% of the time

  Scenario: header bidding multiple domains - domain4
    Given I add cookie UTID with value {d7a8b9caf42446dcbca3248eef7d47bb} to my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Domain4 request for publisher 3673} for publisher 3673 with domain {HBTest4.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {See-Through-1X2-D-4-a-1}
    And all HB responses contains adId with id of entity named {See-Through-1X2-D-4-a-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-See-Through-1X2-D-4-a}
    And all HB responses contains cpm with id 1
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {See-Through-1X2-D-4-a-1-banner-1} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {See-Through-1X2-D-4-a-1} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-HB-See-Through-1X2-D-4-a} 100% of the time

  Scenario: Header bidding - profile targeting
    Given I clear all cookies from uas requests
    Then I add cookie UTID with value {5454} to my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Domain1 with 1X1 size request for publisher 3673} for publisher 3673 with domain {HBTest1.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-SS-1X1-D-1}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-D-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-SS-1X1-D-1}
    And all HB responses contains cpm with id 1
#    And i insert document to
#   insert to the couchbase
    And The response code is 200
    Given i send 1 headerBidding post request for scenario {Send HB Domain2 with 1X1 size request for publisher 3673} for publisher 3673 with domain {HBTest2.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {zone-zoneset-HB-SS-1X1-D-1}
    And all HB responses contains adId with id of entity named {See-Through-1X2-D-4-a-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-See-Through-1X2-D-4-a}
    And all HB responses contains cpm with id 1


#------------------------------------------optimize flow---------------------------------------------------------------------------------------------------------------------------------------------------------
#  Scenario: send HB basic request
#    Given I Delete hbl logs
#    Given i send 20 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-HB-Tablet-160x600}
#    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
#    And all HB responses contains cpm with id 1
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And I send impression requests to UAS
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Tablet-160x600-banner-1} 100% of the time
#    And I read the latest hbl log file from uas
#    And The field bannerid in the 12 column of the hbl log is the same as in impression-url
#    And The field campaignid in the 13 column of the hbl log is the same as in impression-url
#    And The field zoneid in the 14 column of the hbl log is the same as in impression-url
#    And The field bid_request_id in the 30 column of the hbl log is: 21b46gfd59b33
#    And The field Bid_price in the 15 column of the hbl log is: 1.00
#    And The field Publisher_id in the 3 column of the hbl log is: 3673
#    And The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
#
#  Scenario: send HB basic request with domain as array
#    Given i send 1 headerBidding post request for scenario {Send HB basic request with domain as array for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-HB-Tablet-160x600}
#    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
#    And all HB responses contains cpm with id 1
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Tablet-160x600-banner-1} 100% of the time
#
#  Scenario: send HB request without publisherID configured
#    Given i send 1 headerBidding post request for scenario {send HB request without publisherID configured for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The responses are passback
#
#  Scenario: Send HB basic request
#    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
#
#  Scenario: Send HB request with Empty domain
#    Given i send 1 headerBidding post request for scenario {Send HB request with Empty domain for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The responses are passback
#
#  Scenario: Send HB request with Empty placementID
#    Given i send 1 headerBidding post request for scenario {Send HB request with Empty placementID for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
#
#  Scenario: Send HB request with Empty sizes
#    Given i send 1 headerBidding post request for scenario {Send HB request with Empty sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 204
#
#  Scenario: Send HB request with Empty timeout
#    Given i send 1 headerBidding post request for scenario {Send HB request with Empty timeout for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
#
#  Scenario: Send HB request with wrong values
#    Given i send 1 headerBidding post request for scenario {Send HB request with wrong values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 204
#
#  Scenario: Send HB request with one size
#    Given i send 1 headerBidding post request for scenario {Send HB request with one size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
#
#  Scenario: Send HB request with no 1X1 size
#    Given i send 1 headerBidding post request for scenario {Send HB request with no 1X1 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
#
#  Scenario: Send HBProg request with D first P selected
#    Given i send 1 headerBidding post request for scenario {Send HBProg request with D first P selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-Prog-PGC-1X1-1-banner-1}
#
#  Scenario: Send HBProg request with No D, No response from Pwai
#    Given i send 1 headerBidding post request for scenario {Send HBProg request with No D, No response from P publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=1}
#    And The response code is 200
#    And all HB responses contains adId with id 0
#
#  Scenario: Send HBProg request D selected
#    Given i send 1 headerBidding post request for scenario {Send HBProg request D selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-Prog-Billboard-970X250-D-banner-1}
#
#  Scenario: Send Price per platform request with 970X250
#    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with 970X250} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-HB-Billboard-970X250}
#    And all HB responses contains adId with id of entity named {campaign-HB-Billboard-970X250-banner-1}
#    And all HB responses contains cpm with value {1.2}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Billboard-970X250-banner-1} 100% of the time
#
#  Scenario: Send Price per platform request with 300X250
#    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with 300X250} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-HB-Desktop-300X250}
#    And all HB responses contains adId with id of entity named {campaign-HB-Desktop-300X250-banner-1}
#    And all HB responses contains cpm with value {2.5}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Desktop-300X250-banner-1} 100% of the time
#
#  Scenario: Send Price per platform request with 970X250, 300X250
#    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with [970:250],[300:250]} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-HB-Desktop-300X250}
#    And all HB responses contains adId with id of entity named {campaign-HB-Desktop-300X250-banner-1}
#    And all HB responses contains cpm with value {2.5}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Desktop-300X250-banner-1} 100% of the time
#
#  Scenario: header bidding multiple bids requests
#    Given I Delete hbl logs
#    Given i send 3 headerBidding post request for scenario {Send HB Multiple bid request for publisher 3673 with [1:2],[160:600],[970:250],[300:250]} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And i read all HB responses and map their bidId by adId
#    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 100% of the times
#    And in HB responses bidid bid2 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 100% of the times
#    And in HB responses bidid bid3 has entity of adId with name {campaign-HB-Desktop-300X250-banner-1} 100% of the times
#    Given I read the latest hbl log file from uas
#    And For bidID bid1 The field bid_request_id in the 30 column of the hbl log is: bid1
#    And For bidID bid1 The field Selected_Ad_Size in the 6 column of the hbl log is: [[1,2],[160,600]]
#    And For bidID bid1 The field Bid_price in the 15 column of the hbl log is: 1.00
#    And For bidID bid1 The field Publisher_id in the 3 column of the hbl log is: 3673
#    And For bidID bid1 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
#    And For bidID bid2 The field bid_request_id in the 30 column of the hbl log is: bid2
#    And For bidID bid2 The field Selected_Ad_Size in the 6 column of the hbl log is: [[970,250]]
#    And For bidID bid2 The field Bid_price in the 15 column of the hbl log is: 1.20
#    And For bidID bid2 The field Publisher_id in the 3 column of the hbl log is: 3673
#    And For bidID bid2 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
#    And For bidID bid3 The field bid_request_id in the 30 column of the hbl log is: bid3
#    And For bidID bid3 The field Selected_Ad_Size in the 6 column of the hbl log is: [[300,250]]
#    And For bidID bid3 The field Bid_price in the 15 column of the hbl log is: 2.50
#    And For bidID bid3 The field Publisher_id in the 3 column of the hbl log is: 3673
#    And For bidID bid3 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
#    And For bidID bid4 The field Ad_Size in the 7 column of the hbl log is: 0
#
###---frequency capping
#
#  Scenario: header bidding frequency capping from mobile - user 1
#    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
#    Given I delete the history of crmqauo6r8fzyogl4rxao3gsb from user history
#    Given I add cookie UTID with value {d7a8b8faf42446dcbba3248cef7dc7bb} to my requests to uas
#    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
##        And all HB responses contains adId with id 1259793
#    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
#    And all HB responses contains cpm with value {3}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And I send impression requests to UAS
#    Given I sleep for 3 seconds
#    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
##    And all HB responses contains adId with id 1259790
#    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
#    And all HB responses contains cpm with value {1}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And I send impression requests to UAS
#    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And all HB responses contains adId with value {0}
#
#  Scenario: header bidding frequency capping from mobile - user 2 (other user)
#    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
#    Given I delete the history of crmqauo6r8fzyogl4rxao3h6j from user history
#    Given I add cookie UTID with value {d7a8b8faf42446dcbba3248cef7dc9bb} to my requests to uas
#    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
#    And all HB responses contains cpm with value {3}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And I send impression requests to UAS
#    Given I sleep for 3 seconds
#    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains cpm with value {1}
#    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And I send impression requests to UAS
#    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And all HB responses contains adId with value {0}
#
#  Scenario: header bidding frequency capping from Desktop user 3
#    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
#    Given I delete the history of crmqauo6r8fzyogl4rxao3jy3 from user history
#    Given I add cookie UTID with value {d7a8b8faf42446dcbba3248cef7dd7bb} to my requests to uas
#    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And all HB responses contains cpm with value {3}
#    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And I send impression requests to UAS
#    Given I sleep for 3 seconds
#    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And I send impression requests to UAS
#    Given I sleep for 3 seconds
#    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And all HB responses contains adId with value {0}
#
#  Scenario: reset requests and sleep
#    Given i reset responses in the UAS
#    Given I sleep for 460 seconds
#
#  Scenario: header bidding frequency capping from mobile - user 2 after 5 minutes
#    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
#    Given I add cookie UTID with value {d7a8b8faf42446dcbba3248cef7dc9bb} to my requests to uas
#    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
#    And all HB responses contains cpm with value {3}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And I send impression requests to UAS
#    Given I sleep for 3 seconds
#    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And I send impression requests to UAS
#    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And all HB responses contains adId with value {0}
#
#  Scenario: header bidding frequency capping from Desktop user 3 after 5 minutes
#    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
#    Given I add cookie UTID with value {d7a8b8faf42446dcbba3248cef7dd7bb} to my requests to uas
#    Given i send 10 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-banner-1}
#    And all HB responses contains cpm with value {3}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And I send impression requests to UAS
#    Given I sleep for 3 seconds
#    Given i send 15 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And I send impression requests to UAS
#    Given I sleep for 3 seconds
#    Given i send 3 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
#    And all HB responses contains adId with value {0}

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
