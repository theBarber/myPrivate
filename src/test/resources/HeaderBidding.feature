@HeaderBidding
@cli
@uas
@scheduled
Feature: Header Bidding flow support

#  @control
#  Scenario: 1. deactivate optimize flow
#    Given I set the activation status of experiment named {ramp-lift-control-flow} to {1}
#    And I set the activation status of experiment named {ramp-lift-optimize-flow} to {0}
#    And I restart {ramp-lift-services}
#    And I sleep for 120 seconds
#
#  @optimize
#  Scenario: 1. activate optimize flow
#    Given I set the activation status of experiment named {ramp-lift-control-flow} to {0}
#    And I set the activation status of experiment named {ramp-lift-optimize-flow} to {1}
#    And I restart {ramp-lift-services}
#    And I sleep for 100 seconds

  @control
  @optimize
  Scenario: send HB request without params
    Given i send 1 headerBidding post request for scenario {send HB request without params for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id 1223973
    And all HB responses contains campaignId with id 302260
    And all HB responses contains cpm with id 0


  @control
  @optimize
  Scenario: send HB request without publisherID configured
    Given i send 1 headerBidding post request for scenario {send HB request without publisherID configured for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The responses are passback

  @control
  @optimize
  Scenario: Send HB basic request
    Given I Delete req logs
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id 1223973
    And I sleep for 5 seconds
    And I read the latest hbl log file from uas
    And The field experimentID in the 47 column of the req log is {256}
#
  @control
  @optimize
  Scenario: Send HB request to optimizer
    Given i send 1 headerBidding post request for scenario {Send HB request to optimizer for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com&unlimited=1} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id 1223973

  @control
  @optimize
  Scenario: Send HB request with Empty domain
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty domain for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The responses are passback

  @control
  @optimize
  Scenario: Send HB request with Empty placementID
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty placementID for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id 1223973

  @control
  @optimize
  Scenario: Send HB request with Empty sizes
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 204

  @control
  @optimize
  Scenario: Send HB request with Empty timeout
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty timeout for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id 1223973

  @control
  @optimize
  Scenario: Send HB request with wrong values
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 204

  @control
  @optimize
  Scenario: Send HB request with one size
    Given i send 1 headerBidding post request for scenario {Send HB request with one size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id 1200026

  @control
  @optimize
  Scenario: Send HB request with no 1X1 size
    Given i send 1 headerBidding post request for scenario {Send HB request with no 1X1 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id 1223973

#  @control
#  @optimize
#  Scenario: Send HBProg request with D first P selected
#    Given i send 1 headerBidding post request for scenario {Send HBProg request with D first P selected publisher 3690} for publisher 3690 with domain {HBProrgrammatic.com} with extra params {&unlimited=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id 1219268
#  @control
#  @optimize
#  Scenario: Send HBProg request with No D, No response from P
#    Given i send 1 headerBidding post request for scenario {Send HBProg request with No D, No response from P publisher 3690} for publisher 3690 with domain {HBProrgrammatic.com} with extra params {&unlimited=1}
#    And The response code is 200
#    And The responses are passback
#  @control
#  @optimize
#  Scenario: Send HBProg request D selected
#    Given i send 1 headerBidding post request for scenario {Send HBProg request D selected publisher 3690} for publisher 3690 with domain {HBProrgrammatic.com} with extra params {&unlimited=1}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains adId with id 1219276




