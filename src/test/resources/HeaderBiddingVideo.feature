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


  Scenario Outline: Video HB - Duration & skip --> expected VAST XML in response
    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
    Given i send instream video HB post request skip & duration for publisher <pubId> with domain <domain>, placementID group <placementId>, maxDuration = <maxDuration> and skippable = <skip>
    And The response code is 200
    And The response contains {VASTAdTagURI}
    And all HB responses contains campaignId with id of entity named {<campaignId>}
    And The impressionUrl has bannerid field matching the id of the banner named {<bannerId>} 100% of the time
    And The response not contains html

    Examples:
      | pubId | domain                  | placementId | maxDuration | skip  | campaignId                     | bannerId                                |
      | 3843  | duration15_skip_yes.com | 3708002     | 15          | true  | campaign-pub1-level-6-D-skip-Y | campaign-pub1-level-6-D-skip-Y-banner-1 |
      | 3843  | HB-Video.com            | 3708002     | 5           | false | bbb                            | aa                                      |
      | 3843  | HB-Video.com            | 3708002     | 16          | false | ccc                            | aa                                      |
      | 3843  | HB-Video.com            | 3708002     | 22          | false | ddd                            | aa                                      |

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