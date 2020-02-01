@parallel

Feature: Duration Video tests

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: For a publisher 2434 which has single domain with 15s video duration & skippable = Yes - zone tag request
    Given I send 1 times an ad request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-large-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-small-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-small-D-skip-Y-banner-1} 100% of the time
    Given I send 1 times an ad request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-large-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=duration15_skip_yes.com} for zone named {zone-zoneset-small-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: For a publisher 2434 which has single domain with 15s video duration & skippable = No - zone tag request
    Given I send 1 times an ad request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-large-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-small-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-large-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=duration15_skip_no.com} for zone named {zone-zoneset-small-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-small-D-skip-N-banner-1} 100% of the time

    #&&&&&&&&&&&&&&&&&   PUBLISHER LEVEL  &&&&&&&&&&&&&&&&&&&&&

  Scenario: For a publisher 3843 configured with 15s video duration - by publisher level & skippable = Yes - zone tag request
    Given I send 1 times an ad request with parameter {unlimited=1&domain=publisherblocklist.com} for zone named {zone-zoneset-large-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=publisherblocklist.com} for zone named {zone-zoneset-small-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-small-D-skip-Y-banner-1} 100% of the time
    Given I send 1 times an ad request with parameter {unlimited=1&domain=publisherblocklist.com} for zone named {zone-zoneset-large-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=publisherblocklist.com} for zone named {zone-zoneset-small-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: For a publisher 3836 configured with 15s video duration - by publisher level & skippable = No - zone tag request
    Given I send 1 times an ad request with parameter {unlimited=1&domain=dynamicpricingwithmargin.com} for zone named {zone-zoneset-large-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=dynamicpricingwithmargin.com} for zone named {zone-zoneset-small-D-skip-Y-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=dynamicpricingwithmargin.com} for zone named {zone-zoneset-large-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=dynamicpricingwithmargin.com} for zone named {zone-zoneset-small-D-skip-N-CS-Video} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-small-D-skip-N-banner-1} 100% of the time