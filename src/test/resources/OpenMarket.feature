@OpenMarket1
@parallel

Feature: Open Market Testing

  Background: health check
    Given I clear all headers from uas requests
    Given I clear all cookies from uas requests
    And I add header of {x-forwarded-For} with value {78.31.205.183}
    When Sending a healthcheck request to UAS
    Then The response code is 200


     #&&&&&&&&&&&&&&&&  Zone request %%%%%%%%%%%%%%%

     #***********************  R(AN)    R(OX)    OM    ***********************

  Scenario: 1.a  zone request   R(AN) ---  R(OX) --- OM      Open Market banner expected to return in first iteration
    When I send 1 times an ad request with parameter {optimize=1&requestid=Automation-OM} for zone named {zone-zoneset-test-OM-PG} to UAS
    And The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-OPEN-MARKET-1-banner-1} 100% of the time


  Scenario: 1.b  zone request  R(AN) ---  R(OX) --- OM     OpenX banner expected to return in second iteration
    When I send 1 times an ad request with parameter {optimize=1&requestid=Automation-OX} for zone named {zone-zoneset-test-OM-PG} to UAS
    And The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-reserve-OX-iter-2-banner-1} 100% of the time


    #***********************  R(AN)     NR(AN)    OM     D  ***********************

  Scenario: 2.a   zone request   R(AN) ---  NR(AN) --- OM --- D     Open Market banner expected to return in first iteration
    When I send 1 times an ad request with parameter {optimize=1&requestid=Automation-OM} for zone named {zone-zoneset-test-OM-WIN} to UAS
    And The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-OPEN-MARKET-1-chosen-banner-1} 100% of the time

  Scenario: 2.b  zone request    R(AN) ---  NR(AN) --- OM ----- D     App-nexus NR banner expected to return in second iteration
    When I send 1 times an ad request with parameter {optimize=1&requestid=Automation-AN} for zone named {zone-zoneset-test-OM-WIN} to UAS
    And The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-non-reserve-1-banner-1} 100% of the time

     #***********************  D      OM    ***********************

  Scenario: 3   zone request   D --- OM     Direct banner expected to return in first iteration (the PGW not even get approached)
    When I send 1 times an ad request with parameter {optimize=1&requestid=Automation-OM} for zone named {zone-zoneset-test-Direct} to UAS
    And The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-direct-must-be-chosen-banner-1} 100% of the time


    #&&&&&&&&&&&&&&&&  Header Bidding  %%%%%%%%%%%%%%%

       #***********************  R(AN)    R(OX)    OM    ***********************

  Scenario: 4.a   HB request   R(AN) ---  R(OX) --- OM      Open Market banner expected to return in first iteration
    Given i send 1 headerBidding post request for scenario {Send HB request for Open Market with 1X1 publisher 3708 - R R OM} for publisher 3708 with domain {open-market1.com&requestid=Automation-OM} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-OPEN-MARKET-1-banner-1}
    And all HB responses contains campaignId with id of entity named {campaign-OPEN-MARKET-1}

  Scenario: 4.b   HB request   R(AN) ---  R(OX) --- OM     OpenX banner expected to return in second iteration
    Given i send 1 headerBidding post request for scenario {Send HB request for Open Market with 1X1 publisher 3708 - R R OM} for publisher 3708 with domain {open-market1.com&requestid=Automation-OX} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-reserve-OX-iter-2-banner-1}
    And all HB responses contains campaignId with id of entity named {campaign-reserve-OX-iter-2}


     #***********************  R(AN)     NR(AN)      OM       D   ***********************

  Scenario: 5.a  (** BUG UN-24430 **)  HB request   R(AN) ---  NR(AN) --- D --- OM     Open Market banner expected to return in first iteration
    Given i send 1 headerBidding post request for scenario {Send HB request for Open Market with 1X1 publisher 3708 - R NR D OM} for publisher 3708 with domain {open-market2.com&requestid=Automation-OM} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-OPEN-MARKET-1-chosen-banner-1}
    And all HB responses contains campaignId with id of entity named {campaign-OPEN-MARKET-1-chosen}

  Scenario: 5.b  HB request   R(AN) ---  NR(AN) --- D --- OM     App-nexus NR banner expected to return in second iteration
    Given i send 1 headerBidding post request for scenario {Send HB request for Open Market with 1X1 publisher 3708 - R NR D OM} for publisher 3708 with domain {open-market2.com&requestid=Automation-AN} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-non-reserve-1-banner-1}
    And all HB responses contains campaignId with id of entity named {campaign-non-reserve-1}

     #***********************  D      OM    ***********************

  Scenario: 6  HB request   D --- OM     Direct banner expected to return in first iteration (the PGW not even get approached)
    Given i send 1 headerBidding post request for scenario {Send HB request for Open Market with 1X1 publisher 3708 - D OM} for publisher 3708 with domain {open-market3.com&requestid=Automation-OM} with extra params {&unlimited=1&optimize=1}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-direct-must-be-chosen-banner-1}
    And all HB responses contains campaignId with id of entity named {campaign-direct-must-be-chosen}