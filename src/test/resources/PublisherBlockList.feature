@parallel
@scheduled
@noAA




Feature: Publisher blacklist tests

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200


  Scenario: For a publisher 3843 block advertiser 28004 - zone tag request
    Given I send 1 times an ad request with parameter {unlimited=1&domain=publisherblocklist.com} for zone named {zone-zoneset-campaign-pbl-BRAND1-ST} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND1-ST-banner-1} 100% of the time
    Given I send 1 times an ad request with parameter {unlimited=1&domain=publisherblocklist.com} for zone named {zone-zoneset-campaign-pbl-BRAND2-PGX} to UAS
    And The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=nick.com} for zone named {zone-zoneset-campaign-pbl-BRAND2-PGX} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND2-PGX-banner-1} 100% of the time

  Scenario: For a publisher 3843 block advertiser 2184 publisher level - zone tag request
    Given I send 1 times an ad request with parameter {unlimited=1&domain=publisherblocklist.com} for zone named {zone-zoneset-campaign-pbl-BRAND1-ST} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND1-ST-banner-1} 100% of the time
    Given I send 1 times an ad request with parameter {unlimited=1&domain=publisherblocklist.com} for zone named {zone-zoneset-campaign-pbl-BRAND3-PGX} to UAS
    And The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=nick.com} for zone named {zone-zoneset-campaign-pbl-BRAND3-PGX} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: For a publisher 3843 block advertiser 3112 by categories - zone tag request
    Given I send 1 times an ad request with parameter {unlimited=1&domain=kids.com} for zone named {zone-zoneset-campaign-pbl-BRAND2-PGX} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND2-PGX-banner-1} 100% of the time
    Given I send 1 times an ad request with parameter {unlimited=1&domain=kids.com} for zone named {zone-zoneset-campaign-pbl-BRAND1-ST} to UAS
    And The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=nick.com} for zone named {zone-zoneset-campaign-pbl-BRAND2-PGX} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND2-PGX-banner-1} 100% of the time

  Scenario: For a publisher 3843 block advertiser 3112 by categories (sub domain) - zone tag request
    Given I send 1 times an ad request with parameter {unlimited=1&domain=little.kids.com} for zone named {zone-zoneset-campaign-pbl-BRAND2-PGX} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND2-PGX-banner-1} 100% of the time
    Given I send 1 times an ad request with parameter {unlimited=1&domain=little.kids.com} for zone named {zone-zoneset-campaign-pbl-BRAND1-ST} to UAS
    And The response code is 200
    And The responses are passback
    Given I send 1 times an ad request with parameter {unlimited=1&domain=little.nick.com} for zone named {zone-zoneset-campaign-pbl-BRAND2-PGX} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND2-PGX-banner-1} 100% of the time



  Scenario: For a publisher 3843 block advertiser 28004 - dynamic tag request
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {publisherblocklist.com&tagid=541&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND1-ST-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {publisherblocklist.com&tagid=542&optimize=1}
    And The response code is 200
    And The responses are passback
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {nick.com&tagid=542&optimize=1}
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND2-PGX-banner-1} 100% of the time


  Scenario: For a publisher 3843 block advertiser 28004 (sub domain) - dynamic tag request
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {block.publisherblocklist.com&tagid=541&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND1-ST-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {block.publisherblocklist.com&tagid=542&optimize=1}
    And The response code is 200
    And The responses are passback
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {little.nick.com&tagid=542&optimize=1}
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND2-PGX-banner-1} 100% of the time


  Scenario: For a publisher 3843 block advertiser 3112 by categories - dynamic tag request
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {kids.com&tagid=542&optimize=1}
    And The response code is 200
    And The response contains {script}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND2-PGX-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {kids.com&tagid=541&optimize=1}
    And The response code is 200
    And The responses are passback
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3843 with extra params {nick.com&tagid=541&optimize=1}
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-pbl-BRAND1-ST-banner-1} 100% of the time
    
  Scenario: For a publisher 3843 for advertiser 28004 - HB request
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3843 with size1 = 1 size2 = 2, with domain {publisherblocklist.com} and extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-pbl-BRAND1-ST}
    And all HB responses contains adId with id of entity named {campaign-pbl-BRAND1-ST-banner-1}
    And all HB responses contains cpm with value {1.0}

  Scenario: For a publisher 3843 for advertiser 28004 (sub domains) - HB request
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3843 with size1 = 1 size2 = 2, with domain {block.publisherblocklist.com} and extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-pbl-BRAND1-ST}
    And all HB responses contains adId with id of entity named {campaign-pbl-BRAND1-ST-banner-1}
    And all HB responses contains cpm with value {1}

  Scenario: For a publisher 3843 for advertiser 3112 - HB request
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3843 with size1 = 1 size2 = 1, with domain {publisherblocklist.com} and extra params {&unlimited=1&optimize=1}
    And The response code is 204

  Scenario: For a publisher 3843 for advertiser 3112 - HB request
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3843 with size1 = 1 size2 = 1, with domain {block.publisherblocklist.com} and extra params {&unlimited=1&optimize=1}
    And The response code is 204

  Scenario: For a publisher 3843 block advertiser 3112 by categories - HB request
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3843 with size1 = 1 size2 = 1, with domain {kids.com} and extra params {&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-pbl-BRAND2-PGX}
    And all HB responses contains adId with id of entity named {campaign-pbl-BRAND2-PGX-banner-1}
    And all HB responses contains cpm with value {1}

  Scenario: For a publisher 3843 block advertiser 28004 by categories - HB request
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for publisher 3843 with size1 = 1 size2 = 2, with domain {kids.com} and extra params {&optimize=1}
    And The response code is 204