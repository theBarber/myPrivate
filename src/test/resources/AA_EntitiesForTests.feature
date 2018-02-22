Feature: Entities for tests

  Scenario: create entities for HB tests
    Given i create new campaigns with new zoneset
      |Campaign Name               |IO       |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zoneset-zone Name                |limitation    |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |
      |campaign-HB-Tablet 160x600  |75396    |220832     |false                  |148             |zone-zoneset-HB-Tablet 160x600   |[]            |8         |14400            |3673           |65421             |
      |campaign-HB-See Through 1X2 |75396    |210722     |false                  |204             |zone-zoneset-HB-See Through 1X2  |[]            |83        |14400            |3673           |64396             |


    Scenario: update data for HB tests
      Given i update campaigns data by name
        |Campaign ID                 |status      |Priority      |units      |limitation|
        |campaign-HB-Tablet 160x600  |0           |-1            |-1         |[]        |
        |campaign-HB-See Through 1X2 |0           |-1            |-1         |[]        |


    Scenario: refreshing cache
      Given I refresh the zone Cache