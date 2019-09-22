@cli
#@scheduled
@CI
@NeedToFix
Feature: Need To Fix support

  Scenario: 1. basic Call to Programmatic GW - zone tag
    When I send 1 times an ad request with parameter {requestid=systemTestA&optimize=0&unlimited=1&domain=remove} for zone named {zone-zoneset-server-prog-SS} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 2. basic Call to Programmatic GW - dynamic tag
    Then I sleep for 1 seconds
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 196 to UAS for publisher 3711 with domain {test.com&requestid=systemTestA&unlimited=1&optimize=0}
    And The synchronized response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-SS-1-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 4. Call Programmatic GW, GW doing auction, last ad selected - zone tag
    Then I sleep for 1 seconds
    When I send 1 times an ad request with parameter {requestid=systemTestB&optimize=0&unlimited=1&domain=remove} for zone named {zone-zoneset-server-prog-PGC} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-server-prog-PGC-2-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: 1. a. run on false domain flag = true. req sent from a false domain - zone req, DT req.
    When I send 1 times an ad request with parameter {unlimited=1&optimize=0&domain=daniellafalsedomain.test} for zone named {zone-zoneset-YesRunFalseDomain-69-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomain-69-1-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3673 with extra params {daniellaRealDomain.test&tagid=352&unlimited=1&optimize=0}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomain-69-1-banner-1} 100% of the time


  Scenario: 1.c run on false domain flag = true, req sent from a real domain. DT + zone req.
    When I send 1 times an ad request with parameter {domain=daniellaRealDomain.test&unlimited=1&optimize=0} for zone named {zone-zoneset-YesRunFalseDomain-69-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomain-69-1-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3673 with extra params {daniellaRealDomain.test&tagid=352&unlimited=1&optimize=0}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomain-69-1-banner-1} 100% of the time

  @HBFilterNoPoPrice
  Scenario: send HB request mapped to two campaigns one with no po price and one with po price
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    And i send 10 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {hb-po-price-filter.com} and extra params {&unlimited=1&optimize=0}
    Then The response code is 200
    And The response contains script
    And i print the responses
    And all HB responses contains campaignId with id of entity named {campaign-HB-PO-Price}
    And all HB responses contains adId with id of entity named {campaign-HB-PO-Price-banner-1}

  Scenario: 7A. send DT requests, referer is a false domain, should choose domain as effective host.
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://danifalse.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with extra params {danidom.com&tagid=470&optimize=0}
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-EHC-DT-SS-7A-banner-1} 100% of the time
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with extra params {news.danidom.com&tagid=470&optimize=0}
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-EHC-DT-SS-7A-banner-1} 100% of the time

  @gdpr
  @DynTagGdprFalseParamEu
  Scenario: gdpr=0 - dyntag request from Eu
    Given I add {UK} ip header
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdpr=0
    Then I expect delivery

  @gdpr
  @DynTagGdprFalseParamNotEu
  Scenario: gdpr=0 - dyntag request not from Eu
    Given I reset the http headers sent to uas
    And I send 1 times Dynamic Tag ad request to UAS for gdpr publisher's entities with gdpr=0
    Then I expect delivery

  Scenario: PG1 on Desktop - Header Bidding
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB request 1X1 size for publisher 3666} for publisher 3666 with domain {Dynamic2.com} with extra params {&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-PG1-Desktop-limited-banner-1}
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36} as user-agent string to send my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request 1X1 size for publisher 3675} for publisher 3675 with domain {Dynamic3.com} with extra params {&optimize=0}
    And The response code is 204
    Given I use {Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0} as user-agent string to send my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request 1X1 size for publisher 3666} for publisher 3666 with domain {Dynamic2.com} with extra params {&optimize=0}
    Then The response code is 200
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-PG1-Desktop-limited-banner-1}
    Given I use {Mozilla/4.0 (compatible; MSIE 10.0; Windows NT 6.0)} as user-agent string to send my requests to uas
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB request 1X1 size for publisher 3675} for publisher 3675 with domain {Dynamic3.com} with extra params {&optimize=0}
    Then The response code is 204

  Scenario: 2a. run on false domain flag = true, campaign has an include list. req sent from a false domain in the include. zone + HB req
    When I send 1 times an ad request with parameter {domain=daniellafalsedomain.test&unlimited=1&optimize=0} for zone named {zone-zoneset-YesRunFalseDomainInclude-ST-2} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomainInclude-ST-2-banner-1} 100% of the time

  Scenario: PTzoneLimitation
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {bundleid=udmp_seq_profile_web&deviceid=17100000-1710-1710-1710-000000000000} for zone named {zone-zoneset-PTzoneLimitation-ST-1} to UAS
    Then The response code is 200
    And The responses are passback
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {deviceid=00000000-0000-0000-0000-000000005678&bundleid=udmp_seq_profile_web} for zone named {zone-zoneset-PTzoneLimitation-ST-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PTzoneLimitation-ST-1-banner-1} 100% of the time
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {bundleid=udmp_seq_profile_web&deviceid=73000000-6300-6100-6100-810000009000} for zone named {zone-zoneset-PTzoneLimitation-ST-1} to UAS
    Then The response code is 200
    And The responses are passback