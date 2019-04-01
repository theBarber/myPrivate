@HeaderBidding
@cli
@uas
@scheduled
@HB
@test1
@usersBucket
@parallel
@noAA
@Daniella

Feature: Header Bidding flow support

  Scenario: send HB basic request
    Given I Delete hbl logs
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {send HB request without publisherID configured for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script

  Scenario: Send HB request with Empty domain
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty domain for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script

  Scenario: Send HB request with Empty placementID
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty placementID for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HB request with Empty sizes
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with Empty timeout
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty timeout for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HB request with wrong values
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with wrong values - sizes as string
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with sizes as string for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with wrong values - sizes as string array
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with string array sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with wrong values - everything is empty in parmeters
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with empty values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with wrong values - partial data
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with partial data for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with wrong values - empty data
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with empty for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with wrong values - wrong format
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong format for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 204

  Scenario: Send HB request with one size
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with one size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}

  Scenario: Send HB request with no 1X1 size
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with no 1X1 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

#   client programmatic tests
#   Scenario: Send HBProg request with D first P selected
#     Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding post request for scenario {Send HBProg request with D first P selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=0}
#    And The response code is 200
#    And The response contains script
#     And all HB responses contains campaignId with id of entity named {campaign-HB-Prog-PGC-1X1-1}
#     And all HB responses contains adId with id of entity named {campaign-HB-Prog-PGC-1X1-1-banner-1}
#     And all HB responses contains cpm with value {1}
#     And for all HB responses i simulate winning, and send their zone tag
#     And The response code is 200
#     And The response contains script
#
#  Scenario: Send HBProg request with No D, No response from Pwai
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding post request for scenario {Send HBProg request with No D, No response from P publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=0}
#    And The response code is 204
#
#  Scenario: Send HBProg request D selected
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding post request for scenario {Send HBProg request D selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-HB-Prog-Billboard-970X250-D}
#    And all HB responses contains adId with id of entity named {campaign-HB-Prog-Billboard-970X250-D-banner-1}
#    And all HB responses contains cpm with value {1}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Prog-Billboard-970X250-D-banner-1} 100% of the time
#


#   bid price per platform tests
  Scenario: Send Price per platform request with 970X250
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with 970X250} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Billboard-970X250}
    And all HB responses contains adId with id of entity named {campaign-HB-Billboard-970X250-banner-1}
    And all HB responses contains cpm with value {0.5}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Billboard-970X250-banner-1} 100% of the time

  Scenario: Send Price per platform request with 300X250
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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

#   header bidding multiple bids tests
  Scenario: header bidding multiple bids requests
      Given I Delete hbl logs
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
      Given i send 30 headerBidding post request for scenario {Send HB Multiple bid request for publisher 3673 with [1:2],[160:600],[970:250],[300:250]} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
      And The response code is 200
      And The response contains script
      And i read all HB responses and map their bidId by adId
      And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 100% of the times
      And in HB responses bidid bid2 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 100% of the times
      And in HB responses bidid bid3 has entity of adId with name {campaign-HB-Desktop-300X250-banner-1} 100% of the times
      And I sleep for 5 seconds
      Given I read the latest hbl log file from uas
      And For bidID bid1 The field bid_request_id in the 30 column of the hbl log is: bid1
      And For bidID bid1 The field Selected_Ad_Size in the 6 column of the hbl log is: [[1,2],[160,600]]
      And For bidID bid1 The field Bid_price in the 15 column of the hbl log is: 1.00
      And For bidID bid1 The field Publisher_id in the 3 column of the hbl log is: 3673
      And For bidID bid1 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
      And For bidID bid2 The field bid_request_id in the 30 column of the hbl log is: bid2
      And For bidID bid2 The field Selected_Ad_Size in the 6 column of the hbl log is: [[970,250]]
      And For bidID bid2 The field Bid_price in the 15 column of the hbl log is: 0.50
      And For bidID bid2 The field Publisher_id in the 3 column of the hbl log is: 3673
      And For bidID bid2 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
      And For bidID bid3 The field bid_request_id in the 30 column of the hbl log is: bid3
      And For bidID bid3 The field Selected_Ad_Size in the 6 column of the hbl log is: [[300,250]]
      And For bidID bid3 The field Bid_price in the 15 column of the hbl log is: 2.50
      And For bidID bid3 The field Publisher_id in the 3 column of the hbl log is: 3673
      And For bidID bid3 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
      And For bidID bid4 The field Ad_Size in the 7 column of the hbl log is: 0

#   header bidding multiple domains tests
  Scenario: header bidding multiple domains - domain1
    Given I add cookie UTID with value {d7a8b9faf42446dcbca3748eef7d47bb} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 2 headerBidding post request for scenario {Send HB Domain3 request for publisher 3673} for publisher 3673 with domain {HBTest3.com} with extra params {&unlimited=1&optimize=0}
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
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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

#   header bidding profile targeting tests
  Scenario: Header bidding - profile targeting
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB Domain1 with 1X1 size request for publisher 3673} for publisher 3673 with domain {HBTest1.com} with extra params {&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-SS-1X1-D-2}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-D-2-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-SS-1X1-D-1}
    And all HB responses contains cpm with id 3
    Then i create new profile doc with udId {1.crmqc31wdld7y233cq5xaxrjv} on users bucket, where platform = {desktop}, profile type = {udmp_p}, profile num = 1, and reduce 0 days from epoc time stamp
    Then I add cookie UTID with value {d7a8b9caf43446d4bca3f48eef7d47bb} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB Domain2 with 1X1 size request for publisher 3673} for publisher 3673 with domain {HBTest2.com} with extra params {&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-SS-1X1-D-1}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-D-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-SS-1X1-D-2}
    And all HB responses contains cpm with id 3


#   header bidding placment group test
  Scenario: 1. 2 sizes - 1*1 (SS, PG), 1 placment (PG), PG banner expected
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3728 with multi sizes - h1:1 w1:1, h2:1 w2:2 with domain {slader.com} and placmentID group = {3708001} and extra params  {&optimize=0&unlimited=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-PG-1*1}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-PG-1*1-banner-1}

  Scenario: 2. 1 size 1*1 SS, 1 placement with SS adunit, SS banner expected
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:1, with domain {slader.com}, placmentID group = {3728002} and extra params  {&optimize=0&unlimited=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-SS-1*1}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-SS-1*1-banner-1}

  Scenario: 3. 1 size 1*2 (ST), 1 placement (PG), PG banner expected
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:2, with domain {slader.com}, placmentID group = {3728001} and extra params  {&optimize=0&unlimited=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-PG-1*1}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-PG-1*1-banner-1}

  Scenario: 4. 1 size 300*250 (doesn't have a suitable ad), no placement, passback expected
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for publisher 3728 with size1 = 300 size2 = 250, with domain {slader.com} and extra params {&optimize=0&unlimited=1}
    And The response code is 204

  Scenario: 5. wrong size, 1 placement group (PG), PG banner expected
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 basic headerBidding secure post request for publisher 3728 with size - h1:123 w1:321, with domain {slader.com}, placmentID group = {3728001} and extra params  {&optimize=0&unlimited=1}
    And The response code is 200
    And The response contains script
    And The response contains campaignId
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-PG-1*1}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-PG-1*1-banner-1}

  Scenario: 6. size doesn't belong to placement group, banner from placement group expected
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 basic headerBidding secure post request for publisher 3728 with size - h1:300 w1:250, with domain {slader.com}, placmentID group = {3728001} and extra params  {&optimize=0&unlimited=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-PG-1*1}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-PG-1*1-banner-1}


  Scenario: 7. valid size, invalid placement group, banner ST according to sizes expected
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:2, with domain {slader.com}, placmentID group = {blabla} and extra params  {&optimize=0&unlimited=1}
    And The response code is 200
    And The response contains script
    And The response contains campaignId
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-ST-1*2}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-ST-1*2-banner-1}

  Scenario: 8. valid size 1*2 with suitable add, no placement filed - ST 1*2 banner expected
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for publisher 3728 with size1 = 1 size2 = 2, with domain {slader.com} and extra params {&optimize=0&unlimited=1}
    And The response code is 200
    And The response contains script
    And The response contains campaignId
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-ST-1*2}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-ST-1*2-banner-1}




#    #------------------------------------------optimize flow---------------------------------------------------------------------------------------------------------------------------------------------------------
  @optimize
  Scenario: send HB basic request
    Given I Delete hbl logs
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 20 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
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
  @optimize
  Scenario: send HB basic request with domain as array
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB basic request with domain as array for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Tablet-160x600}
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
    And all HB responses contains cpm with id 1
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Tablet-160x600-banner-1} 100% of the time
  @optimize
  Scenario: send HB request without publisherID configured
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {send HB request without publisherID configured for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
  @optimize
  Scenario: Send HB request with Empty domain
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty domain for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
  @optimize
  Scenario: Send HB request with Empty placementID
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty placementID for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
  @optimize
  Scenario: Send HB request with Empty sizes
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with Empty timeout
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty timeout for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
  @optimize
  Scenario: Send HB request with wrong values
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with wrong values - sizes as string
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with sizes as string for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with wrong values - sizes as string array
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with string array sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with wrong values - everything is empty in parmeters
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with empty values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with wrong values - partial data
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with partial data for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with wrong values - empty data
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with empty for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with wrong values - wrong format
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong format for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with one size
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with one size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
  @optimize
  Scenario: Send HB request with no 1X1 size
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with no 1X1 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

##   client programmatic tests
#  @optimize
#  Scenario: Send HBProg request with D first P selected
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding post request for scenario {Send HBProg request with D first P selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-Prog-PGC-1X1-1-banner-1}
#  @optimize
#  Scenario: Send HBProg request with No D, No response from Pwai
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding post request for scenario {Send HBProg request with No D, No response from P publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=1}
#    And The response code is 200
#    And all HB responses contains adId with id 0
#  @optimize
#  Scenario: Send HBProg request D selected
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding post request for scenario {Send HBProg request D selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-Prog-Billboard-970X250-D-banner-1}

#   bid price per platform tests
  @optimize
  Scenario: Send Price per platform request with 970X250
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with 970X250} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Billboard-970X250}
    And all HB responses contains adId with id of entity named {campaign-HB-Billboard-970X250-banner-1}
    And all HB responses contains cpm with value {0.5}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Billboard-970X250-banner-1} 100% of the time
  @optimize
  Scenario: Send Price per platform request with 300X250
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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
  @optimize
  Scenario: Send Price per platform request with 970X250, 300X250
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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

#   header bidding multiple bids tests
  @optimize
  Scenario: header bidding multiple bids requests
    Given I Delete hbl logs
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 3 headerBidding post request for scenario {Send HB Multiple bid request for publisher 3673 with [1:2],[160:600],[970:250],[300:250]} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 100% of the times
    And in HB responses bidid bid2 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 100% of the times
    And in HB responses bidid bid3 has entity of adId with name {campaign-HB-Desktop-300X250-banner-1} 100% of the times
    And I sleep for 5 seconds
    Given I read the latest hbl log file from uas
    And For bidID bid1 The field bid_request_id in the 30 column of the hbl log is: bid1
    And For bidID bid1 The field Selected_Ad_Size in the 6 column of the hbl log is: [[1,2],[160,600]]
    And For bidID bid1 The field Bid_price in the 15 column of the hbl log is: 1.00
    And For bidID bid1 The field Publisher_id in the 3 column of the hbl log is: 3673
    And For bidID bid1 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
    And For bidID bid2 The field bid_request_id in the 30 column of the hbl log is: bid2
    And For bidID bid2 The field Selected_Ad_Size in the 6 column of the hbl log is: [[970,250]]
    And For bidID bid2 The field Bid_price in the 15 column of the hbl log is: 0.50
    And For bidID bid2 The field Publisher_id in the 3 column of the hbl log is: 3673
    And For bidID bid2 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
    And For bidID bid3 The field bid_request_id in the 30 column of the hbl log is: bid3
    And For bidID bid3 The field Selected_Ad_Size in the 6 column of the hbl log is: [[300,250]]
    And For bidID bid3 The field Bid_price in the 15 column of the hbl log is: 2.50
    And For bidID bid3 The field Publisher_id in the 3 column of the hbl log is: 3673
    And For bidID bid3 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
    And For bidID bid4 The field Ad_Size in the 7 column of the hbl log is: 0

#   header bidding multiple domains tests
  Scenario: header bidding multiple domains - domain1
    Given I add cookie UTID with value {d7a8b9faf42446dcbca3748eef7d47bb} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 2 headerBidding post request for scenario {Send HB Domain3 request for publisher 3673} for publisher 3673 with domain {HBTest3.com} with extra params {&unlimited=1&optimize=0}
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
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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

#   header bidding profile targeting tests
  Scenario: Header bidding - profile targeting
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB Domain1 with 1X1 size request for publisher 3673} for publisher 3673 with domain {HBTest1.com} with extra params {&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-SS-1X1-D-2}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-D-2-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-SS-1X1-D-1}
    And all HB responses contains cpm with id 3
    Then i create new profile doc with udId {1.crmqc31wdld7y233cq5xaxrjv} on users bucket, where platform = {desktop}, profile type = {udmp_p}, profile num = 1, and reduce 0 days from epoc time stamp
    Then I add cookie UTID with value {d7a8b9caf43446d4bca3f48eef7d47bb} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB Domain2 with 1X1 size request for publisher 3673} for publisher 3673 with domain {HBTest2.com} with extra params {&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-SS-1X1-D-1}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-D-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-SS-1X1-D-2}
    And all HB responses contains cpm with id 3


    #------------------------------------------optimize flow---------------------------------------------------------------------------------------------------------------------------------------------------------
  @optimize
  Scenario: send HB basic request
    Given I Delete hbl logs
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 20 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
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
  @optimize
  Scenario: send HB basic request with domain as array
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB basic request with domain as array for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Tablet-160x600}
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
    And all HB responses contains cpm with id 1
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Tablet-160x600-banner-1} 100% of the time
  @optimize
  Scenario: send HB request without publisherID configured
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {send HB request without publisherID configured for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
  @optimize
  Scenario: Send HB request with Empty domain
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty domain for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
  @optimize
  Scenario: Send HB request with Empty placementID
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty placementID for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
  @optimize
  Scenario: Send HB request with Empty sizes
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with Empty timeout
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty timeout for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
  @optimize
  Scenario: Send HB request with wrong values
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with wrong values - sizes as string
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with sizes as string for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with wrong values - sizes as string array
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with string array sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with wrong values - everything is empty in parmeters
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with empty values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with wrong values - partial data
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with partial data for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with wrong values - empty data
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with empty for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with wrong values - wrong format
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong format for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 204
  @optimize
  Scenario: Send HB request with one size
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with one size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}
  @optimize
  Scenario: Send HB request with no 1X1 size
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request with no 1X1 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

##   client programmatic tests
#  @optimize
#  Scenario: Send HBProg request with D first P selected
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding post request for scenario {Send HBProg request with D first P selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-Prog-PGC-1X1-1-banner-1}
#  @optimize
#  Scenario: Send HBProg request with No D, No response from Pwai
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding post request for scenario {Send HBProg request with No D, No response from P publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=1}
#    And The response code is 204
#  @optimize
#  Scenario: Send HBProg request D selected
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding post request for scenario {Send HBProg request D selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id of entity named {campaign-HB-Prog-Billboard-970X250-D-banner-1}

#   bid price per platform tests
  @optimize
  Scenario: Send Price per platform request with 970X250
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with 970X250} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Billboard-970X250}
    And all HB responses contains adId with id of entity named {campaign-HB-Billboard-970X250-banner-1}
    And all HB responses contains cpm with value {0.5}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Billboard-970X250-banner-1} 100% of the time
  @optimize
  Scenario: Send Price per platform request with 300X250
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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
  @optimize
  Scenario: Send Price per platform request with 970X250, 300X250
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
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

#   header bidding multiple bids tests
  @optimize
  Scenario: header bidding multiple bids requests
    Given I Delete hbl logs
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
   Given i send 3 headerBidding post request for scenario {Send HB Multiple bid request for publisher 3673 with [1:2],[160:600],[970:250],[300:250]} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 100% of the times
    And in HB responses bidid bid2 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 100% of the times
    And in HB responses bidid bid3 has entity of adId with name {campaign-HB-Desktop-300X250-banner-1} 100% of the times
    And I sleep for 5 seconds
    Given I read the latest hbl log file from uas
   And For bidID bid1 The field bid_request_id in the 30 column of the hbl log is: bid1
    And For bidID bid1 The field Selected_Ad_Size in the 6 column of the hbl log is: [[1,2],[160,600]]
    And For bidID bid1 The field Bid_price in the 15 column of the hbl log is: 1.00
    And For bidID bid1 The field Publisher_id in the 3 column of the hbl log is: 3673
    And For bidID bid1 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
    And For bidID bid2 The field bid_request_id in the 30 column of the hbl log is: bid2
    And For bidID bid2 The field Selected_Ad_Size in the 6 column of the hbl log is: [[970,250]]
    And For bidID bid2 The field Bid_price in the 15 column of the hbl log is: 0.50
    And For bidID bid2 The field Publisher_id in the 3 column of the hbl log is: 3673
    And For bidID bid2 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
    And For bidID bid3 The field bid_request_id in the 30 column of the hbl log is: bid3
    And For bidID bid3 The field Selected_Ad_Size in the 6 column of the hbl log is: [[300,250]]
    And For bidID bid3 The field Bid_price in the 15 column of the hbl log is: 2.50
    And For bidID bid3 The field Publisher_id in the 3 column of the hbl log is: 3673
    And For bidID bid3 The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com
    And For bidID bid4 The field Ad_Size in the 7 column of the hbl log is: 0


   #header bidding multiple domains tests
  @optimize
  Scenario: header bidding multiple domains - domain1
    Given I add cookie UTID with value {d7a8b9faf42446dcbca3748eef7d47bb} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB Domain1 request for publisher 3673} for publisher 3673 with domain {HBTest1.com} with extra params {&unlimited=1&optimize=1}
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
  @optimize
  Scenario: header bidding multiple domains - domain2
    Given I add cookie UTID with value {d7a8b9faf42446dcbca3248kef7d47bb} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB Domain2 request for publisher 3673} for publisher 3673 with domain {HBTest2.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {HB-Tablet-160x600-D-2-a-1}
    And all HB responses contains adId with id of entity named {HB-Tablet-160x600-D-2-a-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-Tablet-160x600-D-2-a}
    And all HB responses contains cpm with id 1
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {HB-Tablet-160x600-D-2-a-1-banner-1} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {HB-Tablet-160x600-D-2-a-1} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-HB-Tablet-160x600-D-2-a} 100% of the time

  @optimize
  Scenario: header bidding multiple domains - domain3
    Given I add cookie UTID with value {d7a8b9faf42446dlbca3248eef7d47bb} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB Domain3 request for publisher 3673} for publisher 3673 with domain {HBTest3.com} with extra params {&unlimited=1&optimize=1}
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
  @optimize
  Scenario: header bidding multiple domains - domain4
    Given I add cookie UTID with value {d7a8b9caf42446dcbca3248eef7d47bb} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB Domain4 request for publisher 3673} for publisher 3673 with domain {HBTest4.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {HB-Tablet-160x600-D-4-a-1}
    And all HB responses contains adId with id of entity named {HB-Tablet-160x600-D-4-a-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-Tablet-160x600-D-4-a}
    And all HB responses contains cpm with id 1
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {HB-Tablet-160x600-D-4-a-1-banner-1} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {HB-Tablet-160x600-D-4-a-1} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-HB-Tablet-160x600-D-4-a} 100% of the time

##   header bidding profile targeting tests
  @optimize
  Scenario: Header bidding - profile targeting
    Then i create new profile doc with udId {1.crmqc31wdld7y233cq5xaxrjv} on users bucket, where platform = {app}, profile type = {udmp_p}, profile num = 1, and reduce 0 days from epoc time stamp
    And I sleep for 4 seconds
    Given I clear all cookies from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB Domain1 with 1X1 size request for publisher 3673} for publisher 3673 with domain {HBTest1.com} with extra params {&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-SS-1X1-D-2}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-D-2-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-SS-1X1-D-1}
    And all HB responses contains cpm with id 3
    Then I add cookie UTID with value {d7a8b9caf43446d4bca3f48eef7d47bb} to my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB Domain2 with 1X1 size request for publisher 3673} for publisher 3673 with domain {HBTest2.com} with extra params {&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-SS-1X1-D-1}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-D-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-SS-1X1-D-2}
    And all HB responses contains cpm with id 3

