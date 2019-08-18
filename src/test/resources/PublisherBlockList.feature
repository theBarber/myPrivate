@parallel
@scheduled
@noAA




Feature: Publisher blacklist tests

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200


  Scenario: For a publisher 3843 block advertiser 22420 - zone tag request
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-campaign-pbl-BRAND1-ES} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND1-ES-banner-1} 100% of the time
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-campaign-pbl-BRAND2-PGX} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: For a publisher 3843 block advertiser by categories - zone tag request
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-campaign-pbl-BRAND1-ES} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND1-ES-banner-1} 100% of the time
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-campaign-pbl-BRAND2-PGX} to UAS
    And The response code is 200
    And The responses are passback

  Scenario: For a publisher 3843 block advertiser 22420 - dynamic tag request
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {manageadvertiserblocklist.com&tagid=542&optimize=0}
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND1-ES-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {manageadvertiserblocklist.com&tagid=541&optimize=0}
    And The response code is 200
    And The responses are passback

  Scenario: For a publisher 3843 block advertiser by categories - dynamic tag request
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {manageadvertiserblocklist.com&tagid=542&optimize=0}
    And The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND1-ES-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {manageadvertiserblocklist.com&tagid=541&optimize=0}
    And The response code is 200
    And The responses are passback

#  Scenario: For a publisher 3843 block advertiser 22420 - dynamic tag request
#    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {manageadvertiserblocklist.com&tagid=540&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND1-PGX-banner-1} 100% of the time
#    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {manageadvertiserblocklist.com&tagid=542&optimize=0}
#    And The response code is 200
#    And The responses are passback
#
#  Scenario: For a publisher 3843 block advertiser by categories - dynamic tag request
#    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {manageadvertiserblocklist.com&tagid=540&optimize=0}
#    And The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND1-PGX-banner-1} 100% of the time
#    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {manageadvertiserblocklist.com&tagid=542&optimize=0}
#    And The response code is 200
#    And The responses are passback

  Scenario: For a publisher 3843 block advertiser 22420 - HB request
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3843 with size1 = 1 size2 = 2, with domain {manageadvertiserblocklist.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-pbl-BRAND1-ES}
    And all HB responses contains adId with id of entity named {campaign-pbl-BRAND1-ES-banner-1}
    And all HB responses contains cpm with value {0.4}

  Scenario: For a publisher 3843 block advertiser by categories - HB request
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3843 with size1 = 1 size2 = 2, with domain {manageadvertiserblocklist.com} and extra params {&unlimited=1&optimize=0}
    And The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-pbl-BRAND1-ES}
    And all HB responses contains adId with id of entity named {campaign-pbl-BRAND1-ES-banner-1}
    And all HB responses contains cpm with value {0.4}

