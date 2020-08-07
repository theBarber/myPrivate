@parallel
@floor1


Feature: HB min floor price

  Background: health check
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When Sending a healthcheck request to UAS
    ################################And I add {NY} ip header
    Then The response code is 200

#***** PUBLISHER 2434 - placement group id = 2434010  ****
    #&&&&&&&&&&&&&&&&& Direct   &&&&&&&&&&&&&&&&&&&&&&

  Scenario: 1.0 - Direct - rate card exists
    Given i send 1 headerBidding post request for scenario {Send HB Direct - Rate card exists} for publisher 2434 with domain {ratecard-floor.com} with extra params {&optimize=1}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-rate-card-medium-rectangle-banner-1} 100% of the time
    And all HB responses contains cpm with value {2.0}

  Scenario: 1.1 - Direct - no rate card , yes ad unit
    Given i send 1 headerBidding post request for scenario {Send HB Direct - ad unit exists - yes rate card} for publisher 2434 with domain {adunit-floor.com} with extra params {&optimize=1}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-adunit-no-rate-card-PG-banner-1} 100% of the time
    And all HB responses contains cpm with value {0.8}

  Scenario: 1.2 - Direct - no rate card , no ad unit
    Given i send 1 headerBidding post request for scenario {Send HB Direct - ad unit exists - no rate card} for publisher 2434 with domain {nodelivery.com} with extra params {&optimize=1}
    And The response code is 204

    #&&&&&&&&&&&&&&&&& Programmatic  &&&&&&&&&&&&&&&&&&&&&&

  Scenario: 2.0 - Programmatic - rate card exists
    Given i send 1 headerBidding post request for scenario {Send HB Direct - Rate card exists} for publisher 2434 with domain {ratecard-floor.com} with extra params {&requestid=OpenMarketMed}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-rate-card-medium-rectangle-banner-1} 100% of the time
    And all HB responses contains cpm with value {2.0}

  Scenario: 2.1 - Programmatic - no rate card , yes ad unit
    Given i send 1 headerBidding post request for scenario {Send HB Direct - ad unit exists - yes rate card} for publisher 2434 with domain {adunit-floor.com} with extra params {&requestid=Automation-AN}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-adunit-no-rate-card-PG-banner-1} 100% of the time
    And all HB responses contains cpm with value {0.8}

  Scenario: 2.2 - Programmatic - no rate card , no ad unit
    Given i send 1 headerBidding post request for scenario {Send HB Direct - ad unit exists - no rate card} for publisher 2434 with domain {nodelivery.com} with extra params {&requestid=OX_BrandReveal}
    And The response code is 204