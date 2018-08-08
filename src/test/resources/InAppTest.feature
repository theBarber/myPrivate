@scheduled
@Inapp
Feature: InApp testing

  Scenario: Image and iframe - Zone request
    When I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-Inapp-SI-1} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-1-banner-1} 100% of the time
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'iframe', url:'https://www.example.com/3'}
    And The response contains var ut_pixel_event = 'viewable-change';
    And The response contains <script src="https://sparkflow-a.akamaihd.net/spk/inapp/ut_pixels.min.js"></script>


  Scenario: Image and iframe - HB request
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 2546} for publisher 2546 with domain {Tradewindsnews.com} with extra params {&unlimited=1&optimize=0}
    Then The response code is 200
    And The response contains script
    And all HB responses contains campaignId with id of entity named {campaign-Inapp-SI-1}
    And all HB responses contains adId with id of entity named {campaign-Inapp-SI-1-banner-1}
    And for all HB responses i simulate winning, and send their zone tag
    And The response code is 200
    And The response contains script
    And I send impression requests to UAS
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-1-banner-1} 100% of the time
    And The impressionUrl has campaignid field matching the id of the campaign named {campaign-Inapp-SI-1} 100% of the time
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'iframe', url:'https://www.example.com/3'}
    And The response contains var ut_pixel_event = 'viewable-change';
    And The response contains <script src="https://sparkflow-a.akamaihd.net/spk/inapp/ut_pixels.min.js"></script>


  Scenario: Image and iframe - DT request
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 2546 with extra params {Tradewindsnews.com&unlimited=1&optimize=0&tagid=241}
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-1-banner-1} 100% of the time
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'iframe', url:'https://www.example.com/3'}
    And The response contains var ut_pixel_event = 'viewable-change';
    And The response contains <script src="https://sparkflow-a.akamaihd.net/spk/inapp/ut_pixels.min.js"></script>


