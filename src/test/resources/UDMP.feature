@UDMP
@UDMPWOAA

Feature: UDMP TESTS = profile targeting, seq targeting, cross decice capping

##UTID=a2b3c8faf45446dcbba3248cef1dc2bb is encoded to=9mrjt7trg1a57yd4pv1i3ltbv
  Scenario: cross device PT for udmp, PERSONA LEVEL, zone req. 1 users - 2 devices - one app one web.
    Then i inject new profile doc with udId {2.12340000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {udpm_p}, profile num = 123, and reduce 0 days from epoc time stamp and extra devices string = {"udid": "2.12340000-0000-0000-0000-000000000000"},{"udid": "1.9mrjt7trg1a57yd4pv1i3ltbv"}
    Then i inject new profile doc with udId {1.9mrjt7trg1a57yd4pv1i3ltbv} on users bucket, where platform = {desktop}, profile type = {udpm_p}, profile num = 456, and reduce 0 days from epoc time stamp and extra devices string = {"udid": "2.12340000-0000-0000-0000-000000000000"},{"udid": "1.9mrjt7trg1a57yd4pv1i3ltbv"}
    When I send 1 times an ad request with parameter {deviceid=12340000-0000-0000-0000-000000000000} for zone named {zone-zoneset-ProfileTargetingUDMPCrossDevice-ST-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-ProfileTargetingUDMPCrossDevice-ST-1-banner-1} 100% of the time
    Given I add cookie UTID with value {a2b3c8faf45446dcbba3248cef1dc2bb} to my requests to uas
    When I send 1 times an ad request for zone named {zone-zoneset-ProfileTargetingUDMPCrossDevice-ST-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-ProfileTargetingUDMPCrossDevice-ST-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {deviceid=06060000-0060-0000-0000-000000006000} for zone named {zone-zoneset-ProfileTargetingUDMPCrossDevice-ST-1} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: cross device capping for udmp,zone req when capping = 2, cross device capping = true
    Then i inject new profile doc with udId {2.11000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {udpm_p}, profile num = 1992, and reduce 0 days from epoc time stamp and extra devices string = {"udid": "2.11000000-0000-0000-0000-000000000000"},{"udid": "2.12000000-0000-0000-0000-000000000000"},{"udid": "2.13000000-0000-0000-0000-000000000000"}
    Then i inject new profile doc with udId {2.12000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {udpm_p}, profile num = 1992, and reduce 0 days from epoc time stamp and extra devices string = {"udid": "2.11000000-0000-0000-0000-000000000000"},{"udid": "2.12000000-0000-0000-0000-000000000000"},{"udid": "2.13000000-0000-0000-0000-000000000000"}
    Then i inject new profile doc with udId {2.13000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {udpm_p}, profile num = 1992, and reduce 0 days from epoc time stamp and extra devices string = {"udid": "2.11000000-0000-0000-0000-000000000000"},{"udid": "2.12000000-0000-0000-0000-000000000000"},{"udid": "2.13000000-0000-0000-0000-000000000000"}
    When I send 1 times an ad request with parameter {deviceid=11000000-0000-0000-0000-000000000000&unlimited=1} for zone named {zone-zoneset-CrossDeviceCappingUDMP-ST-1} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceCappingUDMP-ST-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {deviceid=12000000-0000-0000-0000-000000000000&unlimited=1} for zone named {zone-zoneset-CrossDeviceCappingUDMP-ST-1} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CrossDeviceCappingUDMP-ST-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {deviceid=13000000-0000-0000-0000-000000000000&unlimited=1} for zone named {zone-zoneset-CrossDeviceCappingUDMP-ST-1} to UAS
    And The response code is 200
    And The responses are passback

#    works from here
  Scenario: profile targeting for udmp, zone req, from app
    Then i create new profile doc with udId {2.66600000-6660-6660-6660-666000000000} on users bucket, where platform = {app}, profile type = {udmp_p}, profile num = 1992, and reduce 3 days from epoc time stamp
    When I send 1 times an ad request with parameter {deviceid=66600000-6660-6660-6660-666000000000} for zone named {zone-zoneset-ProfileTargetingUDMPforApp-ST-1} to UAS
    Then The response code is 200
    And The responses are passback
    Then i create new profile doc with udId {2.00000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {udmp_p}, profile num = 1992, and reduce 0 days from epoc time stamp
    When I send 1 times an ad request with parameter {deviceid=00000000-0000-0000-0000-000000000000} for zone named {zone-zoneset-ProfileTargetingUDMPforApp-ST-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-ProfileTargetingUDMPforApp-ST-1-banner-1} 100% of the time
    Then i create new profile doc with udId {2.61000000-6100-6100-6100-610000000000} on users bucket, where platform = {app}, profile type = {udmp_p}, profile num = 1989, and reduce 0 days from epoc time stamp
    When I send 1 times an ad request with parameter {deviceid=61000000-6100-6100-6100-610000000000} for zone named {zone-zoneset-ProfileTargetingUDMPforApp-ST-1} to UAS
    Then The response code is 200
    And The responses are passback

#  UTID=a7b8c8faf42446dcbba3248cef7dc7bb is coded to 9xgoi0i741z1bc7fldhmngq7v
#  UTID=a1b2c8faf42446dcbba3248cef7dc7bb is coded to 9kmivgho2hd1koqz149uxr16j
#  UTID=a1b2c8faf42446dcbba3248cef1dc2bb is coded to 9kmivgho2hd1koqz149uu05ob
  Scenario: profile targeting for udmp, zone req, from desktop
    Then i create new profile doc with udId {1.9xgoi0i741z1bc7fldhmngq7v} on users bucket, where platform = {desktop}, profile type = {udmp_p}, profile num = 1992, and reduce 3 days from epoc time stamp
    Given I add cookie UTID with value {a7b8c8faf42446dcbba3248cef7dc7bb} to my requests to uas
    When I send 1 times an ad request for zone named {zone-zoneset-ProfileTargetingUDMPforWeb-ST-1} to UAS
    Then The response code is 200
    And The responses are passback
    Then i create new profile doc with udId {1.9kmivgho2hd1koqz149uxr16j} on users bucket, where platform = {desktop}, profile type = {udmp_p}, profile num = 1992, and reduce 0 days from epoc time stamp
    Given I add cookie UTID with value {a1b2c8faf42446dcbba3248cef7dc7bb} to my requests to uas
    When I send 1 times an ad request for zone named {zone-zoneset-ProfileTargetingUDMPforWeb-ST-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-ProfileTargetingUDMPforWeb-ST-1-banner-1} 100% of the time
    Then i create new profile doc with udId {1.9kmivgho2hd1koqz149uu05ob} on users bucket, where platform = {desktop}, profile type = {udmp_p}, profile num = 1989, and reduce 0 days from epoc time stamp
    Given I add cookie UTID with value {a1b2c8faf42446dcbba3248cef1dc2bb} to my requests to uas
    When I send 1 times an ad request for zone named {zone-zoneset-ProfileTargetingUDMPforWeb-ST-1} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: Seq-targeting for udmp, DT req, from app
    Then i inject new profile doc with udId {2.00000006-0006-0006-0006-000000000006} on users bucket, where platform = {app}, empty profile type = {sqmsg_p}, non-empty profile type = {udmp_p}
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile&deviceid=00000006-0006-0006-0006-000000000006&tagid=177}
    Then The response code is 200
    And The responses are passback
    Then i inject new profile doc with udId {2.60000006-6006-6006-6006-600000000006} on users bucket, where platform = {app}, with one udmp_p profile = {199} with 3 days reduce and one sqmsg_p profile = {20} with 0 days reduce
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile&deviceid=60000006-6006-6006-6006-600000000006&tagid=177}
    Then The response code is 200
    And The responses are passback
    Then i inject new profile doc with udId {2.60000006-6006-6006-6006-600000000000} on users bucket, where platform = {app}, with one udmp_p profile = {1992} with 0 days reduce and one sqmsg_p profile = {17} with 5 days reduce
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile&deviceid=60000006-6006-6006-6006-600000000000&tagid=177}
    Then The response code is 200
    And The responses are passback
    Then i create new profile doc with udId {2.01000000-0100-0100-0100-010000000000} on users bucket, where platform = {app}, profile type = {sqmsg_p}, profile num = 17, and reduce 0 days from epoc time stamp
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile&deviceid=01000000-0100-0100-0100-010000000000&tagid=177}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SeqProfileTargetingUDMPforApp-ST-1-banner-1} 100% of the time

#UTID=a2b3c8faf45446dcbba3248cef1dc2bb is encoded to=9mrjt7trg1a57yd4pv1i3ltbv
#  UTID=a9b8c7faf65436dcbba3248cef1dc2bb is encoded to=a1q4r5t1dt2193lzjjoz7kmnv
#  UTID=a9b1c7faf25436dcbba3248cef1dc2bb is encoded to=a1o1866gg3j3ulsj9omeyfhyz
#  UTID=a9b1c8faf27436dcbba3248cef1dc2bb is encoded to =a1o19osvf0w6rfwepq3avxy9n
  Scenario: profile seq targeting for udmp, DT req, from desktop
    Then i create new profile doc with udId {1.9mrjt7trg1a57yd4pv1i3ltbv} on users bucket, where platform = {desktop}, profile type = {sqmsg_p}, profile num = 17, and reduce 0 days from epoc time stamp
    Given I add cookie UTID with value {a2b3c8faf45446dcbba3248cef1dc2bb} to my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile&deviceid=01000000-0100-0100-0100-010000000000&tagid=170}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-SeqProfileTargetingUDMPforWeb-ST-1-banner-1} 100% of the time
    Then i inject new profile doc with udId {1.a1q4r5t1dt2193lzjjoz7kmnv} on users bucket, where platform = {desktop}, empty profile type = {sqmsg_p}, non-empty profile type = {udmp_p}
    Given I add cookie UTID with value {a9b8c7faf65436dcbba3248cef1dc2bb} to my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile&deviceid=00000006-0006-0006-0006-000000000006&tagid=170}
    Then The response code is 200
    And The responses are passback
    Then i inject new profile doc with udId {1.a1o1866gg3j3ulsj9omeyfhyz} on users bucket, where platform = {desktop}, with one udmp_p profile = {199} with 3 days reduce and one sqmsg_p profile = {20} with 0 days reduce
    Given I add cookie UTID with value {a9b1c7faf25436dcbba3248cef1dc2bb} to my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile&deviceid=60000006-6006-6006-6006-600000000006&tagid=170}
    Then The response code is 200
    And The responses are passback
    Then i inject new profile doc with udId {1.a1o19osvf0w6rfwepq3avxy9n} on users bucket, where platform = {desktop}, with one udmp_p profile = {1992} with 0 days reduce and one sqmsg_p profile = {17} with 5 days reduce
    Given I add cookie UTID with value {a9b1c8faf27436dcbba3248cef1dc2bb} to my requests to uas
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {udmp_seq_profile&deviceid=60000006-6006-6006-6006-600000000000&tagid=170}
    Then The response code is 200
    And The responses are passback


  Scenario: PTzoneLimitation
    Then i create new profile doc with udId {2.17100000-1710-1710-1710-000000000000} on users bucket, where platform = {app}, profile type = {udmp_p}, profile num = 666, and reduce 3 days from epoc time stamp
    When I send 1 times an ad request with parameter {deviceid=17100000-1710-1710-1710-000000000000} for zone named {zone-zoneset-PTzoneLimitation-ST-1} to UAS
    Then The response code is 200
    And The responses are passback
    Then i create new profile doc with udId {2.00000000-0000-0000-0000-000000005678} on users bucket, where platform = {app}, profile type = {udmp_p}, profile num = 666, and reduce 0 days from epoc time stamp
    When I send 1 times an ad request with parameter {deviceid=00000000-0000-0000-0000-000000005678} for zone named {zone-zoneset-PTzoneLimitation-ST-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-ProfileTargetingUDMPforApp-ST-1-banner-1} 100% of the time
    Then i create new profile doc with udId {2.73000000-6300-6100-6100-810000009000} on users bucket, where platform = {app}, profile type = {udmp_p}, profile num = 555, and reduce 0 days from epoc time stamp
    When I send 1 times an ad request with parameter {deviceid=73000000-6300-6100-6100-810000009000} for zone named {zone-zoneset-PTzoneLimitation-ST-1} to UAS
    Then The response code is 200
    And The responses are passback








##latter
#  Scenario: -Seq PT- for udmp, -zone req-, from app
#    Then i create new profile doc with udId {2.01000000-0100-0100-0100-010000000000} on users bucket, where platform = {app}, profile type = {sqmsg_p}, profile num = 17, and reduce 0 days from epoc time stamp
#    When I send 1 times an ad request with parameter {deviceid=01000000-0100-0100-0100-010000000000 } for zone named {zone-zoneset-SeqProfileTargetingUDMPforApp-ST-1} to UAS
#    Then The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {ampaign-SeqProfileTargetingUDMPforApp-ST-1} 100% of the time
#    Then i inject new profile doc with udId {2.00000006-0006-0006-0006-000000000006} on users bucket, where platform = {app}, empty profile type = {sqmsg_p}, non-empty profile type = {udmp_p}
#    When I send 1 times an ad request with parameter {deviceid=00000006-0006-0006-0006-000000000006 } for zone named {zone-zoneset-SeqProfileTargetingUDMPforApp-ST-1} to UAS
#    Then The response code is 200
#    And The responses are passback
#    Then i inject new profile doc with udId {2.60000006-6006-6006-6006-600000000006} on users bucket, where platform = {app}, with one udmp_p profile = {199} with 3 days reduce and one sqmsg_p profile = {20} with 0 days reduce
#    When I send 1 times an ad request with parameter {deviceid=60000006-6006-6006-6006-600000000006 } for zone named {zone-zoneset-SeqProfileTargetingUDMPforApp-ST-1} to UAS
#    Then The response code is 200
#    And The responses are passback
#    Then i inject new profile doc with udId {2.60000006-6006-6006-6006-600000000000} on users bucket, where platform = {app}, with one udmp_p profile = {1992} with 0 days reduce and one sqmsg_p profile = {17} with 5 days reduce
#    When I send 1 times an ad request with parameter {deviceid=60000006-6006-6006-6006-600000000000 } for zone named {zone-zoneset-SeqProfileTargetingUDMPforApp-ST-1} to UAS
#    Then The response code is 200
#    And The responses are passback


##  Scenario: cross device capping for udmp, HB req when capping = 2, cross device capping = false
##    Then i inject new profile doc with udId {21000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {udpm_p}, profile num = 1992, and reduce 0 days from epoc time stamp and extra devices string = {"udid": "21000000-0000-0000-0000-000000000000"},{"udid": "22000000-0000-0000-0000-000000000000"},{"udid": "23000000-0000-0000-0000-000000000000"}
##    Then i inject new profile doc with udId {22000000-0000-0000-0000-000000000000} on users bucket, where platform = {app}, profile type = {udpm_p}, profile num = 1992, and reduce 0 days from epoc time stamp and extra devices string = {"udid": "21000000-0000-0000-0000-000000000000"},{"udid": "22000000-0000-0000-0000-000000000000"},{"udid": "23000000-0000-0000-0000-000000000000"}
##    Then i send 2 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {??????} with extra params {deviceid=21000000-0000-0000-0000-000000000000}
##    And The response code is 200
##    And The response contains script
##    And all HB responses contains campaignId with id of entity named {campaign-HB-Ta?????????????blet-160x600}
##    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-1????????60x600-banner-1}
##    And all HB responses contains cpm with id 1
##    And for all HB responses i simulate winning, and send their zone tag
##    And The response code is 200
##    And The response contains script
##    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Tablet-1??????0x600-banner-1} 100% of the time
##    Then i send 2 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {??????} with extra params {deviceid=22000000-0000-0000-0000-000000000000}
##    And The response code is 200
##    And The response contains script
##    And all HB responses contains campaignId with id of entity named {campaign-HB-Ta?????????????blet-160x600}
##    And all HB responses contains adId with id of entity named {campaign-HB-Tablet-1????????60x600-banner-1}
##    And all HB responses contains cpm with id 1
##    And for all HB responses i simulate winning, and send their zone tag
##    And The response code is 200
##    And The response contains script
##    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Tablet-1??????0x600-banner-1} 100% of the time
##    Then i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {??????} with extra params {deviceid=21000000-0000-0000-0000-000000000000}
##    And The response code is 200
##    And The responses are passback
##    Then i send 1 headerBidding post request for scenario {Send HB basic request for publisher 3708} for publisher 3708 with domain {??????} with extra params {deviceid=22000000-0000-0000-0000-000000000000}
##    And The response code is 200
##    And The responses are passback