@test1
Feature: Entities for tests

#   Scenario: create entities for HB tests
#      Given i create new campaigns with new zoneset
#        |Campaign Name                |IO       |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zoneset-zone Name                 |limitation    |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |
#        |campaign-HB-Tablet-160x600   |75396    |223539     |false                  |148             |zone-zoneset-HB-Tablet-160x600 |[]            |8         |14509            |3701           |66123             |
#        |campaign-HB-See-Through-1X2  |75396    |210722     |false                  |204             |zone-zoneset-HB-See Through 1X2   |[]            |83        |14509            |3701           |66116             |
#
#  Scenario: update data for HB tests
#    Given i update campaign data by name
#      |Campaign Name               |status      |Priority      |units      |limitation|campaign_delivery_method|
#      |campaign-HB-Tablet-160x600  |0           |-2            |-1         |[]        |1                       |
#      |campaign-HB-See-Through-1X2 |0           |-1            |-1         |[]        |2                       |


  Scenario: create entities for DT tests
      Given i remove all zones from publishers: {3701}
      Given i create new campaigns with new zoneset
        |Campaign Name           |IO       |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zoneset-zone Name        |limitation    |adUnitId   |Web_Section id   |publisher ID   |po_line_item ID   |
        |campaign-DT-SS-1-t-1    |75396    |197418     |false                  |86              |zone-zoneset-DT-SS-t-1   |[]            |69         |14509            |3701           |66124             |
        |campaign-DT-SI-1-t-1    |75396    |211456     |false                  |210             |zone-zoneset-DT-SI-t-1   |[]            |61         |14509            |3701           |66125             |
        |campaign-DT-PGC-2-t-1   |75396    |222908     |false                  |1068            |zone-zoneset-DT-PGC-t-1  |[]            |75         |14509            |3701           |66126             |
#        |campaign-DT-SS-1-t-2    |75396    |197418     |false                  |86              |zone-zoneset-DT-SS-t-2   |[]            |69         |14509            |3701           |66124             |



      And i create new campaigns with zoneset by name
        |Campaign Name                            |IO        |LineItem   |isServerProgrammatic?   |Creative\Deal   |Zoneset Name                            |
        |campaign-DT-SS-1-t-2                     |75396     |197418     |false                   |86              |zone-zoneset-DT-Screen-Shift            |
        |campaign-DT-Smartphone-interstitial-2    |75396     |211456     |false                   |210             |zone-zoneset-DT-Smartphone-interstitial |

      And i update campaign data by name
        |Campaign Name                          |status      |Priority      |units      |limitation|campaign_delivery_method|
        |campaign-DT-Screen-Shift-1-test-1             |0           |-2            |-1         |[]        |1                       |
        |campaign-DT-Screen-Shift-2             |0           |-1            |-1         |[]        |2                       |
        |campaign-DT-Smartphone-interstitial-1  |0           |-2            |-1         |[]        |1                       |
        |campaign-DT-Smartphone-interstitial-2  |0           |-1            |-1         |[]        |2                       |
        |campaign-DT-PGC-2                      |0           |-1            |-1         |[]        |2                       |

  Scenario: refresh cache
    And I refresh zone cache
      And I refresh banner cache
      And I restart {ramp-lift-services}
      And I sleep for 100 seconds