@HeaderBidding
@scheduled
@uas
@PGX
@parallel
@noAA
@PGXFeature
@PGFeatures
@request_service
Feature: PGX - triggering ads tests

  Background: health check
    When Sending a healthcheck request to UAS
    And I add header of {x-forwarded-for} with value {78.31.205.183}
    Then The response code is 200

  Scenario: 1.0 PGX triggering ads - all 3 triggers enabled - PG zone
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-PGX-PG-1-a} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-PG-1-a-banner-1} 100% of the time
    And response value {window.ut_renderTriggers} has the values of 1,2,3

  Scenario: 2.0 PGX triggering ads - all 3 triggers are enabled - see-through zone tag
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-PGX-ST-1-a} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-ST-1-a-banner-1} 100% of the time
    And The response not contains window.ut_renderTriggers=[3,2,1]

  #Scenario: PGX triggering ads - all 3 triggers are enabled - PG Header Bidding
  #  Given i send 1 headerBidding post request for scenario {Send HB 1X1 size request for publisher 3739} for publisher 3739 with domain {PGXTriggering.com} with extra params {&optimize=1&unlimited=1}
  #  Then The response code is 200
  #  And The response contains {script}
  #  And all HB responses contains adId with id of entity named {campaign-PGX-PG-1-a-banner-1}
  #  And I send impression requests to UAS
  #  Then The response code is 200
  #  And The responses has impression-urls
  #  And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-PG-1-a-banner-1} 100% of the time
  #  And response value {window.ut_renderTriggers} has the values of 1,2,3
    
  Scenario: 3.0 PGX triggering ads - all 3 triggers are enabled - see-through Header Bidding
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB 1X2 size request for publisher 3739} for publisher 3739 with domain {PGXTriggering.com} with extra params {&optimize=1&unlimited=1}
    Then The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-PGX-ST-1-a-banner-1}
    And I send impression requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-ST-1-a-banner-1} 100% of the time
    And The response not contains window.ut_renderTriggers=[3,2,1]

  Scenario: 4.0 PGX triggering ads - all 3 triggers are enabled - PG dynamic Tag
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with domain {PGXTriggering.com&tagid=282&unlimited=1&optimize=1}
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-PG-1-a-banner-1} 100% of the time
    And response value {window.ut_renderTriggers} has the values of 1,2,3

  Scenario: 5.0 PGX triggering ads - all 3 triggers are enabled - see-through dynamic Tag
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with domain {PGXTriggering.com&tagid=283&unlimited=1&optimize=1}
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-ST-1-a-banner-1} 100% of the time
    And The response not contains window.ut_renderTriggers=[3,2,1]

  Scenario: 6.0 PGX triggering ads - 1 trigger are enabled (Exit) - PG zone tag
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-PGX-PG-1-b} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-PG-1-b-banner-1} 100% of the time
    And The response contains {window.ut_renderTriggers=[1]}

  Scenario: 7.0 PGX triggering ads - 2 triggers are enabled (Exit, Back) - PG zone tag default
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-PGX-PG-1-c} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-PG-1-c-banner-1} 100% of the time
    And response value {window.ut_renderTriggers} has the values of 1,3


#  -----------------------------------------------------Optimize-------------------------------------------------------------------
  @optimize
  Scenario: 8.0 PGX triggering ads - all 3 triggers are enabled - PG zone tag
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-PGX-PG-1-a} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-PG-1-a-banner-1} 100% of the time
    And response value {window.ut_renderTriggers} has the values of 1,2,3

  @optimize
  Scenario: 9.0 PGX triggering ads - all 3 triggers are enabled - see-through zone tag
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-PGX-ST-1-a} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-ST-1-a-banner-1} 100% of the time
    And The response not contains window.ut_renderTriggers=[3,2,1]

  @optimize
  Scenario: 10.0 PGX triggering ads - all 3 triggers are enabled - PG Header Bidding
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB 1X1 size request for publisher 3739} for publisher 3739 with domain {PGXTriggering.com} with extra params {&optimize=1&unlimited=1}
    Then The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-PGX-PG-1-a-banner-1}
    And I send impression requests to UAS
    Then The response code is 200
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-PG-1-a-banner-1} 100% of the time
    And response value {window.ut_renderTriggers} has the values of 1,2,3

  @optimize
  Scenario: 11.0 PGX triggering ads - all 3 triggers are enabled - see-through Header Bidding
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding post request for scenario {Send HB 1X2 size request for publisher 3739} for publisher 3739 with domain {PGXTriggering.com} with extra params {&optimize=1&unlimited=1}
    Then The response code is 200
    And The response contains {script}
    And all HB responses contains adId with id of entity named {campaign-PGX-ST-1-a-banner-1}
    And I send impression requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-ST-1-a-banner-1} 100% of the time
    And The response not contains window.ut_renderTriggers=[3,2,1]

  @optimize
  Scenario: 12.0 PGX triggering ads - all 3 triggers are enabled - PG dynamic Tag
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with domain {PGXTriggering.com&tagid=282&unlimited=1&optimize=1}
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-PG-1-a-banner-1} 100% of the time
    And response value {window.ut_renderTriggers} has the values of 1,2,3

  @optimize
  Scenario: 13.0 PGX triggering ads - all 3 triggers are enabled - see-through dynamic Tag
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 3739 with domain {PGXTriggering.com&tagid=283&unlimited=1&optimize=1}
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-ST-1-a-banner-1} 100% of the time
    And The response not contains window.ut_renderTriggers=[3,2,1]

  @optimize
  Scenario: 14.0 PGX triggering ads - 1 trigger are enabled (Exit) - PG zone tag
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-PGX-PG-1-b} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-PG-1-b-banner-1} 100% of the time
    And The response contains {window.ut_renderTriggers=[1]}

  @optimize
  Scenario: 15.0 PGX triggering ads - 2 triggers are enabled (Exit, Back) - PG zone tag default
    Given I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-PGX-PG-1-c} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-PGX-PG-1-c-banner-1} 100% of the time
    And response value {window.ut_renderTriggers} has the values of 1,3

