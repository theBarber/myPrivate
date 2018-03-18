@HeaderBidding
@cli
@uas
@scheduled
@HB
@test1
Feature: Header Bidding flow support

  Scenario: send HB request without params
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-HB-Tablet-160x600}
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}
    And all HB responses contains cpm with id 1

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
    And The response code is 200
    And The responses are passback

  Scenario: Send HB request with Empty timeout
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty timeout for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HB request with wrong values
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The responses are passback

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
    Given i send 1 headerBidding post request for scenario {Send HBProg request with No D, No response from P publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&tagid=149&takeratemodel=0&optimize=0}
    And The response code is 200
    And all HB responses contains adId with id 0

  Scenario: Send HBProg request D selected
    Given i send 1 headerBidding post request for scenario {Send HBProg request D selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&takeratemodel=0&optimize=0&tagid=155}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Prog-SS-1X1-D-banner-1}

#------------------------------------------optimize flow---------------------------------------------------------------------------------------------------------------------------------------------------------

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
    And The response code is 200
    And The responses are passback

  Scenario: Send HB request with Empty timeout
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty timeout for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-160x600-banner-1}

  Scenario: Send HB request with wrong values
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The responses are passback

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
    And all HB responses contains adId with one of: {campaign-HB-Prog-PGC-1X1-1-banner-1,campaign-HB-Prog-PGC-1X1-2-banner-1,campaign-HB-Prog-SS-1X1-D-banner-1}

  Scenario: Send HBProg request with No D, No response from Pwai
    Given i send 1 headerBidding post request for scenario {Send HBProg request with No D, No response from P publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&tagid=149&takeratemodel=0&optimize=1}
    And The response code is 200
    And all HB responses contains adId with id 0

  Scenario: Send HBProg request D selected
    Given i send 1 headerBidding post request for scenario {Send HBProg request D selected publisher 3697} for publisher 3697 with domain {hbprog.com} with extra params {&unlimited=1&tagid=155&takeratemodel=0&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-HB-Prog-SS-1X1-D-banner-1}


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