@parallel
@HeaderBiddingVideo1



  ## instream placement id = 3708002 (linear video ad)
  ## outstream placement id = 3708001 (video adhesion)
  # web property --> HB-Video.com
  # web section = 15921
  # linear adunit id = 35
  #video adhesion adunit id = 97

Feature: Header Bidding Video instream & outstream

  Background: health check
    When Sending a healthcheck request to UAS
    And I add header of {X-Forwarded-For} with value {78.31.205.183}
    Then The response code is 200


  Scenario: 1.0      playback_method = all           |  player_size = none
  request:           playback_method = 1             |  player_size = 1
  response:          playback_method = ATP(No sound) |  player_size = small

    Given i send 1 headerBidding post................
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-LinearVideoFiltering-playbackAll-noSize}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackAll-noSize-banner-1} 100% of the time

#    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
#    Given I send 1 times an ad video request with parameter {cw=300&ch=250&vpmt=1} for zone named {zone-zoneset-LinearVideoFiltering-playbackAll-noSize} to UAS
#    Then The response code is 200
#    And The response contains {VASTAdTagURI}
#    And The responses has impression-urls
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-LinearVideoFiltering-playbackAll-noSize-banner-1} 100% of the time


  Scenario: 1.1      playback_method = all      |  player_size = none
  request:  playback_method = 5        |  player_size = 1
  response: playback_method = default  |  player_size = small
    Given I use {Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36} as user-agent string to send my requests to uas
    Given I send 1 times an ad video request with parameter {cw=300&ch=250&vpmt=5} for zone named {zone-zoneset-LinearVideoFiltering-playbackAll-noSize} to UAS
    Then The response code is 200
    And The responses are passback

   #  *********************************************************************************



  Scenario:16 Send Price per platform request with 300X250
    Given i send 1 headerBidding post request for scenario {Send HB PPP request for publisher 3673 with 300X250} for publisher 3673 with domain {headerbiddingproptest.com} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-HB-Desktop-300X250}
    And all HB responses contains adId with id of entity named {campaign-HB-Desktop-300X250-banner-1}
    And all HB responses contains cpm with value {2.5}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-Desktop-300X250-banner-1} 100% of the time
    And I send impression requests to UAS