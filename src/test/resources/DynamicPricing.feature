Feature: Dynamic pricing tests
  Scenario: HB Dynamic-Pricing for Direct - control and optimize flow
    Given i send 1 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {DynamicPricingTest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And all HB responses contains adId with id of entity named {cfdsfds}
    And all HB responses contains cpm with value {1.5}
#    need to be customize price
    Given i send 1 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {DynamicPricingTest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And all HB responses contains adId with id of entity named {campaifs1X2-banner-1}
    And all HB responses contains cpm with value {1.5}
#    need to be customize price

  Scenario: HB Dynamic-Pricing for Server Programmatic Guaranteed - control and optimize flow
    Given i send 1 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {DynamicPricingTest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And all HB responses contains adId with id of entity named {camfdsner-1}
    And all HB responses contains cpm with value {1.5}
#    need to be customize price
    Given i send 1 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {DynamicPricingTest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And all HB responses contains adId with id of entity named {camfdsgh-1X2-banner-1}
    And all HB responses contains cpm with value {1.5}
#    need to be customize price

   Scenario: HB Dynamic-Pricing for Server Programmatic Non Guaranteed - control and optimize flow
    Given i send 1 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {DynamicPricingTest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And all HB responses contains adId with id of entity named {camfdsner-1}
    And all HB responses contains cpm with value {1.5}
#    need to be customize price
    Given i send 1 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {DynamicPricingTest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And all HB responses contains adId with id of entity named {camfdsgh-1X2-banner-1}
    And all HB responses contains cpm with value {1.5}
#    need to be customize price

   Scenario: HB Dynamic-Pricing for client programmatic - control and optimize flow
    Given i send 1 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {DynamicPricingTest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And all HB responses contains adId with id of entity named {camfdsner-1}
    And all HB responses contains cpm with value {1.5}
#    need to be customize price
    Given i send 1 headerBidding post request for scenario {Send HB request with 1X1,1X2 size for publisher 3673} for publisher 3673 with domain {DynamicPricingTest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And all HB responses contains adId with id of entity named {camfdsgh-1X2-banner-1}
    And all HB responses contains cpm with value {1.5}
#    need to be customize price