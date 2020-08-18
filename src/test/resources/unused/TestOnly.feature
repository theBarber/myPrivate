@testlocally

Feature: test1

#  Background:
#    Given I clear all cookies from uas requests
#    Given I clear all headers from uas requests
#    Given I add header of {x-forwarded-for} with value {207.246.116.162}
#    When Sending a healthcheck request to UAS
#    Then The response code is 200


#%%%%%%%%%%%%%%  Agnostic UN-24547 Entities %%%%%%%%%%%%%
  Scenario:  create entites for Agnostic feature


    Given i create new campaigns, new zoneset with domains
      | Campaign Name | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-BB   | 407981 | 271931   | false                 | 35284         | {zone-bb}           | []         | 58       | 4737           | 2434         | 38734           | []             | []             |


    And i update zone data by name
      | Zone Name | is_sync |
      | zone-bb   | 1       |



#  Scenario Outline: Video HB - Location - Desktop
#    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
#    Given i send instream video HB post request for publisher <publisherId> with domain {<domain>}, placementID group {<placementId>}, playerWidth = <playerWidth>, playerHeight = <playerHeight>, playbackMethod = <playbackMethod>, maxDuration = <maxDuration> and skippable = <skippable>
#    And The response code is 200
#    And all HB responses contains campaignId with id of entity named {<campaignId>}
#    And The impressionUrl has bannerid field matching the id of the banner named {<bannerId>} 100% of the time
#
#    Examples:
#      | publisherId | domain       | placementId | playerWidth | playerHeight | playbackMethod | maxDuration | skippable | campaignId | bannerId |
#      | 3708        | HB-Video.com | 3708002     | 300         | 100          | 1              | 30          | true      | aaa        | aa       |
#      | 3708        | HB-Video.com | 3708002     | 500         | 100          | 2              | 5           | false     | bbb        | aa       |
#      | 3708        | HB-Video.com | 3708002     | 300         | 100          | 3              | 16          | true      | ccc        | aa       |
#      | 3708        | HB-Video.com | 3708002     | 800         | 100          | 4              | 22          | false     | ddd        | aa       |


  #    Given i send synchronized 1 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:1, with domain {slader.com}, placmentID group = {3728005} and extra params {&optimize=1&unlimited=1} cookies false


#    When I send 10 times display ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1} for zone id 192979 to UAS
#    And The responses has impression-urls
#    And The response contains {bannerid}
#    #And The impressionUrl has bannerid field matching the id of the banner named {campaign-D-DailyPacing-ST-2-banner-1} 100% of the time
#    And I send impression requests to UAS
#    And I sleep for 3 seconds
#    #When I send 1 times an ad request with parameter {unlimited=1&optimize=1} for zone named {zone-zoneset-D-DailyPacing-ST-2} to UAS
#    When I send 1 times display ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1} for zone id 192979 to UAS
#    And The response code is 200
#    And The response not contains bannerid
#    And The responses are passback
#    And I reset metering bucket record impression counter of campaign campaign-D-DailyPacing-ST-2
#    Given I clear all cookies from uas requests
#    Given i send synchronized 1 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:1, with domain {slader.com}, placmentID group = {3728002} and extra params {&optimize=1&unlimited=1} cookies false
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-SS-1*1}
#    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-SS-1*1-banner-1}
#
#  Scenario:23 -  1 size 1*2 (ST), 1 placement (PG), PG banner expected
#    Given I clear all cookies from uas requests
#    Given i send synchronized 1 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:2, with domain {slader.com}, placmentID group = {3728003} and extra params {&optimize=1&unlimited=1} cookies false
#    And The response code is 200
#    And The response contains {script}
#    And all HB responses contains campaignId with id of entity named {campaign-HB-PlacementG-PG-1*1}
#    And all HB responses contains adId with id of entity named {campaign-HB-PlacementG-PG-1*1-banner-1}







#    Then The response contains {bannerid}
#    And The responses has impression-urls
#    Then The response code is 200
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {92B1BB139A75C} to my impression requests to tracking service
#    And I send impression requests to UAS
#    #And I sleep for 3 seconds
#    Given I clear all cookies from uas requests
#    Given I add cookie UTID with value {92B1BB139A75C} to my requests to uas
#    When I send 4 times display ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1} for zone id 192206 to UAS
#    And The responses are passback



#  Scenario: 3.0 gdpr=1
#    #When I send 1 times an ad request with parameter {optimize=1} for zone named {INT2434 - Billboard 970x250 - zone234903} to UAS
#    When I send 4 times display ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1} for zone id 192206 to UAS
#    And The response code is 200
#    When I print local time
#    And The impressionUrl has bannerid field matching the id of the banner named {billboardTest-banner-1} 100% of the time

#    Given I clear all cookies from uas requests
#    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
#    Given I add cookie UTID with value {22222222222222222222222222222222} to my impression requests to tracking service
#    And I send impression requests to UAS


#    Given I delete the history of campaign campaign-D-DailyPacing-ST-2 from metering bucket
