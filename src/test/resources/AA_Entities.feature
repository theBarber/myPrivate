@test1
Feature: Entities for tests

  Scenario: disable all zone for HB publisher
    Given i remove all zones from publishers: {3673}

   Scenario: create entities for HB tests
    Given i create new campaigns with new zoneset
      |Campaign Name                |IO       |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zoneset-zone Name                |limitation                   |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |
      |campaign-HB-Tablet-160x600   |75396    |223539     |false                  |148             |zone-zoneset-HB                  |[[[1,"!~",2601]]]            |8         |14400            |3673           |65421             |
      |campaign-HB-See-Through-1X2  |75396    |210722     |false                  |204             |zone-zoneset-HB-See Through 1X2  |[]                           |83        |14400            |3673           |64396             |

   Scenario: update data for HB tests
      Given i update campaign data by name
        |Campaign Name               |status      |Priority      |units      |limitation|
        |campaign-HB-Tablet-160x600  |0           |-2            |-1         |[]        |
        |campaign-HB-See-Through-1X2 |0           |-1            |-1         |[]        |

    Scenario: refreshing cache
      Given I refresh the zone Cache
      And I sleep for 200 seconds