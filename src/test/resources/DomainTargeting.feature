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

  @1A
  Scenario: 1A. send zone requests, ex host is not a false domain + in white list
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://daniref.com} as referer string to send my requests to uas
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    When I send 1 times an ad request with parameter {optimize=1&domain=danifalse.com} for zone named {zone-zoneset-EHC-ST-1A} to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-EHC-ST-1A-banner-1} 100% of the time

  Scenario: 1B. send zone requests, ex  host is a false domain + in black list
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://daniref.com} as referer string to send my requests to uas
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    When I send 1 times an ad request with parameter {optimize=1&domain=danifalse.com} for zone named {zone-zoneset-EHC-ST-1B} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 2B. send zone requests, ex referer is not a false domain + in black list
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    When I send 1 times an ad request with parameter {optimize=1&domain=danidom.com} for zone named {zone-zoneset-EHC-ST-2B} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 3A. send zone requests, ex referer is a false domain + in white list
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://danifalse.com} as referer string to send my requests to uas
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-EHC-ST-3A} to UAS
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-EHC-ST-3A-banner-1} 100% of the time

  Scenario: 3B. send zone requests, ex referer is not a false domain + in black list
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://danifalse.com} as referer string to send my requests to uas
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-EHC-ST-3B} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 4A. send zone requests, make sure a complexed referer is extracted correctly.
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://news.danidom.com} as referer string to send my requests to uas
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    When I send 1 times an ad request with parameter {domain=danifalse.com&optimize=1} for zone named {zone-zoneset-EHC-ST-4A} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 4B. send zone requests, make sure a complexed referer is extracted correctly
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://news.danidom.com} as referer string to send my requests to uas
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    When I send 1 times an ad request with parameter {domain=danidomInc.com&optimize=1} for zone named {zone-zoneset-EHC-ST-4B} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 5A. send zone requests, make sure a complexed referer is extracted correctly.
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://news.danidom.com} as referer string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-EHC-ST-5A} to UAS
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-EHC-ST-5A-banner-1} 100% of the time

  Scenario: 5B. send zone requests, make sure a complexed referer is extracted correctly.
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://news.danidom.com} as referer string to send my requests to uas
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    When I send 1 times an ad request with parameter {optimize=1} for zone named {zone-zoneset-EHC-ST-5B} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 6A. send DT requests where referer string is in domain_inclusion_list and domain is in domain_exclusion_list
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://news.danidom.com} as referer string to send my requests to uas
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with extra params {danifalse.com&tagid=470&optimize=1}
    And The response code is 200
    And The responses are passback

  Scenario: 6B. send DT requests where referer string is in domain_inclusion_list and domain is in domain_exclusion_list
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://danidom.com} as referer string to send my requests to uas
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with extra params {danifalse.com&tagid=470&optimize=1}
    And The response code is 200
    And The responses are passback

  Scenario: 6C. send DT requests where referer string is in domain_exclusion_list and no domain is specified
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://danifalse.com} as referer string to send my requests to uas
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with extra params {tagid=470&optimize=1}
    And The response code is 200
    And The responses are passback

  Scenario: 6D. send DT request where referer string is not in any list and domain is in domain_exclusion_list
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    Given I use {https://unknown.com} as referer string to send my requests to uas
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    And i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with extra params {danifalse.com&tagid=470&optimize=1}
    Then The response code is 200
    And The responses are passback
