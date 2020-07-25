@parallel
@HeaderBiddingVideo1



  ## instream placement id = 3708002 (linear video ad)
  ## outstream placement id = 3708001 (video adhesion)
  # web property --> HB-Video.com
  # web section = 15921
  # linear adunit id = 35
  #video adhesion adunit id = 97

Feature: HB - Instream Video

  Background: health check
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    When Sending a healthcheck request to UAS
    And I add header of {X-Forwarded-For} with value {78.31.205.183}
    Then The response code is 200


#  Scenario Outline:1.1 Duration & skip --> expected VAST XML
#    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
#    Given i send instream video HB post request skip & duration for publisher <pubId> with domain <domain>, placementID group <placementId>, maxDuration = <maxDuration> and skippable = <skip>
#    And The response code is 200
#    And The response contains {VASTAdTagURI}
#    And The impressionUrl has bannerid field matching the id of the banner named {<bannerId>} 100% of the time
#    And The response not contains html
#
#    Examples:
#      | pubId | maxDuration | skip | placementId | domain                  | campaignId                      | bannerId                                 | JIRA                   |
#      # same as Publisher config
#      | 3708  | 15          | Y    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | campaign-15-D-skip-Y-banner-1            | UN-25361-Udrive        |
#      | 3843  | 15          | Y    | 3843002     | duration6Y.com          | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25358-Udrive-step1  |
#      | 3843  | 15          | Y    | 3843002     | duration15Y.com         | campaign-pub1-level-15-D-skip-Y | campaign-pub1-level-15-D-skip-Y-banner-1 | UN-25358-Udrive-step3  |
#      # override Publisher config
#      | 3708  | 20          | N    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | campaign-15-D-skip-Y-banner-1            | UN-25509-change-step3  |
#      | 3708  | 20          | Y    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | campaign-15-D-skip-Y-banner-1            | none                   |
#      | 3708  | 30          | N    | 3708002     | HB-Video.com            | campaign-30-D-skip-N            | campaign-30-D-skip-N-banner-1            | UN-25509-change-step4  |
#      | 3843  | 8           | N    | 3843002     | duration6Y.com          | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25359-change-step1  |
#      | 3843  | 16          | N    | 3843002     | duration15N.com         | campaign-pub1-level-15-D-skip-N | campaign-pub1-level-15-D-skip-N-banner-1 | UN-25359-change-step3  |
#      # Inherit Publisher config
#      | 3708  | -1          | N    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | campaign-15-D-skip-Y-banner-1            | UN-25510-Udrive-step1  |
#      | 3708  | -1          | -    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | campaign-15-D-skip-Y-banner-1            | UN-25510-Udrive-step3  |
#      | 3843  | -1          | N    | 3843002     | duration15Y.com         | campaign-pub1-level-15-D-skip-Y | campaign-pub1-level-15-D-skip-Y-banner-1 | UN-25360-Inherit-step1 |
#      | 3843  | -1          | -    | 3843002     | duration6Y.com          | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25360-Inherit-step3 |
##   #  *********************************************************************************
#
#  Scenario Outline:1.2 Video HB - Duration & skip --> expected Passback
#    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
#    Given i send sync instream video HB post request skip & duration for publisher <pubId> with domain <domain>, placementID group <placementId>, maxDuration = <maxDuration> and skippable = <skip>
#    Then The response code is 204
#    And The responses are passback
#
#    Examples:
#      | pubId | maxDuration | skip | placementId | domain                  | campaignId                      | bannerId | JIRA                   |
#      # override Publisher config
#      | 3708  | 6           | N    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | --       | UN-25509-change-step1  |
#      | 3708  | 6           | Y    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | --       | UN-25509-change-step2  |
#      | 3843  | 4           | N    | 3843002     | duration6N.com          | campaign-pub1-level-6-D-skip-N  | --       | UN-25359-change-step2  |
#      | 3843  | 18          | Y    | 3843002     | duration6N.com          | campaign-pub1-level-6-D-skip-N  | --       | none                   |
#      | 3843  | 29          | Y    | 3843002     | HB-Video.com            | campaign-pub1-level-30-D-skip-Y | --       | UN-25359-change-step4  |
#      | 3843  | 29          | N    | 3843002     | HB-Video.com            | campaign-pub1-level-30-D-skip-Y | --       | none                   |
#      # Inherit Publisher config
#      | 3708  | 6           | -    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | --       | UN-25510-Inherit-step2 |
#      | 3843  | 40          | -    | 3843002     | duration6N.com          | campaign-pub1-level-6-D-skip-N  | --       | UN-25360-Inherit-step2 |
#      | 3843  | -1          | -    | 3843002     | duration6N.com          | campaign-pub1-level-6-D-skip-N  | --       | UN-25360-Inherit-step4 |
#      | 3843  | -1          | Y    | 3843002     | HB-Video.com            | campaign-pub1-level-30-D-skip-Y | --       | none                   |


#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ VIDEO LOCATION $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

#*********************  DESKTOP *******************
#  Scenario: 1.0 playback method = all  |  size = none
#    request:  vpmt = 1 , player_size = 1  , response = Vast
#    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
#    Given i send sync video HB request with vpmt & size for pub 3708, domain vpmtAll-noSize.com, placementID 3708002, playerW = 300, playerH = 15, vpmt = 1 and skip = N
#    And The response contains {VASTAdTagURI}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackAll-noSize-banner-1} 100% of the time
#    And The response code is 200
#    #And The response not contains html
#
#  Scenario: 1.1 playback method = all  |  size = none
#  request:       vpmt = 0 (not exists) | player_size = 1  , response = passback
#    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
#    Given i send sync video HB request with vpmt & size for pub 3708, domain vpmtAll-noSize.com, placementID 3708002, playerW = 300, playerH = 15, vpmt = 0 and skip = N
#    Then The response code is 204
#    And The responses are passback
#
#  Scenario: 2.0 playback method = 1  |  size = 1
#  request:                 vpmt = 1  | player_size = 1  , response = Vast
#    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
#    Given i send sync video HB request with vpmt & size for pub 3708, domain vpmt1-Size1.com, placementID 3708002, playerW = 300, playerH = 15, vpmt = 1 and skip = N
#    And The response contains {VASTAdTagURI}
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback1-size1-banner-1} 100% of the time
#    And The response code is 200
#    #And The response not contains html
#
#  Scenario: 2.1 playback method = 1  |  size = 1
#  request:                 vpmt = 1  |  player_size = 2  , response = passback
#    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
#    Given i send sync video HB request with vpmt & size for pub 3708, domain vpmt1-Size1.com, placementID 3708002, playerW = 500, playerH = 15, vpmt = 1 and skip = N
#    Then The response code is 204
#    And The responses are passback
#
#  Scenario: 2.2 playback method = 1  |  size = 1
#  request:                 vpmt = 2  |  player_size = 1  , response = passback
#    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
#    Given i send sync video HB request with vpmt & size for pub 3708, domain vpmt1-Size1.com, placementID 3708002, playerW = 300, playerH = 15, vpmt = 2 and skip = N
#    Then The response code is 204
#    And The responses are passback

  Scenario: 3.0 playback method = 2  |  size = 2
  request:                 vpmt = 2  | player_size = 2  , response = Vast
    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt and size for pub 3708 and domain {vpmt2-Size2.com} and placementID {3708002} and playerW = 500 and playerH = 15 and vpmt = 2 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback2-size2-banner-1} 100% of the time
    And The response code is 200
    #And The response not contains html

#    Examples:
#      | pubId | playerW | playerH | playerMethod | skip | placementId | domain          | campaignId                                    | bannerId                                               |
#    #  | 3708  | 300     | 15      | 1            | N    | 3708002     | vpmtAll-noSize.com | campaign-LinearVideoFiltering-playbackAll-noSize | campaign-LinearVideoFiltering-playbackAll-noSize-banner-1 |
#    #  | 3708  | 300     | 15      | 1            | N    | 3708002     | vpmt1-Size1.com    | campaign-LinearVideoFiltering-playback1-size1    | campaign-LinearVideoFiltering-playback1-size1-banner-1    |
#      | 3708  | 500     | 15      | 2            | N    | 3708002     | vpmt2-Size2.com | campaign-LinearVideoFiltering-playback2-size2 | campaign-LinearVideoFiltering-playback2-size2-banner-1 |


