@HeaderBiddingSahar
@scheduled
Feature: Header Bidding flow support

  Scenario: 1. deactivate optimize flow
    Given I set the activation status of experiment named {ramp-lift-control-flow} to {1}
    And I set the activation status of experiment named {ramp-lift-optimize-flow} to {0}
    And I restart {ramp-lift-services}
    And I sleep for 120 seconds

  Scenario: send HB request without params
    Given i send 1 headerBidding post request for scenario {send HB request without params for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200025

  Scenario: send HB request without publisherID configured
    Given i send 1 headerBidding post request for scenario {send HB request without publisherID configured for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 204

  Scenario: Send HB basic request
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200025

  Scenario: Send HB request to optimizer
    Given i send 1 headerBidding post request for scenario {Send HB request to optimizer for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com&unlimited=1} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200025

  Scenario: Send HB request with Empty domain
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty domain for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 204

  Scenario: Send HB request with Empty placementID
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty placementID for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200025

  Scenario: Send HB request with Empty sizes
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 204

  Scenario: Send HB request with Empty timeout
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty timeout for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200025

  Scenario: Send HB request with wrong values
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 204

  Scenario: Send HB request with one size
    Given i send 1 headerBidding post request for scenario {Send HB request with one size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200026

  Scenario: Send HB request with no 1X1 size
    Given i send 1 headerBidding post request for scenario {Send HB request with no 1X1 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200025

#----------------------------------------------------------------------Header bidding optimize flow----------------------------------------------------------------------

  Scenario: 1. activate optimize flow
    Given I set the activation status of experiment named {ramp-lift-control-flow} to {0}
    And I set the activation status of experiment named {ramp-lift-optimize-flow} to {1}
    And I restart {ramp-lift-services}
    And I sleep for 120 seconds

  Scenario: send HB request without params
    Given i send 1 headerBidding post request for scenario {send HB request without params for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200025

  Scenario: send HB request without publisherID configured
    Given i send 1 headerBidding post request for scenario {send HB request without publisherID configured for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 204

  Scenario: Send HB basic request
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200025

  Scenario: Send HB request to optimizer
    Given i send 1 headerBidding post request for scenario {Send HB request to optimizer for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200025

  Scenario: Send HB request with Empty domain
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty domain for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 204
  Scenario: Send HB request with Empty placementID
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty placementID for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200025

  Scenario: Send HB request with Empty sizes
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty sizes for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 204

  Scenario: Send HB request with Empty timeout
    Given i send 1 headerBidding post request for scenario {Send HB request with Empty timeout for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200025

  Scenario: Send HB request with wrong values
    Given i send 1 headerBidding post request for scenario {Send HB request with wrong values for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 204

  Scenario: Send HB request with one size
    Given i send 1 headerBidding post request for scenario {Send HB request with one size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200026

  Scenario: Send HB request with no 1X1 size
    Given i send 1 headerBidding post request for scenario {Send HB request with no 1X1 size for publisher 3673} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1}
    And The response code is 200
    And The response contains script
    And all responses contains adId with id 1200025