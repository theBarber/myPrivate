@InAppBlackWhiteList
@scheduled
@uas
@parallel
@noAA
@PacingHourly

Feature: Pacing Hourly Test

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

# check what happens at the next day???
#  Scenario: 1. Hourly Pacing.
#    When I calculate the campaign's daily qouta and send the same amount of requests with parameter {unlimited=1&domain=pacing.houry.direct&optimize=0} for zone named {zone-zoneset-D-HourlyPacing-ST-1} to UAS when lifeTimeGoal is = 720 and flex fac = 0
#    And The response contains script
#    And I send impression requests to UAS
#    And I sleep for 60 seconds
#    When I send 5 times an ad request with parameter {unlimited=1&domain=pacing.houry.direct&optimize=0} for zone named {zone-zoneset-D-HourlyPacing-ST-1} to UAS
#    And The response code is 200
#    And The responses are passback

  Scenario: 2. Daily Pacing. life time goal - 45, 3 days left -> NDQ = 15
    When I send 15 times an ad request with parameter {unlimited=1&domain=pacing.houry.direct&optimize=0} for zone named {zone-zoneset-D-DailyPacing-ST-2} to UAS
    And The response contains script
    And I send impression requests to UAS
    And I sleep for 60 seconds
    When I send 1 times an ad request with parameter {unlimited=1&domain=pacing.houry.direct&optimize=0} for zone named {zone-zoneset-D-DailyPacing-ST-2} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 3.  ASAP. making sure there is no over delivering.
    When I send 20 times an ad request with parameter {unlimited=1&domain=pacing.houry.direct&optimize=0} for zone named {zone-zoneset-D-ASAP-ST-3} to UAS
    And The response contains script
    And I send impression requests to UAS
    And I sleep for 60 seconds
    When I send 1 times an ad request with parameter {unlimited=1&domain=pacing.houry.direct&optimize=0} for zone named {zone-zoneset-D-ASAP-ST-3} to UAS
    And The response code is 200
    And The responses are passback

#  Scenario: 4. Hourly Pacing, flex factor = 10
#    When I calculate the campaign's daily qouta and send the same amount of requests with parameter {unlimited=1&domain=pacing.houry.direct&optimize=0} for zone named {zone-zoneset-D-HourlyFF-ST-4} to UAS when lifeTimeGoal is = 720 and flex fac = 10
#    And The response contains script
#    And I send impression requests to UAS
#    And I sleep for 60 seconds
#    When I send 5 times an ad request with parameter {unlimited=1&domain=pacing.houry.direct&optimize=0} for zone named {zone-zoneset-D-HourlyFF-ST-4} to UAS
#    And The response code is 200
#    And The responses are passback