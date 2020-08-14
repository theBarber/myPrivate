@parallel
@LinearVidFiltering
@testeitan1973
@uas
@request_service
Feature: Linear Video Filtering tests

  Background: health check
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    When Sending a healthcheck request to UAS
    And I add {NY} ip header
    Then The response code is 200

# %%%%%%%%%%%%%%%%%%%%%%%%%%%  DESKTOP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# - - - - - - - - - - - - - - - - - - - - - - 1 - - - - - - - - - - - - - - - - - - - - - -

  Scenario: 1.0      playback_method = all   |  player_size = none
  request:  playback_method = 1     |  player_size = 1
  response: playback_method = ATP(No sound) |  player_size = small
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=300&ch=250&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-playbackAll-noSize} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackAll-noSize-banner-1} 100% of the time


   #  - - - - - - - - - - - - -
  Scenario: 1.1      playback_method = all      |  player_size = none
  request:  playback_method = 5        |  player_size = 1
  response: playback_method = default  |  player_size = small
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=300&ch=250&vpmt=5} for zone named {zone-zoneset-LinearVideoFiltering-playbackAll-noSize} to UAS
    Then The response code is 200
    And The responses are passback
# - - - - - - - - - - - - - - - - - - - - - - 2 - - - - - - - - - - - - - - - - - - - - - -

  Scenario: 2.0      playback_method = 1    |  player_size = 1
  request:  playback_method = 1    |  player_size = 1
  response: playback_method = ATP  |  player_size = small
    Given I send 1 times an ad video request with parameter {cw=300&ch=250&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-playback1-size1} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback1-size1-banner-1} 100% of the time

   #  - - - - - - - - - - - - -

  Scenario: 2.1      playback_method = 1    |  player_size = 1
  request:  playback_method = 1    |  player_size = 2
  response: passback
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=400&ch=300&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-playback1-size1} to UAS
    Then The response code is 200
    And The responses are passback
   #  - - - - - - - - - - - - -

  Scenario: 2.2       playback_method = 1    |  player_size = 1
  request:   playback_method = 2    |  player_size = 1
  response: passback
    Given I send 1 times an ad video request with parameter {cw=300&ch=250&vpmt=2} for zone named {zone-zoneset-LinearVideoFiltering-playback1-size1} to UAS
    Then The response code is 200
    And The responses are passback

#  - - - - - - - - - - - - - - - - - - - - - - 3 - - - - - - - - - - - - - - - - - - - - - -

  Scenario: 3.0       playback_method = 2             |   player_size = 2
  request:  playback_method = 2             |   player_size = 2
  response: playback_method = ATP(Sound off) |   player_size = medium
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=400&ch=300&vpmt=2} for zone named {zone-zoneset-LinearVideoFiltering-playback2-size2} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback2-size2-banner-1} 100% of the time


#  - - - - - - - - - - - - - - - - - - - - - - 4 - - - - - - - - - - - - - - - - - - - - - -

  Scenario: 4.0       playback_method = 3              |   player_size = 3
  request:  playback_method = 3              |   player_size = 3
  response: playback_method = CTP |   player_size = large
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=1280&ch=720&vpmt=3} for zone named {zone-zoneset-LinearVideoFiltering-playback3-size3} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback3-size3-banner-1} 100% of the time


#  - - - - - - - - - - - - - - - - - - - - - - 5 - - - - - - - - - - - - - - - - - - - - - -

  Scenario: 5.0       playback_method = 4               |   player_size = all
  request:  playback_method = 4               |   player_size = 3
  response: playback_method = ATP(MouseHover) |   player_size = large
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=1280&ch=720&vpmt=4} for zone named {zone-zoneset-LinearVideoFiltering-playback4-allsizes} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback4-allsizes-banner-1} 100% of the time

#  - - - - - - - - - - - - - - - - - - - - - - 6 - - - - - - - - - - - - - - - - - - - - - -

  Scenario: 6.0       playback_method = all               |   player_size = 3
  request:  playback_method = 4                 |   player_size = 3
  response: playback_method = ATP(MouseHover)   |   player_size = large
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=1280&ch=720&vpmt=4} for zone named {zone-zoneset-LinearVideoFiltering-playbackAll-size3} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackAll-size3-banner-1} 100% of the time

  #  - - - - - - - - - - - - -

  Scenario: 6.1       playback_method = all               |   player_size = 3
  request:  playback_method = 4                 |   player_size = 2
  response: passback
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=400&ch=300&vpmt=4} for zone named {zone-zoneset-LinearVideoFiltering-playbackAll-size3} to UAS
    Then The response code is 200
    And The responses are passback

#  - - - - - - - - - - - - - - - - - - - - - - 7 - - - - - - - - - - - - - - - - - - - - - -

  Scenario: 7.0       playback_method = all   |   player_size = all
  request:  playback_method = 1     |   player_size = 2
  response: playback_method = all   |   player_size = medium
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=400&ch=300&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-playbackall-allsizes} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackall-allsizes-banner-1} 100% of the time

  #  - - - - - - - - - - - - -

  Scenario: 7.1       playback_method = all       |   player_size = all
  request:  playback_method = 0         |   player_size = 2
  response: playback_method = default   |   player_size = medium
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=400&ch=300&vpmt=0} for zone named {zone-zoneset-LinearVideoFiltering-playbackall-allsizes} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackall-allsizes-banner-1} 100% of the time

#  - - - - - - - - - - - - - - - - - - - - - - 8 - - - - - - - - - - - - - - - - - - - - - -

  Scenario: 8.0       playback_method = none        |   player_size = all
  request:  playback_method = 1           |   player_size = 2
  response: playback_method = default     |   player_size = medium
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=600&ch=300&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-noPlayback-allsizes} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-allsizes-banner-1} 100% of the time

#  - - - - - - - - - - - - - - - - - - - - - - 9 - - - - - - - - - - - - - - - - - - - - - -

  Scenario: 9.0       playback_method = none        |   player_size = none
  request:  playback_method = 1           |   player_size = 2
  response: playback_method = default     |   player_size = medium
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=400&ch=300&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-noPlayback-noSize} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-noSize-banner-1} 100% of the time

# %%%%%%%%%%     Story  UN-22187  %%%%%%%%%%%%%%  MOBILE %%%%%%%%%%%%%%%    user-agent --> 640  X 360   %%%%%%%%%%%%%%%%%%%%%%%%

  Scenario: 10.0    |   Positive  test   |     player_size = 1       |  player_size = small
  request:          player_size = small   |  resolution = 150 X 200  |   calculated site = 13%
  response:         player_size = small
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=150&ch=200&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-playback1-size1} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback1-size1-banner-1} 100% of the time

  Scenario: 10.1    |   Negative  test |   player_size = 1       |  player_size = small
  request:             player_size = medium  |  resolution = 250 X 350  |   calculated site = 37.9%
  response:            passback
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=250&ch=350&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-playback1-size1} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: 11.0      |   Positive  test    |     player_size = 2        |  player_size = medium
  request:           player_size = medium   |  resolution = 250 X 350    |   calculated site = 37.9%
  response:          player_size = medium
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=250&ch=350&vpmt=2} for zone named {zone-zoneset-LinearVideoFiltering-playback2-size2} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback2-size2-banner-1} 100% of the time

  Scenario: 11.1    |   Negative  test      |   player_size = 2            |   player_size = medium
  request:          player_size = small     |  resolution = 150 X 200      |   calculated site = 13%
  response:            passback
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=150&ch=200&vpmt=2} for zone named {zone-zoneset-LinearVideoFiltering-playback2-size2} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 11.2    |   Negative  test      |   player_size = 2            |   player_size = medium
  request:             player_size = large  |   resolution = 450 X 500     |   calculated site = 97.6%
  response:            passback
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=450&ch=500&vpmt=2} for zone named {zone-zoneset-LinearVideoFiltering-playback2-size2} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 12.0       |   Positive  test    |   player_size = 3
  request:              player_size = large  |   resolution = 450 X 500     |   calculated site = 97.6%
  response:             player_size = large
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=450&ch=500&vpmt=3} for zone named {zone-zoneset-LinearVideoFiltering-playback3-size3} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback3-size3-banner-1} 100% of the time

  Scenario: 12.1     |   Negative  test      |   player_size = 3            |   player_size = large
  request:            player_size = medium   |  resolution = 250 X 350    |   calculated site = 37.9%
  response:            passback
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=250&ch=350&vpmt=3} for zone named {zone-zoneset-LinearVideoFiltering-playback3-size3} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: 13.0        |   Positive  test    |   player_size = all
  request:      player_size = small           |  resolution = 150 X 200  |   calculated site = 13%
  response:     player_size = small
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=150&ch=200&vpmt=4} for zone named {zone-zoneset-LinearVideoFiltering-playback4-allsizes} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback4-allsizes-banner-1} 100% of the time


  Scenario: 13.1        |   Positive  test    |   player_size = all
  request:      player_size = medium  |  resolution = 250 X 350  |   calculated site = 37.9%
  response:     player_size = medium
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=250&ch=350&vpmt=4} for zone named {zone-zoneset-LinearVideoFiltering-playback4-allsizes} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback4-allsizes-banner-1} 100% of the time

  Scenario: 13.2        |   Positive  test    |   player_size = all
  request:              player_size = large  |   resolution = 450 X 500     |   calculated site = 97.6%
  response:             player_size = large
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=450&ch=500&vpmt=4} for zone named {zone-zoneset-LinearVideoFiltering-playback4-allsizes} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback4-allsizes-banner-1} 100% of the time


  Scenario: 14.0        |   Positive  test    |   player_size = 1 & 2  (small & medium)
  request:      player_size = small           |  resolution = 150 X 200  |   calculated site = 13%
  response:     player_size = small
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=150&ch=200} for zone named {zone-zoneset-LinearVideoFiltering-noPlayback-sizes1And2} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-sizes1And2-banner-1} 100% of the time


  Scenario: 14.1        |   Positive  test    |   player_size = 1 & 2  (small & medium)
  request:      player_size = medium  |  resolution = 250 X 350  |   calculated site = 37.9%
  response:     player_size = medium
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=250&ch=350} for zone named {zone-zoneset-LinearVideoFiltering-noPlayback-sizes1And2} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-sizes1And2-banner-1} 100% of the time


  Scenario: 14.2        |   Negative  test    |   player_size = 1 & 2  (small & medium)
  request:              player_size = large  |   resolution = 450 X 500     |   calculated site = 97.6%
  response:             passback
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=450&ch=500} for zone named {zone-zoneset-LinearVideoFiltering-noPlayback-sizes1And2} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: 15.0        |   Positive  test    |   player_size = no size
  request:      player_size = small           |  resolution = 150 X 200  |   calculated site = 13%
  response:     player_size = small
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=150&ch=200} for zone named {zone-zoneset-LinearVideoFiltering-noPlayback-noSize} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-noSize-banner-1} 100% of the time

  Scenario: 15.1        |   Positive  test    |   player_size = no size
  request:      player_size = medium  |  resolution = 250 X 350  |   calculated site = 37.9%
  response:     player_size = medium
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=250&ch=350} for zone named {zone-zoneset-LinearVideoFiltering-noPlayback-noSize} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-noSize-banner-1} 100% of the time


  Scenario: 15.2        |   Positive  test    |   player_size = no size
  request:              player_size = large  |   resolution = 450 X 500     |   calculated site = 97.6%
  response:             player_size = large
    Given I use {Mozilla/5.0 (Linux; Android 4.4.4; 2014821 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/35.0.1916.138 Mobile Safari/537.36 T7/7.5 baidubrowser/7.5.22.0 (Baidu; P1 4.4.4)} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=450&ch=500} for zone named {zone-zoneset-LinearVideoFiltering-noPlayback-noSize} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-noSize-banner-1} 100% of the time