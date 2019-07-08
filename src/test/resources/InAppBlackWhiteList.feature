@InAppBlackWhiteList
@scheduled
@uas
@parallel
@noAA

Feature: Black and White testing

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: 1.a Campaign has a black and a white list. send zone requests from an app in the white list
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app1} for zone named {zone-zoneset-InappBlackWhiteList-SI-1} to UAS
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-InappBlackWhiteList-SI-1-banner-1} 100% of the time

  Scenario: 1.b Campaign has a black and a white list. send zone requests from an app in the black list
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app2} for zone named {zone-zoneset-InappBlackWhiteList-SI-1} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 1.c Campaign has a black and a white list. send zone requests from an app not in the black or the white list
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app3} for zone named {zone-zoneset-InappBlackWhiteList-SI-1} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 2.a Campaign has a black list only. send zone requests from an app in the black list
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app2} for zone named {zone-zoneset-InappBlackWhiteList-SI-2} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 2.b Campaign has a black list only. send zone requests from an app not in list
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app3} for zone named {zone-zoneset-InappBlackWhiteList-SI-2} to UAS
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-InappBlackWhiteList-SI-2-banner-1} 100% of the time

  Scenario: 3.a Campaign has a white list only. send zone requests from an app in the white list
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app1} for zone named {zone-zoneset-InappBlackWhiteList-SI-3} to UAS
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-InappBlackWhiteList-SI-3-banner-1} 100% of the time

  Scenario: 3.b Campaign has a white list only. send zone requests from an app not in the white list
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app3} for zone named {zone-zoneset-InappBlackWhiteList-SI-3} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 4.a Campaign has a black and a white list. send zone requests from an app in both black and white list
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app1} for zone named {zone-zoneset-InappBlackWhiteList-SI-4} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 5.a Campaign has no black or white list. send zone requests from a random app
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app1} for zone named {zone-zoneset-InappBlackWhiteList-SI-5} to UAS
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-InappBlackWhiteList-SI-5-banner-1} 100% of the time

  Scenario: 6.a Campaign has a black list only. more than one item on list. send zone requests from an app in the black list
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app1} for zone named {zone-zoneset-InappBlackWhiteList-SI-6} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app2} for zone named {zone-zoneset-InappBlackWhiteList-SI-6} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app3} for zone named {zone-zoneset-InappBlackWhiteList-SI-6} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 6.b Campaign has a black list only. more than one item on list. send zone requests from an app not in the black list
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app4} for zone named {zone-zoneset-InappBlackWhiteList-SI-6} to UAS
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-InappBlackWhiteList-SI-6-banner-1} 100% of the time

  Scenario: 7.a Campaign has a white list only. more than one item on list. send zone requests from an app in the white list
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app1} for zone named {zone-zoneset-InappBlackWhiteList-SI-7} to UAS
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-InappBlackWhiteList-SI-7-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app2} for zone named {zone-zoneset-InappBlackWhiteList-SI-7} to UAS
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-InappBlackWhiteList-SI-7-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app3} for zone named {zone-zoneset-InappBlackWhiteList-SI-7} to UAS
    And The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-InappBlackWhiteList-SI-7-banner-1} 100% of the time

  Scenario: 7.b Advertiser has a white list only. more than one item on list. send zone requests from an app not in the white list
    When I send 1 times an ad request with parameter {unlimited=1&bundleid=app6} for zone named {zone-zoneset-InappBlackWhiteList-SI-7} to UAS
    And The response code is 200
    And The responses are passback

