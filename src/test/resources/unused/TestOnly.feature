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

  Scenario: 3.0 gdpr=1
    Given i create new campaigns with new zoneset
         # R ----  R -----  OM
      | Campaign Name                      | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                  | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-no-ratecard-no-adunitaaaa | 407981 | 260626   | true                  | 2212          | {zone-zoneset-brand-reveal-progaaaa} | []         | 95       | 15951          | 2434         | 68022           |
      #| campaign-r      | 703688 | 271140   | false                 | 36398         | {zone-zoneset-cross-screen-blend} | []         | 10       | 15946          | 2434         | 70992           |

    And i update zone data by name
      | Zone Name                          | is_secure |
      | zone-zoneset-brand-reveal-progaaaa | 1         |









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
