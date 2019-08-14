@HeaderBidding
@DynamicPricing

Feature: Dynamic pricing tests
  Scenario: HB Dynamic-Pricing for Direct - control and optimize flow
    Given i send 1 headerBidding post request for scenario {Send HB request with 300X250 size (DT) for publisher 3728} for publisher 3728 with domain {DynamicPricingTest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And all HB responses contains adId with id of entity named {campaign-DP-Direct-300X250-2-banner-1}
#    And all HB responses contains cpm with value {1.5}
#    need to be customize price


  Scenario: HB Dynamic-Pricing for Server Programmatic Guaranteed - control and optimize flow
    Given i send 1 headerBidding post request for scenario {Send HB request with 1X1 size (DT) for publisher 3728} for publisher 3728 with domain {DynamicPricingTest.com} with extra params {&unlimited=1&optimize=0&requestid=systemTestA}
    And The response code is 200
    And all HB responses contains adId with id of entity named {campaign-DP-ProgG-SS-1X1-2-banner-1}
#    And all HB responses contains cpm with value {1.5}
#    need to be customize price


   Scenario: HB Dynamic-Pricing for Server Programmatic Non Guaranteed - control and optimize flow
    Given i send 1 headerBidding post request for scenario {Send HB request with 1X2 size (DT) for publisher 3728} for publisher 3728 with domain {DynamicPricingTest.com} with extra params {&unlimited=1&optimize=0&requestid=systemTestC}
    And The response code is 200
    And all HB responses contains adId with id of entity named {campaign-DP-ProgNG-ST-1X2-2-banner-1}
#    And all HB responses contains cpm with value {1.5}
#    need to be customize price


   Scenario: HB Dynamic-Pricing for client programmatic - control and optimize flow
    Given i send 1 headerBidding post request for scenario {Send HB request with 970X250 size (DT) for publisher 3728} for publisher 3728 with domain {DynamicPricingTest.com} with extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And all HB responses contains adId with id of entity named {campaign-DP-ClientProg-970X250-P-2-banner-1}
#    And all HB responses contains cpm with value {1.5}
#    need to be customize price




   #  -----------------------------------------------------Optimize -------------------------------------------------------------
