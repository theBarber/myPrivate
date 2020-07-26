@parallel
@VideoDuration
@request_service
Feature: Duration Video tests UN-21695 & UN-21696

  Background: health check
    Given I clear all cookies from uas requests
    Given I clear all headers from uas requests
    And I add {NY} ip header
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: 1.1.a. For a publisher 3708 which has single domain with 15s video duration & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-30-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 1.1.b. For a publisher 3708 which has single domain with 15s video duration & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-6-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-6-D-skip-Y-banner-1} 100% of the time
    And The response not contains html

  Scenario: 1.1.c. For a publisher 3708 which has single domain with 15s video duration & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-30-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 1.1.d. For a publisher 3708 which has single domain with 15s video duration & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-6-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 1.1.e. For a publisher 3708 which has single domain with 15s video duration & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-15-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-15-D-skip-Y-banner-1} 100% of the time
    And The response not contains html

  Scenario: 1.1.f. For a publisher 3708 which has single domain with 15s video duration & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-15-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 1.2.a. For a publisher 3708 which has single domain with 15s video duration & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-30-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 1.2.b. For a publisher 3708 which has single domain with 15s video duration & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-6-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-6-D-skip-Y-banner-1} 100% of the time
    And The response not contains html

  Scenario: 1.2.c. For a publisher 3708 which has single domain with 15s video duration & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-30-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 1.2.d. For a publisher 3708 which has single domain with 15s video duration & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-6-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-6-D-skip-N-banner-1} 100% of the time
    And The response not contains html

  Scenario: 1.2.e. For a publisher 3708 which has single domain with 15s video duration & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-15-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-15-D-skip-Y-banner-1} 100% of the time
    And The response not contains html

  Scenario: 1.2.f. For a publisher 3708 which has single domain with 15s video duration & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-15-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-15-D-skip-N-banner-1} 100% of the time
    And The response not contains html


    #***************   PUBLISHER LEVEL  ***************

  Scenario: 2.1.a. For a publisher 3843 configured with 15s video duration - by publisher level & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-30-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 2.1.b. For a publisher 3843 configured with 15s video duration - by publisher level & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-6-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pub1-level-6-D-skip-Y-banner-1} 100% of the time
    And The response not contains html

  Scenario: 2.1.c. For a publisher 3843 configured with 15s video duration - by publisher level & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-30-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 2.1.d. For a publisher 3843 configured with 15s video duration - by publisher level & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-6-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 2.1.e. For a publisher 3843 configured with 15s video duration - by publisher level & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-15-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pub1-level-15-D-skip-Y-banner-1} 100% of the time
    And The response not contains html

  Scenario: 2.1.f. For a publisher 3843 configured with 15s video duration - by publisher level & skippable = Yes - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipyes.com} for zone named {zone-zoneset-pub1-level-15-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: 2.2.a. For a publisher 3728 configured with 15s video duration - by publisher level & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipno.com} for zone named {zone-zoneset-pub2-level-30-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 2.2.b. For a publisher 3728 configured with 15s video duration - by publisher level & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipno.com} for zone named {zone-zoneset-pub2-level-6-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pub2-level-6-D-skip-Y-banner-1} 100% of the time
    And The response not contains html

  Scenario: 2.2.c. For a publisher 3728 configured with 15s video duration - by publisher level & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipno.com} for zone named {zone-zoneset-pub2-level-30-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 2.2.d. For a publisher 3728 configured with 15s video duration - by publisher level & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipno.com} for zone named {zone-zoneset-pub2-level-6-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pub2-level-6-D-skip-N-banner-1} 100% of the time
    And The response not contains html

  Scenario: 2.2.e. For a publisher 3728 configured with 15s video duration - by publisher level & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipno.com} for zone named {zone-zoneset-pub2-level-15-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pub2-level-15-D-skip-Y-banner-1} 100% of the time
    And The response not contains html

  Scenario: 2.2.f. For a publisher 3728 configured with 15s video duration - by publisher level & skippable = No - zone tag request
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=levelduration15skipno.com} for zone named {zone-zoneset-pub2-level-15-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pub2-level-15-D-skip-N-banner-1} 100% of the time
    And The response not contains html


    # %%%%%%%%%%     Story  UN-22740  %%%%%%%%%%%%%%  VIDEO ADHESION LIMITATION %%%%%%%%%%%%%   %%%%%%%%%%%%%%%%%%%%%%%%
  Scenario: 3.1.a. Exclude Outstream from video filtering - Video Adhesion without leave behind, publisher 3708 -  Domain has 15 seconds & skip = yes
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-video-adhesion-campaign-30-skip-Y} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-vid-adhesion-30-skip-Y-banner-1} 100% of the time
    And The response not contains html

  Scenario: 3.1.b. Exclude Outstream from video filtering - Video Adhesion without leave behind, publisher 3708 -  Domain has 15 seconds & skip = yes
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-video-adhesion-campaign-30-skip-N} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-vid-adhesion-30-skip-N-banner-1} 100% of the time
    And The response not contains html

  Scenario: 3.2.a. Exclude Outstream from video filtering - Video Adhesion without leave behind, publisher 3708 -  Domain has 15 seconds & skip = no
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-video-adhesion-campaign-30-skip-Y} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-vid-adhesion-30-skip-Y-banner-1} 100% of the time
    And The response not contains html

  Scenario: 3.2.b. Exclude Outstream from video filtering - Video Adhesion without leave behind, publisher 3708 -  Domain has 15 seconds & skip = no
    Given I send 1 times an ad video request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-video-adhesion-campaign-30-skip-N} to UAS
    Then The response code is 200
    And The response contains {VAST}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-vid-adhesion-30-skip-N-banner-1} 100% of the time
    And The response not contains html