@testlocally

Feature: test1

  Background:
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    When Sending a healthcheck request to UAS
    Then The response code is 200

#    Scenario: 3.0 gdpr=1
#    When I send 1 times an ad request with parameter {optimize=1} for zone named {INT2434 - Billboard 970x250 - zone234903} to UAS
#    #When I send 4 times display ad request with parameter {optimize=1&ct=1&unlimited=1&stid=1} for zone id 192206 to UAS
#    And The response code is 200
#    #When I print local time
#    And The impressionUrl has bannerid field matching the id of the banner named {75396-234903-365943-Billboard 970x250-productionBillboard} 100% of the time

  Scenario:  create entites for new pacing mechanism
    Given i disable campaigns by name on db
      | Campaign Name                 |
      | campaign-D-DailyPacing-ST-aaa |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name                 | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                 | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | campaign-D-DailyPacing-ST-aaa | 407981 | 257595   | false                 | 35284         | {zone-zoneset-D-DailyPacing-ST-aaa} | []         | 58       | 4737           | 2434         | 38734           | []          | []          |

    Given I set campaign campaign-D-DailyPacing-ST-aaa for 10 days

    And i update campaign data by name
#    deliveryPacing = 1 = hourly pacing
#    pacing = hourly flex
      | Campaign Name                 | is_wholesale | skip_daily_goal | pacing | units | goal_type   |
      | campaign-D-DailyPacing-ST-aaa | 1            | 0               | 0      | 100   | impressions |

    And i update zone data by name
      | Zone Name                         | is_secure | zone_type_id |
      | zone-zoneset-D-DailyPacing-ST-aaa | 1         | 10           |









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


#    Given I delete the history of campaign campaign-D-DailyPacing-ST-aaa from metering bucket
