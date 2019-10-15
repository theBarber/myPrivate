@DOT
@HeaderBidding
@scheduled
@parallel
@noAA
@DomainTargetingFeature
Feature: Domain Targeting tests
  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200
    Given I sleep for 120 seconds

   @1A
  Scenario: 1A. send zone requests, ex host is not a false domain + in white list
    Given I sleep for 3 seconds
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://daniref.com} as referer string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0&domain=danifalse.com} for zone named {zone-zoneset-EHC-ST-1A} to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-EHC-ST-1A-banner-1} 100% of the time

  Scenario: 1B. send zone requests, ex  host is a false domain + in black list
    Given I sleep for 3 seconds
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://daniref.com} as referer string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0&domain=danifalse.com} for zone named {zone-zoneset-EHC-ST-1B} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 2B. send zone requests, ex referer is not a false domain + in black list
    Given I sleep for 3 seconds
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {optimize=0&domain=danidom.com} for zone named {zone-zoneset-EHC-ST-2B} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 3A. send zone requests, ex referer is a false domain + in white list
    Given I sleep for 3 seconds
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://danifalse.com} as referer string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-EHC-ST-3A} to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-EHC-ST-3A-banner-1} 100% of the time

  Scenario: 3B. send zone requests, ex referer is not a false domain + in black list
    Given I sleep for 3 seconds
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://danifalse.com} as referer string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-EHC-ST-3B} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: sleep
  Given I sleep for 1 seconds

  Scenario: 4A. send zone requests, make sure a complexed referer is extracted correctly.
    Given I sleep for 3 seconds
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://news.danidom.com} as referer string to send my requests to uas
    When I send 1 times an ad request with parameter {domain=danifalse.com&optimize=0} for zone named {zone-zoneset-EHC-ST-4A} to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-EHC-ST-4A-banner-1} 100% of the time

  Scenario: 4B. send zone requests, make sure a complexed referer is extracted correctly
    Given I sleep for 3 seconds
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://news.danidom.com} as referer string to send my requests to uas
    When I send 1 times an ad request with parameter {domain=danidomInc.com&optimize=0} for zone named {zone-zoneset-EHC-ST-4B} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 5A. send zone requests, make sure a complexed referer is extracted correctly.
    Given I sleep for 3 seconds
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://news.danidom.com} as referer string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-EHC-ST-5A} to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-EHC-ST-5A-banner-1} 100% of the time

  Scenario: 5B. send zone requests, make sure a complexed referer is extracted correctly.
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://news.danidom.com} as referer string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0} for zone named {zone-zoneset-EHC-ST-5B} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 6A. send DT requests, ex is the ref, which is not a false domain + in white list. comp reffrer.
    Given I sleep for 3 seconds
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://news.danidom.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with extra params {danifalse.com&tagid=470&optimize=0}
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-EHC-DT-SS-7A-banner-1} 100% of the time
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://danidom.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with extra params {danifalse.com&tagid=470&optimize=0}
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-EHC-DT-SS-7A-banner-1} 100% of the time
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://danifalse.com} as referer string to send my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with extra params {tagid=470&optimize=0}
    And The response code is 200
    And The responses are passback

#  Scenario: 7A. send DT requests, referer is a false domain, should choose domain as effective host.
#    Given I clear all headers from uas requests
#    Given I clear all cookies from uas requests
#    Given I use {https://danifalse.com} as referer string to send my requests to uas
#    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with extra params {danidom.com&tagid=470&optimize=0}
#    And The response code is 200
#    And The response contains {script}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-EHC-DT-SS-7A-banner-1} 100% of the time
#    Given I clear all headers from uas requests
#    Given I clear all cookies from uas requests
#    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with extra params {news.danidom.com&tagid=470&optimize=0}
#    And The response code is 200
#    And The response contains {script}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-EHC-DT-SS-7A-banner-1} 100% of the time

