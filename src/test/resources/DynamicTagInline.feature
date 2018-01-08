@cli
@uas

Feature: Dynamic Tag inline flow support

  Scenario: 1. Dynamic Tag inline Basic
  Given only tags {111} are enabled and the rest are disabled for publisher 3691
  And i remove all zones from publishers: {3691}, apart from zones:{176942}
  Then I refresh the zone Cache
  Given I add cookie UTID with random value to my requests to uas
  Then i send 1 times Dynamic Tag ad request to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The responses are passback
  Then i send 1 times Dynamic Tag synchronized ad request with tag id 111 to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The response contains script
  And The responses has impression-urls
  And The impressionUrl has bannerid field matching the id of the banner named {See Through-DT-inline-1-banner} 100% of the time

  Scenario: 2. Dynamic Tag inline Basic
  Given only tags {112} are enabled and the rest are disabled for publisher 3691
  And i remove all zones from publishers: {3691}, apart from zones:{176944,176945,176943}
  Then I refresh the zone Cache
  Given I add cookie UTID with random value to my requests to uas
  Then i send 1 times Dynamic Tag ad request to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {Screen shift-DT-inline-1-banner} 100% of the time
  Then i send 1 times Dynamic Tag ad request to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {See Through-DT-inline-2-banner} 100% of the time
  Then i send 1 times Dynamic Tag synchronized ad request with tag id 112 to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {Screen shift-DT-inline-1-banner} 100% of the time
  Then i send 1 times Dynamic Tag synchronized ad request with tag id 112 to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {Screen shift-DT-inline-1-banner} 100% of the time

  Scenario:3.Dynamic Tag inline migrated false
  Given only tags {113,114} are enabled and the rest are disabled for publisher 3691
  And i remove all zones from publishers: {3691}, apart from zones:{176942,176943,176945}
  Then I refresh the zone Cache
  Given I add cookie UTID with random value to my requests to uas
  Then i send 1 times Dynamic Tag ad request to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {Screen shift-DT-inline-2-banner} 100% of the time
  Then i send 1 times Dynamic Tag synchronized ad request with tag id 113 to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The responses are passback
  Then i send 1 times Dynamic Tag synchronized ad request with tag id 114 to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {See Through-DT-inline-1-banner} 100% of the time
  Then i send 1 times Dynamic Tag synchronized ad request with tag id 114 to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {Screen shift-DT-inline-2-banner} 100% of the time


  Scenario:4.Dynamic Tag inline other products
  Given only tags {115,116,117} are enabled and the rest are disabled for publisher 3691
  And i remove all zones from publishers: {3691}, apart from zones:{176944,176948,176942,176943,176949,176951}
  Then I refresh the zone Cache
  Given I add cookie UTID with random value to my requests to uas
  Then i send 1 times Dynamic Tag synchronized ad request with tag id 115 to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {Screen shift-DT-inline-1-banner} 100% of the time
  Then i send 1 times Dynamic Tag synchronized ad request with tag id 115 to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {Page Grabber-DT-inline-2-banner} 100% of the time
  Then i send 1 times Dynamic Tag synchronized ad request with tag id 116 to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {See Through-DT-inline-2-banner} 100% of the time
  Then i send 1 times Dynamic Tag synchronized ad request with tag id 117 to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {Billboard-DT-inline-1-banner} 100% of the time
#    need Asynchronously (!)
  Then i send 10 times Dynamic Tag synchronized ad request with tag id 117 to UAS for publisher 3691 with domain {DynamicTagInline.com&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {Desktop In-Page Blend-DT-inline-1-banner} 100% of the time


  Scenario:5.Header bidding
  Given only tags {118,119} are enabled and the rest are disabled for publisher 3691
  And i remove all zones from publishers: {3691}, apart from zones:{176946,176942,176950,176947}
  Then I refresh the zone Cache
#    is secure (?) synchronized (?)
  Then i send 1 headerBidding post request for scenario {send HB request with sizes:[1,1] for publisher 3691} for publisher 3691 with domain {DynamicTagInline.com} with extra params {&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {See Through-DT-inline-1-banner} 100% of the time
  Then i send 1 headerBidding post request for scenario {send HB request with sizes:[1,1],[970,250] for publisher 3691} for publisher 3691 with domain {DynamicTagInline.com} with extra params {&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {Billboard-DT-inline-1-banner} 100% of the time
  Then i send 1 headerBidding post request for scenario {send HB request with sizes:[1,1] for publisher 3691} for publisher 3691 with domain {DynamicTagInline.com} with extra params {&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {Screen shift-DT-inline-3-banner} 100% of the time
  Then i send 1 headerBidding post request for scenario {send HB request with sizes:[970,250] for publisher 3691} for publisher 3691 with domain {DynamicTagInline.com} with extra params {&unlimited=1}
  And The response contains script
  And The impressionUrl has bannerid field matching the id of the banner named {Screen shift-DT-inline-3-banner} 100% of the time