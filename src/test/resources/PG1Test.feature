@scheduled
@HeaderBidding
@SupplyType
@scheduled
Feature: PG1 x - limitation support

  Scenario: PG1 on Desktop - zone request
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad request for zone named {zone-zoneset-PG1-1-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time
    Given I send 1 times an ad request for zone named {zone-zoneset-PG1-2} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
    Given I send 1 times an ad request for zone named {zone-zoneset-PG1-1-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time
    Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)} as user-agent string to send my requests to uas
    Given I send 1 times an ad request for zone named {zone-zoneset-PG1-2} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time

  Scenario: PG1 on Desktop - Dynamic Tag
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3666 with domain {Dynamic2.com&tagid=232&optimize=0}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3675 with domain {Dynamic3.com&tagid=233&optimize=0}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3666 with domain {Dynamic2.com&tagid=232&optimize=0}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Desktop-limited-banner-1} 100% of the time
    Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)} as user-agent string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3675 with domain {Dynamic3.com&tagid=233&optimize=0}
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
    Given I use {Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB request 1X2 size for publisher 3675} for publisher 3675 with domain {Dynamic3.com} with extra params {&optimize=0}
    Then The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-PG1-Desktop-limited-banner-1}



  Scenario: PG1 on Mobile - zone request
    Given I use {Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19} as user-agent string to send my requests to uas
    Given I send 1 times an ad request for zone named {zone-zoneset-PG1-3-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Smartphone-limited-banner-1} 100% of the time
    Given I send 1 times an ad request for zone named {zone-zoneset-PG1-4} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Smartphone-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Android 4.4; Mobile; rv:41.0) Gecko/41.0 Firefox/41.0} as user-agent string to send my requests to uas
    Given I send 1 times an ad request for zone named {zone-zoneset-PG1-3-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Smartphone-limited-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (compatible; MSIE 10.0; Windows Phone 8.0; Trident/6.0; IEMobile/10.0; ARM; Touch; HTC; Windows Phone 8X by HTC)} as user-agent string to send my requests to uas
    Given I send 1 times an ad request for zone named {zone-zoneset-PG1-4} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Smartphone-limited-banner-1} 100% of the time


  Scenario: PG1 on Tablet - zone request
    Given I use {Mozilla/5.0 (Linux; <Android Version>; <Build Tag etc.>) AppleWebKit/<WebKit Rev>(KHTML, like Gecko) Chrome/<Chrome Rev> Safari/<WebKit Rev>} as user-agent string to send my requests to uas
    Given I send 1 times an ad request for zone named {zone-zoneset-PG1-5-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Tablet-limited-banner-1} 100% of the time
    Given I send 1 times an ad request for zone named {zone-zoneset-PG1-6} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Tablet-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Android 4.4; Tablet; rv:41.0) Gecko/41.0 Firefox/41.0} as user-agent string to send my requests to uas
    Given I send 1 times an ad request for zone named {zone-zoneset-PG1-5-allowed} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Tablet-limited-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; ARM; Trident/6.0; Touch; .NET4.0E; .NET4.0C; Tablet PC 2.0; WebView/1.0)} as user-agent string to send my requests to uas
    Given I send 1 times an ad request for zone named {zone-zoneset-PG1-6} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PG1-Tablet-limited-banner-1} 100% of the time
