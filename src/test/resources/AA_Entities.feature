@couchBaseUtil
@preconditions
@optimize
@AA

Feature: Entities for tests

#  Background: health check
#    When Sending a healthcheck request to RAMP-IO
#    Then The response code is 200

  Scenario: entities end-date update
    And i update po_line_item end date by id {67164,17116,27807,67638,27809,65421,64396,66814,66813,64397,64398,64399,64400,64401,64402,64403,65422,65423,65424,66418,66486,66487,66488,66810,66811,62229,66556,66557,66555,66556,67259,67260,67261,66833,66831,66830,67182,67231,66933,66004,66002,66736,65991,67354,66811,66555,66557,67165,68927,67163,67162,67166,69089,69134,66832,69158,69213}
    And i update io_line_item end date by id {210722,241783,223539,240827,198082,197418,224812,222908,224810,224539,240829,224533,224530,211456,228962,224531,228961,229737,243452,234550,234656,243707,243711,244895,244896,244699}
    And i update io_line_item with id {210722} filed {unit_price} to be {1}
    And i update io_line_item with id {210722} filed {budget} to be {1}


  Scenario: remove all active zones
#    zones that are linked to publisher 2434 are disabled specifically!!
    Given i remove all zones from publishers: {3673}
    Given i remove all zones from publishers: {3697}
    Given i remove all zones from publishers: {3708}
    Given i remove all zones from publishers: {3674}
    Given i remove all zones from publishers: {3675}
    Given i remove all zones from publishers: {3666}
    Given i remove all zones from publishers: {3728}
    Given i remove all zones from publishers: {3690}
    Given i remove all zones from publishers: {1111}
    Given i remove all zones from publishers: {3711}
    Given i remove all zones from publishers: {3739}
    Given i remove all zones from publishers: {2546}
    Given i remove all zones from publishers: {3585}
    Given i remove all zones from publishers: {3586}

#  @zoneTagSanity
#  Scenario: create entities for zone Tag Sanity test
#    Given i create new priority campaigns with new zoneset
#      |Campaign Name                           |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name                      |limitation        |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |campaign priority|
#      |campaign-API-performance-1-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-2-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-3-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-3-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-4-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-5-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-6-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-7-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-8-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-9-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-10-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-11-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-12-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-13-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-14-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-15-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-16-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-17-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-18-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-19-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-20-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-21-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-22-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-23-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-24-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-25-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-26-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-27-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-28-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-29-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-30-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-31-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[[[1,"!~",2601]]] |83        |4737             |2434           |17116             |-1               |
#      |campaign-API-performance-32-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[[[1,"!~",2601]]] |83        |4737             |2434           |17116             |-1               |
#      |campaign-API-performance-33-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[[[1,"!~",2601]]] |83        |4737             |2434           |17116             |-1               |
#      |campaign-API-performance-34-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[[[1,"!~",2601]]] |83        |4737             |2434           |17116             |-1               |
#      |campaign-API-performance-35-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[[[1,"!~",2601]]] |83        |4737             |2434           |17116             |-1               |
#      |campaign-API-performance-36-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[[[1,"!~",2601]]] |83        |4737             |2434           |17116             |-1               |
#      |campaign-API-performance-37-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[[[1,"!~",2601]]] |83        |4737             |2434           |17116             |-1               |
#      |campaign-API-performance-38-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[[[1,"!~",2601]]] |83        |4737             |2434           |17116             |-1               |
#      |campaign-API-performance-39-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[[[1,"!~",2601]]] |83        |4737             |2434           |17116             |-1               |
#      |campaign-API-performance-40-sanity    |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[[[1,"!~",2601]]] |83        |4737             |2434           |17116             |-1               |
#    And i update banner data by name
#      |Campaign Name                                    |limitation                                                     |
#      |campaign-API-performance-39-sanity-banner-1    |[[[5,"=~","il"],[12,"=~","firefox"]]]                          |
#      |campaign-API-performance-40-sanity-banner-1    |[[[5,"=~","il"],[12,"=~","chrome"]]]                           |

  @HB
  @HBEntitiesCreation
  @HBFilterEntitiesCreation
  Scenario: create entities for HeaderBiddingFilter tests
    Given i remove all zones from publishers: {3708}
    And i disable campaigns by name on db
      | Campaign Name           |
      | campaign-HB-PO-Price    |
      | campaign-HB-No-PO-Price |
    And i create new campaigns with new zoneset
      | Campaign Name           | IO    | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name            | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-HB-PO-Price    | 75396 | 244896   | false                 | 8290          | {zone-zoneset-HB-PO-Price}    | []         | 93       | 15281          | 3708         | 69212           |
      | campaign-HB-No-PO-Price | 75396 | 244896   | false                 | 8290          | {zone-zoneset-HB-No-PO-Price} | []         | 93       | 15281          | 3708         | 69211           |
    And i update campaign data by name
      | Campaign Name           | status | Priority | units | limitation | campaign_delivery_method | is_wholesale | skip_daily_goal | units | goal_type   |
      | campaign-HB-PO-Price    | 0      | 1        | -1    | []         | 1                        | 1            | 1               | -1    | impressions |
      | campaign-HB-No-PO-Price | 0      | -2       | -1    | []         | 1                        | 1            | 1               | -1    | impressions |
    And i update banner data by name
      | Banner Name                      | is_secure | limitation |
      | campaign-HB-PO-Price-banner-1    | 1         | []         |
      | campaign-HB-No-PO-Price-banner-1 | 1         | []         |
    And i update zone data by name
      | Zone Name                   | is_secure | limitation |
      | zone-zoneset-HB-PO-Price    | 1         | []         |
      | zone-zoneset-HB-No-PO-Price | 1         | []         |

  @zoneTagSanity
  Scenario: create entities for zone Tag Sanity test
    Given i disable campaigns by name on db
      | Campaign Name           |
      | campaign-API-1-a-sanity |
#    Given i update zone data by name
#    |Zone Name                  | status  |
#    |zone-zoneset-sanity-1-a    |    1    |
    Given i create new campaigns with new zoneset
      | Campaign Name           | IO    | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name        | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-API-1-a-sanity | 75396 | 210722   | false                 | 204           | {zone-zoneset-sanity-1-a} | []         | 83       | 4737           | 2434         | 17116           |
    And i update zone data by name
      | Zone Name               | is_secure |
      | zone-zoneset-sanity-1-a | 1         |

  @GDPR
  Scenario: create entities for zone Tag Sanity test
    Given i disable campaigns by name on db
      | Campaign Name         |
      | campaign-API-1-a-GDPR |
#    Given i update zone data by name
#      |Zone Name                  | status  |
#      |campaign-API-1-a-GDPR      |    1    |
    Given i create new campaigns with new zoneset
      | Campaign Name         | IO    | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name      | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-API-1-a-GDPR | 75396 | 210722   | false                 | 204           | {zone-zoneset-GDPR-1-a} | []         | 83       | 4737           | 2434         | 17116           |
    And i update banner data by name
      | Banner Name                    | limitation        |
      | campaign-API-1-a-GDPR-banner-1 | [[[5,"=~","fr"]]] |
    And i update zone data by name
      | Zone Name             | is_secure |
      | zone-zoneset-GDPR-1-a | 1         |

  @limitationSanity
  Scenario: create entities for zone Tag Sanity test
    Given i disable campaigns by name on db
      | Campaign Name                   |
      | campaign-API-limitations-test-F |
      | campaign-API-limitations-test-C |
      | campaign-API-limitations-test-W |
#    And i update zone data by name
#      |Zone Name                            |  status  |
#      |zone-zoneset-limitations-test        |    1     |
    Given i create new campaigns with new zoneset
      | Campaign Name                   | IO    | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name              | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-API-limitations-test-F | 75396 | 210722   | false                 | 204           | {zone-zoneset-limitations-test} | []         | 83       | 4737           | 2434         | 17116           |
      | campaign-API-limitations-test-C | 75396 | 210722   | false                 | 204           | {zone-zoneset-limitations-test} | []         | 83       | 4737           | 2434         | 17116           |
      | campaign-API-limitations-test-W | 75396 | 210722   | false                 | 204           | {zone-zoneset-limitations-test} | []         | 83       | 4737           | 2434         | 17116           |
    And i update banner data by name
      | Banner Name                              | limitation                                                    |
      | campaign-API-limitations-test-F-banner-1 | [[[5,"!~","af"],[12,"=~","firefox"]]]                         |
      | campaign-API-limitations-test-C-banner-1 | [[[5,"!~","af"],[12,"=~","chrome"]]]                          |
      | campaign-API-limitations-test-W-banner-1 | [[[5,"!~","af"],[12,"=~","msie","msie 7","msie 8","msie 9"]]] |
    And i update zone data by name
      | Zone Name                     | is_secure |
      | zone-zoneset-limitations-test | 1         |

  @UDMP
  Scenario: create entities for profile targeting via UDMP
    Given i disable campaigns by name on db
      | Campaign Name                               |
      | campaign-ProfileTargetingUDMPforApp-ST-1    |
      | campaign-ProfileTargetingUDMPforWeb-ST-1    |
      | campaign-SeqProfileTargetingUDMPforWeb-ST-1 |
      | campaign-CrossDeviceCappingUDMP-ST-1        |
      | campaign-PTzoneLimitation-ST-1              |
    Given i create new campaigns with new zoneset
      | Campaign Name                               | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                               | limitation           | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-ProfileTargetingUDMPforApp-ST-1    | 75396 | 241783   | false                 | 14619         | {zone-zoneset-ProfileTargetingUDMPforApp-ST-1}    | []                   | 80       | 14892          | 3708         | 27807           |
      | campaign-ProfileTargetingUDMPforWeb-ST-1    | 75396 | 210722   | false                 | 8158          | {zone-zoneset-ProfileTargetingUDMPforWeb-ST-1}    | []                   | 93       | 14892          | 3708         | 27807           |
      | campaign-SeqProfileTargetingUDMPforWeb-ST-1 | 75396 | 210722   | false                 | 8158          | {zone-zoneset-SeqProfileTargetingUDMPforWeb-ST-1} | []                   | 93       | 15128          | 3708         | 67638           |
      | campaign-CrossDeviceCappingUDMP-ST-1        | 75396 | 210722   | false                 | 8158          | {zone-zoneset-CrossDeviceCappingUDMP-ST-1}        | []                   | 93       | 14894          | 3708         | 27809           |
      | campaign-PTzoneLimitation-ST-1              | 75396 | 210722   | false                 | 8158          | {zone-zoneset-PTzoneLimitation-ST-1}              | [[[4,"==",1,1,666]]] | 93       | 15124          | 3708         | 27807           |
    And i update zone data by name
      | Zone Name                                       | is_mraid | is_secure |
      | zone-zoneset-ProfileTargetingUDMPforApp-ST-1    | 1        | 1         |
      | zone-zoneset-SeqProfileTargetingUDMPforWeb-ST-1 | 0        | 1         |
      | zone-zoneset-PTzoneLimitation-ST-1              | 0        | 1         |
      | zone-zoneset-CrossDeviceCappingUDMP-ST-1        | 0        | 1         |
      | zone-zoneset-PTzoneLimitation-ST-1              | 0        | 1         |
    Given i update banner data by name
      | Banner Name                                          | limitation            |
      | campaign-ProfileTargetingUDMPforApp-ST-1-banner-1    | [[[4,"==",1,1,1992]]] |
      | campaign-ProfileTargetingUDMPforWeb-ST-1-banner-1    | [[[4,"==",1,1,1992]]] |
      | campaign-SeqProfileTargetingUDMPforWeb-ST-1-banner-1 | [[[4,"==",1,1,17]]]   |
    Given i update campaign data by name
      | Campaign Name                        | capping | session_capping |
      | campaign-CrossDeviceCappingUDMP-ST-1 | 2       | 2               |


  @GDPR
  @HB
  Scenario: create entities for HB tests
    And i disable campaigns by name on db
      | Campaign Name                               |
      | campaign-HB-Tablet-160x600                  |
      | campaign-HB-See-Through-1X2                 |
      | campaign-HB-Desktop-300X250                 |
      | campaign-HB-Billboard-970X250               |
      | campaign-HB-SS-1X1                          |
      | campaign-HB-Prog-PGC-1X1-1                  |
      | campaign-HB-Prog-PGC-1X1-2                  |
      | campaign-HB-Prog-PGC-1X1-3                  |
      | campaign-HB-Prog-See-Through-1X2-1          |
      | campaign-HB-Prog-See-Through-1X2-2          |
      | campaign-HB-Prog-See-Through-1X2-3          |
      | campaign-HB-Prog-Billboard-970X250-D        |
      | campaign-HB-Prog-Billboard-970X250-P        |
#        fixed price, po sp is less
      | campaign-HB-DynamicPrice-1                  |
#       dynamic price, camp sp is less
      | campaign-HB-DynamicPrice-2                  |
#        dynamic price with po sp < camp sp
      | campaign-HB-DynamicPrice-3                  |
#        dynamic price with campaign mobile sp < po sales price < campaign desktop
      | campaign-HB-DynamicPrice-4                  |
#        2 ad units senario
      | campaign-HB-DynamicPrice-ST-1x2-5a          |
      | campaign-HB-DynamicPrice-Desktop-300X250-5b |
      | campaign-HB-DP-ServerPr-ST-DynamicAtPub-6   |
      | campaign-HB-DP-ServerPr-PGC-6b              |

    Given i create new campaigns with new zoneset
      | Campaign Name                               | IO     | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name                                | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-HB-Tablet-160x600                  | 75396  | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600}                  | []         | 8        | 14400          | 3673         | 65421           |
      | campaign-HB-See-Through-1X2                 | 75396  | 210722   | false                 | 204           | {zone-zoneset-HB-See Through 1X2}                 | []         | 83       | 14400          | 3673         | 64396           |
      | campaign-HB-Desktop-300X250                 | 75396  | 240827   | false                 | 85            | {zone-zoneset-Desktop-300X250}                    | []         | 10       | 14400          | 3673         | 66814           |
      | campaign-HB-Billboard-970X250               | 75396  | 198082   | false                 | 64            | {zone-zoneset-HB-Billboard-970X250}               | []         | 58       | 14400          | 3673         | 66813           |
      | campaign-HB-SS-1X1                          | 75396  | 197418   | false                 | 86            | {zone-zoneset-HB-SS-1X1}                          | []         | 69       | 14400          | 3673         | 66933           |
      | campaign-HB-Prog-PGC-1X1-1                  | 407981 | 224812   | false                 | 6499          | {zone-zoneset-HB-Prog-PGC-1X1}                    | []         | 69       | 14507          | 3697         | 66004           |
      | campaign-HB-Prog-PGC-1X1-2                  | 407981 | 224812   | false                 | 6499          | {zone-zoneset-HB-Prog-PGC-1X1}                    | []         | 69       | 14507          | 3697         | 66004           |
      | campaign-HB-Prog-PGC-1X1-3                  | 75396  | 222908   | false                 | 86            | {zone-zoneset-HB-Prog-PGC-1X1}                    | []         | 69       | 14507          | 3697         | 66004           |
      | campaign-HB-Prog-See-Through-1X2-1          | 407981 | 224810   | false                 | 6497          | {zone-zoneset-HB-Prog-See-Through-1X2}            | []         | 83       | 14507          | 3697         | 66002           |
      | campaign-HB-Prog-See-Through-1X2-2          | 407981 | 224810   | false                 | 6497          | {zone-zoneset-HB-Prog-See-Through-1X2}            | []         | 83       | 14507          | 3697         | 66002           |
      | campaign-HB-Prog-See-Through-1X2-3          | 407981 | 224810   | false                 | 6497          | {zone-zoneset-HB-Prog-See-Through-1X2}            | []         | 83       | 14507          | 3697         | 66002           |
      | campaign-HB-Prog-Billboard-970X250-D        | 75396  | 198082   | false                 | 64            | {zone-zoneset-HB-Prog-Billboard-970X250}          | []         | 58       | 14507          | 3697         | 66736           |
      | campaign-HB-Prog-Billboard-970X250-P        | 407981 | 224539   | false                 | 7143          | {zone-zoneset-HB-Prog-Billboard-970X250}          | []         | 58       | 14507          | 3697         | 66736           |
#       sales price for polineitem 65991 = 0.4 (new), for polineitem 67354 = 2
      | campaign-HB-DynamicPrice-1                  | 75396  | 210722   | false                 | 8158          | {zone-zoneset-HB-DynamicPrice-1}                  | []         | 93       | 15133          | 3708         | 65991           |
      | campaign-HB-DynamicPrice-2                  | 75396  | 210722   | false                 | 8158          | {zone-zoneset-HB-DynamicPrice-2}                  | []         | 93       | 15143          | 3708         | 65991           |
      | campaign-HB-DynamicPrice-3                  | 75396  | 210722   | false                 | 8158          | {zone-zoneset-HB-DynamicPrice-3}                  | []         | 93       | 15134          | 3708         | 65991           |
      | campaign-HB-DynamicPrice-4                  | 75396  | 210722   | false                 | 8158          | {zone-zoneset-HB-DynamicPrice-4}                  | []         | 93       | 15144          | 3708         | 65991           |
      | campaign-HB-DynamicPrice-ST-1x2-5a          | 75396  | 210722   | false                 | 8158          | {zone-zoneset-HB-DynamicPrice-ST-1x2-5a}          | []         | 93       | 15145          | 3708         | 67354           |
      | campaign-HB-DynamicPrice-Desktop-300X250-5b | 75396  | 240829   | false                 | 85            | {zone-zoneset-HB-DynamicPrice-Desktop-300X250-5b} | []         | 10       | 15145          | 3708         | 66811           |
#       for SP !!!!!!!after DB copy - change web section
      | campaign-HB-DP-ServerPr-ST-DynamicAtPub-6a  | 407981 | 224533   | true                  | 31            | {zone-zoneset-HB-DP-ServerPr-ST-DynamicAtPub-6a}  | []         | 83       | 15168          | 3711         | 66555           |
      | campaign-HB-DP-ServerPr-PGC-6b              | 407981 | 224530   | true                  | 20            | {zone-zoneset-HB-DP-ServerPr-PGC-6b}              | []         | 75       | 15168          | 3711         | 66557           |
    And i update campaign data by name
      | Campaign Name                        | status | Priority | units | limitation | campaign_delivery_method |
      | campaign-HB-Tablet-160x600           | 0      | -2       | -1    | []         | 1                        |
      | campaign-HB-See-Through-1X2          | 0      | -1       | -1    | []         | 2                        |
      | campaign-HB-Desktop-300X250          | 0      | -2       | -1    | []         | 1                        |
      | campaign-HB-Billboard-970X250        | 0      | -1       | -1    | []         | 2                        |
      | campaign-HB-SS-1X1                   | 0      | -2       | -1    | []         | 1                        |
      | campaign-HB-Prog-PGC-1X1-1           | 0      | -2       | -1    | []         | 1                        |
      | campaign-HB-Prog-PGC-1X1-2           | 0      | -1       | -1    | []         | 2                        |
      | campaign-HB-Prog-PGC-1X1-3           | 0      | 1        | -1    | []         | 4                        |
      | campaign-HB-Prog-See-Through-1X2-1   | 0      | -2       | -1    | []         | 1                        |
      | campaign-HB-Prog-See-Through-1X2-2   | 0      | -1       | -1    | []         | 2                        |
      | campaign-HB-Prog-See-Through-1X2-3   | 0      | 1        | -1    | []         | 4                        |
      | campaign-HB-Prog-Billboard-970X250-D | 0      | -2       | -1    | []         | 1                        |
      | campaign-HB-Prog-Billboard-970X250-P | 0      | -1       | -1    | []         | 2                        |
    #    40% gives cpm = 0.6
    #    70% gives cpm = 0.3
    And i update campaign data by name
      | Campaign Name                               | hb_desktop_bid_price_percentage | hb_mobile_bid_price_percentage |
#      |campaign-HB-DynamicPrice-1                    |40                                   |40                           |
      | campaign-HB-DynamicPrice-2                  | 70                              | 70                             |
      | campaign-HB-DynamicPrice-3                  | 40                              | 40                             |
      | campaign-HB-DynamicPrice-4                  | 50                              | 70                             |
      | campaign-HB-DynamicPrice-ST-1x2-5a          | 40                              | 40                             |
      | campaign-HB-DynamicPrice-Desktop-300X250-5b | 50                              | 50                             |
      | campaign-HB-DP-ServerPr-ST-DynamicAtPub-6a  | 40                              | 40                             |
      | campaign-HB-DP-ServerPr-PGC-6b              | 40                              | 40                             |
    And i update zone data by name
      | Zone Name                                       | is_secure |
      | zone-zoneset-HB-Tablet-160x600                  | 1         |
      | zone-zoneset-HB-See Through 1X2                 | 1         |
      | zone-zoneset-Desktop-300X250                    | 1         |
      | zone-zoneset-HB-Billboard-970X250               | 1         |
      | zone-zoneset-HB-SS-1X1                          | 1         |
      | zone-zoneset-HB-Prog-PGC-1X1                    | 1         |
      | zone-zoneset-HB-Prog-See-Through-1X2            | 1         |
      | zone-zoneset-HB-Prog-Billboard-970X250          | 1         |
      | zone-zoneset-HB-DynamicPrice-1                  | 1         |
      | zone-zoneset-HB-DynamicPrice-2                  | 1         |
      | zone-zoneset-HB-DynamicPrice-3                  | 1         |
      | zone-zoneset-HB-DynamicPrice-4                  | 1         |
      | zone-zoneset-HB-DynamicPrice-Desktop-300X250-5b | 1         |
      | zone-zoneset-HB-DynamicPrice-ST-1x2-5a          | 1         |
      | zone-zoneset-HB-DP-ServerPr-ST-DynamicAtPub-6a  | 1         |
      | zone-zoneset-HB-DP-ServerPr-PGC-6b              | 1         |

    Given i updated bid_price_type for publisher = 3708 for adunit = 93 to be 1
    Given i updated bid_price_type for publisher = 3711 for adunit = 69 to be 1
    Given i updated bid_price_type for publisher = 3711 for adunit = 75 to be 1


  @HB
  Scenario: create entities for HB tests with multiple domains
    Given i disable campaigns by name on db
      | Campaign Name             |
      | HB-Tablet-160x600-D-1-a-1 |
      | HB-Tablet-160x600-D-1-a-2 |
      | HB-Tablet-160x600-D-1-b-1 |
      | HB-Tablet-160x600-D-1-b-2 |
      | See-Through-1X2-D-1-a-1   |
      | See-Through-1X2-D-1-a-2   |
      | See-Through-1X2-D-1-b-1   |
      | See-Through-1X2-D-1-b-2   |
      | HB-Tablet-160x600-D-2-a-1 |
      | HB-Tablet-160x600-D-2-a-2 |
      | HB-Tablet-160x600-D-2-b-1 |
      | HB-Tablet-160x600-D-2-b-2 |
      | See-Through-1X2-D-2-a-1   |
      | See-Through-1X2-D-2-a-2   |
      | See-Through-1X2-D-2-b-1   |
      | See-Through-1X2-D-2-b-2   |
      | HB-Tablet-160x600-D-3-a-1 |
      | HB-Tablet-160x600-D-3-a-2 |
      | HB-Tablet-160x600-D-3-b-1 |
      | HB-Tablet-160x600-D-3-b-2 |
      | See-Through-1X2-D-3-a-1   |
      | See-Through-1X2-D-3-a-2   |
      | See-Through-1X2-D-3-b-1   |
      | See-Through-1X2-D-3-b-2   |
      | HB-Tablet-160x600-D-4-a-1 |
      | HB-Tablet-160x600-D-4-a-2 |
      | HB-Tablet-160x600-D-4-b-1 |
      | HB-Tablet-160x600-D-4-b-2 |
      | See-Through-1X2-D-4-a-1   |
      | See-Through-1X2-D-4-a-2   |
      | See-Through-1X2-D-4-b-1   |
      | See-Through-1X2-D-4-b-2   |
      | campaign-HB-SS-1X1-D-1    |
      | campaign-HB-SS-1X1-D-2    |
    Given i create new zone named {zone-zoneset-HB-Tablet-160x600-D-1-a} with limitation {[]} with adUnitId 8 and web_section id 14818 with affiliateId 3673 with po_line_item_id 65421
    And i create new zone named {zone-zoneset-HB-Tablet-160x600-D-1-b} with limitation {[]} with adUnitId 8 and web_section id 14818 with affiliateId 3673 with po_line_item_id 65421
    And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-1-a} with limitation {[]} with adUnitId 83 and web_section id 14818 with affiliateId 3673 with po_line_item_id 64396
    And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-1-b} with limitation {[]} with adUnitId 83 and web_section id 14818 with affiliateId 3673 with po_line_item_id 64396
    Given i create new zone named {zone-zoneset-HB-Tablet-160x600-D-2-a} with limitation {[]} with adUnitId 8 and web_section id 14819 with affiliateId 3673 with po_line_item_id 65421
    And i create new zone named {zone-zoneset-HB-Tablet-160x600-D-2-b} with limitation {[]} with adUnitId 8 and web_section id 14819 with affiliateId 3673 with po_line_item_id 65421
    And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-2-a} with limitation {[]} with adUnitId 83 and web_section id 14819 with affiliateId 3673 with po_line_item_id 64396
    And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-2-b} with limitation {[]} with adUnitId 83 and web_section id 14819 with affiliateId 3673 with po_line_item_id 64396
    Given i create new zone named {zone-zoneset-HB-Tablet-160x600-D-3-a} with limitation {[]} with adUnitId 8 and web_section id 14820 with affiliateId 3673 with po_line_item_id 65421
    And i create new zone named {zone-zoneset-HB-Tablet-160x600-D-3-b} with limitation {[]} with adUnitId 8 and web_section id 14820 with affiliateId 3673 with po_line_item_id 65421
    And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-3-a} with limitation {[]} with adUnitId 83 and web_section id 14820 with affiliateId 3673 with po_line_item_id 64396
    And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-3-b} with limitation {[]} with adUnitId 83 and web_section id 14820 with affiliateId 3673 with po_line_item_id 64396
    Given i create new zone named {zone-zoneset-HB-Tablet-160x600-D-4-a} with limitation {[]} with adUnitId 8 and web_section id 14851 with affiliateId 3673 with po_line_item_id 65421
    And i create new zone named {zone-zoneset-HB-Tablet-160x600-D-4-b} with limitation {[]} with adUnitId 8 and web_section id 14851 with affiliateId 3673 with po_line_item_id 65421
    And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-4-a} with limitation {[]} with adUnitId 83 and web_section id 14851 with affiliateId 3673 with po_line_item_id 64396
    And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-4-b} with limitation {[]} with adUnitId 83 and web_section id 14851 with affiliateId 3673 with po_line_item_id 64396
    And i create new zone named {zone-zoneset-HB-SS-1X1-D-1} with limitation {[]} with adUnitId 69 and web_section id 14818 with affiliateId 3673 with po_line_item_id 66933
    And i create new zone named {zone-zoneset-HB-SS-1X1-D-2} with limitation {[]} with adUnitId 69 and web_section id 14819 with affiliateId 3673 with po_line_item_id 66933
    And i create new campaigns with new zoneset
      | Campaign Name             | IO    | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name                                      |
      | HB-Tablet-160x600-D-1-a-1 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-1-a}                  |
      | HB-Tablet-160x600-D-1-a-2 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-1-a}                  |
      | HB-Tablet-160x600-D-1-b-1 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-1-b}                  |
      | HB-Tablet-160x600-D-1-b-2 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-1-b}                  |
      | See-Through-1X2-D-1-a-1   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-1-a}                 |
      | See-Through-1X2-D-1-a-2   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-1-a}                 |
      | See-Through-1X2-D-1-b-1   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-1-b}                 |
      | See-Through-1X2-D-1-b-2   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-1-b}                 |
      | HB-Tablet-160x600-D-2-a-1 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-2-a}                  |
      | HB-Tablet-160x600-D-2-a-2 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-2-a}                  |
      | HB-Tablet-160x600-D-2-b-1 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-2-b}                  |
      | HB-Tablet-160x600-D-2-b-2 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-2-b}                  |
      | See-Through-1X2-D-2-a-1   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-2-a}                 |
      | See-Through-1X2-D-2-a-2   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-2-a}                 |
      | See-Through-1X2-D-2-b-1   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-2-b}                 |
      | See-Through-1X2-D-2-b-2   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-2-b}                 |
      | HB-Tablet-160x600-D-3-a-1 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-3-a}                  |
      | HB-Tablet-160x600-D-3-a-2 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-3-a}                  |
      | HB-Tablet-160x600-D-3-b-1 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-3-b}                  |
      | HB-Tablet-160x600-D-3-b-2 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-3-b}                  |
      | See-Through-1X2-D-3-a-1   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-3-a}                 |
      | See-Through-1X2-D-3-a-2   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-3-a}                 |
      | See-Through-1X2-D-3-b-1   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-3-b}                 |
      | See-Through-1X2-D-3-b-2   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-3-b}                 |
      | HB-Tablet-160x600-D-4-a-1 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-4-a}                  |
      | HB-Tablet-160x600-D-4-a-2 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-4-a}                  |
      | HB-Tablet-160x600-D-4-b-1 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-4-b}                  |
      | HB-Tablet-160x600-D-4-b-2 | 75396 | 223539   | false                 | 148           | {zone-zoneset-HB-Tablet-160x600-D-4-b}                  |
      | See-Through-1X2-D-4-a-1   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-4-a}                 |
      | See-Through-1X2-D-4-a-2   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-4-a}                 |
      | See-Through-1X2-D-4-b-1   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-4-b}                 |
      | See-Through-1X2-D-4-b-2   | 75396 | 210722   | false                 | 204           | {zone-zoneset-HB-See-Through-1X2-D-4-b}                 |
      | campaign-HB-SS-1X1-D-1    | 75396 | 197418   | false                 | 86            | {zone-zoneset-HB-SS-1X1-D-1,zone-zoneset-HB-SS-1X1-D-2} |
      | campaign-HB-SS-1X1-D-2    | 75396 | 197418   | false                 | 86            | {zone-zoneset-HB-SS-1X1-D-1,zone-zoneset-HB-SS-1X1-D-2} |
    And i update campaign data by name
      | Campaign Name             | Priority | campaign_delivery_method | delivery_algorithm |
      | HB-Tablet-160x600-D-1-a-1 | -2       | 1                        | 4                  |
      | HB-Tablet-160x600-D-1-a-2 | -1       | 2                        | 3                  |
      | HB-Tablet-160x600-D-1-b-1 | 1        | 4                        | 2                  |
      | HB-Tablet-160x600-D-1-b-2 | 1        | 4                        | 1                  |
      | See-Through-1X2-D-1-a-1   | -1       | 2                        | 3                  |
      | See-Through-1X2-D-1-a-2   | -1       | 2                        | 3                  |
      | See-Through-1X2-D-1-b-1   | 1        | 4                        | 2                  |
      | See-Through-1X2-D-1-b-2   | 1        | 4                        | 1                  |
      | HB-Tablet-160x600-D-2-a-1 | -1       | 2                        | 3                  |
      | HB-Tablet-160x600-D-2-a-2 | -1       | 2                        | 3                  |
      | HB-Tablet-160x600-D-2-b-1 | 1        | 4                        | 2                  |
      | HB-Tablet-160x600-D-2-b-2 | 1        | 4                        | 1                  |
      | See-Through-1X2-D-2-a-1   | -2       | 1                        | 4                  |
      | See-Through-1X2-D-2-a-2   | -1       | 2                        | 3                  |
      | See-Through-1X2-D-2-b-1   | 1        | 4                        | 2                  |
      | See-Through-1X2-D-2-b-2   | 1        | 4                        | 1                  |
      | HB-Tablet-160x600-D-3-a-1 | -2       | 1                        | 4                  |
      | HB-Tablet-160x600-D-3-a-2 | -1       | 2                        | 3                  |
      | HB-Tablet-160x600-D-3-b-1 | 1        | 4                        | 2                  |
      | HB-Tablet-160x600-D-3-b-2 | 1        | 4                        | 1                  |
      | See-Through-1X2-D-3-a-1   | -1       | 2                        | 3                  |
      | See-Through-1X2-D-3-a-2   | -1       | 2                        | 3                  |
      | See-Through-1X2-D-3-b-1   | 1        | 4                        | 2                  |
      | See-Through-1X2-D-3-b-2   | 1        | 4                        | 1                  |
      | HB-Tablet-160x600-D-4-a-1 | -1       | 2                        | 3                  |
      | HB-Tablet-160x600-D-4-a-2 | -1       | 2                        | 3                  |
      | HB-Tablet-160x600-D-4-b-1 | 1        | 4                        | 2                  |
      | HB-Tablet-160x600-D-4-b-2 | 1        | 4                        | 1                  |
      | See-Through-1X2-D-4-a-1   | -2       | 1                        | 4                  |
      | See-Through-1X2-D-4-a-2   | -1       | 2                        | 3                  |
      | See-Through-1X2-D-4-b-1   | 1        | 4                        | 2                  |
      | See-Through-1X2-D-4-b-2   | 1        | 4                        | 1                  |
      | campaign-HB-SS-1X1-D-1    | -2       | 1                        | 4                  |
      | campaign-HB-SS-1X1-D-2    | -1       | 2                        | 3                  |
    And i update banner data by name
      | Banner Name                     | limitation            |
      | campaign-HB-SS-1X1-D-1-banner-1 | [[[4,\"=~\",30,1,1]]] |
      | campaign-HB-SS-1X1-D-2-banner-1 | []                    |
    And i update zone data by name
      | Zone Name                             | is_secure |
      | zone-zoneset-HB-Tablet-160x600-D-1-a  | 1         |
      | zone-zoneset-HB-Tablet-160x600-D-1-b  | 1         |
      | zone-zoneset-HB-See-Through-1X2-D-1-a | 1         |
      | zone-zoneset-HB-See-Through-1X2-D-1-b | 1         |
      | zone-zoneset-HB-Tablet-160x600-D-2-a  | 1         |
      | zone-zoneset-HB-Tablet-160x600-D-2-b  | 1         |
      | zone-zoneset-HB-See-Through-1X2-D-2-a | 1         |
      | zone-zoneset-HB-See-Through-1X2-D-2-b | 1         |
      | zone-zoneset-HB-Tablet-160x600-D-3-a  | 1         |
      | zone-zoneset-HB-Tablet-160x600-D-3-b  | 1         |
      | zone-zoneset-HB-See-Through-1X2-D-3-a | 1         |
      | zone-zoneset-HB-See-Through-1X2-D-3-b | 1         |
      | zone-zoneset-HB-Tablet-160x600-D-4-a  | 1         |
      | zone-zoneset-HB-Tablet-160x600-D-4-b  | 1         |
      | zone-zoneset-HB-See-Through-1X2-D-4-a | 1         |
      | zone-zoneset-HB-See-Through-1X2-D-4-b | 1         |
      | zone-zoneset-HB-SS-1X1-D-1            | 1         |
      | zone-zoneset-HB-SS-1X1-D-2            | 1         |


  @DT
  Scenario: create entities for DT tests
    Given i disable campaigns by name on db
      | Campaign Name          |
      | campaign-DT-SS-1-t-1   |
      | campaign-DT-SI-2-t-1   |
      | campaign-DT-SI-1-t-1   |
      | campaign-DT-SI-2-t-1   |
      | campaign-DT-PGC-2-t-1  |
      | campaign-DT-SS-1-t-2   |
      | campaign-DT-SI-2-t-2   |
      | campaign-DT-PGC-3-t-2  |
      | campaign-DT-SI-1-t-3-L |
      | campaign-DT-SI-2-t-3   |
    Given i create new campaigns with new zoneset
      | Campaign Name          | IO    | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name         | limitation        | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-DT-SS-1-t-1   | 75396 | 197418   | false                 | 86            | {zone-zoneset-DT-SS-t-1}   | []                | 69       | 14401          | 3674         | 64397           |
      | campaign-DT-SS-2-t-1   | 75396 | 197418   | false                 | 86            | {zone-zoneset-DT-SS-t-1}   | []                | 69       | 14401          | 3674         | 64397           |
      | campaign-DT-SI-1-t-1   | 75396 | 211456   | false                 | 210           | {zone-zoneset-DT-SI-t-1}   | []                | 61       | 14401          | 3674         | 64398           |
      | campaign-DT-SI-2-t-1   | 75396 | 211456   | false                 | 210           | {zone-zoneset-DT-SI-t-1}   | []                | 61       | 14401          | 3674         | 64398           |
      | campaign-DT-PGC-2-t-1  | 75396 | 222908   | false                 | 1068          | {zone-zoneset-DT-PGC-t-1}  | []                | 75       | 14401          | 3674         | 64399           |
      | campaign-DT-SS-1-t-2   | 75396 | 197418   | false                 | 86            | {zone-zoneset-DT-SS-t-2}   | []                | 69       | 14402          | 3666         | 64400           |
      | campaign-DT-SI-2-t-2   | 75396 | 211456   | false                 | 210           | {zone-zoneset-DT-SI-t-2}   | []                | 61       | 14402          | 3666         | 64401           |
      | campaign-DT-PGC-3-t-2  | 75396 | 222908   | false                 | 1068          | {zone-zoneset-DT-PGC-t-2}  | []                | 75       | 14402          | 3666         | 64402           |
      | campaign-DT-SI-1-t-3-L | 75396 | 211456   | false                 | 210           | {zone-zoneset-DT-SI-t-3-L} | [[[5,"=~","af"]]] | 61       | 14403          | 3675         | 64403           |
      | campaign-DT-SI-2-t-3   | 75396 | 211456   | false                 | 210           | {zone-zoneset-DT-SI-t-3}   | []                | 61       | 14403          | 3675         | 64403           |
    And i update campaign data by name
      | Campaign Name          | Priority | campaign_delivery_method |
      | campaign-DT-SS-1-t-1   | -2       | 1                        |
      | campaign-DT-SI-2-t-1   | -1       | 2                        |
      | campaign-DT-SI-1-t-1   | -2       | 1                        |
      | campaign-DT-SI-2-t-1   | -1       | 2                        |
      | campaign-DT-PGC-2-t-1  | -1       | 2                        |
      | campaign-DT-SS-1-t-2   | -2       | 1                        |
      | campaign-DT-SI-2-t-2   | -1       | 2                        |
      | campaign-DT-PGC-3-t-2  | 1        | 4                        |
      | campaign-DT-SI-1-t-3-L | -2       | 1                        |
      | campaign-DT-SI-2-t-3   | -1       | 2                        |
    And i update zone data by name
      | Zone Name                | is_secure |
      | zone-zoneset-DT-SS-t-1   | 1         |
      | zone-zoneset-DT-SI-t-1   | 1         |
      | zone-zoneset-DT-PGC-t-1  | 1         |
      | zone-zoneset-DT-SS-t-2   | 1         |
      | zone-zoneset-DT-SI-t-2   | 1         |
      | zone-zoneset-DT-PGC-t-2  | 1         |
      | zone-zoneset-DT-SI-t-3-L | 1         |
      | zone-zoneset-DT-SI-t-3   | 1         |

  @GDPR
  @DT
  Scenario: create entities for DT inline tests
    Given i disable campaigns by name on db
      | Campaign Name            |
      | Campaign Name            |
      | campaign-DT-Inline-ST-1  |
      | campaign-DT-Inline-ST-2  |
      | campaign-DT-Inline-SS-1  |
      | campaign-DT-Inline-PGC-2 |
      | campaign-DT-Inline-SS-3  |
    Given i create new campaigns with new zoneset
      | Campaign Name            | IO    | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name            | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-DT-Inline-ST-1  | 75396 | 210722   | false                 | 204           | {zone-zoneset-DT-inline-ST}   | []         | 83       | 14470          | 3690         | 65422           |
      | campaign-DT-Inline-ST-2  | 75396 | 210722   | false                 | 204           | {zone-zoneset-DT-inline-ST}   | []         | 83       | 14470          | 3690         | 65422           |
      | campaign-DT-Inline-SS-1  | 75396 | 197418   | false                 | 86            | {zone-zoneset-DT-inline-SS-1} | []         | 69       | 14470          | 3690         | 65423           |
      | campaign-DT-Inline-SS-3  | 75396 | 197418   | false                 | 86            | {zone-zoneset-DT-inline-SS-3} | []         | 69       | 14470          | 3690         | 65423           |
      | campaign-DT-Inline-PGC-2 | 75396 | 222908   | false                 | 1068          | {zone-zoneset-DT-inline-PGC}  | []         | 75       | 14470          | 3690         | 65424           |
    And i update campaign data by name
      | Campaign Name            | Priority | campaign_delivery_method |
      | campaign-DT-Inline-ST-1  | -2       | 1                        |
      | campaign-DT-Inline-ST-2  | -1       | 2                        |
      | campaign-DT-Inline-SS-1  | -2       | 1                        |
      | campaign-DT-Inline-PGC-2 | -1       | 2                        |
      | campaign-DT-Inline-SS-3  | 1        | 4                        |
    And i update zone data by name
      | Zone Name                   | is_secure |
      | zone-zoneset-DT-inline-ST   | 1         |
      | zone-zoneset-DT-inline-SS-1 | 1         |
      | zone-zoneset-DT-inline-SS-3 | 1         |
      | zone-zoneset-DT-inline-PGC  | 1         |
    And I flush bucket name {us-east-1-adserver} on couchbase


  @GDPR
  @appnexus
  Scenario: create entities for server programmatic tests
    Given i disable campaigns by name on db
      | Campaign Name                   |
      | campaign-server-prog-SS-1       |
      | campaign-server-prog-SS-2       |
      | campaign-server-prog-SS-3       |
      | campaign-server-prog-SS-4       |
      | campaign-server-prog-PGC-1      |
      | campaign-server-prog-PGC-2      |
      | campaign-server-prog-PGC-3      |
      | campaign-server-prog-PGC-4      |
      | campaign-server-prog-ST-1       |
      | campaign-server-prog-ST-2       |
      | campaign-server-prog-ST-3       |
      | campaign-server-prog-ST-4       |
#     InApp Burl
      | campaign-server-prog-inApp-ST-1 |
#     multiple bids
#      |campaign-server-prog-MultiBids-SS-1 |
#      |campaign-server-prog-MultiBids-ST-2 |
    Given i create new campaigns with new zoneset
      | Campaign Name                   | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                 | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-server-prog-SS-1       | 407981 | 228962   | true                  | 17            | {zone-zoneset-server-prog-SS}       | []         | 69       | 2164           | 3711         | 66556           |
      | campaign-server-prog-SS-2       | 407981 | 224531   | true                  | 18            | {zone-zoneset-server-prog-SS}       | []         | 69       | 2164           | 3711         | 66556           |
      | campaign-server-prog-SS-3       | 75396  | 197418   | false                 | 86            | {zone-zoneset-server-prog-SS}       | []         | 69       | 2164           | 3711         | 66556           |
      | campaign-server-prog-SS-4       | 407981 | 224531   | true                  | 19            | {zone-zoneset-server-prog-SS}       | []         | 69       | 2164           | 3711         | 66556           |
      | campaign-server-prog-PGC-1      | 407981 | 224530   | true                  | 20            | {zone-zoneset-server-prog-PGC}      | []         | 75       | 2164           | 3711         | 66557           |
      | campaign-server-prog-PGC-2      | 407981 | 228961   | true                  | 21            | {zone-zoneset-server-prog-PGC}      | []         | 75       | 2164           | 3711         | 66557           |
      | campaign-server-prog-PGC-3      | 407981 | 224530   | true                  | 22            | {zone-zoneset-server-prog-PGC}      | []         | 75       | 2164           | 3711         | 66557           |
      | campaign-server-prog-PGC-4      | 407981 | 228961   | true                  | 23            | {zone-zoneset-server-prog-PGC}      | []         | 75       | 2164           | 3711         | 66557           |
      | campaign-server-prog-ST-1       | 407981 | 229737   | true                  | 24            | {zone-zoneset-server-prog-ST}       | []         | 83       | 2164           | 3711         | 66555           |
      | campaign-server-prog-ST-2       | 407981 | 224533   | true                  | 31            | {zone-zoneset-server-prog-ST}       | []         | 83       | 2164           | 3711         | 66555           |
      | campaign-server-prog-ST-3       | 407981 | 229737   | true                  | 32            | {zone-zoneset-server-prog-ST}       | []         | 83       | 2164           | 3711         | 66555           |
      | campaign-server-prog-ST-4       | 407981 | 224533   | true                  | 33            | {zone-zoneset-server-prog-ST}       | []         | 83       | 2164           | 3711         | 66555           |
      #     InApp Burl
      | campaign-server-prog-inApp-ST-1 | 407981 | 224533   | true                  | 33            | {zone-zoneset-server-prog-inApp-ST} | []         | 83       | 2164           | 3711         | 66555           |
##     multiple bids
#      |campaign-server-prog-MultiBids-SS-1  |407981        |243452     |true                  |1719               |{zone-zoneset-server-prog-MultiBids-SS-1}           |[]           |69        |15176              |3711           |66556             |
#      |campaign-server-prog-MultiBids-ST-2  |407981        |229737     |true                  |1720               |{zone-zoneset-server-prog-MultiBids-ST-2}           |[]           |83        |15177              |3711           |66555             |
    And i update campaign data by name
      | Campaign Name                   | Priority | campaign_delivery_method | delivery_algorithm | run_on_unknown_domains |
      | campaign-server-prog-SS-1       | -2       | 1                        | 4                  | 1                      |
      | campaign-server-prog-SS-2       | -1       | 2                        | 3                  | 1                      |
      | campaign-server-prog-SS-3       | 1        | 4                        | 2                  | 1                      |
      | campaign-server-prog-SS-4       | 1        | 4                        | 1                  | 1                      |
      | campaign-server-prog-PGC-1      | -2       | 1                        | 4                  | 1                      |
      | campaign-server-prog-PGC-2      | -1       | 2                        | 3                  | 1                      |
      | campaign-server-prog-PGC-3      | 1        | 4                        | 2                  | 1                      |
      | campaign-server-prog-PGC-4      | 1        | 4                        | 1                  | 1                      |
      | campaign-server-prog-ST-1       | -2       | 1                        | 4                  | 1                      |
      | campaign-server-prog-ST-2       | -1       | 2                        | 3                  | 1                      |
      | campaign-server-prog-ST-3       | 1        | 4                        | 2                  | 1                      |
      | campaign-server-prog-ST-4       | 1        | 4                        | 1                  | 1                      |
      #     InApp Burl
      | campaign-server-prog-inApp-ST-1 | 1        | 4                        | 1                  | 1                      |
    And i update zone data by name
      | Zone Name                    | is_secure |
      | zone-zoneset-server-prog-SS  | 1         |
      | zone-zoneset-server-prog-PGC | 1         |
      | zone-zoneset-server-prog-ST  | 1         |
#     |zone-zoneset-server-prog-MultiBids-SS-1     |1            |
#     |zone-zoneset-server-prog-MultiBids-ST-2      |1            |
#     Given i sent an analize req to peer39 for the following website = {https://www.bbc.com/sport}


    Given i create new campaigns with new zoneset
      | Campaign Name       | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name       | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-Inapp-SI-1 | 75396 | 241783   | false                 | 14619         | {zone-zoneset-Inapp-SI-1} | []         | 80       | 5164           | 2546         | 67259           |
#      |campaign-Inapp-SI-1       |75396         |241783     |false                  |14619             |{zone-zoneset-Inapp-SI-1}     |[]           |80        |5164             |2546           |?             |
      | campaign-Inapp-SI-2 | 75396 | 241783   | false                 | 14620         | {zone-zoneset-Inapp-SI-2} | []         | 80       | 5164           | 2546         | 67259           |
#      |campaign-Inapp-SI-2       |75396         |241783     |false                  |14620             |{zone-zoneset-Inapp-SI-2}     |[]           |80        |5164             |2546           |?             |
      | campaign-Inapp-SI-3 | 75396 | 241783   | false                 | 14621         | {zone-zoneset-Inapp-SI-3} | []         | 80       | 5164           | 2546         | 67259           |
#      |campaign-Inapp-SI-3       |75396         |241783     |false                  |14621             |{zone-zoneset-Inapp-SI-3}     |[]           |80        |5164             |2546           |?             |
      | campaign-Inapp-SI-4 | 75396 | 241783   | false                 | 14451         | {zone-zoneset-Inapp-SI-4} | []         | 80       | 5164           | 2546         | 67259           |
#      |campaign-Inapp-SI-4       |75396         |241783     |false                  |14451             |{zone-zoneset-Inapp-SI-4}     |[]           |80        |5164             |2546           |?             |
      | campaign-Inapp-SI-5 | 75396 | 241783   | false                 | 14621         | {zone-zoneset-Inapp-SI-5} | []         | 80       | 10138          | 3585         | 67260           |
#      |campaign-Inapp-SI-5       |75396         |241783     |false                  |14621             |{zone-zoneset-Inapp-SI-5}     |[]           |80        |10138            |3585           |?             |
      | campaign-Inapp-SI-6 | 75396 | 241783   | false                 | 14621         | {zone-zoneset-Inapp-SI-6} | []         | 80       | 8803           | 3586         | 67260           |
#      |campaign-Inapp-SI-6       |75396         |241783     |false                  |14621            |{zone-zoneset-Inapp-SI-6}     |[]           |80        |8803             |3586           |?             |

    And i update campaign data by name
      | Campaign Name       | Priority | campaign_delivery_method | delivery_algorithm |
      | campaign-Inapp-SI-1 | -2       | 1                        | 4                  |
      | campaign-Inapp-SI-2 | -1       | 2                        | 3                  |
      | campaign-Inapp-SI-3 | -1       | 2                        | 3                  |
      | campaign-Inapp-SI-4 | -1       | 2                        | 3                  |
      | campaign-Inapp-SI-5 | -1       | 2                        | 3                  |
      | campaign-Inapp-SI-6 | -1       | 2                        | 3                  |

    And i update zone data by name
      | Zone Name               | is_mraid |
      | zone-zoneset-Inapp-SI-1 | 1        |
      | zone-zoneset-Inapp-SI-2 | 1        |
      | zone-zoneset-Inapp-SI-3 | 1        |
      | zone-zoneset-Inapp-SI-4 | 1        |
      | zone-zoneset-Inapp-SI-5 | 1        |
      | zone-zoneset-Inapp-SI-6 | 1        |
    And i update zone data by name
      | Zone Name               | is_secure |
      | zone-zoneset-Inapp-SI-1 | 1         |
      | zone-zoneset-Inapp-SI-2 | 1         |
      | zone-zoneset-Inapp-SI-3 | 1         |
      | zone-zoneset-Inapp-SI-4 | 1         |
      | zone-zoneset-Inapp-SI-5 | 1         |
      | zone-zoneset-Inapp-SI-6 | 1         |

  @InAppBlackWhiteList
  Scenario: create entities for Black and white app listu
    Given i disable campaigns by name on db
      | Campaign Name                     |
      | campaign-InappBlackWhiteList-SI-1 |
      | campaign-InappBlackWhiteList-SI-2 |
      | campaign-InappBlackWhiteList-SI-3 |
      | campaign-InappBlackWhiteList-SI-4 |
      | campaign-InappBlackWhiteList-SI-5 |
      | campaign-InappBlackWhiteList-SI-6 |
      | campaign-InappBlackWhiteList-SI-7 |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name                     | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                     | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include                  | app_exclude                  |
      | campaign-InappBlackWhiteList-SI-1 | 75396 | 241783   | false                 | 14619         | {zone-zoneset-InappBlackWhiteList-SI-1} | []         | 80       | 15300          | 1111         | 67261           | [{app1,2}]                   | [{app2,2}]                   |
      | campaign-InappBlackWhiteList-SI-2 | 75396 | 241783   | false                 | 14619         | {zone-zoneset-InappBlackWhiteList-SI-2} | []         | 80       | 15300          | 1111         | 67261           | []                           | [{app2,2}]                   |
      | campaign-InappBlackWhiteList-SI-3 | 75396 | 241783   | false                 | 14619         | {zone-zoneset-InappBlackWhiteList-SI-3} | []         | 80       | 15300          | 1111         | 67261           | [{app1,2}]                   | []                           |
      | campaign-InappBlackWhiteList-SI-4 | 75396 | 241783   | false                 | 14619         | {zone-zoneset-InappBlackWhiteList-SI-4} | []         | 80       | 15300          | 1111         | 67261           | [{app1,2}]                   | [{app1,2}]                   |
      | campaign-InappBlackWhiteList-SI-5 | 75396 | 241783   | false                 | 14619         | {zone-zoneset-InappBlackWhiteList-SI-5} | []         | 80       | 15300          | 1111         | 67261           | []                           | []                           |
      | campaign-InappBlackWhiteList-SI-6 | 75396 | 241783   | false                 | 14619         | {zone-zoneset-InappBlackWhiteList-SI-6} | []         | 80       | 15300          | 1111         | 67261           | []                           | [{app1,2};{app2,2};{app3,2}] |
      | campaign-InappBlackWhiteList-SI-7 | 75396 | 241783   | false                 | 14619         | {zone-zoneset-InappBlackWhiteList-SI-7} | []         | 80       | 15300          | 1111         | 67261           | [{app1,2};{app2,2};{app3,2}] | []                           |
    And i update zone data by name
      | Zone Name                             | is_mraid |
      | zone-zoneset-InappBlackWhiteList-SI-1 | 1        |
      | zone-zoneset-InappBlackWhiteList-SI-2 | 1        |
      | zone-zoneset-InappBlackWhiteList-SI-3 | 1        |
      | zone-zoneset-InappBlackWhiteList-SI-4 | 1        |
      | zone-zoneset-InappBlackWhiteList-SI-5 | 1        |
      | zone-zoneset-InappBlackWhiteList-SI-6 | 1        |
      | zone-zoneset-InappBlackWhiteList-SI-7 | 1        |
    And i update zone data by name
      | Zone Name                             | is_secure |
      | zone-zoneset-InappBlackWhiteList-SI-1 | 1         |
      | zone-zoneset-InappBlackWhiteList-SI-2 | 1         |
      | zone-zoneset-InappBlackWhiteList-SI-3 | 1         |
      | zone-zoneset-InappBlackWhiteList-SI-4 | 1         |
      | zone-zoneset-InappBlackWhiteList-SI-5 | 1         |
      | zone-zoneset-InappBlackWhiteList-SI-6 | 1         |
      | zone-zoneset-InappBlackWhiteList-SI-7 | 1         |


  @DynamicPricing
  Scenario: create entities for dynamic pricing
    Given i disable campaigns by name on db
      | Campaign Name                      |
      | campaign-DP-Direct-300X250-2       |
      | campaign-DP-Direct-300X250-1       |
      | campaign-DP-ProgG-SS-1X1-2         |
      | campaign-DP-ProgG-SS-1X1-1         |
      | campaign-DP-ProgNG-ST-1X2-2        |
      | campaign-DP-ProgNG-ST-1X2-1        |
      | campaign-DP-ClientProg-970X250-P-2 |
      | campaign-DP-ClientProg-970X250-P-1 |
      | campaign-DP-ClientProg-970X250-D   |
    Given i create new campaigns with new zoneset
      | Campaign Name                      | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                      | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-DP-Direct-300X250-1       | 75396  | 234550   | false                 | 85            | {zone-zoneset-DP-Direct-300X250-1}       | []         | 10       | 14862          | 3728         | 66833           |
#PROD |campaign-DP-Direct-300X250-1       |75396         |234656     |false                  |85                |{zone-zoneset-DP-Direct-300X250-1}        |[]          |10        |14877              |3728           |66833            |
      | campaign-DP-Direct-300X250-2       | 75396  | 234550   | false                 | 85            | {zone-zoneset-DP-Direct-300X250-2}       | []         | 10       | 14862          | 3728         | 66833           |
#PROD |campaign-DP-Direct-300X250-2       |75396         |234656     |false                  |85                |{zone-zoneset-DP-Direct-300X250-2}        |[]          |10        |14877              |3728           |66833            |
      | campaign-DP-ProgG-SS-1X1-1         | 407981 | 228962   | true                  | 17            | {zone-zoneset-DP-ProgG-SS-1X1-1}         | []         | 69       | 14862          | 3728         | 66831           |
#PROD  |campaign-DP-ProgG-SS-1X1-1         |407981        |228962     |true                   |17                |{zone-zoneset-DP-ProgG-SS-1X1-1}          |[]          |69        |14877              |3728           |66831            |
      | campaign-DP-ProgG-SS-1X1-2         | 407981 | 228962   | true                  | 17            | {zone-zoneset-DP-ProgG-SS-1X1-2}         | []         | 69       | 14862          | 3728         | 66831           |
#PROD  |campaign-DP-ProgG-SS-1X1-2         |407981        |228962     |true                   |17                |{zone-zoneset-DP-ProgG-SS-1X1-2}          |[]          |69        |14877              |3728           |66831            |
      | campaign-DP-ProgNG-ST-1X2-1        | 407981 | 224533   | true                  | 33            | {zone-zoneset-DP-ProgNG-ST-1X2-1}        | []         | 83       | 14862          | 3728         | 66830           |
#PROD  |campaign-DP-ProgNG-ST-1X2-1        |407981        |224533     |true                   |33                |{zone-zoneset-DP-ProgNG-ST-1X2-1}         |[]          |83        |14877              |3728           |66830            |
      | campaign-DP-ProgNG-ST-1X2-2        | 407981 | 224533   | true                  | 33            | {zone-zoneset-DP-ProgNG-ST-1X2-2}        | []         | 83       | 14862          | 3728         | 66830           |
#PROD  |campaign-DP-ProgNG-ST-1X2-2        |407981        |224533     |true                   |33                |{zone-zoneset-DP-ProgNG-ST-1X2-2}         |[]          |83        |14877              |3728           |66830            |
      | campaign-DP-ClientProg-970X250-P-1 | 407981 | 224539   | false                 | 7143          | {zone-zoneset-DP-ClientProg-970X250-P-1} | []         | 58       | 14862          | 3728         | 67182           |
#PROD |campaign-DP-ClientProg-970X250-P-1 |407981        |224539     |false                  |7143              |{zone-zoneset-DP-ClientProg-970X250-P-1}  |[]          |58        |14877              |3728           |67231            |
      | campaign-DP-ClientProg-970X250-P-2 | 407981 | 224539   | false                 | 7143          | {zone-zoneset-DP-ClientProg-970X250-P-2} | []         | 58       | 14862          | 3728         | 67182           |
#PROD |campaign-DP-ClientProg-970X250-P-2 |407981        |224539     |false                  |7143              |{zone-zoneset-DP-ClientProg-970X250-P-2}  |[]          |58        |14877              |3728           |67231            |
      | campaign-DP-ClientProg-970X250-D   | 75396  | 198082   | false                 | 64            | {zone-zoneset-DP-ClientProg-970X250-D}   | []         | 58       | 14862          | 3728         | 67182           |
#PROD |campaign-DP-ClientProg-970X250-D   |75396         |198082     |false                  |64                |{zone-zoneset-DP-ClientProg-970X250-D}    |[]          |58        |14877              |3728           |67231            |
    And i update campaign data by name
      | Campaign Name                      | Priority | campaign_delivery_method | delivery_algorithm |
      | campaign-DP-Direct-300X250-2       | -2       | 1                        | 4                  |
      | campaign-DP-Direct-300X250-1       | -1       | 2                        | 3                  |
      | campaign-DP-ProgG-SS-1X1-2         | -2       | 1                        | 4                  |
      | campaign-DP-ProgG-SS-1X1-1         | -1       | 2                        | 3                  |
      | campaign-DP-ProgNG-ST-1X2-2        | -2       | 1                        | 4                  |
      | campaign-DP-ProgNG-ST-1X2-1        | -1       | 2                        | 3                  |
      | campaign-DP-ClientProg-970X250-P-2 | -2       | 1                        | 4                  |
      | campaign-DP-ClientProg-970X250-P-1 | -1       | 2                        | 3                  |
      | campaign-DP-ClientProg-970X250-D   | 1        | 4                        | 2                  |

  @PLT
  Scenario: create entities for Persona Level Targeting test
    Given i disable campaigns by name on db
      | Campaign Name                 |
      | campaign-PLT-NotPersonaL-ST-1 |
      | campaign-PLT-YesPersonaL-ST-1 |
      | campaign-PLT-YesPersonaL-ST-2 |
    Given i create new campaigns with new zoneset
      | Campaign Name                 | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                 | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-PLT-NotPersonaL-ST-1 | 75396 | 210722   | false                 | 8158          | {zone-zoneset-PLT-NotPersonaL-ST-1} | []         | 93       | 15132          | 3708         | 67638           |
      | campaign-PLT-YesPersonaL-ST-1 | 75396 | 210722   | false                 | 8158          | {zone-zoneset-PLT-YesPersonaL-ST-1} | []         | 93       | 15131          | 3708         | 67638           |
      | campaign-PLT-YesPersonaL-ST-2 | 75396 | 210722   | false                 | 8158          | {zone-zoneset-PLT-YesPersonaL-ST-2} | []         | 93       | 15131          | 3708         | 67638           |
    And i update campaign data by name
      | Campaign Name                 | is_persona_targeting |
      | campaign-PLT-NotPersonaL-ST-1 | 0                    |
      | campaign-PLT-YesPersonaL-ST-1 | 1                    |
      | campaign-PLT-YesPersonaL-ST-2 | 1                    |
    And i update banner data by name
      | Banner Name                            | limitation                            |
      | campaign-PLT-NotPersonaL-ST-1-banner-1 | [[[4,"==",1,1,456],[4,"==",1,1,123]]] |
      | campaign-PLT-YesPersonaL-ST-1-banner-1 | [[[4,"==",1,1,456],[4,"==",1,1,123]]] |
      | campaign-PLT-YesPersonaL-ST-2-banner-1 | [[[4,"==",1,1,123]]]                  |
    And i update zone data by name
      | Zone Name                         | is_secure |
      | zone-zoneset-PLT-NotPersonaL-ST-1 | 1         |
      | zone-zoneset-PLT-YesPersonaL-ST-1 | 1         |
      | zone-zoneset-PLT-YesPersonaL-ST-2 | 1         |

  @falseDomain
  Scenario: create entities for false domain feature
    Given i disable campaigns by name on db
      | Campaign Name                            |
      | campaign-YesRunFalseDomain-69-1          |
      | campaign-YesRunFalseDomainInclude-ST-2   |
      | campaign-NoRunFalseDomainInclude-92-3    |
      | campaign-YesRunFalseDomainExclude-ST-4   |
      | campaign-YesRunFalseDomainExclude-10-5   |
      | campaign-YesRunFalseDomainBothLists-ST-6 |
      | campaign-NoRunFalseDomainBothLists-ST-7  |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name                            | IO    | LineItem | isServerProgrammatic? | Creative | Zonesets-zones Name                            | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include                | domain_exclude                 |
      | campaign-YesRunFalseDomain-69-1          | 75396 | 197418   | false                 | 86       | {zone-zoneset-YesRunFalseDomain-69-1}          | []         | 69       | 15160          | 3673         | 66933           | []                            | []                             |
      | campaign-YesRunFalseDomainInclude-ST-2   | 75396 | 210722   | false                 | 8158     | {zone-zoneset-YesRunFalseDomainInclude-ST-2}   | []         | 93       | 15160          | 3673         | 64396           | [{includeFalseDomain.test,1}] | []                             |
      | campaign-NoRunFalseDomainInclude-92-3    | 75396 | 222908   | false                 | 14488    | {zone-zoneset-NoRunFalseDomainInclude-92-3}    | []         | 92       | 15160          | 3673         | 67165           | [{includeFalseDomain.test,1}] | []                             |
      | campaign-YesRunFalseDomainExclude-ST-4   | 75396 | 210722   | false                 | 8158     | {zone-zoneset-YesRunFalseDomainExclude-ST-4}   | []         | 93       | 15160          | 3673         | 64396           | []                            | [{daniellafalsedomain.test,1}] |
      | campaign-YesRunFalseDomainExclude-10-5   | 75396 | 240827   | false                 | 85       | {zone-zoneset-YesRunFalseDomainExclude-10-5}   | []         | 10       | 15160          | 3673         | 66814           | []                            | [{daniellafalsedomain.test,1}] |
      | campaign-YesRunFalseDomainBothLists-ST-6 | 75396 | 210722   | false                 | 8158     | {zone-zoneset-YesRunFalseDomainBothLists-ST-6} | []         | 93       | 15160          | 3673         | 64396           | [{includeFalseDomain.test,1}] | [{daniellafalsedomain.test,1}] |
      | campaign-NoRunFalseDomainBothLists-ST-7  | 75396 | 210722   | false                 | 8158     | {zone-zoneset-NoRunFalseDomainBothLists-ST-7}  | []         | 93       | 15160          | 3673         | 64396           | [{includeFalseDomain.test,1}] | [{daniellafalsedomain.test,1}] |
    And i update campaign data by name
      | Campaign Name                            | run_on_unknown_domains |
      | campaign-YesRunFalseDomain-69-1          | 1                      |
      | campaign-YesRunFalseDomainInclude-ST-2   | 1                      |
      | campaign-NoRunFalseDomainInclude-92-3    | 0                      |
      | campaign-YesRunFalseDomainExclude-ST-4   | 1                      |
      | campaign-YesRunFalseDomainExclude-10-5   | 1                      |
      | campaign-YesRunFalseDomainBothLists-ST-6 | 1                      |
      | campaign-NoRunFalseDomainBothLists-ST-7  | 0                      |


  @wurfl

  Scenario: create entities for peer39 and wurfl feature
    Given i disable campaigns by name on db
      | Campaign Name    |
      | campaign-CT-ST-1 |
      | campaign-CT-ST-2 |
      | campaign-WL-ST-2 |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name    | IO    | LineItem | isServerProgrammatic? | Creative | Zonesets-zones Name    | limitation           | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-CT-ST-1 | 75396 | 210722   | false                 | 8290     | {zone-zoneset-CT-ST-1} | []                   | 93       | 15182          | 3708         | 65991           | []             | []             |
      | campaign-CT-ST-2 | 75396 | 210722   | false                 | 8290     | {zone-zoneset-CT-ST-2} | []                   | 93       | 15182          | 3708         | 65991           | []             | []             |
      | campaign-WL-ST-2 | 75396 | 210722   | false                 | 8290     | {zone-zoneset-WL-ST-2} | [[[32,"==",201211]]] | 93       | 15183          | 3708         | 65991           | []             | []             |
    And i update banner data by name
      | Banner Name               | limitation                                |
      | campaign-CT-ST-1-banner-1 | [[[26,"=~",7541],[26,"=~",7531]]]         |
      | campaign-CT-ST-2-banner-1 | [[[64,"=~","1_7541"],[64,"=~","1_7531"]]] |
      | campaign-WL-ST-2-banner-1 | [[[39,"=~","Windows"],[41,"=~","Chrome"]  |


  Scenario:  create entites for vidAd
    Given i disable campaigns by name on db
      | Campaign Name     |
      | campaign-TN       |
      | campaign-vidAd-SP |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name     | IO     | LineItem | isServerProgrammatic? | Creative | Zonesets-zones Name     | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-TN       | 75396  | 243707   | false                 | 21638    | {zone-zoneset-TN}       | []         | 97       | 15196          | 3708         | 68927           | []             | []             |
      | campaign-vidAd-SP | 407981 | 243711   | true                  | 568      | {zone-zoneset-vidAd-SP} | []         | 97       | 15292          | 3708         | 68927           | []             | []             |
    And i update campaign data by name
      | Campaign Name     | Priority |
      | campaign-TN       | -1       |
      | campaign-vidAd-SP | -2       |

  @PG1
  Scenario: create entities for PG1 tests
    Given i disable campaigns by name on db
      | Campaign Name                   |
      | campaign-PG1-Desktop-limited    |
      | campaign-PG1-Desktop            |
      | campaign-PG1-Smartphone-limited |
      | campaign-PG1-Smartphone         |
      | campaign-PG1-Tablet-limited     |
      | campaign-PG1-Tablet             |
    Given i create new zone named {zone-zoneset-PG1-1-allowed} with limitation {[]} with adUnitId 92 and web_section id 14402 with affiliateId 3666 with po_line_item_id 67001
    And i create new zone named {zone-zoneset-PG1-2} with limitation {[]} with adUnitId 92 and web_section id 14403 with affiliateId 3675 with po_line_item_id 67002
    Given i create new zone named {zone-zoneset-ST-1} with limitation {[]} with adUnitId 93 and web_section id 14402 with affiliateId 3666 with po_line_item_id 66997
    And i create new zone named {zone-zoneset-ST-2} with limitation {[]} with adUnitId 93 and web_section id 14403 with affiliateId 3675 with po_line_item_id 67000
#    Given i create new zone named {zone-zoneset-PG1-5-allowed} with limitation {[]} with adUnitId 92 and web_section id 14402 with affiliateId 3666 with po_line_item_id 67001
#    And i create new zone named {zone-zoneset-PG1-6} with limitation {[]} with adUnitId 92 and web_section id 14403 with affiliateId 3675 with po_line_item_id 67000
    Given i create new campaigns with new zoneset
      | Campaign Name                | IO    | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name                              |
      | campaign-PG1-Desktop-limited | 75396 | 222908   | false                 | 24315         | {zone-zoneset-PG1-1-allowed,zone-zoneset-PG1-2} |
      | campaign-ST1-Desktop         | 75396 | 210722   | false                 | 22538         | {zone-zoneset-ST-1,zone-zoneset-ST-2}           |
#      |campaign-PG1-Smartphone-limited     |75396         |210722     |false                  |14610           |{zone-zoneset-PG1-3-allowed,zone-zoneset-PG1-4} |
#      |campaign-PG1-Smartphone             |75396         |210722     |false                  |204             |{zone-zoneset-PG1-3-allowed,zone-zoneset-PG1-4} |
#      |campaign-PG1-Tablet-limited         |75396         |210722     |false                  |14611           |{zone-zoneset-PG1-5-allowed,zone-zoneset-PG1-6} |
#      |campaign-PG1-Tablet                 |75396         |210722     |false                  |204             |{zone-zoneset-PG1-5-allowed,zone-zoneset-PG1-6} |
    And i update campaign data by name
      | Campaign Name                | Priority | campaign_delivery_method | delivery_algorithm |
      | campaign-PG1-Desktop-limited | -2       | 1                        | 4                  |
      | campaign-ST1-Desktop         | -1       | 2                        | 3                  |
#      |campaign-PG1-Smartphone-limited   |-2            |1                       |4                 |
#      |campaign-PG1-Smartphone           |-1            |2                       |3                 |
#      |campaign-PG1-Tablet-limited       |-2            |1                       |4                 |
#      |campaign-PG1-Tablet               |-1            |2                       |3                 |
    And i update banner data by name
      | Banner Name                           | limitation      |
      | campaign-PG1-Desktop-limited-banner-1 | [[[51,"==",1]]] |
#      |campaign-ST1-Desktop-banner-1          |[[[51,"==",1]]]  |
    And i update zone data by name
      | Zone Name                  | is_secure |
      | zone-zoneset-PG1-1-allowed | 1         |
      | zone-zoneset-PG1-2         | 1         |
      | zone-zoneset-ST-1          | 1         |
      | zone-zoneset-ST-2          | 1         |
#      |zone-zoneset-PG1-5-allowed   |1            |
#      |zone-zoneset-PG1-6           |1            |

  @PGX
  Scenario: create entities for PGX tests
    Given i disable campaigns by name on db
      | Campaign Name       |
      | campaign-PGX-PG-1-a |
      | campaign-PGX-ST-1-a |
      | campaign-PGX-PG-1-b |
      | campaign-PGX-PG-1-c |
    Given i create new campaigns with new zoneset
      | Campaign Name       | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name       | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-PGX-PG-1-a | 75396 | 222908   | false                 | 14488         | {zone-zoneset-PGX-PG-1-a} | []         | 92       | 14852          | 3739         | 67163           |
      | campaign-PGX-ST-1-a | 75396 | 210722   | false                 | 204           | {zone-zoneset-PGX-ST-1-a} | []         | 83       | 14852          | 3739         | 67162           |
      | campaign-PGX-PG-1-b | 75396 | 222908   | false                 | 14488         | {zone-zoneset-PGX-PG-1-b} | []         | 92       | 14400          | 3673         | 67165           |
      | campaign-PGX-PG-1-c | 75396 | 222908   | false                 | 14488         | {zone-zoneset-PGX-PG-1-c} | []         | 92       | 2080           | 3728         | 67166           |
    And i update campaign data by name
      | Campaign Name       | Priority | campaign_delivery_method |
      | campaign-PGX-PG-1-b | 1        | 4                        |
      | campaign-PGX-PG-1-c | 1        | 4                        |
    And i update zone data by name
      | Zone Name               | is_secure |
      | zone-zoneset-PGX-PG-1-a | 1         |
      | zone-zoneset-PGX-ST-1-a | 1         |
      | zone-zoneset-PGX-PG-1-b | 1         |
      | zone-zoneset-PGX-PG-1-c | 1         |

  Scenario: create entities for line item level persona level frequency capping
    Given i disable campaigns by name on db
      | Campaign Name       |
      | campaign-LI-FC-ST-1 |
      | campaign-LI-FC-ST-2 |
    Given i create new campaigns with new zoneset
#      first is Inapp
      | Campaign Name       | IO    | LineItem | isServerProgrammatic? | Deal\  Creative | Zonesets-zones Name       | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-LI-FC-ST-1 | 75396 | 244895   | false                 | 8290            | {zone-zoneset-LI-FC-ST-1} | []         | 93       | 15220          | 3708         | 65991           |
      | campaign-LI-FC-ST-2 | 75396 | 244896   | false                 | 8290            | {zone-zoneset-LI-FC-ST-2} | []         | 93       | 15221          | 3708         | 65991           |


  Scenario: create entities for HB persona level frequency capping
    Given i disable campaigns by name on db
      | Campaign Name          |
      | campaign-HB-FC-PL-PG-1 |
      | campaign-HB-FC-PL-PG-2 |
    Given i create new campaigns with new zoneset
#      pro id = 151
      | Campaign Name          | IO    | LineItem | isServerProgrammatic? | Deal\  Creative | Zonesets-zones Name          | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-HB-FC-PL-PG-1 | 75396 | 241783   | false                 | 13265           | {zone-zoneset-HB-FC-PL-PG-1} | []         | 75       | 15222          | 3708         | 69089           |
#      |campaign-HB-FC-PL-PG-2      |75396         |241783     |false                  |13265              |{zone-zoneset-HB-FC-PL-PG-2}     |[]           |75        |15222             |3708           |69089             |


  Scenario: create entities for Header Bidding - Delivery by placement ID
#    Given I send 2 times an ad request with parameter {dfa} for zone named {fas} to UAS
    Given i disable campaigns by name on db
      | Campaign Name                            |
      | campaign-HB-PlacementG-SS-1*1            |
      | campaign-HB-PlacementG-ST-1*2            |
      | campaign-HB-PlacementG-Billabord-970*250 |
      | campaign-HB-PlacementG-PG-1*1            |
#    first po LI not in prod
    Given i create new campaigns with new zoneset
      | Campaign Name                            | IO    | LineItem | isServerProgrammatic? | Deal\  Creative | Zonesets-zones Name                            | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-HB-PlacementG-SS-1*1            | 75396 | 197418   | false                 | 86              | {zone-zoneset-HB-PlacementG-SS-1*1}            | []         | 69       | 15227          | 3728         | 66831           |
      | campaign-HB-PlacementG-ST-1*2            | 75396 | 210722   | false                 | 8158            | {zone-zoneset-HB-PlacementG-ST-1*2}            | []         | 93       | 15227          | 3728         | 66830           |
      | campaign-HB-PlacementG-Billabord-970*250 | 75396 | 198082   | false                 | 64              | {zone-zoneset-HB-PlacementG-Billabord-970*250} | []         | 58       | 15227          | 3728         | 67231           |
      | campaign-HB-PlacementG-PG-1*1            | 75396 | 241783   | false                 | 1068            | {zone-zoneset-HB-PlacementG-PG-1*1}            | []         | 75       | 15227          | 3728         | 66832           |


  Scenario:  create entites for instream_video viewbility
    Given i disable campaigns by name on db
      | Campaign Name                |
      | campaign-InstreamVid-View-SP |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name                | IO     | LineItem | isServerProgrammatic? | Creative | Zonesets-zones Name                | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-InstreamVid-View-SP | 407981 | 244699   | true                  | 568      | {zone-zoneset-InstreamVid-View-SP} | []         | 35       | 15196          | 3708         | 69158           | []             | []             |


  Scenario:  create entities for enrich geo filter
    Given i disable campaigns by name on db
      | Campaign Name                       |
      | campaign-city-zoneLevelLimit-ST     |
      | campaign-region-bannerLevelLimit-ST |
      | campaign-state-zoneLevelLimit-ST    |
      | campaign-state-bannerLevelLimit-ST  |
      | campaign-noGeoLimit-ST              |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name                       | IO    | LineItem | isServerProgrammatic? | Creative | Zonesets-zones Name                       | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-city-zoneLevelLimit-ST     | 75396 | 244896   | false                 | 8290     | {zone-zoneset-city-zoneLevelLimit-ST}     | []         | 93       | 15288          | 3708         | 65991           | []             | []             |
      | campaign-region-bannerLevelLimit-ST | 75396 | 244896   | false                 | 8290     | {zone-zoneset-region-bannerLevelLimit-ST} | []         | 93       | 15289          | 3708         | 65991           | []             | []             |
      | campaign-state-zoneLevelLimit-ST    | 75396 | 244896   | false                 | 8290     | {zone-zoneset-state-zoneLevelLimit-ST}    | []         | 93       | 15291          | 3708         | 65991           | []             | []             |
      | campaign-state-bannerLevelLimit-ST  | 75396 | 244896   | false                 | 8290     | {zone-zoneset-state-bannerLevelLimit-ST}  | []         | 93       | 15290          | 3708         | 65991           | []             | []             |
    And i update banner data by name
      | Banner Name                                  | limitation             |
      | campaign-region-bannerLevelLimit-ST-banner-1 | [[[7,"=~","us","co"]]] |
      | campaign-state-bannerLevelLimit-ST-banner-1  | [[[5,"=~","ca"]]]      |
    And i update zone data by name
      | Zone Name                            | limitation                       |
      | zone-zoneset-city-zoneLevelLimit-ST  | [[[8,"=~","bo",["l","la paz"]]]] |
      | zone-zoneset-state-zoneLevelLimit-ST | [[[5,"=~","ca"]]]                |


  Scenario:  create entities for contextual targeting - double verify
    Given i disable campaigns by name on db
      | Campaign Name                              |
      | campaign-dv-zoneLevelLimit-ST              |
      | campaign-dv-campaignLevelLimit-ST          |
      | campaign-dv-campaignLevelLimit-exclude-ST  |
      | campaign-dv-zoneLevelLimit-peer-ST         |
      | campaign-dv-zoneLevelLimit-brand-safety-ST |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name                              | IO    | LineItem | isServerProgrammatic? | Creative | Zonesets-zones Name                              | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include                                                                | domain_exclude                                                                |
      | campaign-dv-zoneLevelLimit-ST              | 75396 | 208153   | false                 | 8290     | {zone-zoneset-dv-zoneLevelLimit-ST}              | []         | 93       | 15288          | 3708         | 65991           | [{disney.com,1};{drugs.com,1};{https://www.military.com/equipment/weapons,1}] | []                                                                            |
      | campaign-dv-campaignLevelLimit-ST          | 75396 | 208153   | false                 | 8290     | {zone-zoneset-dv-campaignLevelLimit-ST}          | []         | 93       | 15289          | 3708         | 65991           | [{disney.com,1};{drugs.com,1};{https://www.military.com/equipment/weapons,1}] | []                                                                            |
      | campaign-dv-campaignLevelLimit-exclude-ST  | 75396 | 208153   | false                 | 8290     | {zone-zoneset-dv-campaignLevelLimit-exclude-ST}  | []         | 93       | 15289          | 3708         | 65991           | []                                                                            | [{disney.com,1};{drugs.com,1};{https://www.military.com/equipment/weapons,1}] |
      | campaign-dv-zoneLevelLimit-peer-ST         | 75396 | 208153   | false                 | 8290     | {zone-zoneset-dv-zoneLevelLimit-peer-ST}         | []         | 93       | 15289          | 3708         | 65991           | [{disney.com,1};{drugs.com,1};{https://www.military.com/equipment/weapons,1}] | []                                                                            |
      | campaign-dv-zoneLevelLimit-brand-safety-ST | 75396 | 208153   | false                 | 8290     | {zone-zoneset-dv-zoneLevelLimit-brand-safety-ST} | []         | 93       | 15289          | 3708         | 65991           | []                                                                            | []                                                                            |

    And i update banner data by name
      | Banner Name                                         | limitation                                                     |
      | campaign-dv-campaignLevelLimit-ST-banner-1          | [[[64,"=~","2_84251001","2_84252026"]]]                        |
      | campaign-dv-campaignLevelLimit-exclude-ST-banner-1  | [[[64,"=~","2_84251001","2_84252026"]]]                        |
      | campaign-dv-zoneLevelLimit-brand-safety-ST-banner-1 | [[[64,"!=","2_80012001"],[64,"=~","2_80512003","2_80512001"]]] |

    And i update campaign data by name
      | Campaign Name                             | limitation                              |
      | campaign-dv-campaignLevelLimit-ST         | [[[64,"=~","2_84251001","2_84252026"]]] |
      | campaign-dv-campaignLevelLimit-exclude-ST | [[[64,"=~","2_84251001","2_84252026"]]] |

    And i update zone data by name
      | Zone Name                              | limitation                                       |
      | zone-zoneset-dv-zoneLevelLimit-ST      | [[[64,"=~","2_84251001","2_84252026"]]]          |
      | zone-zoneset-dv-zoneLevelLimit-peer-ST | [[[64,"=~","2_84251001","2_84252026","1_5261"]]] |


  Scenario:  create entites for effctive host choosing
    Given i disable campaigns by name on db
      | Campaign Name          |
      | campaign-EHC-ST-1A     |
      | campaign-EHC-ST-1B     |
      | campaign-EHC-ST-2A     |
      | campaign-EHC-ST-2B     |
      | campaign-EHC-ST-3A     |
      | campaign-EHC-ST-3B     |
      | campaign-EHC-ST-4A     |
      | campaign-EHC-ST-4B     |
      | campaign-EHC-ST-5A     |
      | campaign-EHC-ST-5B     |
      | campaign-EHC-DT-BB-6A  |
      | campaign-EHC-DT-BB-6B  |
      | campaign-EHC-DT-SS-7A  |
      | campaign-EHC-DT-CSB-7B |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name         | IO    | LineItem | isServerProgrammatic? | Creative | Zonesets-zones Name         | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include         | domain_exclude         |
      | campaign-EHC-ST-1A    | 75396 | 244896   | false                 | 8290     | {zone-zoneset-EHC-ST-1A}    | []         | 93       | 15269          | 3728         | 66830           | [{daniref.com,1}]      | []                     |
      | campaign-EHC-ST-1B    | 75396 | 244896   | false                 | 8290     | {zone-zoneset-EHC-ST-1B}    | []         | 93       | 15269          | 3728         | 66830           | []                     | [{daniref.com,1}]      |
      | campaign-EHC-ST-2A    | 75396 | 244896   | false                 | 8290     | {zone-zoneset-EHC-ST-2A}    | []         | 93       | 15269          | 3728         | 66830           | [{danifalse.com,1}]    | []                     |
      | campaign-EHC-ST-2B    | 75396 | 244896   | false                 | 8290     | {zone-zoneset-EHC-ST-2B}    | []         | 93       | 15269          | 3728         | 66830           | []                     | [{danidom.com,1}]      |
      | campaign-EHC-ST-3A    | 75396 | 244896   | false                 | 8290     | {zone-zoneset-EHC-ST-3A}    | []         | 93       | 15269          | 3728         | 66830           | [{danifalse.com,1}]    | []                     |
      | campaign-EHC-ST-3B    | 75396 | 244896   | false                 | 8290     | {zone-zoneset-EHC-ST-3B}    | []         | 93       | 15269          | 3728         | 66830           | []                     | [{danifalse.com,1}]    |
      | campaign-EHC-ST-4A    | 75396 | 244896   | false                 | 8290     | {zone-zoneset-EHC-ST-4A}    | []         | 93       | 15269          | 3728         | 66830           | [{danidom.com,1}]      | [{danifalse.com,1}]    |
      | campaign-EHC-ST-4B    | 75396 | 244896   | false                 | 8290     | {zone-zoneset-EHC-ST-4B}    | []         | 93       | 15269          | 3728         | 66830           | [{danidomInc.com,1}]   | [{danidom.com,1}]      |
      | campaign-EHC-ST-5A    | 75396 | 244896   | false                 | 8290     | {zone-zoneset-EHC-ST-5A}    | []         | 93       | 15269          | 3728         | 66830           | [{news.danidom.com,1}] | []                     |
      | campaign-EHC-ST-5B    | 75396 | 244896   | false                 | 8290     | {zone-zoneset-EHC-ST-5B}    | []         | 93       | 15269          | 3728         | 66830           | []                     | [{news.danidom.com,1}] |
      | campaign-EHC-DT-SS-7A | 75396 | 197418   | false                 | 86       | {zone-zoneset-EHC-DT-SS-7A} | []         | 69       | 15275          | 3739         | 67164           | [{danidom.com,1}]      | [{danifalse.com,1}]    |
    And i update campaign data by name
      | Campaign Name         | run_on_unknown_domains |
      | campaign-EHC-ST-1A    | 1                      |
      | campaign-EHC-ST-1B    | 1                      |
      | campaign-EHC-ST-2A    | 1                      |
      | campaign-EHC-ST-2B    | 1                      |
      | campaign-EHC-ST-3A    | 1                      |
      | campaign-EHC-ST-3B    | 1                      |
      | campaign-EHC-ST-4A    | 1                      |
      | campaign-EHC-ST-4B    | 1                      |
      | campaign-EHC-ST-5A    | 1                      |
      | campaign-EHC-ST-5B    | 1                      |
      | campaign-EHC-DT-SS-7A | 1                      |
    And i update zone data by name
      | Zone Name              | is_secure |
      | zone-zoneset-EHC-ST-1A | 1         |
      | zone-zoneset-EHC-ST-1B | 1         |
      | zone-zoneset-EHC-ST-2A | 1         |
      | zone-zoneset-EHC-ST-2B | 1         |
      | zone-zoneset-EHC-ST-3A | 1         |
      | zone-zoneset-EHC-ST-3B | 1         |
      | zone-zoneset-EHC-ST-4A | 1         |
      | zone-zoneset-EHC-ST-4B | 1         |
      | zone-zoneset-EHC-ST-5A | 1         |
      | zone-zoneset-EHC-ST-5B | 1         |

  Scenario:  create entites for new pacing mechanism
    Given i disable campaigns by name on db
      | Campaign Name                |
      | campaign-D-HourlyPacing-ST-1 |
      | campaign-D-DailyPacing-ST-2  |
      | campaign-D-ASAP-ST-3         |
      | campaign-D-HourlyFF-ST-4     |
      | campaign-D-DailyFF-ST-5      |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name                | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | campaign-D-HourlyPacing-ST-1 | 75396 | 247767   | false                 | 8158          | {zone-zoneset-D-HourlyPacing-ST-1} | []         | 93       | 15303          | 3821         | 69255           | []          | []          |
      | campaign-D-DailyPacing-ST-2  | 75396 | 247767   | false                 | 8158          | {zone-zoneset-D-DailyPacing-ST-2}  | []         | 93       | 15303          | 3821         | 69255           | []          | []          |
      | campaign-D-ASAP-ST-3         | 75396 | 247767   | false                 | 8158          | {zone-zoneset-D-ASAP-ST-3}         | []         | 93       | 15303          | 3821         | 69255           | []          | []          |
      | campaign-D-HourlyFF-ST-4     | 75396 | 247767   | false                 | 8158          | {zone-zoneset-D-HourlyFF-ST-4}     | []         | 93       | 15303          | 3821         | 69255           | []          | []          |
      | campaign-D-DailyFF-ST-5      | 75396 | 247767   | false                 | 8158          | {zone-zoneset-D-DailyFF-ST-5}      | []         | 93       | 15303          | 3821         | 69255           | []          | []          |
# To do - update all campaigns to end in 3 days from today (including today!!) at the database
#   And i update campaign end day to be 3 days from today
    And i update campaign data by name
#    deliveryPacing = 1 = hourly pacing
#    pacing = hourly flex
      | Campaign Name                | is_wholesale | skip_daily_goal | pacing | units | goal_type   | expire              |
      | campaign-D-HourlyPacing-ST-1 | 0            | 0               | 0      | 720   | impressions | 2019-06-26 23:59:59 |
      | campaign-D-DailyPacing-ST-2  | 1            | 0               | 0      | 45    | impressions | 2019-06-26 23:59:59 |
      | campaign-D-ASAP-ST-3         | 1            | 1               | 0      | 20    | impressions | 2019-06-26 23:59:59 |
      | campaign-D-HourlyFF-ST-4     | 0            | 0               | 5      | 720   | impressions | 2019-06-26 23:59:59 |
      | campaign-D-DailyFF-ST-5      | 1            | 0               | 10     | 45    | impressions | 2019-06-26 23:59:59 |
    And i update zone data by name
      | Zone Name                        | is_secure | zone_type_id |
      | zone-zoneset-D-HourlyPacing-ST-1 | 1         | 10           |
      | zone-zoneset-D-DailyPacing-ST-2  | 1         | 10           |
      | zone-zoneset-D-ASAP-ST-3         | 1         | 10           |
      | zone-zoneset-D-HourlyFF-ST-4     | 1         | 10           |
      | zone-zoneset-D-DailyFF-ST-5      | 1         | 10           |


  Scenario:  create entites for new pacing mechanism
    Given i disable campaigns by name on db
      | Campaign Name                 |
      | campaign-state-screenShift-ST |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name                 | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                 | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | campaign-state-screenShift-ST | 75396 | 240787   | false                 | 192           | {zone-zoneset-state-screenShift-ST} | []         | 69       | 15290          | 3821         | 69426           | []          | []          |
    And i update banner data by name
      | Banner Name                            | limitation                        |
      | campaign-state-screenShift-ST-banner-1 | [[[26,"=~",7541],[26,"=~",7531]]] |

  Scenario: create entites for new publisher block list
    Given i disable campaigns by name on db
      | Campaign Name           |
      | campaign-pbl-BRAND1-ES  |
      | campaign-pbl-BRAND2-PGX |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name           | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                    | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | campaign-pbl-BRAND1-ES  | 574531 | 251644   | false                 | 84            | {zone-zoneset-campaign-pbl-BRAND1-ES}  | []         | 10       | 25159          | 3843         | 69607           | []          | []          |
      | campaign-pbl-BRAND2-PGX | 75396  | 251661   | false                 | 1068          | {zone-zoneset-campaign-pbl-BRAND2-PGX} | []         | 92       | 25159          | 3843         | 69608           | []          | []          |


  @DynamicPricing
  @InAppBlackWhiteList
  @OpenX
  @Inapp
  @UDMP
  @PGX
  @PG1
  @SupplyType
  @viewability
  @GDPR
  @appnexus
  @cacheRefresh
  @HB
  @DOT
  @DT
  @AB
  @PLT
  @zoneTagSanity
  @Keren
  @limitationSanity
  @Zonerefresh
  Scenario: refresh zone cache with wait
    Given i kill replay on the machines
    And I setup the db
    And I sleep for 60 seconds


  @DynamicPricing
  @InAppBlackWhiteList
  @UDMP
  @PG1
  @PLT
  @SupplyType
  @viewability
  @appnexus
  @cacheRefresh
  @bannerCache
  @HB
  @DOT
  @DT
  @Keren

  Scenario: refresh banner cache
    And I refresh banner cache
    And I restart {ramp-lift-services}
    And I restart {ut-programmatic-gw}
    And I sleep for 40 seconds

  @refreshZoneCache

  Scenario: refresh zone cache
    And I refresh the zone Cache

  @optimize
  Scenario: update test strategy
    Given i disable all tests except 53
#    And I set test id of test_strategy named {scoringV2} to {53}

  @optimize

  Scenario: save entities to file
    And save all entities to json file

  Scenario: sleep
    And I sleep for 240 seconds
