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
      | pubId | domain                  | placementId | maxDuration | skip | campaignId                      | bannerId                                 | JIRA                   |
      | 3708  | duration15_skip_yes.com | 3708002     | 15          | Y    | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25361-Udrive        |
      | 3843  | duration6Y.com          | 3843002     | 15          | Y    | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25358-Udrive-step1  |
      | 3843  | duration15Y.com         | 3843002     | 15          | Y    | campaign-pub1-level-15-D-skip-Y | campaign-pub1-level-15-D-skip-Y-banner-1 | UN-25358-Udrive-step3  |
      # override Publisher config
      | 3708  | duration15_skip_yes.com | 3708002     | 20          | N    | campaign-15-D-skip-Y            | campaign-15-D-skip-Y-banner-1            | UN-25509-change-step2  |
      | 3708  | duration15_skip_yes.com | 3708002     | 30          | N    | campaign-30-D-skip-N            | campaign-30-D-skip-N-banner-1            | UN-25509-change-step3  |
      | 3843  | duration6Y.com          | 3843002     | 8           | N    | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25359-change-step1  |
      | 3843  | duration15N.com         | 3843002     | 16          | N    | campaign-pub1-level-15-D-skip-N | campaign-pub1-level-15-D-skip-N-banner-1 | UN-25359-change-step3  |
      # Inherit Publisher config
      | 3843  | duration15Y.com         | 3843002     | -1          | N    | campaign-pub1-level-15-D-skip-Y | campaign-pub1-level-15-D-skip-Y-banner-1 | UN-25360-Inherit-step1 |
      | 3843  | duration6Y.com          | 3843002     | -1          | -    | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25360-Inherit-step3 |
   #  *********************************************************************************

  Scenario Outline: Video HB - Duration & skip --> expected Passback in response
    Given I use {Mozilla/5.0 (Linux; Android 4.4.2; GT-P5220 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.94 Safari/537.36} as user-agent string to send my requests to uas
    Given i send instream video HB post request skip & duration for publisher <pubId> with domain <domain>, placementID group <placementId>, maxDuration = <maxDuration> and skippable = <skip>
    Then The response code is 204
    And The responses are passback

    Examples:
      | pubId | domain                  | placementId | maxDuration | skip | campaignId                      | bannerId                                 | JIRA                   |
      | 3708  | duration15_skip_yes.com | 3708002     | 15          | Y    | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25361-Udrive        |
      | 3843  | duration6Y.com          | 3843002     | 15          | Y    | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25358-Udrive-step1  |
      | 3843  | duration15Y.com         | 3843002     | 15          | Y    | campaign-pub1-level-15-D-skip-Y | campaign-pub1-level-15-D-skip-Y-banner-1 | UN-25358-Udrive-step3  |
      # override Publisher config
      | 3708  | duration15_skip_yes.com | 3708002     | 20          | N    | campaign-15-D-skip-Y            | campaign-15-D-skip-Y-banner-1            | UN-25509-change-step2  |
      | 3708  | duration15_skip_yes.com | 3708002     | 30          | N    | campaign-30-D-skip-N            | campaign-30-D-skip-N-banner-1            | UN-25509-change-step3  |
      | 3843  | duration6Y.com          | 3843002     | 8           | N    | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25359-change-step1  |
      | 3843  | duration15N.com         | 3843002     | 16          | N    | campaign-pub1-level-15-D-skip-N | campaign-pub1-level-15-D-skip-N-banner-1 | UN-25359-change-step3  |
      # Inherit Publisher config
      | 3843  | duration15Y.com         | 3843002     | -1          | N    | campaign-pub1-level-15-D-skip-Y | campaign-pub1-level-15-D-skip-Y-banner-1 | UN-25360-Inherit-step1 |
      | 3843  | duration6Y.com          | 3843002     | -1          | -    | campaign-pub1-level-6-D-skip-Y  | campaign-pub1-level-6-D-skip-Y-banner-1  | UN-25360-Inherit-step3 |


