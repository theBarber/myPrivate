@cli
@uas
@HeaderBidding
@scheduled
@test1
Feature: Dynamic Tag inline flow support

  Scenario: 1. Dynamic Tag inline Basic - including migrated tags
    Given I add cookie UTID with random value to my requests to uas
    Then i send 20 times Dynamic Tag ad request to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-SS-1-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 130 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-SS-1-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-ST-1-banner-1} 100% of the time
    And i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1}
    Then The responses are passback

  Scenario: 2. Dynamic Tag inline - new tags (migrated false)
    Given I add cookie UTID with random value to my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 153 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-PGC-2-banner-1} 100% of the time
    And i send 1 times Dynamic Tag synchronized ad request with tag id 153 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1}
    And The responses are passback
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-ST-1-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1}
    And The responses are passback

  Scenario:3.Dynamic Tag inline (multiple products in certain tag)
    Given I add cookie UTID with random value to my requests to uas
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 154 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-SS-1-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 154 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-PGC-2-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 154 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1}
    And The responses are passback
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1}
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-ST-1-banner-1} 100% of the time

  Scenario:4.Header bidding
    Then i send 10 headerBidding post request for scenario {Send HB basic request for publisher 3690} for publisher 3690 with domain {DynamicTagInline.com} with extra params {&unlimited=1}
    And The response contains script
    And all HB responses contains adId with id of entity named {campaign-DT-Inline-SS-1-banner-1}
