@parallel
@VideoDuration

Feature: Duration Video tests UN-21695 & UN-21696

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: 1.1 For a publisher 3708 which has single domain with 15s video duration & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-large-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-small-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-small-D-skip-Y-banner-1} 100% of the time
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-large-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-small-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-equal-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-equal-D-skip-Y-banner-1} 100% of the time
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-equal-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 1.2 For a publisher 3708 which has single domain with 15s video duration & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-large-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-small-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-small-D-skip-Y-banner-1} 100% of the time
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-large-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-small-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-small-D-skip-N-banner-1} 100% of the time
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-equal-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-equal-D-skip-Y-banner-1} 100% of the time
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-equal-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-equal-D-skip-N-banner-1} 100% of the time


    #***************   PUBLISHER LEVEL  ***************

  Scenario: 2.1 For a publisher 3843 configured with 15s video duration - by publisher level & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-small-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pub1-level-small-D-skip-Y-banner-1} 100% of the time
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-large-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-small-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-equal-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pub1-level-equal-D-skip-Y-banner-1} 100% of the time
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-equal-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback



  Scenario: 2.2 For a publisher 3728 configured with 15s video duration - by publisher level & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipno.com} for zone named {zone-zoneset-pub2-level-large-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipno.com} for zone named {zone-zoneset-pub2-level-small-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pub2-level-small-D-skip-Y-banner-1} 100% of the time
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipno.com} for zone named {zone-zoneset-pub2-level-large-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipno.com} for zone named {zone-zoneset-pub2-level-small-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pub2-level-small-D-skip-N-banner-1} 100% of the time
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipno.com} for zone named {zone-zoneset-pub2-level-equal-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pub2-level-equal-D-skip-Y-banner-1} 100% of the time
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipno.com} for zone named {zone-zoneset-pub2-level-equal-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pub2-level-equal-D-skip-N-banner-1} 100% of the time


    # %%%%%%%%%%     Story  UN-22740  %%%%%%%%%%%%%%  VIDEO ADHESION LIMITATION %%%%%%%%%%%%%   %%%%%%%%%%%%%%%%%%%%%%%%
  Scenario: 3.1 Exclude Outstream from video filtering - Video Adhesion without leave behind, publisher 3708 -  Domain has 15 seconds & skip = yes
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-video-adhesion-campaign-30-skip-Y} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-vid-adhesion-30-skip-Y-banner-1} 100% of the time

    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-video-adhesion-campaign-30-skip-N} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-vid-adhesion-30-skip-N-banner-1} 100% of the time


  Scenario: 3.2 Exclude Outstream from video filtering - Video Adhesion without leave behind, publisher 3708 -  Domain has 15 seconds & skip = no
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-video-adhesion-campaign-30-skip-Y} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-vid-adhesion-30-skip-Y-banner-1} 100% of the time

    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-video-adhesion-campaign-30-skip-N} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-vid-adhesion-30-skip-N-banner-1} 100% of the time
