@NdqFilteringTL
@scheduled
@uas
@Sanity
@UASBuyAtMost
@Integration
@hardcoded
@cli
@parallel
@noAA


Feature: ROFD


  Scenario: 1. a. run on false domain flag = true. req sent from a false domain - zone req, DT req.
    When I send 1 times an ad request with parameter {unlimited=1&optimize=0&domain=daniellafalsedomain.test} for zone named {zone-zoneset-YesRunFalseDomain-69-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomain-69-1-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3673 with extra params {daniellaRealDomain.test&tagid=353&unlimited=1&optimize=0}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomain-69-1-banner-1} 100% of the time

  Scenario:  1. b. run on false domain flag = true. req sent from an empty domain - zone req, HB req.
    When I send 1 times an ad request with parameter {domain=&unlimited=1&optimize=0} for zone named {zone-zoneset-YesRunFalseDomain-69-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomain-69-1-banner-1} 100% of the time
#      Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {empty} and extra params {&unlimited=1,optimize=0}
#      And The response code is 200
#      And The response contains script
#      And all HB responses contains campaignId with id of entity named {campaign-HB-DynamicPrice-3}
#      And all HB responses contains adId with id of entity named {campaign-HB-DynamicPrice-3-banner-1}
#      And all HB responses contains cpm with value {7}
#      And for all HB responses i simulate winning, and send their zone tag
#      And The response code is 200
#      And The response contains script
#      And The impressionUrl has bannerid field matching the id of the banner named {campaign-HB-DynamicPrice-3-banner-1} 100% of the time

  Scenario: 1.c run on false domain flag = true, req sent from a real domain. DT + zone req.
    When I send 1 times an ad request with parameter {domain=daniellaRealDomain.test&unlimited=1&optimize=0} for zone named {zone-zoneset-YesRunFalseDomain-69-1} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomain-69-1-banner-1} 100% of the time
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3673 with extra params {daniellaRealDomain.test&tagid=353&unlimited=1&optimize=0}
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomain-69-1-banner-1} 100% of the time

  Scenario: 2a. run on false domain flag = true, campaign has an include list. req sent from a false domain not in the include. zone + HB req
    When I send 1 times an ad request with parameter {domain=daniellafalsedomain.test&unlimited=1&optimize=0} for zone named {zone-zoneset-YesRunFalseDomainInclude-ST-2} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomainInclude-ST-2-banner-1} 100% of the time
#    Given i send 1 headerBidding secure post request for publisher 3708 with size1 = 1 size2 = 2, with domain {domain=daniellafalsedomain.test} and extra params {&unlimited=1,optimize=0}
#    And The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-YesRunFalseDomainInclude-ST-2}
#    And all HB responses contains adId with id of entity named {campaign-YesRunFalseDomainInclude-ST-2-banner-1}
#    And all HB responses contains cpm with value {7}
#    And for all HB responses i simulate winning, and send their zone tag
#    And The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomainInclude-ST-2-banner-1} 100% of the time

  Scenario: 2b. run on false domain flag = true, campaign has an include list. req sent from with empty domain string
    When I send 1 times an ad request with parameter {domain=&unlimited=1&optimize=0} for zone named {zone-zoneset-YesRunFalseDomainInclude-ST-2} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomainInclude-ST-2-banner-1} 100% of the time

  Scenario: 3a. run on false domain flag = false, campaign has an include list. req sent from a false domain in the include. zone + DT req
    When I send 1 times an ad request with parameter {domain=includeFalseDomain.test&unlimited=1&optimize=0} for zone named {zone-zoneset-NoRunFalseDomainInclude-92-3} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NoRunFalseDomainInclude-92-3-banner-1} 100% of the time
#    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with extra params {includeFalseDomain.test&tagid=354&unlimited=1&optimize=0}
#    Then The response code is 200
#    And The response contains script
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NoRunFalseDomainInclude-92-3-banner-1} 100% of the time

  Scenario: 3b. run on false domain flag = false, campaign has an include list. req sent from with emp3bty domain string
    When I send 1 times an ad request with parameter {domain=&unlimited=1&optimize=0} for zone named {zone-zoneset-NoRunFalseDomainInclude-92-3} to UAS
    Then The response code is 200
    And The responses are passback


  Scenario: 4. run on false domain flag = true, campaign has an exclude list. req sent from a false domain in the exclude. zone req
    When I send 1 times an ad request with parameter {domain=daniellafalsedomain.test&unlimited=1&optimize=0} for zone named {zone-zoneset-YesRunFalseDomainExclude-ST-4} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 5. run on false domain flag = false, campaign has an exclude list. req sent from a false domain in the exclude list. zone req
    When I send 1 times an ad request with parameter {domain=daniellafalsedomain.test&unlimited=1&optimize=0} for zone named {zone-zoneset-YesRunFalseDomainExclude-10-5} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 6a. run on false domain flag = true, campaign has include and exclude lists. req sent from a false domain in the include list. zone req
    When I send 1 times an ad request with parameter {domain=includeFalseDomain.test&unlimited=1&optimize=0} for zone named {zone-zoneset-YesRunFalseDomainBothLists-ST-6} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-YesRunFalseDomainBothLists-ST-6-banner-1} 100% of the time

  Scenario: 6b. run on false domain flag = true, campaign has exnclude and exclude lists. req sent from a false domain in the exclude list. zone req
    When I send 1 times an ad request with parameter {domain=daniellafalsedomain.test&unlimited=1&optimize=0} for zone named {zone-zoneset-YesRunFalseDomainBothLists-ST-6} to UAS
    Then The response code is 200
    And The responses are passback

  Scenario: 7a. run on false domain flag = false, campaign has include and exclude lists. req sent from a false domain in the include list. zone req
    When I send 1 times an ad request with parameter {domain=includeFalseDomain.test&unlimited=1&optimize=0} for zone named {zone-zoneset-NoRunFalseDomainBothLists-ST-7} to UAS
    Then The response code is 200
    And The response contains script
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NoRunFalseDomainBothLists-ST-7-banner-1} 100% of the time

  Scenario: 7b. run on false domain flag = false, campaign has include and exclude lists. req sent from a false domain in the exclude list. zone req
    When I send 1 times an ad request with parameter {domain=daniellafalsedomain.test&unlimited=1&optimize=0} for zone named {zone-zoneset-NoRunFalseDomainBothLists-ST-7} to UAS
    Then The response code is 200
    And The responses are passback

