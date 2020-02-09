@parallel
@LinearVidFiltering
@testeitan2
@uas

#   Keren Levy
#   2.2.2010

Feature: Linear Video Filtering tests - ATP/CTP & Video Player size Limitation

  Background: health check
    When Sending a healthcheck request to {UAS}
    Then The response code is 200


# - - - - - - - - - - - - - - - - - - - - - - 1 - - - - - - - - - - - - - - - - - - - - - -
  
   Scenario: 1.0      playback_method = all   |  player_size = none
            request:  playback_method = 1     |  player_size = 1
            response: playback_method = CTP   |  player_size = small
    Given I send 1 times an ad request with parameter {cw=300&ch=250&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-playbackAll-noSize} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackAll-noSize-banner-1} 100% of the time
    
   
   #  - - - - - - - - - - - - -
   Scenario: 1.1      playback_method = all      |  player_size = none
            request:  playback_method = 5        |  player_size = 1
            response: playback_method = default  |  player_size = small
     Given I send 1 times an ad request with parameter {cw=300&ch=250&vpmt=5} for zone named {zone-zoneset-LinearVideoFiltering-playbackAll-noSize} to UAS
     Then The response code is 200
     And The response contains {VAST}
     And The responses has impression-urls
     And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackAll-noSize-banner-1} 100% of the time


# - - - - - - - - - - - - - - - - - - - - - - 2 - - - - - - - - - - - - - - - - - - - - - -
  
   Scenario: 2.0      playback_method = 1    |  player_size = 1
            request:  playback_method = 1    |  player_size = 1
            response: playback_method = CTP  |  player_size = small
     Given I send 1 times an ad request with parameter {cw=300&ch=250&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-playback1-size1} to UAS
     Then The response code is 200
     And The response contains {VAST}
     And The responses has impression-urls
     And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback1-size1-banner-1} 100% of the time

   #  - - - - - - - - - - - - -
  
   Scenario: 2.1      playback_method = 1    |  player_size = 1
            request:  playback_method = 1    |  player_size = 2
            response: passback
     Given I send 1 times an ad request with parameter {cw=400&ch=300&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-playback1-size1} to UAS
     Then The response code is 200
     And The responses are passback
   #  - - - - - - - - - - - - -
  
   Scenario: 2.2       playback_method = 1    |  player_size = 1
            request:   playback_method = 2    |  player_size = 1
            response: passback
     Given I send 1 times an ad request with parameter {cw=300&ch=250&vpmt=2} for zone named {zone-zoneset-LinearVideoFiltering-playback1-size1} to UAS
     Then The response code is 200
     And The responses are passback
   
#  - - - - - - - - - - - - - - - - - - - - - - 3 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 3.0       playback_method = 2             |   player_size = 2
            request:  playback_method = 2             |   player_size = 2
            response: playback_method = ATP(Sound On) |   player_size = medium
    Given I send 1 times an ad request with parameter {cw=400&ch=300&vpmt=2} for zone named {zone-zoneset-LinearVideoFiltering-playback2-size2} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback2-size2-banner-1} 100% of the time


#  - - - - - - - - - - - - - - - - - - - - - - 4 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 4.0       playback_method = 3              |   player_size = 3
            request:  playback_method = 3              |   player_size = 3
            response: playback_method = ATP(Sound Off) |   player_size = large
    Given I send 1 times an ad request with parameter {cw=1280&ch=720&vpmt=3} for zone named {zone-zoneset-LinearVideoFiltering-playback3-size3} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback3-size3-banner-1} 100% of the time


#  - - - - - - - - - - - - - - - - - - - - - - 5 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 5.0       playback_method = 4               |   player_size = all
            request:  playback_method = 4               |   player_size = 3
            response: playback_method = ATP(MouseHover) |   player_size = large
    Given I send 1 times an ad request with parameter {cw=1280&ch=720&vpmt=4} for zone named {zone-zoneset-LinearVideoFiltering-playback4-allsizes} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playback4-allsizes-banner-1} 100% of the time

#  - - - - - - - - - - - - - - - - - - - - - - 6 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 6.0       playback_method = all               |   player_size = 3
            request:  playback_method = 4                 |   player_size = 3
            response: playback_method = ATP(MouseHover)   |   player_size = large
    Given I send 1 times an ad request with parameter {cw=1280&ch=720&vpmt=4} for zone named {zone-zoneset-LinearVideoFiltering-playbackAll-size3} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackAll-size3-banner-1} 100% of the time

  #  - - - - - - - - - - - - -

  Scenario: 6.1       playback_method = all               |   player_size = 3
            request:  playback_method = 4                 |   player_size = 2
            response: passback
    Given I send 1 times an ad request with parameter {cw=400&ch=300&vpmt=4} for zone named {zone-zoneset-LinearVideoFiltering-playbackAll-size3} to UAS
    Then The response code is 200
    And The responses are passback

#  - - - - - - - - - - - - - - - - - - - - - - 7 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 7.0       playback_method = all   |   player_size = all
            request:  playback_method = 1     |   player_size = 2
            response: playback_method = CTP   |   player_size = medium
    Given I send 1 times an ad request with parameter {cw=400&ch=300&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-playbackall-allsizes} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackall-allsizes-banner-1} 100% of the time

  #  - - - - - - - - - - - - -
  
  Scenario: 7.1       playback_method = all       |   player_size = all
            request:  playback_method = 0         |   player_size = 2
            response: playback_method = default   |   player_size = medium
    Given I send 1 times an ad request with parameter {cw=400&ch=300&vpmt=0} for zone named {zone-zoneset-LinearVideoFiltering-playbackall-allsizes} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackall-allsizes-banner-1} 100% of the time

#  - - - - - - - - - - - - - - - - - - - - - - 8 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 8.0       playback_method = none        |   player_size = all
            request:  playback_method = 1           |   player_size = 2
            response: playback_method = default     |   player_size = medium
    Given I send 1 times an ad request with parameter {cw=600&ch=300&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-noPlayback-allsizes} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-allsizes-banner-1} 100% of the time

#  - - - - - - - - - - - - - - - - - - - - - - 9 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 9.0       playback_method = none        |   player_size = none
            request:  playback_method = 1           |   player_size = 2
            response: playback_method = default     |   player_size = medium
    Given I send 1 times an ad request with parameter {cw=400&ch=300&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-noPlayback-noSize} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-noPlayback-noSize-banner-1} 100% of the time