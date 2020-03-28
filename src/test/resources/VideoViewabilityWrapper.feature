@parallel
@wrapper1

Feature: video viewability wrapper tests on cross screen video blend product

  Background: health check
    When Sending a healthcheck request to UAS
    Then The response code is 200


  Scenario: 1.0 Testing IAS wrapper response - video zone request
    When I send 1 times an ad video request with parameter {optimize=1&unlimited=1&domain=dnu-tt} for zone named {zone-zoneset-IAS-wrapper-CSVB} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The response contains {campaign-IAS-wrapper-CSVB-banner-1}
    And The response contains {https://vast.adsafeprotected.com/vast?anId=927944}

  Scenario: 2.0 Testing Moat wrapper response - video zone request
  #  &&&&&&&&&&&&&&&&&  Eitan need to fix 4
    When I send 1 times an ad video request with parameter {optimize=1&unlimited=1&domain=dnu-tt} for zone named {zone-zoneset-MOAT-wrapper-CSVB} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The response contains {campaign-MOAT-wrapper-CSVB-banner-1}
    And The response contains {https://svastx.moatads.com/undertonevpaid8571606/template.xml}

  Scenario: 3.0 Testing DV wrapper response - video zone request
  #  &&&&&&&&&&&&&&&&&  Eitan need to fix 4
    When I send 1 times an ad video request with parameter {optimize=1&unlimited=1&domain=dnu-tt} for zone named {zone-zoneset-DV-wrapper-CSVB} to UAS
    Then The response code is 200
    And The response contains {VASTAdTagURI}
    And The response contains {campaign-DV-wrapper-CSVB-banner-1}
    And The response contains {https://vast.doubleverify.com/v3/vast}


