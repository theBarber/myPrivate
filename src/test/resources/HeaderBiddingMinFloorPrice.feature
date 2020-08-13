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

  Scenario: 1.0.a - Direct - rate card exists - Desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Direct - Rate card exists} for publisher 2434 with domain {ratecard-floor.com} with extra params {&optimize=1}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-rate-card-medium-rectangle-banner-1} 100% of the time
    And all HB responses contains cpm with value {3.63}

  Scenario: 1.0.b - Direct - rate card exists - Mobile
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Direct - Rate card exists} for publisher 2434 with domain {ratecard-floor.com} with extra params {&optimize=1}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-rate-card-medium-rectangle-banner-1} 100% of the time
    And all HB responses contains cpm with value {2.78}

  Scenario: 1.1.a - Direct - no rate card , yes ad unit - Desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Direct - ad unit exists - no rate card} for publisher 2434 with domain {adunit-floor.com} with extra params {&optimize=1}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-no-rate-card-yes-adunit-BillBoard-banner-1} 100% of the time
    And all HB responses contains cpm with value {1.77}

  Scenario: 1.1.b - Direct - no rate card , yes ad unit - Mobile
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB Direct - ad unit exists - no rate card} for publisher 2434 with domain {adunit-floor.com} with extra params {&optimize=1}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-no-rate-card-yes-adunit-BillBoard-banner-1} 100% of the time
    And all HB responses contains cpm with value {2.66}

  Scenario: 1.2 - Direct - no rate card , no ad unit
    Given i send 1 headerBidding post request for scenario {Send HB Direct - no adunit - no rate card} for publisher 2434 with domain {nodelivery.com} with extra params {&optimize=1}
    And The response code is 204

    #&&&&&&&&&&&&&&&&& Programmatic  &&&&&&&&&&&&&&&&&&&&&&

  Scenario: 2.0.a - Programmatic - rate card exists - Desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB programmatic - Rate card exists} for publisher 2434 with domain {prog1.com} with extra params {&requestid=OpenMarketMed}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-rate-card-medium-rectangle-prog-banner-1} 100% of the time
    And all HB responses contains cpm with value {3.63}

  Scenario: 2.0.b - Programmatic - rate card exists - Mobile
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB programmatic - Rate card exists} for publisher 2434 with domain {prog1.com} with extra params {&requestid=OpenMarketMed}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-rate-card-medium-rectangle-prog-banner-1} 100% of the time
    And all HB responses contains cpm with value {2.78}

  Scenario: 2.1.a - Programmatic - no rate card , yes ad unit - Desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB programmatic - ad unit exists - no rate card} for publisher 2434 with domain {prog2.com} with extra params {&requestid=OXbidDynMarg}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-no-rate-card-yes-adunit-BillBoard-prog-banner-1} 100% of the time
    And all HB responses contains cpm with value {1.77}

  Scenario: 2.1.b - Programmatic - no rate card , yes ad unit - Mobile
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB programmatic - ad unit exists - no rate card} for publisher 2434 with domain {prog2.com} with extra params {&requestid=OXbidDynMarg}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-no-rate-card-yes-adunit-BillBoard-prog-banner-1} 100% of the time
    And all HB responses contains cpm with value {2.66}

  Scenario: 2.2 - Programmatic - zone -  no rate card , no ad unit - passback expected
    When I send 1 times an ad request with parameter {optimize=1&requestid=OX_BrandReveal} for zone named {zone-zoneset-brand-reveal-prog} to UAS
    And The responses are passback


  Scenario: 2.3 - Programmatic - HB -  no rate card , no ad unit - passback expected
    Given i send 1 headerBidding post request for scenario {Send HB programmatic - no adunit - no rate card} for publisher 2434 with domain {prog3.com} with extra params {&requestid=OX_BrandReveal}
    And The response code is 204

    #*******************************  below and beyond floor price ****************

  Scenario: 3.1 - Direct - beyond floor price - 4.99$
    Given i send 1 headerBidding post request for scenario {Send HB getting 4.98 price} for publisher 2434 with domain {Dynamic1.com} with extra params {&optimize=1&requestid=OpenMarketMed}
    And The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-cross-screen-price4.98-banner-1} 100% of the time
    And all HB responses contains cpm with value {4.99}


  Scenario: 3.2 - Direct - below floor price - passback?
    Given i send 1 headerBidding post request for scenario {Send HB getting below floor price} for publisher 2434 with domain {Dynamic2.com} with extra params {&optimize=1&requestid=OpenMarketMed}
    And The response code is 204