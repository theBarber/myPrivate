@HeaderBidding
@PLT
@parallel
@scheduled
@noAA
@HB
@DHB
@HB
@request_service
Feature: Dynamic HB bid price

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario:1.0 Publisher with fixed bid price for BB, Campaign with no margin
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with fixed bid price for campaign with no margin} for publisher 3836 with domain {DynamicPricingWithMargin.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-fixed-no-margin-BB-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-direct-fixed-no-margin-BB-ES-banner-1}
    And all HB responses contains cpm with value {1}

  Scenario:2.0 Publisher with fixed bid price for BB, Campaign with margin
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given I Delete hbl logs
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with fixed bid price for campaign with margin} for publisher 3836 with domain {DynamicPricingWithMargin1.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-fixed-margin-BB-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-direct-fixed-margin-BB-ES-banner-1}
    And all HB responses contains ad impression with zoneId of entity named {zone-zoneset-dpm-direct-fixed-margin-BB-ES}
    And all HB responses contains cpm with value {1}
    And I send impression requests to UAS
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS

  Scenario:3.0 Publisher with dynamic bid price for MR, Campaign with no margin
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with dynamic bid price for campaign with no margin} for publisher 3836 with domain {DynamicPricingWithMargin8.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-dynamic-no-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-direct-dynamic-no-margin-MR-ES-banner-1}
    And all HB responses contains cpm with value {2}

  Scenario:4.0 Publisher with dynamic bid price for MR, Campaign with margin
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with dynamic bid price for campaign with margin} for publisher 3836 with domain {DynamicPricingWithMargin9.com} with extra params {&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-direct-dynamic-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-direct-dynamic-margin-MR-ES-banner-1}
    And all HB responses contains cpm with value {2.1}


  Scenario:5.0 Publisher with reserved fixed bid price for BB, Campaign with margin
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with reserved fixed bid price for campaign with margin} for publisher 3836 with domain {DynamicPricingWithMargin10.com} with extra params {&requestid=ANbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-reserved-fixed-margin-BB-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-reserved-fixed-margin-BB-ES-banner-1}
    And all HB responses contains cpm with value {1}

  Scenario:6.0 Publisher with reserved fixed bid price for BB, Campaign with no margin
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with reserved fixed bid price for campaign with no margin} for publisher 3836 with domain {DynamicPricingWithMargin11.com} with extra params {&requestid=ANbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-reserved-fixed-no-margin-BB-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-reserved-fixed-no-margin-BB-ES-banner-1}
    And all HB responses contains cpm with value {1}

  Scenario:7.0 Publisher with reserved dynamic bid price for MR, Campaign with margin
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with reserved dynamic bid price for campaign with margin} for publisher 3836 with domain {DynamicPricingWithMargin12.com} with extra params {&requestid=ANbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-reserved-dynamic-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-reserved-dynamic-margin-MR-ES-banner-1}
    And all HB responses contains cpm with value {2.4}

  Scenario:8.0 Publisher with reserved dynamic bid price for MR, Campaign with no margin
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with reserved dynamic bid price for campaign with no margin} for publisher 3836 with domain {DynamicPricingWithMargin13.com} with extra params {&requestid=ANbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-reserved-dynamic-no-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-reserved-dynamic-no-margin-MR-ES-banner-1}
    And all HB responses contains cpm with value {2}


  Scenario:9.0 Publisher with non reserved fixed bid price for BB, Campaign with margin
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with non reserved fixed bid price for campaign with margin} for publisher 3836 with domain {DynamicPricingWithMargin4.com} with extra params {&requestid=OXbidDynMarg&unlimited=1&optimize=0&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-non-reserved-fixed-margin-BB-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-non-reserved-fixed-margin-BB-ES-banner-1}
    And all HB responses contains cpm with value {1}


  Scenario:10.0 Publisher with non reserved fixed bid price for BB, Campaign with no margin
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with non reserved fixed bid price for campaign with no margin} for publisher 3836 with domain {DynamicPricingWithMargin5.com} with extra params {&requestid=OXbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-non-reserved-fixed-no-margin-BB-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-non-reserved-fixed-no-margin-BB-ES-banner-1}
    And all HB responses contains cpm with value {1}

#    BUG UN-23379
#  Scenario:11.0 Publisher with non reserved dynamic bid price for MR, Campaign with margin
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with non reserved dynamic bid price for campaign with zero margin} for publisher 3836 with domain {DynamicPricingWithMargin6.com} with extra params {&requestid=returnMockPrice&unlimited=1&optimize=1&sim_geo=1&country=us}
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-margin-MR-ES}
#    And all HB responses contains adId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-margin-MR-ES-banner-1}
#    And all HB responses contains cpm with value {6.2}

#&&&&&&&&&&& 20% margin NR &&&&&&
  Scenario:12.0 Publisher with non reserved dynamic bid price for MR, Campaign with 20% margin - return price = 0.8*6.2 = 4.96$
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with non reserved dynamic bid price for campaign with 20 margin} for publisher 3836 with domain {DynamicPricingWithMarginMock.com} with extra params {&requestid=returnMockPrice&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-20-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-20-margin-MR-ES-banner-1}
    And all HB responses contains cpm with value {4.96}


  Scenario:13.0 zonetag - po price < max price, Campaign with margin
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-dpm-direct-fixed-margin-BB-ES} to UAS
    And The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-dpm-direct-fixed-margin-BB-ES-banner-1} 100% of the time
    And The impressionUrl has zoneid field matching the id of the zone named {zone-zoneset-dpm-direct-fixed-margin-BB-ES} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {campaign-dpm-direct-fixed-margin-BB-ES} 100% of the time

   Scenario:14.0 zonetag - po price > max price, Campaign with margin
     Given I add header of {x-forwarded-for} with value {207.246.116.162}
     When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-dpm-prog-non-reserved-fixed-margin-BB-ES} to UAS
     And The response code is 200
     And The responses are passback

  Scenario:15.0 Publisher with non reserved dynamic bid price for MR, Campaign with no margin
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3836 with non reserved dynamic bid price for campaign with no margin} for publisher 3836 with domain {DynamicPricingWithMargin7.com} with extra params {&requestid=OXbidDynMarg&unlimited=1&optimize=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-no-margin-MR-ES}
    And all HB responses contains adId with id of entity named {campaign-dpm-prog-non-reserved-dynamic-no-margin-MR-ES-banner-1}
    And all HB responses contains cpm with value {2}