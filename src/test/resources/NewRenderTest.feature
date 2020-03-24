@NewRenderTest

Feature: Validate New Render Service

  Scenario: Send a web zone request and validate the response of a direct ES banner with event trackers
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    And I send 1 times an ad request with parameter {unlimited=1} for zone named {zone-zoneset-NewRenderTest-Direct-event-trackers} to UAS
    Then The response code is 200
    And The responses has impression-urls
    And The renderUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-event-trackers-banner-1} 100% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-event-trackers-banner-1} 100% of the time
    # And Response has all the trackers setup in {url} column of {banner_event_trackers} table for banner named {banner-NewRenderTest-web-direct-zone-banner}
    # And Response has User sync pixels in {zone_append}
    And The response contains {https://www.example.com/tracker?adid=12345}
    And The response contains {https://www.example.com/tracker?adid=123456}
    And The response contains {https://www.example.com/tracker?adid=1234567}
    And The response contains {<img src="https://www.example.com/tracker?adid=12345678" height="1" width="1" alt="Advertisement">}
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://x.bidswitch.net/sync?ssp=undertone}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}
