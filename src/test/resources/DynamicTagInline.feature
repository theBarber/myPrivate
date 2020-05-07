@cli
@uas
@HeaderBidding
@scheduled
@dynamic1
@noAA
@DynamicTagInlineFlowSupport
Feature: Dynamic Tag inline flow support

  Background: health check
    When Sending a healthcheck request to UAS
    Given I add header of {X-Forwarded-For} with value {78.31.205.183}
    Given I add cookie UTID with random value to my requests to uas
    Then The response code is 200

#  Scenario: 1. Dynamic Tag inline Basic - including migrated tags
#    Given I add cookie UTID with random value to my requests to uas
#    Then i send 20 times Dynamic Tag ad request to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-SS-1-banner-1} 100% of the time
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 130 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-SS-1-banner-1} 100% of the time
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-ST-1-banner-1} 100% of the time
#    And i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    Then The synchronized responses are passback
#
#  Scenario: 2. Dynamic Tag inline - new tags (migrated false)
#    Given I add cookie UTID with random value to my requests to uas
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 153 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-PGC-2-banner-1} 100% of the time
#    And i send 1 times Dynamic Tag synchronized ad request with tag id 153 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    Then The synchronized responses are passback
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-ST-1-banner-1} 100% of the time
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    Then The synchronized responses are passback
#
#  Scenario:3.Dynamic Tag inline (multiple products in certain tag)
#    Given I add cookie UTID with random value to my requests to uas
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 154 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-SS-1-banner-1} 100% of the time
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 154 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-PGC-2-banner-1} 100% of the time
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 154 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    Then The synchronized responses are passback
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-ST-1-banner-1} 100% of the time
#
##------------------------------------------optimize flow---------------------------------------------------------------------------------------------------------------------------------------------------------
#  @optimize
#  Scenario: 1. Dynamic Tag inline Basic - including migrated tags
#    Given I add cookie UTID with random value to my requests to uas
#    Then i send 20 times Dynamic Tag ad request to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-SS-1-banner-1} 100% of the time
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 130 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-SS-1-banner-1} 100% of the time
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-ST-1-banner-1} 100% of the time
#    And i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    Then The synchronized responses are passback
#  @optimize
#  Scenario: 2. Dynamic Tag inline - new tags (migrated false)
#    Given I add cookie UTID with random value to my requests to uas
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 153 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-PGC-2-banner-1} 100% of the time
#    And i send 1 times Dynamic Tag synchronized ad request with tag id 153 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    Then The synchronized responses are passback
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-ST-1-banner-1} 100% of the time
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    Then The synchronized responses are passback
#  @optimize
#  Scenario:3.Dynamic Tag inline (multiple products in certain tag)
#    Given I add cookie UTID with random value to my requests to uas
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 154 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-SS-1-banner-1} 100% of the time
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 154 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-PGC-2-banner-1} 100% of the time
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 154 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    Then The synchronized responses are passback
#    Then i send 1 times Dynamic Tag synchronized ad request with tag id 152 to UAS for publisher 3690 with domain {DynamicTagInline.com&unlimited=1&optimize=1}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-DT-Inline-ST-1-banner-1} 100% of the time

