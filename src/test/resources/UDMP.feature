@UDMP
@parallel
@scheduled
@noAA
@UDMPFeature
@request_service
Feature: UDMP TESTS = profile targeting, seq targeting, cross decice capping

  Background: health check
    When Sending a healthcheck request to UAS
    And I add header of {X-Forwarded-For} with value {78.31.205.183}
    Then The response code is 200

  Scenario: 0. injecting to users bucket
    Then i inject new profile doc with udId {2.11000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {u_p}, profile num = 1992, and reduce 0 days from epoc time stamp and extra devices string = "upid": "12.3.45b46d3d9ce4015fa47f2076c315ea23", "devices": [{ "udid": "2.11000000-0000-0000-0000-000000000000"},{"udid": "2.12000000-0000-0000-0000-000000000000"},{"udid": "2.13000000-0000-0000-0000-000000000000"}]
    Then i inject new profile doc with udId {2.12000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {u_p}, profile num = 1992, and reduce 0 days from epoc time stamp and extra devices string = "upid": "12.3.45b46d3d9ce4015fa47f2076c315ea23", "devices": [{ "udid": "2.11000000-0000-0000-0000-000000000000"},{"udid": "2.12000000-0000-0000-0000-000000000000"},{"udid": "2.13000000-0000-0000-0000-000000000000"}]
    Then i inject new profile doc with udId {2.13000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {u_p}, profile num = 1992, and reduce 0 days from epoc time stamp and extra devices string = "upid": "12.3.45b46d3d9ce4015fa47f2076c315ea23", "devices": [{ "udid": "2.11000000-0000-0000-0000-000000000000"},{"udid": "2.12000000-0000-0000-0000-000000000000"},{"udid": "2.13000000-0000-0000-0000-000000000000"}]
    Then i create new profile doc with udId {2.66600000-6660-6660-6660-666000000000} on users bucket, where platform = {app}, profile type = {u_p}, profile num = 1992, and reduce 3 days from epoc time stamp
    Then i create new profile doc with udId {2.00000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {u_p}, profile num = 1992, and reduce 0 days from epoc time stamp
    Then i create new profile doc with udId {2.61000000-6100-6100-6100-610000000000} on users bucket, where platform = {app}, profile type = {u_p}, profile num = 1989, and reduce 0 days from epoc time stamp
    Then i create new profile doc with udId {1.9xgoi0i741z1bc7fldhmngq7v} on users bucket, where platform = {desktop}, profile type = {u_p}, profile num = 1992, and reduce 3 days from epoc time stamp
    Then i create new profile doc with udId {1.9kmivgho2hd1koqz149uxr16j} on users bucket, where platform = {desktop}, profile type = {u_p}, profile num = 1992, and reduce 0 days from epoc time stamp
    Then i create new profile doc with udId {1.9kmivgho2hd1koqz149uu05ob} on users bucket, where platform = {desktop}, profile type = {u_p}, profile num = 1989, and reduce 0 days from epoc time stamp
    Then i inject new profile doc with udId {2.00000006-0006-0006-0006-000000000006} on users bucket, where platform = {app}, empty profile type = {sqmsg_p}, non-empty profile type = {u_p}
    Then i create new profile doc with udId {2.01000000-0100-0100-0100-010000000000} on users bucket, where platform = {app}, profile type = {sqmsg_p}, profile num = 17, and reduce 0 days from epoc time stamp
    Then i inject new profile doc with udId {2.60000006-6006-6006-6006-600000000006} on users bucket, where platform = {app}, with one udmp_p profile = {199} with 3 days reduce and one sqmsg_p profile = {20} with 0 days reduce
    Then i inject new profile doc with udId {2.60000006-6006-6006-6006-600000000000} on users bucket, where platform = {app}, with one udmp_p profile = {1992} with 0 days reduce and one sqmsg_p profile = {17} with 5 days reduce
    Then i create new profile doc with udId {1.9mrjt7trg1a57yd4pv1i3ltbv} on users bucket, where platform = {desktop}, profile type = {sqmsg_p}, profile num = 17, and reduce 0 days from epoc time stamp
    Then i inject new profile doc with udId {1.a1q4r5t1dt2193lzjjoz7kmnv} on users bucket, where platform = {desktop}, empty profile type = {sqmsg_p}, non-empty profile type = {u_p}
    Then i inject new profile doc with udId {1.a1o1866gg3j3ulsj9omeyfhyz} on users bucket, where platform = {desktop}, with one udmp_p profile = {199} with 3 days reduce and one sqmsg_p profile = {20} with 0 days reduce
    Then i inject new profile doc with udId {1.a1o19osvf0w6rfwepq3avxy9n} on users bucket, where platform = {desktop}, with one udmp_p profile = {1992} with 0 days reduce and one sqmsg_p profile = {17} with 5 days reduce
    Then i create new profile doc with udId {2.17100000-1710-1710-1710-000000000000} on users bucket, where platform = {app}, profile type = {u_p}, profile num = 666, and reduce 3 days from epoc time stamp
    Then i create new profile doc with udId {2.00000000-0000-0000-0000-000000005678} on users bucket, where platform = {app}, profile type = {u_p}, profile num = 666, and reduce 0 days from epoc time stamp
    Then i create new profile doc with udId {2.73000000-6300-6100-6100-810000009000} on users bucket, where platform = {app}, profile type = {u_p}, profile num = 555, and reduce 0 days from epoc time stamp
    Then i inject new profile doc with udId {2.67000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {u_p}, profile num = 1992, and reduce 0 days from epoc time stamp and extra devices string = "upid": "12.3.45b46d3d9ce4015fa47f2076c315ea23", "devices": [{ "udid": "2.67000000-0000-0000-0000-000000000000"},{"udid": "2.78000000-0000-0000-0000-000000000000"}]
    Then i inject new profile doc with udId {2.78000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {u_p}, profile num = 1992, and reduce 0 days from epoc time stamp and extra devices string = "upid": "12.3.45b46d3d9ce4015fa47f2076c315ea23", "devices": [{ "udid": "2.78000000-0000-0000-0000-000000000000"},{"udid": "2.67000000-0000-0000-0000-000000000000"}]
    Then i inject new profile doc with udId {2.89000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {u_p}, profile num = 1992, and reduce 0 days from epoc time stamp and extra devices string = "upid": "12.3.45b46d3d9ce4015fa47f2076c315ea23", "devices": [{ "udid": "2.90000000-0000-0000-0000-000000000000"},{"udid": "2.89000000-0000-0000-0000-000000000000"}]
    Then i inject new profile doc with udId {2.90000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {u_p}, profile num = 1992, and reduce 0 days from epoc time stamp and extra devices string = "upid": "12.3.45b46d3d9ce4015fa47f2076c315ea23", "devices": [{ "udid": "2.90000000-0000-0000-0000-000000000000"},{"udid": "2.89000000-0000-0000-0000-000000000000"}]

  Scenario: 1  cross device capping for udmp,zone req when capping = 2, cross device capping = true - PART ONE - Delivery
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {deviceid=11000000-0000-0000-0000-000000000000&unlimited=1&optimize=1&bundleid=app1} for zone named {zone-zoneset-CrossDeviceCappingUDMP-ST-1} to UAS
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceCappingUDMP-ST-1-banner-1} 100% of the time
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {deviceid=11000000-0000-0000-0000-000000000000&unlimited=1&optimize=1&bundleid=app1} for zone named {zone-zoneset-CrossDeviceCappingUDMP-ST-1} to UAS
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceCappingUDMP-ST-1-banner-1} 100% of the time
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {deviceid=11000000-0000-0000-0000-000000000000&unlimited=1&optimize=1&bundleid=app1} for zone named {zone-zoneset-CrossDeviceCappingUDMP-ST-1} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: 2.a  profile targeting for udmp, zone req, from app - PART ONE - Passback
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {deviceid=66600000-6660-6660-6660-666000000000&optimize=1&bundleid=app1} for zone named {zone-zoneset-ProfileTargetingUDMPforApp-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 2.b  profile targeting for udmp, zone req, from app - PART TWO - Delivery
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {deviceid=00000000-0000-0000-0000-000000000000&optimize=1&bundleid=app1} for zone named {zone-zoneset-ProfileTargetingUDMPforApp-ST-1} to UAS
    Then The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-ProfileTargetingUDMPforApp-ST-1-banner-1} 100% of the time

  Scenario: 2.c  profile targeting for udmp, zone req, from app - PART THREE - Passback
    Given I clear all cookies from uas requests
    When I send 1 times an ad request with parameter {deviceid=61000000-6100-6100-6100-610000000000&optimize=1&bundleid=app1} for zone named {zone-zoneset-ProfileTargetingUDMPforApp-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  #  UTID=a7b8c8faf42446dcbba3248cef7dc7bb is coded to 9xgoi0i741z1bc7fldhmngq7v
  Scenario: 3. a. profile targeting for udmp, zone req, with cookie - PART ONE - Passback
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a7b8c8faf42446dcbba3248cef7dc7bb} to my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=udmp_seq_profile_web} for zone named {zone-zoneset-ProfileTargetingUDMPforWeb-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  #  UTID=a1b2c8faf42446dcbba3248cef7dc7bb is coded to 9kmivgho2hd1koqz149uxr16j
  Scenario: 3. b. profile targeting for udmp, zone req, with cookie - PART TWO - Delivery
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a1b2c8faf42446dcbba3248cef7dc7bb} to my requests to uas
    When I send 1 times an ad request for zone named {zone-zoneset-ProfileTargetingUDMPforWeb-ST-1} to UAS
    Then The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-ProfileTargetingUDMPforWeb-ST-1-banner-1} 100% of the time

  #  UTID=a1b2c8faf42446dcbba3248cef1dc2bb is coded to 9kmivgho2hd1koqz149uu05ob
  Scenario: 3. c. profile targeting for udmp, zone req, with cookie - PART THREE - Passback
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a1b2c8faf42446dcbba3248cef1dc2bb} to my requests to uas
    When I send 1 times an ad request with parameter {optimize=1&domain=udmp_seq_profile_web} for zone named {zone-zoneset-ProfileTargetingUDMPforWeb-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 4. a. Seq-targeting for udmp, DT req, with deviceid - PART ONE - Passback
    Given I clear all cookies from uas requests
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile_web&deviceid=00000006-0006-0006-0006-000000000006&tagid=170}
    Then The response code is 200
    And The responses are passback

  Scenario: 4. b. Seq-targeting for udmp, DT req, with deviceid - PART TWO - Passback
    Given I clear all cookies from uas requests
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile_web&deviceid=60000006-6006-6006-6006-600000000006&tagid=170}
    Then The response code is 200
    And The responses are passback

  Scenario: 4. c. Seq-targeting for udmp, DT req, with deviceid - PART THREE - Passback
    Given I clear all cookies from uas requests
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile_web&deviceid=60000006-6006-6006-6006-600000000000&tagid=170}
    Then The response code is 200
    And The responses are passback

  @SeqTargeting
  Scenario: 4. d. Seq-targeting for udmp, DT req, with deviceid - PART FOUR - Delivery
    Given I clear all cookies from uas requests
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile_web&deviceid=01000000-0100-0100-0100-010000000000&tagid=170}
    Then The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SeqProfileTargetingUDMPforWeb-ST-1-banner-1} 100% of the time


  @SeqTargeting
#  UTID=a2b3c8faf45446dcbba3248cef1dc2bb is encoded to=9mrjt7trg1a57yd4pv1i3ltbv
  Scenario: 5. a. profile seq targeting for udmp, DT req, from desktop - PART ONE - Delivery
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a2b3c8faf45446dcbba3248cef1dc2bb} to my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile_web&deviceid=01000000-0100-0100-0100-010000000000&tagid=170}
    Then The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SeqProfileTargetingUDMPforWeb-ST-1-banner-1} 100% of the time

#  UTID=a9b8c7faf65436dcbba3248cef1dc2bb is encoded to=a1q4r5t1dt2193lzjjoz7kmnv
  Scenario: 5. b. profile seq targeting for udmp, DT req, from desktop - PART TWO - Passback
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a9b8c7faf65436dcbba3248cef1dc2bb} to my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile_web&deviceid=00000006-0006-0006-0006-000000000006&tagid=170}
    Then The response code is 200
    And The responses are passback

#  UTID=a9b1c7faf25436dcbba3248cef1dc2bb is encoded to=a1o1866gg3j3ulsj9omeyfhyz
  Scenario: 5. c. profile seq targeting for udmp, DT req, from desktop - PART THREE - Passback
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a9b1c7faf25436dcbba3248cef1dc2bb} to my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile_web&deviceid=60000006-6006-6006-6006-600000000006&tagid=170}
    Then The response code is 200
    And The responses are passback

#  UTID=a9b1c8faf27436dcbba3248cef1dc2bb is encoded to =a1o19osvf0w6rfwepq3avxy9n
  Scenario: 5. d. profile seq targeting for udmp, DT req, from desktop - PART FOUR - Passback
    Given I clear all cookies from uas requests
    Given I add cookie UTID with value {a9b1c8faf27436dcbba3248cef1dc2bb} to my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile_web&deviceid=60000006-6006-6006-6006-600000000000&tagid=170}
    Then The response code is 200
    And The responses are passback

#  Scenario: 6. line item level frequency capping persona level - Mixed
###  67000000-0000-0000-0000-000000000000
###  78000000-0000-0000-0000-000000000000
#    #  step 1: 2 req from device 78
#    Given I clear all cookies from uas requests
#    When I send 2 times an ad request with parameter {deviceid=78000000-0000-0000-0000-000000000000&unlimited=1&optimize=1&bundleid=app1} for zone named {zone-zoneset-LI-FC-ST-1} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And I send impression requests to UAS
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LI-FC-ST-1-banner-1} 100% of the time
##   step 2: 1 req from device 67
#    When I send 1 times an ad request with parameter {deviceid=67000000-0000-0000-0000-000000000000&unlimited=1&optimize=1&bundleid=app1} for zone named {zone-zoneset-LI-FC-ST-2} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And I send impression requests to UAS
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LI-FC-ST-2-banner-1} 100% of the time
##    step 3: 1 req from 67, should return pb cause capping = 3
#    When I send 1 times an ad request with parameter {deviceid=67000000-0000-0000-0000-000000000000&unlimited=1&optimize=1&bundleid=app1} for zone named {zone-zoneset-LI-FC-ST-2} to UAS
#    And The response code is 200
#    And The responses are passback
##  step 4: renewal after 4 mins
#    And I sleep for 250 seconds
#    Given I clear all cookies from uas requests
#    When I send 1 times an ad request with parameter {deviceid=78000000-0000-0000-0000-000000000000&unlimited=1&optimize=1&bundleid=app1} for zone named {zone-zoneset-LI-FC-ST-1} to UAS
#    And The response code is 200
#    And The response contains {script}
#    And I send impression requests to UAS
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LI-FC-ST-1-banner-1} 100% of the time


  #  &&&&&&&&&&&&&&&&&  Eitan need to fix 3
  Scenario: 1.a *single device*  HB frequency capping persona level.
#  step 1: 3 req from device 89
    Given I clear all cookies from uas requests
    Given I use {Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30} as user-agent string to send my requests to uas
    Given i send 3 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 1, with domain {HB-FC-PL.com} and extra params {&deviceid=89000000-0000-0000-0000-000000000000&unlimited=1&optimize=1&bundleid=app1}
    And The response code is 200
    And all HB responses contains adId with id of entity named {campaign-HB-FC-PL-PG-1-banner-1}
    And The response code is 200
    And The response contains {script}
    Then The response contains {has_capping=1}
    And I send impression requests to UAS
    Given I sleep for 1 seconds
    Given i send 2 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 1, with domain {HB-FC-PL.com} and extra params {&deviceid=89000000-0000-0000-0000-000000000000&unlimited=1&optimize=1&bundleid=app1}
    And The response code is 200
    And all HB responses contains adId with id of entity named {campaign-HB-FC-PL-PG-1-banner-1}
    And The response code is 200
    And The response contains {script}
    And I send impression requests to UAS
    Given I sleep for 1 seconds
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 1, with domain {HB-FC-PL.com} and extra params {&deviceid=89000000-0000-0000-0000-000000000000&unlimited=1&optimize=1&bundleid=app1}
    And The responses are passback
    Given I sleep for 1 seconds
#  step 4: renewal after 1 min
    And I sleep for 62 seconds
    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 1, with domain {HB-FC-PL.com} and extra params {&deviceid=89000000-0000-0000-0000-000000000000&unlimited=1&optimize=1&bundleid=app1}
    And The response code is 200
    And all HB responses contains adId with id of entity named {campaign-HB-FC-PL-PG-1-banner-1}



