@parallel
@DailyPaicing
@request_service
Feature: Pacing Daily Test

  Background: health check
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: 1.0 Daily Pacing. life time goal - 100, 10 days left , flex = 0% (pacing)  -> NDQ = 10 (10 units per day)
    When I send 10 times an ad request with parameter {unlimited=1&optimize=1} for zone named {zone-zoneset-D-DailyPacing-ST-2} to UAS
    And The responses has impression-urls
    And The response contains {bannerid}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-D-DailyPacing-ST-2-banner-1} 100% of the time
    And I send impression requests to UAS
    And I sleep for 1 seconds
    When I send 1 times an ad request with parameter {unlimited=1&optimize=1} for zone named {zone-zoneset-D-DailyPacing-ST-2} to UAS
    And The response code is 200
    And The response not contains bannerid
    And The responses are passback
    And I reset metering bucket record impression counter of campaign campaign-D-DailyPacing-ST-2


#Feature: Daily Pacing, over 24 hours
#
#  Scenario: 1.a cdm 1, ASAP, hour num 1
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 1.b cdm 2, ASAP, hour num 1
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 1.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 1
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 1.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 1
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 2.a cdm 1, ASAP, hour num 2
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 2.b cdm 2, ASAP hour num 2
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 2.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 2
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 2.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 2
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 3.a cdm 1, ASAP, hour num 3
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 3.b cdm 2, ASAP hour num 3
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 3.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 3
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 3.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 3
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 4.a cdm 1, ASAP, hour num 4
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 4.b cdm 2, ASAP hour num 4
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 4.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 4
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 4.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 4
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 4.a cdm 1, ASAP, hour num 5
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 5.b cdm 2, ASAP hour num 5
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 5.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 5
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 5.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 5
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 6.a cdm 1, ASAP, hour num 6
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 6.b cdm 2, ASAP hour num 6
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 6.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 6
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 6.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 6
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 7.a cdm 1, ASAP, hour num 7
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 7.b cdm 2, ASAP hour num 7
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 7.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 7
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 7.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 7
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 8.a cdm 1, ASAP, hour num 8
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 8.b cdm 2, ASAP, hour num 8
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 8.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 8
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 8.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 8
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 9.a cdm 1, ASAP, hour num 9
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 9.b cdm 2, ASAP hour num 9
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 9.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 9
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 9.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 9
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 10.a cdm 1, ASAP, hour num 10
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 10.b cdm 2, ASAP hour num 10
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 10.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 10
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 10.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 10
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 11.a cdm 1, ASAP, hour num 11
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 11.b cdm 2, ASAP hour num 11
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 11.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 11
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 11.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 11
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 12.a cdm 1, ASAP, hour num 12
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 12.b cdm 2, ASAP hour num 12
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 12.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 12
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 12.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 12
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 13.a cdm 1, ASAP, hour num 13
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 13.b cdm 2, ASAP hour num 13
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 13.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 13
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 13.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 13
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 14.a cdm 1, ASAP, hour num 14
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 14.b cdm 2, ASAP hour num 14
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 14.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 14
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 14.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 14
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#
#  Scenario: 15.a cdm 1, ASAP, hour num 15
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 15.b cdm 2, ASAP, hour num 15
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 15.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 15
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 15.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 15
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 16.a cdm 1, ASAP, hour num 16
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 16.b cdm 2, ASAP hour num 16
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 16.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 16
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 16.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 16
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 17.a cdm 1, ASAP, hour num 17
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 17.b cdm 2, ASAP hour num 17
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 17.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 17
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 17.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 17
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 18.a cdm 1, ASAP, hour num 18
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 18.b cdm 2, ASAP hour num 18
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 18.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 18
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 18.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 18
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 19.a cdm 1, ASAP, hour num 19
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 19.b cdm 2, ASAP hour num 19
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 19.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 19
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 19.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 19
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 20.a cdm 1, ASAP, hour num 20
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 20.b cdm 2, ASAP hour num 20
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 20.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 20
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 20.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 20
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 21.a cdm 1, ASAP, hour num 21
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 21.b cdm 2, ASAP hour num 21
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 21.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 21
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 21.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 21
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 22.a cdm 1, ASAP, hour num 22
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 22.b cdm 2, ASAP, hour num 22
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 22.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 22
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 22.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 22
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 23.a cdm 1, ASAP, hour num 23
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 23.b cdm 2, ASAP hour num 23
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 23.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 23
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 23.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 23
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 24.a cdm 1, ASAP, hour num 24
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-1-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-1-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 24.b cdm 2, ASAP hour num 24
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-2-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-2-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 24.c cdm 3, should delive daily goal ASAP, but not pass it (daily goal = 2400), hour num 24
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-3-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-3-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
#
#  Scenario: 24.d cdm 4, should not pass hourly goal (hourly goal = 100), hour num 24
#    When I send 800 times an ad request with parameter {unlimited=1} for zone named {INT2434 - See Through 2.0 - DailyPacing-CDM-4-DNU} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {DailyPacing-CDM-4-test-DNU-banner-1} 100% of the time
#    And I send impression requests to UAS
