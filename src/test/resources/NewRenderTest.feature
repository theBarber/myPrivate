@NewRenderTest

Feature: Validate New Render Service

  Scenario: Send a web request to a zone linked to no banners and validate Passback
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {unlimited=1&newrender=1} for zone named {zone-zoneset-NewRenderTest-Passback} to UAS
    Then The response code is 200
    And The response contains {https://optimized-by.rubiconproject.com/a/dk.js?defaulting_ad=x3059e7.js&size_id=9&account_id=7847&site_id=13097&size=160x600}
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web zone request and validate the response of a direct PG banner

    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {unlimited=1&newrender=1} for zone named {zone-zoneset-NewRenderTest-Direct-Zone-Regular} to UAS
    Then The response code is 200
    And The response contains {ut_scripts}
    And The response contains {https://pixel.adsafeprotected.com/jload?anId=}
    And The renderUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-zone-banner-banner-1} 100% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-zone-banner-banner-1} 100% of the time
    And The clickUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-zone-banner-banner-1} 100% of the time
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web DT request and validate the response of a direct PG banner
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When i send 1 times Dynamic Tag ad request to UAS for publisher 3728 with domain {12news.com&tagid=238&newrender=1}
    And The response code is 200
    And The response contains {sf_tag}
    And The response contains {ut_udms}
    And The responses has impression-urls
    And The response contains {&e=render}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-DT-banner-banner-1} 100% of the time
    And The clickUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-DT-banner-banner-1} 100% of the time
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web HB request and validate the response of a direct ES banner
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB PPP request for publisher 3673 with 300X250} for publisher 3673 with domain {americanow.com} with extra params {&unlimited=1&newrender=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-NewRenderTest-web-direct-HB-banner}
    And all HB responses contains adId with id of entity named {campaign-NewRenderTest-web-direct-HB-banner-banner-1}
    And all HB responses contains cpm with value {2.5}
    And The response contains {&e=render}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-HB-banner-banner-1} 100% of the time
    And The response contains {events-s-us-east-1.undertone.com\/c?}
    And The response contains {https:\/\/ib.adnxs.com\/getuidnb?https:\/\/usr.undertone.com\/userPixel\/sync?partner=appnexus}
    And The response contains {usr.undertone.com\/userPixel\/sync?partnerId=39}
    And The response contains {https:\/\/cw.addthis.com\/t.gif?pid=46}
    And The response contains {https:\/\/ads.scorecardresearch.com\/b?c1=9&c2=2113&c3=2&cs_xi}
    And The response contains {https:\/\/tags.bluekai.com\/site\/15597?id=}
    And The response contains {https:\/\/sync.alphonso.tv\/sync?srcid=}
    And The response contains {https:\/\/ads.undertone.com\/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc}
#    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
#    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
#    And The response contains {https://x.bidswitch.net/sync?ssp=undertone}
#    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
#    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
#    And The response contains {https://tags.bluekai.com/site/15597?id=}
#    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
#    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web zone request and validate the response of a programmatic PG banner
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {requestid=PGZoneRender&newrender=1&unlimited=1} for zone named {zone-zoneset-NewRenderTest-Prog-Zone} to UAS
    Then The response code is 200
    And The response contains {&e=render}
#    And The renderUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-programmatic-zone-banner-banner-1} 100% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-programmatic-zone-banner-banner-1} 100% of the time
    And The clickUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-programmatic-zone-banner-banner-1} 100% of the time
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web HB request and validate the response of a Programmatic ES banner
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB PPP request for publisher 3728 with 300X250} for publisher 3728 with domain {testing.com} with extra params {&requestid=OXESRender&unlimited=1&newrender=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-NewRenderTest-web-programmatic-HB-banner}
    And all HB responses contains adId with id of entity named {campaign-NewRenderTest-web-programmatic-HB-banner-banner-1}
    And all HB responses contains cpm with value {99999}
    And The response contains {&e=render}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-programmatic-HB-banner-banner-1} 100% of the time
    And The response contains {events-s-us-east-1.undertone.com\/c?}
    And The response contains {https:\/\/ib.adnxs.com\/getuidnb?https:\/\/usr.undertone.com\/userPixel\/sync?partner=appnexus}
    And The response contains {usr.undertone.com\/userPixel\/sync?partnerId=39}
    And The response contains {https:\/\/cw.addthis.com\/t.gif?pid=46}
    And The response contains {https:\/\/ads.scorecardresearch.com\/b?c1=9&c2=2113&c3=2&cs_xi}
    And The response contains {https:\/\/tags.bluekai.com\/site\/15597?id=}
    And The response contains {https:\/\/sync.alphonso.tv\/sync?srcid=}
    And The response contains {https:\/\/ads.undertone.com\/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc}
#    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
#    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
#    And The response contains {https://x.bidswitch.net/sync?ssp=undertone}
#    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
#    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
#    And The response contains {https://tags.bluekai.com/site/15597?id=}
#    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
#    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web DT request and validate the response of a programmatic PG banner
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When i send 1 times Dynamic Tag ad request to UAS for publisher 3728 with domain {damndelicious.net&requestid=PGZoneRender&tagid=238&newrender=1}
    And The response code is 200
    And The response contains {ut_udms}
    And The responses has impression-urls
    And The response contains {&e=render}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-programmatic-DT-banner-banner-1} 100% of the time
    And The clickUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-programmatic-DT-banner-banner-1} 100% of the time
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web zone request and validate the response of a direct PG Action banner
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {unlimited=1&newrender=1} for zone named {zone-zoneset-NewRenderTest-Direct-Zone-PGAction} to UAS
    Then The response code is 200
    And The response contains {ut_scripts}
    And The response contains {"https://pixel.adsafeprotected.com/jload?anId=}
    And The response contains {renderTriggers}
    And The response contains {'exit_viewport\', \'back_button\'}
    And The response contains {&e=render}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-zone-PGAction-banner-1} 100% of the time
    And The clickUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-zone-PGAction-banner-1} 100% of the time
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web DT request and validate the response of a direct PG Action banner
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When i send 1 times Dynamic Tag ad request to UAS for publisher 3673 with domain {chess24.com&tagid=349&newrender=1}
    And The response code is 200
    And The response contains {ut_scripts}
    And The response contains {"https://pixel.adsafeprotected.com/jload?anId=}
    And The response contains {renderTriggers}
    And The response contains {'exit_viewport\', \'back_button\'}
    And The responses has impression-urls
    And The response contains {&e=render}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-DT-PGAction-banner-1} 100% of the time
    And The clickUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-DT-PGAction-banner-1} 100% of the time
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web zone request and validate the response of a programmatic PG Action banner
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {requestid=AN-PGA-Render&unlimited=1&newrender=1} for zone named {zone-zoneset-NewRenderTest-Prog-Zone-PGAction} to UAS
    Then The response code is 200
    And The response contains {window.ut_renderTriggers=[1]}
    And The response contains {&e=render}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-programmatic-zone-PGAction-banner-1} 100% of the time
    And The clickUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-programmatic-zone-PGAction-banner-1} 100% of the time
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web DT request and validate the response of a programmatic PG Action banner
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When i send 1 times Dynamic Tag ad request to UAS for publisher 3673 with domain {gamesradar.com&requestid=AN-PGA-Render&tagid=617&newrender=1}
    And The response code is 200
    And The response contains {window.ut_renderTriggers=[1]}
    And The responses has impression-urls
    And The response contains {&e=render}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-programmatic-DT-PGAction-banner-1} 100% of the time
    And The clickUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-programmatic-DT-PGAction-banner-1} 100% of the time
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web zone request from US and validate the response of a Direct Video Adhesion Ad (With Leave Behind)
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {unlimited=1&newrender=1} for zone named {zone-zoneset-NewRenderTest-web-direct-zone-video} to UAS
    Then The response code is 200
    And The response contains {var ut_aniview={publisherId:'5912cb1028a06142db67f38a',channelId:'5b7d30c4073ef454a07d4d64'}}
    And The response contains {VASTAdTagURI}
    And The response contains {ut_udms}
    And The response contains {[CDATA[https://vast.adsafeprotected.com/vast?}
    And The response contains {&originalVast=https%3A%2F%2Fads.sparkflow.net%2Fvast%2F%3Fg%3D38662}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-zone-video-banner-1} 100% of the time
    And The response contains {&e=firstQuartile}
    And The response contains {&e=midpoint}
    And The response contains {&e=thirdQuartile}
    And The response contains {&e=complete}
    And The response contains {&e=pause}
    And The response contains {&e=mute}
    And The response contains {&e=close}
    And The response contains {&e=start}
    And The response contains {&e=unmute}
    And The response contains {&e=render}
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web DT request and validate the response of a Direct Video Adhesion Ad (With Leave Behind)
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with domain {autoweek.com&tagid=430&newrender=1}
    And The response code is 200
    And The response contains {var ut_aniview={publisherId:\'5912cb1028a06142db67f38a\',channelId:\'5b7d30c4073ef454a07d4d64\'}}
    And The response contains {VASTAdTagURI}
    And The response contains {ut_udms}
    And The response contains {[CDATA[https://vast.adsafeprotected.com/vast?}
    And The response contains {&originalVast=https%3A%2F%2Fads.sparkflow.net%2Fvast%2F%3Fg%3D38662}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-DT-video-banner-1} 100% of the time
    And The response contains {&e=firstQuartile}
    And The response contains {&e=midpoint}
    And The response contains {&e=thirdQuartile}
    And The response contains {&e=complete}
    And The response contains {&e=pause}
    And The response contains {&e=mute}
    And The response contains {&e=close}
    And The response contains {&e=start}
    And The response contains {&e=unmute}
    And The response contains {&e=render}
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web HB request and validate the response of a Direct Video Adhesion Ad (With Leave Behind)
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3708 with 320X50} for publisher 3708 with domain {autoshopper.com} with extra params {&unlimited=1&newrender=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-NewRenderTest-web-direct-HB-video}
    And all HB responses contains adId with id of entity named {campaign-NewRenderTest-web-direct-HB-video-banner-1}
    And all HB responses contains cpm with value {1}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-HB-video-banner-1} 100% of the time
    And The response contains {&e=firstQuartile}
    And The response contains {&e=midpoint}
    And The response contains {&e=thirdQuartile}
    And The response contains {&e=complete}
    And The response contains {&e=pause}
    And The response contains {&e=mute}
    And The response contains {&e=close}
    And The response contains {&e=start}
    And The response contains {&e=unmute}
    And The response contains {&e=render}
    And The response contains {events-s-us-east-1.undertone.com\/c?}
    And The response contains {https:\/\/ib.adnxs.com\/getuidnb?https:\/\/usr.undertone.com\/userPixel\/sync?partner=appnexus&uid=}
    And The response contains {https:\/\/us-u.openx.net\/w\/1.0\/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https:\/\/usr.undertone.com\/userPixel\/sync?partnerId=39}
    And The response contains {https:\/\/cw.addthis.com\/t.gif?pid=46&pdid=}
    And The response contains {https:\/\/ads.scorecardresearch.com\/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https:\/\/tags.bluekai.com\/site\/15597?id=}
    And The response contains {https:\/\/sync.alphonso.tv\/sync?srcid=}
    And The response contains {https:\/\/ads.undertone.com\/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc}

  Scenario: Send a web zone request from US and validate the response of a Programmatic Video Adhesion Ad (With Leave Behind)
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {requestid=OX-VA-Render&unlimited=1&newrender=1} for zone named {zone-zoneset-NewRenderTest-web-programmatic-zone-video} to UAS
    Then The response code is 200
    And The response contains {var ut_aniview={publisherId:'5912cb1028a06142db67f38a',channelId:'5b7d30c4073ef454a07d4d64'}}
    And The response contains {VASTAdTagURI}
    And The response contains {ut_udms}
    And The response contains {[CDATA[https://vast.adsafeprotected.com/vast?}
    And The response contains {&originalVast=https%3A%2F%2Fnym1-ib.adnxs.com}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-programmatic-zone-video-banner-1} 100% of the time
    And The response contains {&e=firstQuartile}
    And The response contains {&e=midpoint}
    And The response contains {&e=thirdQuartile}
    And The response contains {&e=complete}
    And The response contains {&e=pause}
    And The response contains {&e=mute}
    And The response contains {&e=close}
    And The response contains {&e=start}
    And The response contains {&e=unmute}
    And The response contains {&e=render}
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web DT request and validate the response of a Programmatic Video Adhesion Ad (With Leave Behind)
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When i send 1 times Dynamic Tag ad request to UAS for publisher 3708 with domain {bassfan.com&requestid=OX-VA-Render&tagid=430&newrender=1}
    And The response code is 200
    And The response contains {var ut_aniview={publisherId:\'5912cb1028a06142db67f38a\',channelId:\'5b7d30c4073ef454a07d4d64\'}}
    And The response contains {VASTAdTagURI}
    And The response contains {ut_udms}
    And The response contains {[CDATA[https://vast.adsafeprotected.com/vast?}
    And The response contains {&originalVast=https%3A%2F%2Fnym1-ib.adnxs.com}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-programmatic-DT-video-banner-1} 100% of the time
    And The response contains {&e=firstQuartile}
    And The response contains {&e=midpoint}
    And The response contains {&e=thirdQuartile}
    And The response contains {&e=complete}
    And The response contains {&e=pause}
    And The response contains {&e=mute}
    And The response contains {&e=close}
    And The response contains {&e=start}
    And The response contains {&e=unmute}
    And The response contains {&e=render}
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web HB request and validate the response of a Programmatic Video Adhesion Ad (With Leave Behind)
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    Given i send 1 headerBidding secure post request for scenario {Send HB request for publisher 3708 with 320X50} for publisher 3708 with domain {cnn.com} with extra params {&requestid=OX-VA-Render&unlimited=1&newrender=1&sim_geo=1&country=us}
    And The response code is 200
    And The response contains {script}
    And all HB responses contains campaignId with id of entity named {campaign-NewRenderTest-web-programmatic-HB-video}
    And all HB responses contains adId with id of entity named {campaign-NewRenderTest-web-programmatic-HB-video-banner-1}
    And all HB responses contains cpm with value {1}
    And The response contains {var ut_aniview={publisherId:'5912cb1028a06142db67f38a',channelId:'5b7d30c4073ef454a07d4d64'}}
    And The response contains {VASTAdTagURI}
    And The response contains {ut_udms}
    And The response contains {https:\/\/vast.doubleverify.com\/v3\/vast?}
    And The response contains {_vast=https%3A%2F%2Fnym1-ib.adnxs.com%2Fab%3F}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-programmatic-HB-video-banner-1} 100% of the time
    And The response contains {&e=firstQuartile}
    And The response contains {&e=midpoint}
    And The response contains {&e=thirdQuartile}
    And The response contains {&e=complete}
    And The response contains {&e=pause}
    And The response contains {&e=mute}
    And The response contains {&e=close}
    And The response contains {&e=start}
    And The response contains {&e=unmute}
    And The response contains {&e=render}
    And The response contains {events-s-us-east-1.undertone.com\/c?}
    And The response contains {https:\/\/ib.adnxs.com\/getuidnb?https:\/\/usr.undertone.com\/userPixel\/sync?partner=appnexus}
    And The response contains {usr.undertone.com\/userPixel\/sync?partnerId=39}
    And The response contains {https:\/\/cw.addthis.com\/t.gif?pid=46}
    And The response contains {https:\/\/ads.scorecardresearch.com\/b?c1=9&c2=2113&c3=2&cs_xi}
    And The response contains {https:\/\/tags.bluekai.com\/site\/15597?id=}
    And The response contains {https:\/\/sync.alphonso.tv\/sync?srcid=}
    And The response contains {https:\/\/ads.undertone.com\/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc}

  Scenario: Send a web zone request from US and validate the response of a Direct Video Adhesion Ad (Without Leave Behind)
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {unlimited=1&newrender=1} for zone named {zone-zoneset-NewRenderTest-VidAd-w/o-leave-behind-zone} to UAS
    Then The response code is 200
    And The response contains {var ut_aniview={publisherId:'5912cb1028a06142db67f38a',channelId:'5b7d30c4073ef454a07d4d64'}}
    And The response contains {VASTAdTagURI}
    And The response contains {ut_udms}
    And The response contains {https://vast.doubleverify.com/v3/vast?}
    And The response contains {_vast=https%3A%2F%2Fads.sparkflow.net%2Fvast}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-VidAd-w/o-leave-behind-zone-banner-1} 100% of the time
    And The response contains {&e=firstQuartile}
    And The response contains {&e=midpoint}
    And The response contains {&e=thirdQuartile}
    And The response contains {&e=complete}
    And The response contains {&e=pause}
    And The response contains {&e=mute}
    And The response contains {&e=close}
    And The response contains {&e=start}
    And The response contains {&e=unmute}
    And The response contains {&e=render}
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web zone request from US and validate the response of a Programmatic Video Adhesion Ad (Without Leave Behind)
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {requestid=AN-VA-Render&unlimited=1&newrender=1} for zone named {zone-zoneset-NewRenderTest-VidAd-w/o-leave-behind-zone-P} to UAS
    Then The response code is 200
    And The response contains {var ut_aniview={publisherId:'5912cb1028a06142db67f38a',channelId:'5b7d30c4073ef454a07d4d64'}}
    And The response contains {VASTAdTagURI}
    And The response contains {ut_udms}
    And The response contains {https://vast.doubleverify.com/v3/vast?}
    And The response contains {_vast=https%3A%2F%2Fnym1-ib.adnxs.com}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-VidAd-w/o-leave-behind-zone-prog-banner-1} 100% of the time
    And The response contains {&e=firstQuartile}
    And The response contains {&e=midpoint}
    And The response contains {&e=thirdQuartile}
    And The response contains {&e=complete}
    And The response contains {&e=pause}
    And The response contains {&e=mute}
    And The response contains {&e=close}
    And The response contains {&e=start}
    And The response contains {&e=unmute}
    And The response contains {&e=render}
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}

  Scenario: Send a web zone request from US and validate the response of a Direct Linear Video Ad
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {unlimited=1&newrender=1} for zone named {zone-zoneset-NewRenderTest-Instream-View-direct} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The response contains {[CDATA[https://vast.doubleverify.com/v3/vast?}
    And The response contains {ads.sparkflow.net%252Fvast%252F%253Fg%253D39636}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-Instream-View-zone-banner-1} 100% of the time
    And The response contains {&e=firstQuartile}
    And The response contains {&e=midpoint}
    And The response contains {&e=thirdQuartile}
    And The response contains {&e=complete}
    And The response contains {&e=pause}
    And The response contains {&e=mute}
    And The response contains {&e=close}
    And The response contains {&e=start}
    And The response contains {&e=unmute}
    And The clickUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-Instream-View-zone-banner-1} 100% of the time
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {usr.undertone.com/userPixel/sync?partnerId=39}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://dpm.demdex.net/ibs:dpid=152416}

  Scenario: Send a web zone request from US and validate the response of a Programmatic Linear Video Ad
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {requestid=OX-CSVB-Render&unlimited=1&newrender=1} for zone named {zone-zoneset-NewRenderTest-Instream-View-programmatic} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The response contains {[CDATA[https://vast.doubleverify.com/v3/vast?}
    And The response contains {_vast=https%3A%2F%2Fnym1-ib.adnxs.com}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-Instream-View-SP-banner-1} 100% of the time
    And The response contains {&e=firstQuartile}
    And The response contains {&e=midpoint}
    And The response contains {&e=thirdQuartile}
    And The response contains {&e=complete}
    And The response contains {&e=pause}
    And The response contains {&e=mute}
    And The response contains {&e=close}
    And The response contains {&e=start}
    And The response contains {&e=unmute}
    And The response contains {events-s-us-east-1.undertone.com/c?}
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {usr.undertone.com/userPixel/sync?partnerId=39}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://dpm.demdex.net/ibs:dpid=152416}

  Scenario: Send a web zone request and validate the response of a direct ES banner with event trackers
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {unlimited=1&newrender=1} for zone named {zone-zoneset-NewRenderTest-Direct-event-trackers} to UAS
    Then The response code is 200
    And The renderUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-event-trackers-banner-1} 100% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-event-trackers-banner-1} 100% of the time
    And The clickUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-event-trackers-banner-1} 100% of the time
    And The response contains {type:'image', url:'https://www.example.com/tracker?adid=12345'}
    And The response contains {type:'iframe', url:'https://www.example.com/tracker?adid=123456'}
    And The response contains {type:'script', url:'https://www.example.com/tracker?adid=1234567'}
    And The response contains {type:'markup', url:'PGltZyBzcmM9Imh0dHBzOi8vd3d3LmV4YW1wbGUuY29tL3RyYWNrZXI/YWRpZD0xMjM0NTY3OCIgaGVpZ2h0PSIxIiB3aWR0aD0iMSIgYWx0PSJBZHZlcnRpc2VtZW50Ij4='}
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}


  Scenario: Send an InApp request and validate the banner response (Viewable Change)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=appdevice&newrender=1} for zone named {zone-zoneset-Inapp-SI-3} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-3-banner-1} 100% of the time
    And The response contains {var ut_pixels}
    And The response contains {var ut_pixel_event = 'viewableChange';}
    And The response contains {https://creative-p.undertone.com/inapp/ut_pixels.min.js}
    And The clickUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-3-banner-1} 100% of the time
    And The renderUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-3-banner-1} 100% of the time


  Scenario: Send an InApp request and validate the banner response (render)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=appdevice&newrender=1} for zone named {zone-zoneset-Inapp-SI-5} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-5-banner-1} 100% of the time
    And The response contains {var ut_pixels}
    And The response contains {var ut_pixel_event = 'render';}
    And The response contains {https://creative-p.undertone.com/inapp/ut_pixels.min.js}
    And The clickUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-5-banner-1} 100% of the time
    And The renderUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-5-banner-1} 100% of the time

  Scenario: image, markup and iframe - Zone request (ready)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=appdevice&newrender=1} for zone named {zone-zoneset-Inapp-SI-6} to UAS
    Then The response code is 200
    And The response contains {script}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-6-banner-1} 100% of the time
    And The response contains {var ut_pixels}
    And The response contains {var ut_pixel_event = 'ready';}
    And The response contains {https://creative-p.undertone.com/inapp/ut_pixels.min.js}
    And The clickUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-6-banner-1} 100% of the time
    And The renderUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-6-banner-1} 100% of the time

  Scenario: Send an InApp request and validate the programmatic banner response (ready)
    When I send 1 times an ad request with parameter {requestid=OXAppRender&unlimited=1&deviceid=appdevice&newrender=1} for zone named {zone-zoneset-NewRenderTest-InApp-Programmatic} to UAS
    Then The response code is 200
    And The response contains {script}
    And The response contains {sf_tag}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-InApp-Programmatic-banner-1} 100% of the time
    And The response contains {var ut_pixels}
    And The response contains {ut_clickurl}
    And The response contains {ut_udms}
    And The response contains {ut_scripts}
    And The response contains {var ut_scripts = ["https://pixel.adsafeprotected.com/jload?anId=}
    And The response contains {https://cdn.doubleverify.com/dvtp_src.js}
    And The response contains {var ut_pixel_event = 'ready';}
    And The response contains {https://creative-p.undertone.com/inapp/ut_pixels.min.js}
    And The clickUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-InApp-Programmatic-banner-1} 100% of the time
    And The renderUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-InApp-Programmatic-banner-1} 100% of the time


  Scenario: Send a web zone request and validate the response of a direct PG banner with Pub fix
    Given I add header of {x-forwarded-for} with value {207.246.116.162}
    When I send 1 times an ad request with parameter {unlimited=1&newrender=1} for zone named {zone-zoneset-NewRenderTest-Direct-Zone-Regular} to UAS
    Then The response code is 200
    And The response contains {ut_scripts}
    And The response contains {https://pixel.adsafeprotected.com/jload?anId=}
    And The response contains {https://ops-cdn.undertone.com/pubfix/britco_br_pubfix.js}
    And The renderUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-zone-banner-banner-1} 100% of the time
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-zone-banner-banner-1} 100% of the time
    And The clickUrl has bannerid field matching the id of the banner named {campaign-NewRenderTest-web-direct-zone-banner-banner-1} 100% of the time
    And The response contains {https://ib.adnxs.com/getuidnb?https://usr.undertone.com/userPixel/sync?partner=appnexus&uid=}
    And The response contains {https://us-u.openx.net/w/1.0/cm?id=fba3d144-1026-4d31-a758-943b9545e305&r=https://usr.undertone.com/userPixel/sync?partnerId=39&uid=}
    And The response contains {https://cw.addthis.com/t.gif?pid=46&pdid=}
    And The response contains {https://ads.scorecardresearch.com/b?c1=9&c2=2113&c3=2&cs_xi=}
    And The response contains {https://tags.bluekai.com/site/15597?id=}
    And The response contains {https://sync.alphonso.tv/sync?srcid=1200&puid=}
    And The response contains {https://ads.undertone.com/u?dp=44&url=https%3A%2F%2Fpx.tvadsync.com%2Fcom.snowplowanalytics.iglu%2Fv1%3Fschema%3Diglu%3Acom.tvadsync.poc%2Fad_impression%2Fjsonschema%2F1-2-0%26aid%3DUndertone-sync%26partnercookieID%3D}
