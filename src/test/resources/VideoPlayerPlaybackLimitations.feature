@parallel
@LinearVidFiltering
@uas

#   Keren Levy
#   2.2.2010

Feature: Linear Video Filtering tests - ATP/CTP & Video Player size Limitation

  Background: health check
    When Sending a healthcheck request to {UAS}
    Then The response code is 200


# - - - - - - - - - - - - - - - - - - - - - - 1 - - - - - - - - - - - - - - - - - - - - - -
  
   Scenario: 1.0       playback_method = all  |  player_size = none
            request:  playback_method = 1     |  player_size = 1
            response: playback_method = CTP   |  player_size = small
    Given I send 1 times an ad request with parameter {cw=640&ch=360&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-playbackAll-noSize} to UAS
    Then The response code is 200
    And The response contains {script}
    
   
   #  - - - - - - - - - - - - -
   Scenario: 1.1       playback_method = all     |  player_size = none
            request:  playback_method = 5        |  player_size = 1
            response: playback_method = default  |  player_size = small
    Given I send 1 times an ad request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-large-D-skip-Y-CS-Video} to UAS


# - - - - - - - - - - - - - - - - - - - - - - 2 - - - - - - - - - - - - - - - - - - - - - -
  
   Scenario: 2.0       playback_method = 1   |  player_size = 1
            request:  playback_method = 1    |  player_size = 1
            response: playback_method = CTP  |  player_size = small
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-small-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pub1-level-small-D-skip-Y-banner-1} 100% of the time
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-small-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
  
   #  - - - - - - - - - - - - -
  
   Scenario: 2.1       playback_method = 1   |  player_size = 1
            request:  playback_method = 1    |  player_size = 2
            response: passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} to UAS
   
   #  - - - - - - - - - - - - -
  
   Scenario: 2.2       playback_method = 1    |  player_size = 1
            request:   playback_method = 2    |  player_size = 1
            response: passback
   Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} to UAS
   
   
#  - - - - - - - - - - - - - - - - - - - - - - 3 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 3.0       playback_method = 2             |   player_size = 2
            request:  playback_method = 2             |   player_size = 2
            response: playback_method = ATP(Sound On) |   player_size = medium
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} to UAS

#  - - - - - - - - - - - - - - - - - - - - - - 4 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 4.0       playback_method = 3              |   player_size = 3
            request:  playback_method = 3              |   player_size = 3
            response: playback_method = ATP(Sound Off) |   player_size = large
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} to UAS


#  - - - - - - - - - - - - - - - - - - - - - - 5 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 5.0       playback_method = 4               |   player_size = all
            request:  playback_method = 4               |   player_size = 3
            response: playback_method = ATP(MouseHover) |   player_size = large
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} to UAS
 
#  - - - - - - - - - - - - - - - - - - - - - - 6 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 6.0       playback_method = all               |   player_size = 3
            request:  playback_method = 4                 |   player_size = 3
            response: playback_method = ATP(MouseHover)   |   player_size = large
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} to UAS

  #  - - - - - - - - - - - - -

  Scenario: 6.1       playback_method = all               |   player_size = 3
            request:  playback_method = 4                 |   player_size = 2
            response: passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} to UAS

#  - - - - - - - - - - - - - - - - - - - - - - 7 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 7.0       playback_method = all   |   player_size = all
            request:  playback_method = 1     |   player_size = 2
            response: playback_method = CTP   |   player_size = medium
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} to UAS
  
  #  - - - - - - - - - - - - -
  
  Scenario: 7.1       playback_method = all       |   player_size = all
            request:  playback_method = 0         |   player_size = 2
            response: playback_method = default   |   player_size = medium
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} to UAS

#  - - - - - - - - - - - - - - - - - - - - - - 8 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 8.0       playback_method = none        |   player_size = all
            request:  playback_method = 1           |   player_size = 2
            response: playback_method = default     |   player_size = medium
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} to UAS
   
#  - - - - - - - - - - - - - - - - - - - - - - 9 - - - - - - - - - - - - - - - - - - - - - -
  
  Scenario: 9.0       playback_method = none        |   player_size = none
            request:  playback_method = 1           |   player_size = 2
            response: playback_method = default     |   player_size = medium
    Given I send 1 times an ad request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} to UAS
    