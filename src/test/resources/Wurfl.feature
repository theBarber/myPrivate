@warfle
@parallel
@scheduled
@noAA




Feature: warfle tests - wurfl limitation in campaign and zone level, contextual targeting

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: contextual targeting by dv - campaign level limitation domain exclude
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdisney.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-exclude-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fwww.military.com%2Fequipment%2Fweapons%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-exclude-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=notarealweblala.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: contextual targeting by dv - campaign level limitation
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdisney.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains script
#    And I read the latest req log file from uas
#    And The field providers_categories in the 116 column of the req log is: 2_81012999,2_81030001,2_81030002,2_82031130,2_82032230,2_82033130,2_82033140,2_82035130,2_82041105,2_82042105,2_82043105,2_82045105,2_83032003,2_83032004,2_83041130,2_83041140,2_83041150,2_83041155,2_83041160,2_83051110,2_84011001,2_84012001,2_84251001,2_84252026,2_85000000,2_99000001,2_99012001,2_99012012,2_99012013,2_99012014
#    And The field categories in the 23 column of the req log is: 5248,7553,7554,5252,37765,39178,12940,5261,12687,24728,39322,37660,17183,18208,17186,13475,18853,17190,39595,10288,17845,16951,37433,38329,37435,39103,38596,38085,21318,22984,21320,20812,18893,17869,12750,12752,24657,24146,2261,7510,17114,15963,39651,17764,7526,20838,19047,7527,33128,7528,7529,7531,7532,16621,18161,35445,7541,39672,24184,7545,7546,7548,25087
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-dv-campaignLevelLimit-ST-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdrugs.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fwww.military.com%2Fequipment%2Fweapons%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=notarealweblala.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-campaignLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback


  Scenario: contextual targeting - peer 39 banner level limitation backward compatibility
    When I send 1 times an ad request with parameter {optimize=0&loc=https://edition.cnn.com/sport} for zone named {zone-zoneset-CT-ST-1} to UAS
#    And I sleep for 600 seconds
    When I send 1 times an ad request with parameter {optimize=0&loc=http://www.cnn.com} for zone named {zone-zoneset-CT-ST-1} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-CT-ST-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0&loc=notarealweblala.com} for zone named {zone-zoneset-CT-ST-1} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: contextual targeting - peer 39 banner level limitation
    When I send 1 times an ad request with parameter {optimize=0&loc=http://www.cnn.com} for zone named {zone-zoneset-CT-ST-1} to UAS
    And The response code is 200
    And The response contains script
#    And I read the latest req log file from uas
#    And The field providers_categories in the 116 column of the req log is: 1_10288,1_12687,1_12750,1_12752,1_12940,1_13475,1_1419,1_15963,1_16621,1_16951,1_17114,1_17134,1_17183,1_17764,1_17845,1_17869,1_18161,1_18208,1_18853,1_18893,1_19047,1_20812,1_20838,1_21314,1_21316,1_21318,1_21321,1_22025,1_2261,1_22984,1_24146,1_24184,1_24657,1_24728,1_25086,1_32793,1_33128,1_35445,1_36087,1_36194,1_37116,1_37435,1_37765,1_37843,1_38596,1_38848,1_39242,1_39489,1_39672,1_5248,1_5250,1_5252,1_7435,1_7526,1_7527,1_7528,1_7529,1_7531,1_7541,1_7545,1_7546,1_7548,1_7553,1_7554,1_8835
#    And The field categories in the 23 column of the req log is: 5248,7553,5250,7554,8835,5252,37765,22025,7435,1419,12940,12687,24728,32793,17183,18208,13475,18853,10288,17845,16951,37435,38848,39489,21314,21316,38596,21318,22984,21321,39242,20812,18893,17869,12750,12752,24657,24146,37843,2261,17114,15963,36194,17764,7526,20838,19047,7527,33128,7528,7529,7531,16621,17134,18161,7541,35445,36087,39672,24184,7545,7546,37116,7548,25086
    And The impressionUrl has bannerid field matching the id of the banner named {zone-zoneset-CT-ST-1-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0&loc=notarealweblala.com} for zone named {zone-zoneset-CT-ST-1} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: contextual targeting by dv - zone level limitation
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdisney.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-dv-zoneLevelLimit-ST-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdrugs.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fwww.military.com%2Fequipment%2Fweapons%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=notarealweblala.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-ST} to UAS
    And The response code is 200
    And The responses are passback


  Scenario: contextual targeting by dv & peer 39 - zone level limitation
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdisney.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-peer-ST} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-dv-zoneLevelLimit-peer-ST-banner-1} 100% of the time
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fdrugs.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-peer-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=https%3A%2F%2Fwww.military.com%2Fequipment%2Fweapons%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-peer-ST} to UAS
    And The response code is 200
    And The responses are passback
    When I send 1 times an ad request with parameter {optimize=0&loc=notarealweblala.com%3Fdv_test%3D1} for zone named {zone-zoneset-dv-zoneLevelLimit-peer-ST} to UAS
    And The response code is 200
    And The responses are passback


  Scenario: Wurfl limitations
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0&domain=daniellaHamalka.com} for zone named {zone-zoneset-WL-ST-2} to UAS
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-WL-ST-2-banner-1} 100% of the time
    Given I use {Mozilla/5.0 (Linux; U; Android 2.2) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1} as user-agent string to send my requests to uas
    When I send 1 times an ad request with parameter {optimize=0&domain=daniellaHamalka.com} for zone named {zone-zoneset-WL-ST-2} to UAS
    And The response code is 200
    And The responses are passback