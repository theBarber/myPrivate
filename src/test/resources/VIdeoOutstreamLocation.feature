@parallel
@outstream1

Feature: outstream video duration feature

  Background: health check
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    When Sending a healthcheck request to UAS
    And I add {NY} ip header
    Then The response code is 200

#***** PUBLISHER 3708 - DEFAULT VALUES ****
  Scenario: 1.1 checking default values publisher level - publisher 3708 - inline (98) - desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-inline-pub3708} to UAS
    Then The response code is 200
    And The response contains {float: 'bottom-right'}
    And The response contains {placement: '98'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-inline-pub3708-banner-1} 100% of the time

  Scenario: 1.2 checking default values publisher level - publisher 3708 - inline (98) - mobile
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-inline-pub3708} to UAS
    Then The response code is 200
    And The response contains {float: 'bottom-right'}
    And The response contains {placement: '98'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-inline-pub3708-banner-1} 100% of the time

  Scenario: 1.3 checking default values publisher level - publisher 3708 - video adhesion (97) - desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-vidAd-pub3708} to UAS
    Then The response code is 200
    And The response contains {float: 'bottom-right'}
    And The response contains {placement: '97'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-vidAd-pub3708-banner-1} 100% of the time


#***** DOMAIN (related to publisher 3708) - amazonaws.com -  DEFAULT VALUES ****

  Scenario: 1.4 checking default values domain level - publisher 3708 - inline (98) - desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=amazonaws.com} for zone named {zone-zoneset-inline-pub3708} to UAS
    Then The response code is 200
    And The response contains {float: 'bottom-right'}
    And The response contains {placement: '98'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-inline-pub3708-banner-1} 100% of the time

  Scenario: 1.5 checking default values domain level - publisher 3708 - inline (98) - mobile
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=amazonaws.com} for zone named {zone-zoneset-inline-pub3708} to UAS
    Then The response code is 200
    And The response contains {float: 'bottom-right'}
    And The response contains {placement: '98'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-inline-pub3708-banner-1} 100% of the time

  Scenario: 1.6 checking default values domain level - publisher 3708 - video adhesion (97) - desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=amazonaws.com} for zone named {zone-zoneset-vidAd-pub3708} to UAS
    Then The response code is 200
    And The response contains {float: 'bottom-right'}
    And The response contains {placement: '97'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-vidAd-pub3708-banner-1} 100% of the time


#***** PUBLISHER 2434 - CHANGED VALUES - NONE , NONE , LEFT ****

  Scenario: 2.1 checking changed values publisher level - publisher 2434 - inline (98) - desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-inline-pub2434} to UAS
    Then The response code is 200
    And The response contains {float: 'none'}
    And The response contains {placement: '98'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-inline-pub2434-banner-1} 100% of the time

  Scenario: 2.2 checking changed values publisher level - publisher 2434 - inline (98) - mobile
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-inline-pub2434} to UAS
    Then The response code is 200
    And The response contains {float: 'none'}
    And The response contains {placement: '98'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-inline-pub2434-banner-1} 100% of the time

  Scenario: 2.3 checking changed values publisher level - publisher 3708 - video adhesion (97) - desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-vidAd-pub2434} to UAS
    Then The response code is 200
    And The response contains {float: 'bottom-left'}
    And The response contains {placement: '97'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-vidAd-pub2434-banner-1} 100% of the time


#***** DOMAIN INHERITANCE (inherited values from publisher level 2434) - kentucky.com - inherited configuration from publisher  NONE , NONE , LEFT ****  ****

  Scenario: 2.4 checking inherited values from publisher - domain level - kentucky.com - inline (98) - desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=kentucky.com} for zone named {zone-zoneset-inline-pub2434} to UAS
    Then The response code is 200
    And The response contains {float: 'none'}
    And The response contains {placement: '98'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-inline-pub2434-banner-1} 100% of the time

  Scenario: 2.5 checking inherited values from publisher  - domain level - kentucky.com - inline (98) - mobile
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=kentucky.com} for zone named {zone-zoneset-inline-pub2434} to UAS
    Then The response code is 200
    And The response contains {float: 'none'}
    And The response contains {placement: '98'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-inline-pub2434-banner-1} 100% of the time

  Scenario: 2.6 checking inherited values from publisher - domain level - kentucky.com - video adhesion (97) - desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=kentucky.com} for zone named {zone-zoneset-vidAd-pub2434} to UAS
    Then The response code is 200
    And The response contains {float: 'bottom-left'}
    And The response contains {placement: '97'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-vidAd-pub2434-banner-1} 100% of the time

  #***** DOMAIN (related to publisher 2434) - kansascity.com -  Changed values - LEFT , LEFT , RIGHT  ****

  Scenario: 2.7 checking changed values domain level - kansascity.com - inline (98) - desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=kansascity.com} for zone named {zone-zoneset-inline-pub2434} to UAS
    Then The response code is 200
    And The response contains {float: 'bottom-left'}
    And The response contains {placement: '98'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-inline-pub2434-banner-1} 100% of the time

  Scenario: 2.8 checking changed values domain level - kansascity.com - inline (98) - mobile
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=kansascity.com} for zone named {zone-zoneset-inline-pub2434} to UAS
    Then The response code is 200
    And The response contains {float: 'bottom-left'}
    And The response contains {placement: '98'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-inline-pub2434-banner-1} 100% of the time

  Scenario: 2.9 checking changed values domain level - kansascity.com- video adhesion (97) - desktop
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=kansascity.com} for zone named {zone-zoneset-vidAd-pub2434} to UAS
    Then The response code is 200
    And The response contains {float: 'bottom-right'}
    And The response contains {placement: '97'}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-stg-vidAd-pub2434-banner-1} 100% of the time

  #***** Non outsream cmapaign - validate "float" string is not included in response  ****

  Scenario: 3. non outstream entitiy - should not contain float string
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {INT2434 - Billboard 970x250 - zone234903} to UAS
    Then The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {75396-234903-365943-Billboard 970x250-productionBillboard} 100% of the time
    And The response not contains float
