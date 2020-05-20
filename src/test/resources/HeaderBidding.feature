@HeaderBidding
@cli
@uas
@scheduled
@HB
@test1
@usersBucket
@parallel
@noAA
@eitan12
@HeaderBiddingFlowSupport
@request_service
Feature: Header Bidding Flow Support

  Background: health check
    When Sending a healthcheck request to UAS
    And I add header of {X-Forwarded-For} with value {78.31.205.183}
    Then The response code is 200
    

  Scenario:1 send HB basic request
    Given I Delete hbl logs
    Given i send 20 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-Tablet-160x600}
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-Tablet-160x600}
    And all HB responses contains cpm with value {1}
    And I send impression requests to UAS
    And The response code is 200
    And The response contains {script}
#    And I send impression requests to UAS
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Tablet-160x600-banner-1} 100% of the time
#    And The impressionUrl has campaignid field matching the id of the campaign named {campaign-HB-Tablet-160x600} 100% of the time
#    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-HB-Tablet-160x600} 100% of the time
#    And I read the latest hbl log file from uas
#    And The field bannerid in the 12 column of the hbl log is the same as in impression-url
#    And The field campaignid in the 13 column of the hbl log is the same as in impression-url
#    And The field zoneid in the 14 column of the hbl log is the same as in impression-url
#    And The field bid_request_id in the 30 column of the hbl log is: 21b46gfd59b33
#    And The field Bid_price in the 15 column of the hbl log is: 1.00
#    And The field Publisher_id in the 3 column of the hbl log is: 3673
#    And The field Domain in the 5 column of the hbl log is: headerbiddingproptest.com

  Scenario:2 send HB basic request with domain as array
    Given i send 1 headerBidding post request for scenario {Send HB basic request with domain as array for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-Tablet-160x600}
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
    And all HB responses contains cpm with value {1}
    And I send impression requests to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Tablet-160x600-banner-1} 100% of the time

  Scenario:3 send HB request without publisherID configured
    Given i send 1 headerBidding post request for scenario {send HB request without publisherID configured for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}

  Scenario:4 Send HB request with Empty domain
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty domain for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}

  Scenario:5 Send HB request with Empty placementID
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty placementID for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario:6 Send HB request with Empty sizes
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 204

  Scenario:7 Send HB request with Empty timeout
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty timeout for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario:8 Send HB request with wrong values
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 204

  Scenario:9 Send HB request with wrong values - sizes as string
    Given i send 1 headerBidding post request for scenario {Send HB request with sizes as string for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 204

  Scenario:10 Send HB request with wrong values - sizes as string array
    Given i send 1 headerBidding post request for scenario {Send HB request with string array sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 204

  Scenario:11 Send HB request with wrong values - everything is empty in parmeters
    Given i send 1 headerBidding post request for scenario {Send HB request with empty values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 204

  Scenario:12 Send HB request with wrong values - partial data
    Given i send 1 headerBidding post request for scenario {Send HB request with partial data for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 204

  Scenario:13 Send HB request with wrong values - empty data
    Given i send 1 headerBidding post request for scenario {Send HB request with empty for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 204

  Scenario:14 Send HB request with wrong values - wrong format
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong format for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 204

  Scenario:15 Send HB request with one size
    Given i send 1 headerBidding post request for scenario {Send HB request with one size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-HB-See-Through-1X2-banner-1}

  Scenario:16 Send HB request with no 1X1 size
    Given i send 1 headerBidding post request for scenario {Send HB request with no 1X1 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

#   bid price per platform tests
  Scenario:17 Send Price per platform request with 970X250
    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with 970X250} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-Billboard-970X250}
    And all HB responses contains adId with id of entity named {campaign-HB-Billboard-970X250-banner-1}
    And all HB responses contains cpm with value {0.5}
    And I send impression requests to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Billboard-970X250-banner-1} 100% of the time

  Scenario:18 Send Price per platform request with 300X250
    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with 300X250} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-Desktop-300X250}
    And all HB responses contains adId with id of entity named {campaign-HB-Desktop-300X250-banner-1}
    And all HB responses contains cpm with value {2.5}
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Desktop-300X250-banner-1} 100% of the time
    And I send impression requests to UAS

  Scenario:19 Send Price per platform request with 970X250, 300X250
    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with [970:250],[300:250]} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-Desktop-300X250}
    And all HB responses contains adId with id of entity named {campaign-HB-Desktop-300X250-banner-1}
    And all HB responses contains cpm with value {2.5}
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Desktop-300X250-banner-1} 100% of the time
    And I send impression requests to UAS

#   header bidding multiple bids tests
  Scenario:20 header bidding multiple bids requests
    Given I Delete hbl logs
    Given i send 30 headerBidding post request for scenario {Send HB Multiple bid request for publisher 3673 with [1:2],[160:600],[970:250],[300:250]} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And i read all HB responses and map their bidId by adId
    And in HB responses bidid bid1 has entity of adId with name {campaign-HB-Tablet-160x600-banner-1} 100% of the times
    And in HB responses bidid bid2 has entity of adId with name {campaign-HB-Billboard-970X250-banner-1} 100% of the times
    And in HB responses bidid bid3 has entity of adId with name {campaign-HB-Desktop-300X250-banner-1} 100% of the times

#   header bidding multiple domains tests
  Scenario:21 header bidding multiple domains - domain1
    Given I add cookie UTID with value {d7a8b9faf42446dcbca3748eef7d47bb} to my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Domain1 request for publisher 3673} for publisher 3673 with domain {HBTest1.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {HB-Tablet-160x600-D-1-a-1}
    And all HB responses contains adId with id of entity named {HB-Tablet-160x600-D-1-a-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-Tablet-160x600-D-1-a}
    And all HB responses contains cpm with value {1}
    And The response contains {script}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {HB-Tablet-160x600-D-1-a-1-banner-1} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {HB-Tablet-160x600-D-1-a-1} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-HB-Tablet-160x600-D-1-a} 100% of the time
    And I send impression requests to UAS

#   header bidding profile targeting tests
  @HBProfileTargeting
  Scenario:22  Header bidding - profile targeting - Ver1
    Given I clear all cookies from uas requests
    Given i send 1 headerBidding post request for scenario {Send HB Domain1 with 1X1 size request for publisher 3673} for publisher 3673 with domain {HBTest1.com} with extra params {&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-SS-1X1-D-2}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-D-2-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-SS-1X1-D-1}
    And all HB responses contains cpm with value {3}
    Then i create new profile doc with udId {1.crmqc31wdld7y233cq5xaxrjv} on users bucket, where platform = {desktop}, profile type = {u_p}, profile num = 1, and reduce 0 days from epoc time stamp
    Then I add cookie UTID with value {d7a8b9caf43446d4bca3f48eef7d47bb} to my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Domain2 with 1X1 size request for publisher 3673} for publisher 3673 with domain {HBTest2.com} with extra params {&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-SS-1X1-D-1}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-D-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-SS-1X1-D-2}
    And all HB responses contains cpm with value {3}


#   header bidding placment group test
  Scenario:23   2 sizes - 1*1 (SS, PG), 1 placment (PG), PG banner expected
    Given I clear all cookies from uas requests
    Given i send 1 headerBidding secure post request for publisher 3728 with multi sizes - h1:1 w1:1, h2:1 w2:2 with domain {slader.com} and placmentID group = {3728003} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-PG-1*1}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-PG-1*1-banner-1}

  Scenario: 24    size 1*1 SS, 1 placement with SS adunit, SS banner expected
    Given I clear all cookies from uas requests
    Given i send synchronized 1 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:1, with domain {slader.com}, placmentID group = {3728002} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us} cookies false
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-SS-1*1}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-SS-1*1-banner-1}

  Scenario:25    size 1*2 (ST), 1 placement (PG), PG banner expected
    Given I clear all cookies from uas requests
    Given i send synchronized 1 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:2, with domain {slader.com}, placmentID group = {3728003} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us} cookies false
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-PG-1*1}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-PG-1*1-banner-1}

  Scenario:26    size 300*250 (doesn't have a suitable ad), no placement, passback expected
    Given I clear all cookies from uas requests
    Given i send 1 headerBidding secure post request for publisher 3728 with size1 = 300 size2 = 250, with domain {slader.com} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us}
    And The response code is 204

  Scenario:27   wrong size, 1 placement group (PG), PG banner expected
    Given I clear all cookies from uas requests
    Given i send synchronized 1 basic headerBidding secure post request for publisher 3728 with size - h1:123 w1:321, with domain {slader.com}, placmentID group = {3728003} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us} cookies false
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-PG-1*1}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-PG-1*1-banner-1}

  Scenario:28   size doesn't belong to placement group, banner from placement group expected
    Given I clear all cookies from uas requests
    Given i send synchronized 1 basic headerBidding secure post request for publisher 3728 with size - h1:300 w1:250, with domain {slader.com}, placmentID group = {3728003} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us} cookies false
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-PG-1*1}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-PG-1*1-banner-1}


  Scenario:29  valid size, invalid placement group, banner ST according to sizes expected
    Given I clear all cookies from uas requests
    Given i send synchronized 1 basic headerBidding secure post request for publisher 3728 with size - h1:970 w1:250, with domain {slader.com}, placmentID group = {blabla} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us} cookies false
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-Billabord-970*250}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-Billabord-970*250-banner-1}

  Scenario:30   valid size 1*1 with suitable ad, no placement filed -BB 970*250 banner expected
    Given I clear all cookies from uas requests
    Given i send 1 headerBidding secure post request for publisher 3728 with size1 = 970 size2 = 250, with domain {slader.com} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And The response contains {campaignId}
    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-Billabord-970*250}
    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-Billabord-970*250-banner-1}

  Scenario:31 valid size 1*1 with suitable add, unactive placement group. should ignore sizes and return pb
    Given I clear all cookies from uas requests
    Given i send synchronized 1 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:1, with domain {slader.com}, placmentID group = {3728005} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us} cookies false
    And The response code is 204

  Scenario:32   header bidding multiple domains - domain2
    Given I add cookie UTID with value {1112223331114444} to my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Domain2 request for publisher 3673} for publisher 3673 with domain {HBTest2.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {HB-Tablet-160x600-D-2-a-1}
    And all HB responses contains adId with id of entity named {HB-Tablet-160x600-D-2-a-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-Tablet-160x600-D-2-a}
    And all HB responses contains cpm with value {1}
    And I send impression requests to UAS
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {HB-Tablet-160x600-D-2-a-1-banner-1} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {HB-Tablet-160x600-D-2-a-1} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-HB-Tablet-160x600-D-2-a} 100% of the time

  Scenario:33   header bidding multiple domains - domain3
    Given I add cookie UTID with value {1112226661114444} to my requests to uas
    Given i send 2 headerBidding post request for scenario {Send HB Domain3 request for publisher 3673} for publisher 3673 with domain {HBTest3.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {HB-Tablet-160x600-D-3-a-1}
    And all HB responses contains adId with id of entity named {HB-Tablet-160x600-D-3-a-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-Tablet-160x600-D-3-a}
    And all HB responses contains cpm with value {1}
    And I send impression requests to UAS
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {HB-Tablet-160x600-D-3-a-1-banner-1} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {HB-Tablet-160x600-D-3-a-1} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-HB-Tablet-160x600-D-3-a} 100% of the time

  Scenario:34   header bidding multiple domains - domain4
    Given I add cookie UTID with value {d7a8b9caf42446dcbca3248eef7d47bb} to my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Domain4 request for publisher 3673} for publisher 3673 with domain {HBTest4.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {HB-Tablet-160x600-D-4-a-1}
    And all HB responses contains adId with id of entity named {HB-Tablet-160x600-D-4-a-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-Tablet-160x600-D-4-a}
    And all HB responses contains cpm with value {1}
    And I send impression requests to UAS
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {HB-Tablet-160x600-D-4-a-1-banner-1} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {HB-Tablet-160x600-D-4-a-1} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-HB-Tablet-160x600-D-4-a} 100% of the time

#   header bidding profile targeting tests
  @HBProfileTargeting
  Scenario:35   Header bidding - profile targeting - Ver2
    Given I clear all cookies from uas requests
    Given i send 1 headerBidding post request for scenario {Send HB Domain1 with 1X1 size request for publisher 3673} for publisher 3673 with domain {HBTest1.com} with extra params {&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-SS-1X1-D-2}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-D-2-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-SS-1X1-D-1}
    And all HB responses contains cpm with value {3}
    Then i create new profile doc with udId {1.crmqc31wdld7y233cq5xaxrjv} on users bucket, where platform = {desktop}, profile type = {u_p}, profile num = 1, and reduce 0 days from epoc time stamp
    Then I add cookie UTID with value {d7a8b9caf43446d4bca3f48eef7d47bb} to my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Domain2 with 1X1 size request for publisher 3673} for publisher 3673 with domain {HBTest2.com} with extra params {&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-SS-1X1-D-1}
    And all HB responses contains adId with id of entity named {campaign-HB-SS-1X1-D-1-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-HB-SS-1X1-D-2}
    And all HB responses contains cpm with value {3}

