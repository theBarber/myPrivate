@parallel
@noAA

Feature: video Adhision new ad unit tests

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200

  Scenario: vidAd server prog test, zone req
    When I send 1 times an ad video request with parameter {requestid=vidAd&optimize=1&unlimited=1&domain=dnu-tt} for zone named {zone-zoneset-vidAd-SP} to UAS
    Then The response code is 200
    And The response contains {bannerid}
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-vidAd-SP-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: vidAd server prog test, DT req
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 430 to UAS for publisher 3708 with domain {vidAd-SP&requestid=vidAd&unlimited=1&optimize=1}
    And The synchronized response code is 200
    And The response contains {bannerid}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-vidAd-SP-banner-1} 100% of the time
    When I send impression requests to UAS

  Scenario: vidAd base test, zone req
    When I send 1 times an ad video request with parameter {optimize=1&unlimited=1&domain=dnu-tt&requestid=vidAd} for zone named {zone-zoneset-TN} to UAS
    Then The response code is 200
    And The response contains {bannerid}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-TN-banner-1} 100% of the time

  Scenario: vidAd base test, DT req
    Then i send 1 times Dynamic Tag synchronized ad request with tag id 430 to UAS for publisher 3708 with domain {dnu-tt&unlimited=1&optimize=1}
    And The synchronized response code is 200
    And The response contains {bannerid}
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-TN-banner-1} 100% of the time
    When I send impression requests to UAS


  Scenario: 1. InstreamVid, zone req, vpaid_support=0, inapp. banner without moat wrapper expected
    When I send 1 times an ad video request with parameter {optimize=1&unlimited=1&domain=dnu-tt&vpaid_support=0&deviceid=123&requestid=vidAd} for zone named {zone-zoneset-InstreamVid-View-SP} to UAS
    And The response not contains https://svastx.moatads.com/undertonevpaid8571606/template.xml?tmode=1&vast_url=https%3A%2F%2Fpubads.g.doubleclick.net%2Fgampad%2Fads%3Fsz%3D640x480%26iu%3D%2F124319096%2Fexternal%2Fsingle_ad_samples%26ciu_szs%3D300x250%26impl%3Ds%26gdfp_req%3D1%26env%3Dvp%26output%3Dvast%26unviewed_position_start%3D1%26cust_params%3Ddeployment%253Ddevsite%2526sample_ct%253Dredirectlinear%26correlator%3D&level1=22420&level2=407981&level3=243711&level4=1373640&slicer1=339771&slicer2=190035&zMoatWEBID=3708&ad_title=undefined&ad_duration=00:00:15&ad_width=640&ad_height=360
    Then The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-InstreamVid-View-SP-banner-1} 100% of the time

  Scenario: 2. InstreamVid, zone req, vpaid_support=0, not inapp. banner without moat wrapper expected
    When I send 1 times an ad video request with parameter {optimize=1&unlimited=1&domain=dnu-tt&vpaid_support=0&requestid=vidAd} for zone named {zone-zoneset-InstreamVid-View-SP} to UAS
    And The response not contains https://svastx.moatads.com/undertonevpaid8571606/template.xml?tmode=1&vast_url=https%3A%2F%2Fpubads.g.doubleclick.net%2Fgampad%2Fads%3Fsz%3D640x480%26iu%3D%2F124319096%2Fexternal%2Fsingle_ad_samples%26ciu_szs%3D300x250%26impl%3Ds%26gdfp_req%3D1%26env%3Dvp%26output%3Dvast%26unviewed_position_start%3D1%26cust_params%3Ddeployment%253Ddevsite%2526sample_ct%253Dredirectlinear%26correlator%3D&level1=22420&level2=407981&level3=243711&level4=1373640&slicer1=339771&slicer2=190035&zMoatWEBID=3708&ad_title=undefined&ad_duration=00:00:15&ad_width=640&ad_height=360
    Then The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-InstreamVid-View-SP-banner-1} 100% of the time

  Scenario: 3. InstreamVid, zone req, vpaid_support=1, inapp. banner without moat wrapper expected
    When I send 1 times an ad video request with parameter {optimize=1&unlimited=1&domain=dnu-tt&vpaid_support=1&deviceid=123&requestid=vidAd} for zone named {zone-zoneset-InstreamVid-View-SP} to UAS
    And The response not contains https://svastx.moatads.com/undertonevpaid8571606/template.xml?tmode=1&vast_url=https%3A%2F%2Fpubads.g.doubleclick.net%2Fgampad%2Fads%3Fsz%3D640x480%26iu%3D%2F124319096%2Fexternal%2Fsingle_ad_samples%26ciu_szs%3D300x250%26impl%3Ds%26gdfp_req%3D1%26env%3Dvp%26output%3Dvast%26unviewed_position_start%3D1%26cust_params%3Ddeployment%253Ddevsite%2526sample_ct%253Dredirectlinear%26correlator%3D&level1=22420&level2=407981&level3=243711&level4=1373640&slicer1=339771&slicer2=190035&zMoatWEBID=3708&ad_title=undefined&ad_duration=00:00:15&ad_width=640&ad_height=360
    Then The response code is 200
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-InstreamVid-View-SP-banner-1} 100% of the time

  #  &&&&&&&&&&&&&&&&&  Eitan need to fix 4
#  Scenario: 4. InstreamVid, zone req, vpaid_support=1, not inapp. banner with moat wrapper expected
#    When I send 1 times an ad video request with parameter {optimize=1&unlimited=1&domain=dnu-tt&vpaid_support=1&requestid=vidAd} for zone named {zone-zoneset-InstreamVid-View-SP} to UAS
#    And The response has a moat wrapper with params advanced string with advertiserid = 22420, ioid = 407981, iolineitemid = 244699, bannername = {campaign-InstreamVid-View-SP-banner-1}, campaignname = {campaign-InstreamVid-View-SP}, zonename = {zone-zoneset-InstreamVid-View-SP}, MoatWEBID = 3708
#    And The response contains {&zMoatWEBID=3708}
