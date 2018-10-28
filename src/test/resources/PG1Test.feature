@HeaderBidding
@SupplyType
@scheduled
@parallel
Feature: PG1 x - limitation support

  Scenario: PG1 on Desktop - zone request
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-PG1-1-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-PG1-2} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-PG1-1-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time
    Given I use {Mozilla/4.0 (compatible; MSIE 10.0; Windows NT 6.0)} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-PG1-2} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time

  Scenario: PG1 on Desktop - Dynamic Tag
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3666 with domain {Dynamic2.com&tagid=254&optimize=0}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3675 with domain {Dynamic3.com&tagid=255&optimize=0}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3666 with domain {Dynamic2.com&tagid=254&optimize=0}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time
    Given I use {Mozilla/4.0 (compatible; MSIE 10.0; Windows NT 6.0)} as user-agent string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3675 with domain {Dynamic3.com&tagid=255&optimize=0}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time


  Scenario: PG1 on Desktop - Header Bidding
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB request 1X2 size for publisher 3666} for publisher 3666 with domain {Dynamic2.com} with extra params {&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-PG1-Desktop-limited-banner-1}
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB request 1X2 size for publisher 3675} for publisher 3675 with domain {Dynamic3.com} with extra params {&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-PG1-Desktop-banner-1}
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB request 1X2 size for publisher 3666} for publisher 3666 with domain {Dynamic2.com} with extra params {&optimize=0}
    Then The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-PG1-Desktop-limited-banner-1}
    Given I use {Mozilla/4.0 (compatible; MSIE 10.0; Windows NT 6.0)} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB request 1X2 size for publisher 3675} for publisher 3675 with domain {Dynamic3.com} with extra params {&optimize=0}
    Then The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-PG1-Desktop-limited-banner-1}

  Scenario: PG1 on Mobile - zone request
    Given I use {Mozilla/5.0 (Linux; Android 4.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-PG1-3-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Smartphone-limited-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-PG1-4} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Smartphone-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-PG1-3-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Smartphone-limited-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-PG1-4} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Smartphone-limited-banner-1} 100% of the time


  Scenario: PG1 on Tablet - zone request
    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-PG1-5-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Tablet-limited-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-PG1-6} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Tablet-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (iPad; CPU OS 9_3_2 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13F69 Safari/601.1} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-PG1-5-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Tablet-limited-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (iPad; CPU OS 9_3_2 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13F69 Safari/601.1} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-PG1-6} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Tablet-limited-banner-1} 100% of the time


    #  -----------------------------------------------------Optimize-------------------------------------------------------------------

  @optimize
  Scenario: PG1 on Desktop - zone request
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-PG1-1-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-PG1-2} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-PG1-1-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time
    Given I use {Mozilla/4.0 (compatible; MSIE 10.0; Windows NT 6.0)} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-PG1-2} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time
  @optimize
  Scenario: PG1 on Desktop - Dynamic Tag
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3666 with domain {Dynamic2.com&tagid=254&optimize=1}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3675 with domain {Dynamic3.com&tagid=255&optimize=1}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3666 with domain {Dynamic2.com&tagid=254&optimize=1}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time
    Given I use {Mozilla/4.0 (compatible; MSIE 10.0; Windows NT 6.0)} as user-agent string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3675 with domain {Dynamic3.com&tagid=255&optimize=1}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time

  @optimize
  Scenario: PG1 on Desktop - Header Bidding
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB request 1X2 size for publisher 3666} for publisher 3666 with domain {Dynamic2.com} with extra params {&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-PG1-Desktop-limited-banner-1}
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB request 1X2 size for publisher 3675} for publisher 3675 with domain {Dynamic3.com} with extra params {&optimize=1}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-PG1-Desktop-banner-1}
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB request 1X2 size for publisher 3666} for publisher 3666 with domain {Dynamic2.com} with extra params {&optimize=1}
    Then The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-PG1-Desktop-limited-banner-1}
    Given I use {Mozilla/4.0 (compatible; MSIE 10.0; Windows NT 6.0)} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB request 1X2 size for publisher 3675} for publisher 3675 with domain {Dynamic3.com} with extra params {&optimize=1}
    Then The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-PG1-Desktop-limited-banner-1}

  @optimize
  Scenario: PG1 on Mobile - zone request
    Given I use {Mozilla/5.0 (Linux; Android 4.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-PG1-3-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Smartphone-limited-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-PG1-4} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Smartphone-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-PG1-3-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Smartphone-limited-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-PG1-4} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Smartphone-limited-banner-1} 100% of the time

  @optimize
  Scenario: PG1 on Tablet - zone request
    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-PG1-5-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Tablet-limited-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-PG1-6} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Tablet-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (iPad; CPU OS 9_3_2 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13F69 Safari/601.1} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-PG1-5-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Tablet-limited-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (iPad; CPU OS 9_3_2 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13F69 Safari/601.1} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-PG1-6} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Tablet-limited-banner-1} 100% of the time

