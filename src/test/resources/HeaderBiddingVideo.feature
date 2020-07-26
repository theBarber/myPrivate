@parallel
@HeaderBiddingVideo1

Feature: HB - Instream Video

  Background: health check
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    When Sending a healthcheck request to UAS
    And I add header of {X-Forwarded-For} with value {78.31.205.183}
    Then The response code is 200


  Scenario Outline:1.1 Duration & skip --> expected VAST XML
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync instream video HB post request skip & duration for publisher <pubId> with domain {<domain>}, placementID group {<placementId>}, maxDuration = <maxDuration> and skippable = {<skip>}
    And The response code is 200
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {<bannerId>} 100% of the time
    And The response not contains html

    Examples:
      | pubId | maxDuration | skip | placementId | domain                  | campaignId                      | bannerId                                 | JIRA                   |
      # same as Publisher config
      | 3708  | 15          | Y    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | campaign-15-D-skip-Y-banner-1            | UN-25361-Udrive        |
      | 3843  | 15          | Y    | 3843002     | duration6Y.com          | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25358-Udrive-step1  |
      | 3843  | 15          | Y    | 3843002     | duration15Y.com         | campaign-pub1-level-15-D-skip-Y | campaign-pub1-level-15-D-skip-Y-banner-1 | UN-25358-Udrive-step3  |
      # override Publisher config
      | 3708  | 20          | N    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | campaign-15-D-skip-Y-banner-1            | UN-25509-change-step3  |
      | 3708  | 20          | Y    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | campaign-15-D-skip-Y-banner-1            | none                   |
      | 3708  | 30          | N    | 3708002     | HB-Video.com            | campaign-30-D-skip-N            | campaign-30-D-skip-N-banner-1            | UN-25509-change-step4  |
      | 3843  | 8           | N    | 3843002     | duration6Y.com          | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25359-change-step1  |
      | 3843  | 16          | N    | 3843002     | duration15N.com         | campaign-pub1-level-15-D-skip-N | campaign-pub1-level-15-D-skip-N-banner-1 | UN-25359-change-step3  |
      | 3843  | 16          | N    | 3843002     | duration6N.com          | campaign-pub1-level-6-D-skip-N  | campaign-pub1-level-6-D-skip-N-banner-1  | UN-25359-change-step3  |
      # Inherit Publisher config
      | 3708  | -1          | N    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | campaign-15-D-skip-Y-banner-1            | UN-25510-Udrive-step1  |
      | 3708  | -1          | -    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | campaign-15-D-skip-Y-banner-1            | UN-25510-Udrive-step3  |
      | 3843  | -1          | N    | 3843002     | duration15Y.com         | campaign-pub1-level-15-D-skip-Y | campaign-pub1-level-15-D-skip-Y-banner-1 | UN-25360-Inherit-step1 |
      | 3843  | -1          | -    | 3843002     | duration6Y.com          | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25360-Inherit-step3 |
#   #  *********************************************************************************

  Scenario Outline:1.2 Video HB - Duration & skip --> expected Passback
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync instream video HB post request skip & duration for publisher <pubId> with domain {<domain>}, placementID group {<placementId>}, maxDuration = <maxDuration> and skippable = {<skip>}
    Then The response code is 204
    And The responses are passback

    Examples:
      | pubId | maxDuration | skip | placementId | domain                  | campaignId                      | bannerId | JIRA                   |
      # override Publisher config
      | 3708  | 6           | N    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | --       | UN-25509-change-step1  |
      | 3708  | 6           | Y    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | --       | UN-25509-change-step2  |
      | 3843  | 4           | N    | 3843002     | duration6N.com          | campaign-pub1-level-6-D-skip-N  | --       | UN-25359-change-step2  |
      | 3843  | 18          | Y    | 3843002     | duration6N.com          | campaign-pub1-level-6-D-skip-N  | --       | none                   |
      | 3843  | 29          | Y    | 3843002     | HB-Video.com            | campaign-pub1-level-30-D-skip-Y | --       | UN-25359-change-step4  |
      | 3843  | 29          | N    | 3843002     | HB-Video.com            | campaign-pub1-level-30-D-skip-Y | --       | none                   |
      # Inherit Publisher config
      | 3708  | 6           | -    | 3708002     | duration15_skip_yes.com | campaign-15-D-skip-Y            | --       | UN-25510-Inherit-step2 |
      | 3843  | 40          | -    | 3843002     | duration6N.com          | campaign-pub1-level-6-D-skip-N  | --       | UN-25360-Inherit-step2 |
      | 3843  | -1          | -    | 3843002     | duration6N.com          | campaign-pub1-level-6-D-skip-N  | --       | UN-25360-Inherit-step4 |
      | 3843  | -1          | Y    | 3843002     | HB-Video.com            | campaign-pub1-level-30-D-skip-Y | --       | none                   |


#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ VIDEO LOCATION $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

#*********************  DESKTOP *******************
#         player size = request size / (phone screen size) * 100
#       < 400    --> small
#     400 - 700  --> medium
#     above 700  --> large

  Scenario: 1.0 playback method = all  |  size = none
  request:  vpmt = 1 , player_size = 1  , response = Vast
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtAll-noSize.com}, placementID {3708002}, playerW = 300, playerH = 15, vpmt = 1 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackAll-noSize-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 1.1 playback method = all  |  size = none
  request:       vpmt = 0 (not exists) | player_size = 1  , response = passback
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtAll-noSize.com}, placementID {3708002}, playerW = 300, playerH = 15, vpmt = 0 and skip = {N}
    Then The response code is 204
    And The responses are passback

  Scenario: 2.0 playback method = 1  |  size = 1
  request:                 vpmt = 1  | player_size = 1  , response = Vast
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt1-Size1.com}, placementID {3708002}, playerW = 300, playerH = 15, vpmt = 1 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback1-size1-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 2.1 playback method = 1  |  size = 1
  request:                 vpmt = 1  |  player_size = 2  , response = passback
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt1-Size1.com}, placementID {3708002}, playerW = 500, playerH = 15, vpmt = 1 and skip = {N}
    Then The response code is 204
    And The responses are passback

  Scenario: 2.2 playback method = 1  |  size = 1
  request:                 vpmt = 2  |  player_size = 1  , response = passback
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt1-Size1.com}, placementID {3708002}, playerW = 300, playerH = 15, vpmt = 2 and skip = {N}
    Then The response code is 204
    And The responses are passback

  Scenario: 3.0 playback method = 2  |  size = 2
  request:                 vpmt = 2  | player_size = 2  , response = Vast
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt2-Size2.com}, placementID {3708002}, playerW = 500, playerH = 15, vpmt = 2 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback2-size2-banner-1} 100% of the time
    And The response code is 200
    #And The response not contains html

  Scenario: 4.0 playback method = 3  |  size = 3
  request:                 vpmt = 3  | player_size = 3  , response = Vast
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt3-Size3.com}, placementID {3708002}, playerW = 800, playerH = 15, vpmt = 3 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback3-size3-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 5.0 playback method = 4  |  size = all
  request:                 vpmt = 4  | player_size = 3  , response = Vast
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt4-allSizes.com}, placementID {3708002}, playerW = 800, playerH = 15, vpmt = 4 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback4-allsizes-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 6.0 playback method = all  |  size = 3
  request:                   vpmt = 4  | player_size = 3  , response = Vast
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtAll-Size3.com}, placementID {3708002}, playerW = 800, playerH = 15, vpmt = 4 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackAll-size3-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 6.1 playback method = all  |  size = 3
  request:                   vpmt = 4  | player_size = 2  , response = passback
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtAll-Size3.com}, placementID {3708002}, playerW = 500, playerH = 15, vpmt = 4 and skip = {N}
    Then The response code is 204
    And The responses are passback

  Scenario: 7.0 playback method = all  |  size = all
  request:                   vpmt = 1  | player_size = 2  , response = Vast
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtAll-allSize.com}, placementID {3708002}, playerW = 500, playerH = 15, vpmt = 1 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackall-allsizes-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 7.1 playback method = all  |  size = all
  request:       vpmt = 0 (not exists) | player_size = 2  , response = Vast
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtAll-allSize.com}, placementID {3708002}, playerW = 500, playerH = 15, vpmt = 0 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackall-allsizes-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 8.0 playback method = none  |  size = all
  request:                     vpmt = 1 | player_size = 2  , response = Vast
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtNon-allSize.com}, placementID {3708002}, playerW = 500, playerH = 15, vpmt = 1 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-allsizes-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html


  Scenario: 9.0 playback method = none  |  size = none
  request:                   vpmt = 1 | player_size = 2  , response = Vast
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtNon-noSize.com}, placementID {3708002}, playerW = 500, playerH = 15, vpmt = 1 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-noSize-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

#*********************  MOBILE  ******************* user-agent --> 640  X 360
#         player size = request size / (phone screen size) * 100
#       0 -20%  --> small
#     20% - 90% --> medium
#     above 90% --> large

  Scenario: 10.0 playback method = 1  |  size = 1
  request:                  vpmt = 1  | player_size = 1  , response = Vast
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt1-Size1.com}, placementID {3708002}, playerW = 150, playerH = 200, vpmt = 1 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback1-size1-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 10.1   playback method = 1  |  size = 1
  request:                     vpmt = 1 | player_size = 2  , response = passback
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt1-Size1.com}, placementID {3708002}, playerW = 250, playerH = 350, vpmt = 1 and skip = {N}
    Then The response code is 204
    And The responses are passback


  Scenario: 11.0 playback method = 2  |  size = 2
  request:                  vpmt = 2  | player_size = 2  , response = Vast
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt2-Size2.com}, placementID {3708002}, playerW = 250, playerH = 350, vpmt = 2 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback2-size2-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 11.1 playback method = 2  |  size = 2
  request:                  vpmt = 2  | player_size = 1  , response = passback
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt2-Size2.com}, placementID {3708002}, playerW = 150, playerH = 200, vpmt = 2 and skip = {N}
    Then The response code is 204
    And The responses are passback

  Scenario: 11.2 playback method = 2  |  size = 2
  request:                  vpmt = 2  | player_size = 3  , response = passback
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt2-Size2.com}, placementID {3708002}, playerW = 450, playerH = 500, vpmt = 2 and skip = {N}
    Then The response code is 204
    And The responses are passback

  Scenario: 12.0 playback method = 3  |  size = 3
  request:                  vpmt = 3  | player_size = 3  , response = Vast
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt3-Size3.com}, placementID {3708002}, playerW = 450, playerH = 500, vpmt = 3 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback3-size3-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 12.1 playback method = 3  |  size = 3
  request:                  vpmt = 3  | player_size = 2  , response = passback
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt3-Size3.com}, placementID {3708002}, playerW = 250, playerH = 350, vpmt = 3 and skip = {N}
    Then The response code is 204
    And The responses are passback

  Scenario: 13.0 playback method = 4  |  size = all
  request:                  vpmt = 4  | player_size = 1  , response = Vast
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt4-allSizes.com}, placementID {3708002}, playerW = 150, playerH = 200, vpmt = 4 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback4-allsizes-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 13.1 playback method = 4  |  size = all
  request:                  vpmt = 4  | player_size = 2  , response = Vast
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt4-allSizes.com}, placementID {3708002}, playerW = 250, playerH = 350, vpmt = 4 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback4-allsizes-banner-1} 100% of the time
    And The response code is 200
    #And The response not contains html

  Scenario: 13.2 playback method = 4  |  size = all
  request:                  vpmt = 4  | player_size = 3  , response = Vast
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmt4-allSizes.com}, placementID {3708002}, playerW = 450, playerH = 500, vpmt = 4 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback4-allsizes-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 14.0 playback method = none  |  size = 1 & 2
  request:         vpmt = 0 (not exists) | player_size = 1  , response = Vast
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtNon-Size1_2.com}, placementID {3708002}, playerW = 150, playerH = 200, vpmt = 0 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-sizes1And2-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 14.1 playback method = none  |  size = 1 & 2
  request:         vpmt = 0 (not exists) | player_size = 2  , response = Vast
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtNon-Size1_2.com}, placementID {3708002}, playerW = 250, playerH = 350, vpmt = 0 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-sizes1And2-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 14.1 playback method = none  |  size = 1 & 2
  request:         vpmt = 0 (not exists) | player_size = 3  , response = passback
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtNon-Size1_2.com}, placementID {3708002}, playerW = 450, playerH = 500, vpmt = 0 and skip = {N}
    Then The response code is 204
    And The responses are passback

  Scenario: 15.0 playback method = none  |  size = none
  request:         vpmt = 0 (not exists) | player_size = 1 , response = Vast
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtNon-noSize.com}, placementID {3708002}, playerW = 150, playerH = 200, vpmt = 0 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-noSize-banner-1} 100% of the time
    And The response code is 200
    #And The response not contains html

  Scenario: 15.1 playback method = none  |  size = none
  request:         vpmt = 0 (not exists) | player_size = 2 , response = Vast
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtNon-noSize.com}, placementID {3708002}, playerW = 250, playerH = 350, vpmt = 0 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-noSize-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

  Scenario: 15.2 playback method = none  |  size = none
  request:         vpmt = 0 (not exists) | player_size = 3 , response = Vast
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given i send sync video HB request with vpmt & size for pub 3708, domain {vpmtNon-noSize.com}, placementID {3708002}, playerW = 450, playerH = 500, vpmt = 0 and skip = {N}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-noSize-banner-1} 100% of the time
    And The response code is 200
    And The response not contains html

#&&&&&&&&&&&&&&&&&&&&&& special scenarios --  no skip no duration campaigns &&&&&&&&&&&&&&&&&&&

  Scenario: 16.0 No skip and no duration no player size campaign - publisher 3843 (15Y) - passback - UN-25541
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB video with no skip mo duration no vpmt - inherit pub 3843} for publisher 3843 with domain {noSkipNoDuration.com} with extra params {&optimize=1}
    Then The response code is 204
    And The responses are passback

  Scenario: 16.1 No skip and no duration no player size campaign - publisher 3728 (15N) - VAST - UN-25541
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB video with no skip mo duration no vpmt - inherit pub 3728} for publisher 3728 with domain {noSkipNoDuration.com} with extra params {&optimize=1}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-noSkip-noDuration3728-banner-1} 100% of the time
    And The response code is 200


  Scenario: 17.0 Two eligible zones 1X1 - display and video - no placement group --> video Vast return - UN-25542
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given i send 1 headerBidding post request for scenario {Send HB video with 2 eligible zones - display and video} for publisher 3708 with domain {noSize-vpmtAll.com} with extra params {&optimize=1}
    And The response contains {VASTAdTagURI}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-instream-general-banner-1} 100% of the time
    And The response code is 200






#    Examples:
#      | pubId | playerW | playerH | playerMethod | skip | placementId | domain          | campaignId                                    | bannerId                                               |
#    #  | 3708  | 300     | 15      | 1            | N    | 3708002     | vpmtAll-noSize.com | campaign-LinearVideoFiltering-playbackAll-noSize | campaign-LinearVideoFiltering-playbackAll-noSize-banner-1 |
#    #  | 3708  | 300     | 15      | 1            | N    | 3708002     | vpmt1-Size1.com    | campaign-LinearVideoFiltering-playback1-size1    | campaign-LinearVideoFiltering-playback1-size1-banner-1    |
#      | 3708  | 500     | 15      | 2            | N    | 3708002     | vpmt2-Size2.com | campaign-LinearVideoFiltering-playback2-size2 | campaign-LinearVideoFiltering-playback2-size2-banner-1 |


