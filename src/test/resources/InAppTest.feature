@scheduled
@Inapp
@HeaderBidding
@uas
Feature: InApp testing

  Scenario: Image and iframe - Zone request (viewableChange)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar} for zone named {zone-zoneset-Inapp-SI-1} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-1-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'iframe', url:' https://www.example.com/3'}
    And The response contains var ut_pixel_event = 'viewableChange';
    And The response contains <script src="https://sparkflow-a.akamaihd.net/spk/inapp/ut_pixels.min.js"></script>


  Scenario: Image and iframe - HB request (viewableChange)
    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 2546} for publisher 2546 with domain {Tradewindsnews.com} with extra params {&unlimited=1&optimize=0&deviceid=sahar}
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
    And The response contains var ut_pixels
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'iframe', url:'https://www.example.com/3'}
    And The response contains var ut_pixel_event = 'viewableChange';
    And The response contains <script src="https://sparkflow-a.akamaihd.net/spk/inapp/ut_pixels.min.js"></script>


  Scenario: Image and iframe - DT request (viewableChange)
    Then i send 1 times Dynamic Tag ad request to UAS for publisher 2546 with extra params {Tradewindsnews.com&unlimited=1&optimize=0&tagid=241&deviceid=sahar}
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-1-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'iframe', url:'https://www.example.com/3'}
    And The response contains var ut_pixel_event = 'viewableChange';
    And The response contains <script src="https://sparkflow-a.akamaihd.net/spk/inapp/ut_pixels.min.js"></script>


  Scenario: just event tracker enabled - Zone request (viewableChange)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar} for zone named {zone-zoneset-Inapp-SI-2} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-2-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains var ut_pixel_event = 'viewableChange';
    And The response contains <script src="https://sparkflow-a.akamaihd.net/spk/inapp/ut_pixels.min.js"></script>


  Scenario: image, markup and iframe - Zone request (viewableChange)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar} for zone named {zone-zoneset-Inapp-SI-3} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-3-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'markup', url:'<IMG SRC="https://ad.doubleclick.net/ddm/trackimp/N740925.3139425VIVAKIPHMPMEDIA/B21156576.221148734;dc_trk_aid=420127888;dc_trk_cid=101825399;ord=[timestamp];dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;tfua=?https://ad.doubleclick.net/ddm/trackimp/N740925.3139425VIVAKIPHMPMEDIA/B21156576.221148734;dc_trk_aid=420127888;dc_trk_cid=101825399;ord=[timestamp];dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;tfua=" BORDER="0" HEIGHT="1" WIDTH="1" ALT="Advertisement">'}
    And The response contains {type:'iframe', url:'https://www.example.com/3'}
    And The response contains var ut_pixel_event = 'viewableChange';
    And The response contains <script src="https://sparkflow-a.akamaihd.net/spk/inapp/ut_pixels.min.js"></script>


  Scenario: without trackers  - Zone request (viewableChange)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar} for zone named {zone-zoneset-Inapp-SI-3} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-3-banner-1} 100% of the time
    And The response not contains var ut_pixels


  Scenario: image, markup and iframe - Zone request (render)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar} for zone named {zone-zoneset-Inapp-SI-3} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-3-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'markup', url:'<IMG SRC="https://ad.doubleclick.net/ddm/trackimp/N740925.3139425VIVAKIPHMPMEDIA/B21156576.221148734;dc_trk_aid=420127888;dc_trk_cid=101825399;ord=[timestamp];dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;tfua=?https://ad.doubleclick.net/ddm/trackimp/N740925.3139425VIVAKIPHMPMEDIA/B21156576.221148734;dc_trk_aid=420127888;dc_trk_cid=101825399;ord=[timestamp];dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;tfua=" BORDER="0" HEIGHT="1" WIDTH="1" ALT="Advertisement">'}
    And The response contains {type:'iframe', url:'https://www.example.com/3'}
    And The response contains var ut_pixel_event = 'render';
    And The response contains <script src="https://sparkflow-a.akamaihd.net/spk/inapp/ut_pixels.min.js"></script>


  Scenario: image, markup and iframe - Zone request (ready)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar} for zone named {zone-zoneset-Inapp-SI-3} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-3-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'markup', url:'<IMG SRC="https://ad.doubleclick.net/ddm/trackimp/N740925.3139425VIVAKIPHMPMEDIA/B21156576.221148734;dc_trk_aid=420127888;dc_trk_cid=101825399;ord=[timestamp];dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;tfua=?https://ad.doubleclick.net/ddm/trackimp/N740925.3139425VIVAKIPHMPMEDIA/B21156576.221148734;dc_trk_aid=420127888;dc_trk_cid=101825399;ord=[timestamp];dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;tfua=" BORDER="0" HEIGHT="1" WIDTH="1" ALT="Advertisement">'}
    And The response contains {type:'iframe', url:'https://www.example.com/3'}
    And The response contains var ut_pixel_event = 'ready';
    And The response contains <script src="https://sparkflow-a.akamaihd.net/spk/inapp/ut_pixels.min.js"></script>
