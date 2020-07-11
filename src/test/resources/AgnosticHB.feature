@parallel
@agnostic1


Feature: Agnostic Header bidding feature

  Background: health check
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    When Sending a healthcheck request to UAS
    And I add {NY} ip header
    Then The response code is 200

#***** PUBLISHER 2434 - placement group id = 2434010  ****

  Scenario: 1 Agnostic - fictive placement , correct sizes [1,1],[1,2],[970,250] - expected 970X250
    Given i send 1 headerBidding post request for scenario {Send HB Agnostic - fictive placement - correct sizes - publisher 2434} for publisher 2434 with domain {agnostic.com} with extra params {&optimize=1}
    And The response code is 200
    And The response contains {bannerid}
    And all HB responses contains campaignId with id of entity named {campaign-agnostic-Billboard}
    And all HB responses contains cpm with value {3.0}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-agnostic-Billboard-banner-1} 100% of the time
    And The response contains {"width":970}
    And The response contains {"height":250}

  Scenario: 2 Agnostic - fictive placement , fictive sizes - passback expected
    Given i send 1 headerBidding post request for scenario {Send HB Agnostic - fictive placement - fictive sizes - publisher 2434} for publisher 2434 with domain {agnostic.com} with extra params {&optimize=1}
    Then The response code is 200
    And The responses are passback

  Scenario: 3 Agnostic - valid placement , valid sizes [1,1],[1,2],[970,250] -  expected 970X250
    Given i send 1 headerBidding post request for scenario {Send HB Agnostic - valid placement - valid sizes - publisher 2434} for publisher 2434 with domain {agnostic.com} with extra params {&optimize=1}
    And The response code is 200
    And The response contains {bannerid}
    And all HB responses contains campaignId with id of entity named {campaign-agnostic-Billboard}
    And all HB responses contains cpm with value {3.0}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-agnostic-Billboard-banner-1} 100% of the time
    And The response contains {"width":970}
    And The response contains {"height":250}


  Scenario: 4 Agnostic - valid placement , invalid sizes  -  expected [111,444] - choosing the first invalid size
    Given i send 1 headerBidding post request for scenario {Send HB Agnostic - valid placement - invalid sizes - publisher 2434} for publisher 2434 with domain {agnostic.com} with extra params {&optimize=1}
    And The response code is 200
    And The response contains {bannerid}
    And all HB responses contains campaignId with id of entity named {campaign-agnostic-Billboard}
    And all HB responses contains cpm with value {3.0}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-agnostic-Billboard-banner-1} 100% of the time
    And The response contains {"width":111}
    And The response contains {"height":444}