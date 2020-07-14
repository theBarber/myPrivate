@couchBaseUtil
@preconditions
@optimize
@AA

Feature: Entities for tests

  Scenario: entities end-date update
    And i update po_line_item end date by id {4584,66997,67000,67001,67002,69725,69608,69625,69723,67164,17116,27807,67638,27809,65421,64396,66814,66813,64397,64398,64399,64400,64401,64402,64403,65422,65423,65424,66418,66486,66487,66488,66810,66811,62229,66556,66557,66555,66556,67259,67260,67261,66833,66831,66830,67182,67231,66933,66004,66002,66736,65991,67354,66811,66555,66557,67165,69992,67163,67162,67166,69089,69134,66832,69158,69213,70473,70474}
    And i update io_line_item end date by id {243710,251644,253288,253747,210722,241783,223539,240827,198082,197418,224812,222908,234810,224810,224539,240829,224533,224530,211456,228962,224531,228961,229737,243452,234550,234656,243707,243711,244895,244896,244699}
    And i update io_line_item with id {210722} filed {unit_price} to be {1}
    And i update io_line_item with id {210722} filed {budget} to be {1}

  Scenario: remove all active zones
#    zones that are linked to publisher 2434 are disabled specifically!!
    Given i remove all zones from publishers: {3836}
    Given i remove all zones from publishers: {3843}
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

  @HB
  @HBEntitiesCreation
  @HBFilterEntitiesCreation
  Scenario: create entities for HeaderBiddingFilter tests
    And i disable campaigns by name on db
      | Campaign Name           |
      | campaign-HB-PO-Price    |
      | campaign-HB-No-PO-Price |
    And i create new campaigns with new zoneset
      | Campaign Name           | IO    | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name            | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-HB-PO-Price    | 75396 | 246300   | false                 | 288           | {zone-zoneset-HB-PO-Price}    | []         | 58       | 15281          | 3708         | 69726           |
      | campaign-HB-No-PO-Price | 75396 | 246300   | false                 | 288           | {zone-zoneset-HB-No-PO-Price} | []         | 58       | 15281          | 3708         | 69725           |
    And i update campaign data by name
      | Campaign Name           | status | Priority | units | limitation | campaign_delivery_method | is_wholesale | skip_daily_goal | goal_type   |
      | campaign-HB-PO-Price    | 0      | 1        | -1    | []         | 1                        | 1            | 1               | impressions |
      | campaign-HB-No-PO-Price | 0      | -2       | -1    | []         | 1                        | 1            | 1               | impressions |
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
    Given i create new campaigns with new zoneset
      | Campaign Name           | IO    | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name        | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-API-1-a-sanity | 75396 | 210722   | false                 | 204           | {zone-zoneset-sanity-1-a} | []         | 83       | 4737           | 2434         | 17116           |
    And i update zone data by name
      | Zone Name               | is_secure |
      | zone-zoneset-sanity-1-a | 1         |

  @GDPR
  Scenario: create entities for zone Tag Sanity test
    Given i disable campaigns by name on db
      | Campaign Name               |
      | campaign-API-1-a-GDPR       |
      | campaign-San-Francisco-city |

    Given i create new campaigns with new zoneset
      | Campaign Name               | IO    | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name             | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-API-1-a-GDPR       | 75396 | 210722   | false                 | 204           | {zone-zoneset-GDPR-1-a}        | []         | 83       | 4737           | 2434         | 17116           |
      # goe --> city limitation
      | campaign-San-Francisco-city | 75396 | 210722   | false                 | 204           | {zone-zoneset-city-limitation} | []         | 83       | 15853          | 2434         | 62229           |
    And i update banner data by name
      | Banner Name                          | limitation                               |
      | campaign-API-1-a-GDPR-banner-1       | [[[5,"=~","fr"]]]                        |
      #  goe --> city limitation
      | campaign-San-Francisco-city-banner-1 | [[[8,"=~","us",["ca","san francisco"]]]] |
    And i update zone data by name
      | Zone Name                    | is_secure |
      | zone-zoneset-GDPR-1-a        | 1         |
      | zone-zoneset-city-limitation | 1         |


  @limitationSanity
  Scenario: create entities for zone Tag Sanity test
    Given i disable campaigns by name on db
      | Campaign Name                   |
      | campaign-API-limitations-test-F |
      | campaign-API-limitations-test-C |
      | campaign-API-limitations-test-W |
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
      | campaign-ProfileTargetingUDMPforWeb-ST-1    | 75396 | 210722   | false                 | 8290          | {zone-zoneset-ProfileTargetingUDMPforWeb-ST-1}    | []                   | 93       | 14892          | 3708         | 27807           |
      | campaign-SeqProfileTargetingUDMPforWeb-ST-1 | 75396 | 210722   | false                 | 8290          | {zone-zoneset-SeqProfileTargetingUDMPforWeb-ST-1} | []                   | 93       | 15128          | 3708         | 67638           |
      | campaign-CrossDeviceCappingUDMP-ST-1        | 75396 | 210722   | false                 | 8290          | {zone-zoneset-CrossDeviceCappingUDMP-ST-1}        | []                   | 93       | 14894          | 3708         | 27809           |
      | campaign-PTzoneLimitation-ST-1              | 75396 | 210722   | false                 | 8290          | {zone-zoneset-PTzoneLimitation-ST-1}              | [[[4,"==",1,1,666]]] | 93       | 15124          | 3708         | 27807           |
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


  @CrossDeviceCapping
  Scenario: create entities for cross device capping
    Given i disable campaigns by name on db
      | Campaign Name                                   |
      | campaign-CrossDeviceCapping-ST                  |
      | campaign-DeviceSessionCapping-ST-1              |
      | campaign-CrossDeviceSessionCapping-ST-2         |
      | campaign-DeviceLifetimeCapping-ST-3             |
      | campaign-CrossDeviceLifetimeCapping-ST-4        |
      | campaign-DeviceCappingMultipleCampaigns-ST-5    |
      | campaign-DeviceCappingMultipleCampaigns-ST-6    |
      | campaign-DeviceCappingMultipleCampaigns-ST-7    |
      | campaign-DeviceLiCapping-ST-8                   |
      | campaign-DeviceSessionCapping-Inapp-ST-9        |
      | campaign-CrossDeviceSessionCapping-Inapp-ST-10  |
      | campaign-DeviceLifetimeCapping-Inapp-ST-11      |
      | campaign-CrossDeviceLifetimeCapping-Inapp-ST-12 |

    Given i create new campaigns with new zoneset
      | Campaign Name                                   | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                                           | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-CrossDeviceCapping-ST                  | 75396 | 210722   | false                 | 8290          | {INT3708-zone-zoneset-CrossDeviceCapping-ST}                  | []         | 93       | 14892          | 3708         | 27807           |
      | campaign-DeviceSessionCapping-ST-1              | 75396 | 210722   | false                 | 8290          | {INT3708-zone-zoneset-DeviceSessionCapping-ST-1}              | []         | 93       | 14892          | 3708         | 27807           |
      | campaign-CrossDeviceSessionCapping-ST-2         | 75396 | 210722   | false                 | 8290          | {INT3708-zone-zoneset-CrossDeviceSessionCapping-ST-2}         | []         | 93       | 14892          | 3708         | 27807           |
      | campaign-DeviceLifetimeCapping-ST-3             | 75396 | 210722   | false                 | 8290          | {INT3708-zone-zoneset-DeviceLifetimeCapping-ST-3}             | []         | 93       | 14892          | 3708         | 27807           |
      | campaign-CrossDeviceLifetimeCapping-ST-4        | 75396 | 210722   | false                 | 8290          | {INT3708-zone-zoneset-CrossDeviceLifetimeCapping-ST-4}        | []         | 93       | 14892          | 3708         | 27807           |
      | campaign-DeviceCappingMultipleCampaigns-ST-5    | 75396 | 210722   | false                 | 8290          | {INT3708-zone-zoneset-DeviceCappingMultipleCampaigns-ST-5}    | []         | 93       | 14892          | 3708         | 27807           |
      | campaign-DeviceCappingMultipleCampaigns-ST-6    | 75396 | 210722   | false                 | 8290          | {INT3708-zone-zoneset-DeviceCappingMultipleCampaigns-ST-5}    | []         | 93       | 14892          | 3708         | 27807           |
      | campaign-DeviceCappingMultipleCampaigns-ST-7    | 75396 | 210722   | false                 | 8290          | {INT3708-zone-zoneset-DeviceCappingMultipleCampaigns-ST-5}    | []         | 93       | 14892          | 3708         | 27807           |
      | campaign-DeviceLiCapping-ST-8                   | 75396 | 244895   | false                 | 8290          | {INT3708-zone-zoneset-DeviceLiCapping-ST-8}                   | []         | 93       | 14892          | 3708         | 27807           |
      | campaign-DeviceSessionCapping-Inapp-ST-9        | 75396 | 241783   | false                 | 14619         | {INT3708-zone-zoneset-DeviceSessionCapping-Inapp-ST-9}        | []         | 80       | 14892          | 3708         | 27807           |
      | campaign-CrossDeviceSessionCapping-Inapp-ST-10  | 75396 | 241783   | false                 | 14619         | {INT3708-zone-zoneset-CrossDeviceSessionCapping-Inapp-ST-10}  | []         | 80       | 14892          | 3708         | 27807           |
      | campaign-DeviceLifetimeCapping-Inapp-ST-11      | 75396 | 241783   | false                 | 14619         | {INT3708-zone-zoneset-DeviceLifetimeCapping-Inapp-ST-11}      | []         | 80       | 14892          | 3708         | 27807           |
      | campaign-CrossDeviceLifetimeCapping-Inapp-ST-12 | 75396 | 241783   | false                 | 14619         | {INT3708-zone-zoneset-CrossDeviceLifetimeCapping-Inapp-ST-12} | []         | 80       | 14892          | 3708         | 27807           |

    And i update zone data by name
      | Zone Name                                                   | is_mraid | is_secure |
      | INT3708-zone-zoneset-CrossDeviceCapping-ST                  | 0        | 1         |
      | INT3708-zone-zoneset-DeviceSessionCapping-ST-1              | 0        | 1         |
      | INT3708-zone-zoneset-CrossDeviceSessionCapping-ST-2         | 0        | 1         |
      | INT3708-zone-zoneset-DeviceLifetimeCapping-ST-3             | 0        | 1         |
      | INT3708-zone-zoneset-CrossDeviceLifetimeCapping-ST-4        | 0        | 1         |
      | INT3708-zone-zoneset-DeviceCappingMultipleCampaigns-ST-5    | 0        | 1         |
      | INT3708-zone-zoneset-DeviceLiCapping-ST-8                   | 0        | 1         |
      | INT3708-zone-zoneset-DeviceSessionCapping-Inapp-ST-9        | 1        | 1         |
      | INT3708-zone-zoneset-CrossDeviceSessionCapping-Inapp-ST-10  | 1        | 1         |
      | INT3708-zone-zoneset-DeviceLifetimeCapping-Inapp-ST-11      | 1        | 1         |
      | INT3708-zone-zoneset-CrossDeviceLifetimeCapping-Inapp-ST-12 | 1        | 1         |

    Given i update campaign data by name
      | Campaign Name                                   | capping | session_capping | block | priority |
      | campaign-CrossDeviceCapping-ST                  | 4       | 0               | 0     | -2       |
      | campaign-DeviceSessionCapping-ST-1              | 0       | 2               | 60    | -2       |
      | campaign-CrossDeviceSessionCapping-ST-2         | 0       | 2               | 60    | -2       |
      | campaign-DeviceLifetimeCapping-ST-3             | 2       | 0               | 0     | -2       |
      | campaign-CrossDeviceLifetimeCapping-ST-4        | 2       | 0               | 0     | -2       |
      | campaign-DeviceCappingMultipleCampaigns-ST-5    | 2       | 0               | 0     | -2       |
      | campaign-DeviceCappingMultipleCampaigns-ST-6    | 1       | 0               | 0     | -1       |
      | campaign-DeviceCappingMultipleCampaigns-ST-7    | 0       | 0               | 0     | 1        |
      | campaign-DeviceSessionCapping-Inapp-ST-9        | 0       | 2               | 60    | -2       |
      | campaign-CrossDeviceSessionCapping-Inapp-ST-10  | 0       | 2               | 60    | -2       |
      | campaign-DeviceLifetimeCapping-Inapp-ST-11      | 2       | 0               | 0     | -2       |
      | campaign-CrossDeviceLifetimeCapping-Inapp-ST-12 | 2       | 0               | 0     | -2       |


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
      | campaign-HB-DynamicPrice-1                  | 75396  | 210722   | false                 | 8290          | {zone-zoneset-HB-DynamicPrice-1}                  | []         | 10       | 15133          | 3708         | 66736           |
      | campaign-HB-DynamicPrice-2                  | 75396  | 210722   | false                 | 8290          | {zone-zoneset-HB-DynamicPrice-2}                  | []         | 10       | 15143          | 3708         | 66736           |
      | campaign-HB-DynamicPrice-3                  | 75396  | 210722   | false                 | 8290          | {zone-zoneset-HB-DynamicPrice-3}                  | []         | 10       | 15134          | 3708         | 66736           |
      | campaign-HB-DynamicPrice-4                  | 75396  | 210722   | false                 | 8290          | {zone-zoneset-HB-DynamicPrice-4}                  | []         | 10       | 15144          | 3708         | 66736           |
      | campaign-HB-DynamicPrice-ST-1x2-5a          | 75396  | 210722   | false                 | 8290          | {zone-zoneset-HB-DynamicPrice-ST-1x2-5a}          | []         | 93       | 15145          | 3708         | 67354           |
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
      | Campaign Name                               | hb_desktop_bid_price_percentage | hb_mobile_bid_price_percentage | use_default_margin |
      | campaign-HB-DynamicPrice-2                  | 70                              | 70                             | 0                  |
      | campaign-HB-DynamicPrice-3                  | 40                              | 40                             | 0                  |
      | campaign-HB-DynamicPrice-4                  | 50                              | 70                             | 0                  |
      | campaign-HB-DynamicPrice-ST-1x2-5a          | 40                              | 40                             | 0                  |
      | campaign-HB-DynamicPrice-Desktop-300X250-5b | 50                              | 50                             | 0                  |
      | campaign-HB-DP-ServerPr-ST-DynamicAtPub-6a  | 40                              | 40                             | 0                  |
      | campaign-HB-DP-ServerPr-PGC-6b              | 40                              | 40                             | 0                  |
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


    Given i update bid_price_type for publisher = 3708 for adunit = 93 to be 1
#    Given i update bid_price_type for publisher = 3711 for adunit = 69 to be 1
#    Given i update bid_price_type for publisher = 3711 for adunit = 75 to be 1


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
      | Campaign Name         |
      | campaign-DT-SS-1-t-1  |
      | campaign-DT-SI-2-t-1  |
      | campaign-DT-SI-1-t-1  |
      | campaign-DT-SI-2-t-1  |
      | campaign-DT-PGC-2-t-1 |
#      | campaign-DT-SS-1-t-2   |
#      | campaign-DT-SI-2-t-2   |
#      | campaign-DT-SI-1-t-3-L |
#      | campaign-DT-SI-2-t-3   |
    Given i create new campaigns with new zoneset
      | Campaign Name         | IO    | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name        | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-DT-SS-1-t-1  | 75396 | 197418   | false                 | 86            | {zone-zoneset-DT-SS-t-1}  | []         | 69       | 14401          | 3674         | 64397           |
      | campaign-DT-SS-2-t-1  | 75396 | 197418   | false                 | 86            | {zone-zoneset-DT-SS-t-1}  | []         | 69       | 14401          | 3674         | 64397           |
      | campaign-DT-SI-1-t-1  | 75396 | 211456   | false                 | 210           | {zone-zoneset-DT-SI-t-1}  | []         | 61       | 14401          | 3674         | 64398           |
      | campaign-DT-SI-2-t-1  | 75396 | 211456   | false                 | 210           | {zone-zoneset-DT-SI-t-1}  | []         | 61       | 14401          | 3674         | 64398           |
      | campaign-DT-PGC-2-t-1 | 75396 | 222908   | false                 | 34670         | {zone-zoneset-DT-PGC-t-1} | []         | 75       | 14401          | 3674         | 64399           |
#      | campaign-DT-SS-1-t-2   | 75396 | 197418   | false                 | 86            | {zone-zoneset-DT-SS-t-2}   | []                | 69       | 14402          | 3666         | 64400           |
#      | campaign-DT-SI-2-t-2   | 75396 | 211456   | false                 | 210           | {zone-zoneset-DT-SI-t-2}   | []                | 61       | 14402          | 3666         | 64401           |
#      | campaign-DT-SI-1-t-3-L | 75396 | 211456   | false                 | 210           | {zone-zoneset-DT-SI-t-3-L} | [[[5,"=~","af"]]] | 61       | 14403          | 3675         | 64403           |
#      | campaign-DT-SI-2-t-3   | 75396 | 211456   | false                 | 210           | {zone-zoneset-DT-SI-t-3}   | []                | 61       | 14403          | 3675         | 64403           |
    And i update campaign data by name
      | Campaign Name         | Priority | campaign_delivery_method |
      | campaign-DT-SS-1-t-1  | -2       | 1                        |
      | campaign-DT-SI-2-t-1  | -1       | 2                        |
      | campaign-DT-SI-1-t-1  | -2       | 1                        |
      | campaign-DT-SI-2-t-1  | -1       | 2                        |
      | campaign-DT-PGC-2-t-1 | -1       | 2                        |
#      | campaign-DT-SS-1-t-2   | -2       | 1                        |
#      | campaign-DT-SI-2-t-2   | -1       | 2                        |
#      | campaign-DT-SI-1-t-3-L | -2       | 1                        |
#      | campaign-DT-SI-2-t-3   | -1       | 2                        |
    And i update zone data by name
      | Zone Name               | is_secure |
      | zone-zoneset-DT-SS-t-1  | 1         |
      | zone-zoneset-DT-SI-t-1  | 1         |
      | zone-zoneset-DT-PGC-t-1 | 1         |
#      | zone-zoneset-DT-SS-t-2   | 1         |
#      | zone-zoneset-DT-SI-t-2   | 1         |
#      | zone-zoneset-DT-SI-t-3-L | 1         |
#      | zone-zoneset-DT-SI-t-3   | 1         |

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
      | campaign-DT-Inline-PGC-2 | 75396 | 222908   | false                 | 34670         | {zone-zoneset-DT-inline-PGC}  | []         | 75       | 14470          | 3690         | 65424           |
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

 ### In App Black White List
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

  @PLT
  Scenario: create entities for Persona Level Targeting test
    Given i disable campaigns by name on db
      | Campaign Name                 |
      | campaign-PLT-NotPersonaL-ST-1 |
      | campaign-PLT-YesPersonaL-ST-1 |
      | campaign-PLT-YesPersonaL-ST-2 |
    Given i create new campaigns with new zoneset
      | Campaign Name                 | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                 | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-PLT-NotPersonaL-ST-1 | 75396 | 210722   | false                 | 8290          | {zone-zoneset-PLT-NotPersonaL-ST-1} | []         | 93       | 15132          | 3708         | 67638           |
      | campaign-PLT-YesPersonaL-ST-1 | 75396 | 210722   | false                 | 8290          | {zone-zoneset-PLT-YesPersonaL-ST-1} | []         | 93       | 15131          | 3708         | 67638           |
      | campaign-PLT-YesPersonaL-ST-2 | 75396 | 210722   | false                 | 8290          | {zone-zoneset-PLT-YesPersonaL-ST-2} | []         | 93       | 15131          | 3708         | 67638           |
    And i update campaign data by name
      | Campaign Name                 | is_persona_targeting |
      | campaign-PLT-NotPersonaL-ST-1 | 0                    |
      | campaign-PLT-YesPersonaL-ST-1 | 1                    |
      | campaign-PLT-YesPersonaL-ST-2 | 1                    |
    And i update banner data by name
      | Banner Name                            | limitation                                |
      | campaign-PLT-NotPersonaL-ST-1-banner-1 | [[[4,"==",365,1,456],[4,"==",365,1,123]]] |
      | campaign-PLT-YesPersonaL-ST-1-banner-1 | [[[4,"==",365,1,456],[4,"==",365,1,123]]] |
      | campaign-PLT-YesPersonaL-ST-2-banner-1 | [[[4,"==",365,1,123]]]                    |
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
      | Campaign Name                            | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                            | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include                | domain_exclude                 |
      | campaign-YesRunFalseDomain-69-1          | 75396 | 197418   | false                 | 86            | {zone-zoneset-YesRunFalseDomain-69-1}          | []         | 69       | 15160          | 3673         | 66933           | []                            | []                             |
      | campaign-YesRunFalseDomainInclude-ST-2   | 75396 | 210722   | false                 | 8290          | {zone-zoneset-YesRunFalseDomainInclude-ST-2}   | []         | 93       | 15160          | 3673         | 64396           | [{includeFalseDomain.test,1}] | []                             |
      | campaign-NoRunFalseDomainInclude-92-3    | 75396 | 222908   | false                 | 14488         | {zone-zoneset-NoRunFalseDomainInclude-92-3}    | []         | 92       | 15160          | 3673         | 67165           | [{includeFalseDomain.test,1}] | []                             |
      | campaign-YesRunFalseDomainExclude-ST-4   | 75396 | 210722   | false                 | 8290          | {zone-zoneset-YesRunFalseDomainExclude-ST-4}   | []         | 93       | 15160          | 3673         | 64396           | []                            | [{daniellafalsedomain.test,1}] |
      | campaign-YesRunFalseDomainExclude-10-5   | 75396 | 240827   | false                 | 85            | {zone-zoneset-YesRunFalseDomainExclude-10-5}   | []         | 10       | 15160          | 3673         | 66814           | []                            | [{daniellafalsedomain.test,1}] |
      | campaign-YesRunFalseDomainBothLists-ST-6 | 75396 | 210722   | false                 | 8290          | {zone-zoneset-YesRunFalseDomainBothLists-ST-6} | []         | 93       | 15160          | 3673         | 64396           | [{includeFalseDomain.test,1}] | [{daniellafalsedomain.test,1}] |
      | campaign-NoRunFalseDomainBothLists-ST-7  | 75396 | 210722   | false                 | 8290          | {zone-zoneset-NoRunFalseDomainBothLists-ST-7}  | []         | 93       | 15160          | 3673         | 64396           | [{includeFalseDomain.test,1}] | [{daniellafalsedomain.test,1}] |
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
  @wurflEntities
  Scenario: create entities for peer39 and wurfl feature
    Given i disable campaigns by name on db
      | Campaign Name    |
      | campaign-WL-ST-2 |
      | campaign-WL-ST-3 |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name    | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name    | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-WL-ST-2 | 75396 | 210722   | false                 | 8290          | {zone-zoneset-WL-ST-2} | []         | 93       | 15183          | 3708         | 65991           | []             | []             |
      | campaign-WL-ST-3 | 75396 | 210722   | false                 | 8290          | {zone-zoneset-WL-ST-3} | []         | 93       | 15183          | 3708         | 65991           | []             | []             |
    And i update banner data by name
      | Banner Name               | limitation                                            |
      | campaign-WL-ST-2-banner-1 | [[[12,"=~","chrome","firefox","safari"],[50,"==",1]]] |
    And i update zone data by name
      | zone Name            | limitation                                            |
      | zone-zoneset-WL-ST-3 | [[[12,"=~","chrome","firefox","safari"],[50,"==",1]]] |


  Scenario:  create entites for vidAd
    Given i disable campaigns by name on db
      | Campaign Name     |
      | campaign-TN       |
      | campaign-vidAd-SP |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name     | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name     | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-TN       | 75396  | 243707   | false                 | 21638         | {zone-zoneset-TN}       | []         | 97       | 15196          | 3708         | 69992           | []             | []             |
      | campaign-vidAd-SP | 407981 | 243710   | true                  | 568           | {zone-zoneset-vidAd-SP} | []         | 97       | 15292          | 3708         | 69992           | []             | []             |

    # ****  update also is_sync=1 & is_video=1 parameters of the campaign ***
    And i update campaign data by name
      | Campaign Name     | Priority | is_sync | is_video |
      | campaign-TN       | -1       | 1       | 1        |
      | campaign-vidAd-SP | -2       | 1       | 1        |

    # ****  update is_sync=1 parameter of the zone ***
    And i update zone data by name
      | Zone Name             | is_sync |
      | zone-zoneset-TN       | 1       |
      | zone-zoneset-vidAd-SP | 1       |
     # ****  update is_sync=1 & is_video=1 parameter of the zoneset ***
    And i update zoneset data by name
      | Zoneset Name          | is_sync | is_video |
      | zone-zoneset-TN       | 1       | 1        |
      | zone-zoneset-vidAd-SP | 1       | 1        |


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


  @HBEntitiesCreation
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
      | campaign-HB-PlacementG-ST-1*2            | 75396 | 210722   | false                 | 8290            | {zone-zoneset-HB-PlacementG-ST-1*2}            | []         | 93       | 15227          | 3728         | 66830           |
      | campaign-HB-PlacementG-Billabord-970*250 | 75396 | 198082   | false                 | 64              | {zone-zoneset-HB-PlacementG-Billabord-970*250} | []         | 58       | 15227          | 3728         | 67231           |
      | campaign-HB-PlacementG-PG-1*1            | 75396 | 241783   | false                 | 34670           | {zone-zoneset-HB-PlacementG-PG-1*1}            | []         | 75       | 15227          | 3728         | 66832           |


  Scenario:  create entites for instream_video viewbility
    Given i disable campaigns by name on db
      | Campaign Name                |
      | campaign-InstreamVid-View-SP |
      | campaign-InstreamVid-Moat    |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name                | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-InstreamVid-View-SP | 407981 | 244699   | true                  | 816           | {zone-zoneset-InstreamVid-View-SP} | []         | 35       | 15196          | 3708         | 69158           | []             | []             |
      | campaign-InstreamVid-Moat    | 407981 | 244699   | true                  | 816           | {zone-zoneset-InstreamVid-Moat}    | []         | 35       | 15196          | 3708         | 69158           | []             | []             |
     # ****  update is_sync=1 & is_video=1 parameters of the campaign ***
    And i update campaign data by name
      | Campaign Name                | is_sync | is_video |
      | campaign-InstreamVid-View-SP | 1       | 1        |
      | campaign-InstreamVid-Moat    | 1       | 1        |

    And i update campaign data by name
      | Campaign Name             | viewability_wrapper_enabled | viewability_wrapper_vendor |
      | campaign-InstreamVid-Moat | 1                           | MOAT                       |

      # ****  update is_sync=1 parameter of the zone ***
    And i update zone data by name
      | Zone Name                        | is_sync |
      | zone-zoneset-InstreamVid-View-SP | 1       |
      | zone-zoneset-InstreamVid-Moat    | 1       |
     # ****  update is_sync=1 & is_video=1 parameter of the zoneset ***
    And i update zoneset data by name
      | Zoneset Name                     | is_sync | is_video |
      | zone-zoneset-InstreamVid-View-SP | 1       | 1        |
      | zone-zoneset-InstreamVid-Moat    | 1       | 1        |


  Scenario:  create entities for enrich geo filter
    Given i disable campaigns by name on db
      | Campaign Name                       |
      | campaign-city-zoneLevelLimit-ST     |
      | campaign-region-bannerLevelLimit-ST |
      | campaign-state-zoneLevelLimit-ST    |
      | campaign-state-bannerLevelLimit-ST  |
      | campaign-noGeoLimit-ST              |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name                       | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                       | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-city-zoneLevelLimit-ST     | 75396 | 244896   | false                 | 8290          | {zone-zoneset-city-zoneLevelLimit-ST}     | []         | 93       | 15288          | 3708         | 65991           | []             | []             |
      | campaign-region-bannerLevelLimit-ST | 75396 | 244896   | false                 | 8290          | {zone-zoneset-region-bannerLevelLimit-ST} | []         | 93       | 739            | 3708         | 65991           | []             | []             |
      | campaign-state-zoneLevelLimit-ST    | 75396 | 244896   | false                 | 8290          | {zone-zoneset-state-zoneLevelLimit-ST}    | []         | 93       | 15291          | 3708         | 65991           | []             | []             |
      | campaign-state-bannerLevelLimit-ST  | 75396 | 244896   | false                 | 8290          | {zone-zoneset-state-bannerLevelLimit-ST}  | []         | 93       | 15290          | 3708         | 65991           | []             | []             |
    And i update banner data by name
      | Banner Name                                  | limitation             |
      | campaign-region-bannerLevelLimit-ST-banner-1 | [[[7,"=~","us","co"]]] |
      | campaign-state-bannerLevelLimit-ST-banner-1  | [[[5,"=~","ca"]]]      |
    And i update zone data by name
      | Zone Name                            | limitation                                                                                                                                                                                                   |
      | zone-zoneset-city-zoneLevelLimit-ST  | [[[8,\"=~\",\"us\",[\"dc\",\"washington\"],[\"ma\",\"boston\"],[\"md\",\"baltimore\"],[\"pa\",\"lehigh valley\",\"philadelphia\"],[\"ri\",\"providence\"]]],[[7,\"=~\",\"us\",\"ct\",\"nh\",\"nj\",\"ny\"]]] |
      | zone-zoneset-state-zoneLevelLimit-ST | [[[5,"=~","ca"]]]                                                                                                                                                                                            |


#******  CONTEXTUAL  ********
  Scenario:  create entities for contextual targeting - double verify
    Given i disable campaigns by name on db
      | Campaign Name                              |
      | campaign-CT-ST-1                           |
      | campaign-dv-campaignLevelLimit-ST          |
      | campaign-dv-campaignLevelLimit-exclude-ST  |
      | campaign-dv-zoneLevelLimit-peer-ST         |
      | campaign-dv-zoneLevelLimit-brand-safety-ST |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name                              | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                              | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include                                                                | domain_exclude                                                                |
      | campaign-CT-ST-1                           | 75396 | 210722   | false                 | 8290          | {zone-zoneset-CT-ST-1}                           | []         | 93       | 15182          | 3708         | 65991           | []                                                                            | []                                                                            |
      | campaign-dv-campaignLevelLimit-ST          | 75396 | 208153   | false                 | 8290          | {zone-zoneset-dv-campaignLevelLimit-ST}          | []         | 93       | 15289          | 3708         | 65991           | [{disney.com,1};{drugs.com,1};{https://www.military.com/equipment/weapons,1}] | []                                                                            |
      | campaign-dv-campaignLevelLimit-exclude-ST  | 75396 | 208153   | false                 | 8290          | {zone-zoneset-dv-campaignLevelLimit-exclude-ST}  | []         | 93       | 15289          | 3708         | 65991           | []                                                                            | [{disney.com,1};{drugs.com,1};{https://www.military.com/equipment/weapons,1}] |
      | campaign-dv-zoneLevelLimit-peer-ST         | 75396 | 208153   | false                 | 8290          | {zone-zoneset-dv-zoneLevelLimit-peer-ST}         | []         | 93       | 15289          | 3708         | 65991           | [{disney.com,1};{drugs.com,1};{https://www.military.com/equipment/weapons,1}] | []                                                                            |
      | campaign-dv-zoneLevelLimit-brand-safety-ST | 75396 | 208153   | false                 | 8290          | {zone-zoneset-dv-zoneLevelLimit-brand-safety-ST} | []         | 93       | 15289          | 3708         | 65991           | []                                                                            | []                                                                            |

    And i update banner data by name
      | Banner Name                                         | limitation                                                                                            |
      | campaign-CT-ST-1-banner-1                           | [[[64,"=~","1_5252","1_5250"]]]                                                                       |
      | campaign-dv-campaignLevelLimit-ST-banner-1          | [[[64,"=~","2_84252026","2_82033230"]]]                                                               |
      | campaign-dv-campaignLevelLimit-exclude-ST-banner-1  | [[[64,"=~","2_84251001","2_84252026"]]]                                                               |
      | campaign-dv-zoneLevelLimit-brand-safety-ST-banner-1 | [[[64,"!=","2_80012001"],[64,"=~","2_80510000","2_80520000","2_82043105","2_82045105","2_80512001"]]] |

    And i update campaign data by name
      | Campaign Name                             | limitation                              |
      | campaign-CT-ST-1                          | [[[64,"=~","1_5252","1_5250"]]]         |
      | campaign-dv-campaignLevelLimit-ST         | [[[64,"=~","2_84252026","2_82033230"]]] |
      | campaign-dv-campaignLevelLimit-exclude-ST | [[[64,"=~","2_84251001","2_84252026"]]] |

    And i update zone data by name
      | Zone Name                                      | limitation |
      | zone-zoneset-dv-zoneLevelLimit-peer-ST         | []         |
      | zone-zoneset-dv-zoneLevelLimit-brand-safety-ST | []         |


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
      | Campaign Name         | IO    | LineItem | isServerProgrammatic? | Creative or Deal | Zonesets-zones Name         | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include         | domain_exclude         |
      | campaign-EHC-ST-1A    | 75396 | 244896   | false                 | 8290             | {zone-zoneset-EHC-ST-1A}    | []         | 93       | 15269          | 3728         | 66830           | [{daniref.com,1}]      | []                     |
      | campaign-EHC-ST-1B    | 75396 | 244896   | false                 | 8290             | {zone-zoneset-EHC-ST-1B}    | []         | 93       | 15269          | 3728         | 66830           | []                     | [{daniref.com,1}]      |
      | campaign-EHC-ST-2A    | 75396 | 244896   | false                 | 8290             | {zone-zoneset-EHC-ST-2A}    | []         | 93       | 15269          | 3728         | 66830           | [{danifalse.com,1}]    | []                     |
      | campaign-EHC-ST-2B    | 75396 | 244896   | false                 | 8290             | {zone-zoneset-EHC-ST-2B}    | []         | 93       | 15269          | 3728         | 66830           | []                     | [{danidom.com,1}]      |
      | campaign-EHC-ST-3A    | 75396 | 244896   | false                 | 8290             | {zone-zoneset-EHC-ST-3A}    | []         | 93       | 15269          | 3728         | 66830           | [{danifalse.com,1}]    | []                     |
      | campaign-EHC-ST-3B    | 75396 | 244896   | false                 | 8290             | {zone-zoneset-EHC-ST-3B}    | []         | 93       | 15269          | 3728         | 66830           | []                     | [{danifalse.com,1}]    |
      | campaign-EHC-ST-4A    | 75396 | 244896   | false                 | 8290             | {zone-zoneset-EHC-ST-4A}    | []         | 93       | 15269          | 3728         | 66830           | [{danidom.com,1}]      | [{danifalse.com,1}]    |
      | campaign-EHC-ST-4B    | 75396 | 244896   | false                 | 8290             | {zone-zoneset-EHC-ST-4B}    | []         | 93       | 15269          | 3728         | 66830           | [{danidomInc.com,1}]   | [{danidom.com,1}]      |
      | campaign-EHC-ST-5A    | 75396 | 244896   | false                 | 8290             | {zone-zoneset-EHC-ST-5A}    | []         | 93       | 15269          | 3728         | 66830           | [{news.danidom.com,1}] | []                     |
      | campaign-EHC-ST-5B    | 75396 | 244896   | false                 | 8290             | {zone-zoneset-EHC-ST-5B}    | []         | 93       | 15269          | 3728         | 66830           | []                     | [{news.danidom.com,1}] |
      | campaign-EHC-DT-SS-7A | 75396 | 197418   | false                 | 86               | {zone-zoneset-EHC-DT-SS-7A} | []         | 69       | 15275          | 3739         | 67164           | [{danidom.com,1}]      | [{danifalse.com,1}]    |
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
      | campaign-D-HourlyPacing-ST-1 | 75396 | 247767   | false                 | 8290          | {zone-zoneset-D-HourlyPacing-ST-1} | []         | 93       | 15303          | 3821         | 69255           | []          | []          |
      | campaign-D-DailyPacing-ST-2  | 75396 | 247767   | false                 | 8290          | {zone-zoneset-D-DailyPacing-ST-2}  | []         | 93       | 15303          | 3821         | 69255           | []          | []          |
      | campaign-D-ASAP-ST-3         | 75396 | 247767   | false                 | 8290          | {zone-zoneset-D-ASAP-ST-3}         | []         | 93       | 15303          | 3821         | 69255           | []          | []          |
      | campaign-D-HourlyFF-ST-4     | 75396 | 247767   | false                 | 8290          | {zone-zoneset-D-HourlyFF-ST-4}     | []         | 93       | 15303          | 3821         | 69255           | []          | []          |
      | campaign-D-DailyFF-ST-5      | 75396 | 247767   | false                 | 8290          | {zone-zoneset-D-DailyFF-ST-5}      | []         | 93       | 15303          | 3821         | 69255           | []          | []          |

    Given I set campaign campaign-D-HourlyPacing-ST-1 for 3 days
    Given I set campaign campaign-D-DailyPacing-ST-2 for 10 days
    Given I set campaign campaign-D-ASAP-ST-3 for 3 days
    Given I set campaign campaign-D-HourlyFF-ST-4 for 3 days
    Given I set campaign campaign-D-DailyFF-ST-5 for 3 days

    And i update campaign data by name
#    deliveryPacing = 1 = hourly pacing
#    pacing = hourly flex
      | Campaign Name                | is_wholesale | skip_daily_goal | pacing | units | goal_type   |
      | campaign-D-HourlyPacing-ST-1 | 0            | 0               | 0      | 720   | impressions |
      | campaign-D-DailyPacing-ST-2  | 1            | 0               | 0      | 100   | impressions |
      | campaign-D-ASAP-ST-3         | 1            | 1               | 0      | 20    | impressions |
      | campaign-D-HourlyFF-ST-4     | 0            | 0               | 5      | 720   | impressions |
      | campaign-D-DailyFF-ST-5      | 1            | 0               | 10     | 45    | impressions |

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
      | campaign-pbl-BRAND1-ST  |
      | campaign-pbl-BRAND2-PGX |
      | campaign-pbl-BRAND3-PGX |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name           | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                    | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | campaign-pbl-BRAND1-ST  | 574531 | 251644   | false                 | 26778         | {zone-zoneset-campaign-pbl-BRAND1-ST}  | []         | 93       | 15376          | 3843         | 69625           | []          | []          |
      | campaign-pbl-BRAND2-PGX | 75396  | 222908   | false                 | 11958         | {zone-zoneset-campaign-pbl-BRAND2-PGX} | []         | 92       | 15376          | 3843         | 69608           | []          | []          |
      | campaign-pbl-BRAND3-PGX | 372125 | 234550   | false                 | 11958         | {zone-zoneset-campaign-pbl-BRAND3-PGX} | []         | 92       | 15376          | 3843         | 69608           | []          | []          |
    And i update zone data by name
      | Zone Name                            | is_secure |
      | zone-zoneset-campaign-pbl-BRAND1-ST  | 1         |
      | zone-zoneset-campaign-pbl-BRAND2-PGX | 1         |
      | zone-zoneset-campaign-pbl-BRAND3-PGX | 1         |

  @HB
  @yaniv
  Scenario: create entities for dynamic pricing with margin
    Given i disable campaigns by name on db
      | Campaign Name                                              |
      | campaign-dpm-direct-fixed-no-margin-BB-ES                  |
      | campaign-dpm-direct-fixed-margin-BB-ES                     |
      | campaign-dpm-direct-dynamic-no-margin-MR-ES                |
      | campaign-dpm-direct-dynamic-margin-MR-ES                   |
      | campaign-dpm-prog-reserved-fixed-margin-BB-ES              |
      | campaign-dpm-prog-reserved-fixed-no-margin-BB-ES           |
      | campaign-dpm-prog-reserved-dynamic-margin-MR-ES            |
      | campaign-dpm-prog-reserved-dynamic-no-margin-MR-ES         |
      | campaign-dpm-prog-non-reserved-fixed-margin-BB-ES          |
      | campaign-dpm-prog-non-reserved-fixed-no-margin-BB-ES       |
      | campaign-dpm-prog-non-reserved-dynamic-margin-MR-ES        |
      | campaign-dpm-prog-non-reserved-dynamic-20-margin-MR-ES     |
      | campaign-dpm-prog-non-reserved-dynamic-no-margin-MR-ES     |
      | campaign-dpm-prog-non-reserved-dynamic-margin-HP-ES        |
      | campaign-dpm-prog-non-reserved-dynamic-margin-MR-ES-mobile |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name                                              | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                                              | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | campaign-dpm-direct-fixed-no-margin-BB-ES                  | 75396  | 198082   | false                 | 1782          | {zone-zoneset-dpm-direct-fixed-no-margin-BB-ES}                  | []         | 58       | 15349          | 3836         | 69502           | []          | []          |
      | campaign-dpm-direct-fixed-margin-BB-ES                     | 75396  | 198082   | false                 | 1782          | {zone-zoneset-dpm-direct-fixed-margin-BB-ES}                     | []         | 58       | 15355          | 3836         | 69502           | []          | []          |
      | campaign-dpm-direct-dynamic-no-margin-MR-ES                | 75396  | 249737   | false                 | 22986         | {zone-zoneset-dpm-direct-dynamic-no-margin-MR-ES}                | []         | 10       | 15415          | 3836         | 69501           | []          | []          |
      | campaign-dpm-direct-dynamic-margin-MR-ES                   | 75396  | 249737   | false                 | 22986         | {zone-zoneset-dpm-direct-dynamic-margin-MR-ES}                   | []         | 10       | 15416          | 3836         | 69501           | []          | []          |
      | campaign-dpm-prog-reserved-fixed-margin-BB-ES              | 407981 | 224528   | true                  | 1400          | {zone-zoneset-dpm-prog-reserved-fixed-margin-BB-ES}              | []         | 58       | 15417          | 3836         | 69502           | []          | []          |
      | campaign-dpm-prog-reserved-fixed-no-margin-BB-ES           | 407981 | 224528   | true                  | 1400          | {zone-zoneset-dpm-prog-reserved-fixed-no-margin-BB-ES}           | []         | 58       | 15418          | 3836         | 69502           | []          | []          |
      | campaign-dpm-prog-reserved-dynamic-margin-MR-ES            | 407981 | 249770   | true                  | 1400          | {zone-zoneset-dpm-prog-reserved-dynamic-margin-MR-ES}            | []         | 10       | 15419          | 3836         | 69501           | []          | []          |
      | campaign-dpm-prog-reserved-dynamic-no-margin-MR-ES         | 407981 | 249770   | true                  | 1400          | {zone-zoneset-dpm-prog-reserved-dynamic-no-margin-MR-ES}         | []         | 10       | 15420          | 3836         | 69501           | []          | []          |
      | campaign-dpm-prog-non-reserved-fixed-margin-BB-ES          | 407981 | 234810   | true                  | 1401          | {zone-zoneset-dpm-prog-non-reserved-fixed-margin-BB-ES}          | []         | 58       | 15360          | 3836         | 69502           | []          | []          |
      | campaign-dpm-prog-non-reserved-fixed-no-margin-BB-ES       | 407981 | 234810   | true                  | 1401          | {zone-zoneset-dpm-prog-non-reserved-fixed-no-margin-BB-ES}       | []         | 58       | 15361          | 3836         | 69502           | []          | []          |
      | campaign-dpm-prog-non-reserved-dynamic-margin-MR-ES        | 407981 | 249772   | true                  | 1401          | {zone-zoneset-dpm-prog-non-reserved-dynamic-margin-MR-ES}        | []         | 10       | 15363          | 3836         | 69501           | []          | []          |
      | campaign-dpm-prog-non-reserved-dynamic-20-margin-MR-ES     | 407981 | 249772   | true                  | 1401          | {zone-zoneset-dpm-prog-non-reserved-dynamic-20-margin-MR-ES}     | []         | 10       | 15811          | 3836         | 69501           | []          | []          |
      | campaign-dpm-prog-non-reserved-dynamic-no-margin-MR-ES     | 407981 | 249772   | true                  | 1401          | {zone-zoneset-dpm-prog-non-reserved-dynamic-no-margin-MR-ES}     | []         | 10       | 15362          | 3836         | 69501           | []          | []          |
      | campaign-dpm-prog-non-reserved-dynamic-margin-HP-ES        | 407981 | 251116   | true                  | 1401          | {zone-zoneset-dpm-prog-non-reserved-dynamic-margin-HP-ES}        | []         | 29       | 15356          | 3836         | 69503           | []          | []          |
      | campaign-dpm-prog-non-reserved-dynamic-margin-MR-ES-mobile | 407981 | 251035   | true                  | 1401          | {zone-zoneset-dpm-prog-non-reserved-dynamic-margin-MR-ES-mobile} | []         | 10       | 15359          | 3836         | 69501           | []          | []          |

    And i update campaign data by name
      | Campaign Name                                              | hb_desktop_bid_price_percentage | hb_mobile_bid_price_percentage | priority | use_default_margin |
      | campaign-dpm-direct-fixed-margin-BB-ES                     | 20                              | 20                             | -1       | 0                  |
      | campaign-dpm-direct-dynamic-margin-MR-ES                   | 30                              | 30                             | -1       | 0                  |
      | campaign-dpm-prog-reserved-fixed-margin-BB-ES              | 20                              | 20                             | -2       | 0                  |
      | campaign-dpm-prog-reserved-dynamic-margin-MR-ES            | 20                              | 60                             | -2       | 0                  |
      | campaign-dpm-prog-non-reserved-fixed-margin-BB-ES          | 90                              | 90                             | -2       | 0                  |
      | campaign-dpm-prog-non-reserved-dynamic-margin-MR-ES        | 0                               | 0                              | -2       | 0                  |
      | campaign-dpm-prog-non-reserved-dynamic-20-margin-MR-ES     | 20                              | 20                             | -2       | 0                  |
      | campaign-dpm-prog-non-reserved-dynamic-margin-HP-ES        | 70                              | 70                             | -2       | 0                  |
      | campaign-dpm-prog-non-reserved-dynamic-margin-MR-ES-mobile | 90                              | 20                             | -2       | 0                  |

    And i update campaign data by name
      | Campaign Name                                          | priority |
      | campaign-dpm-direct-fixed-no-margin-BB-ES              | -1       |
      | campaign-dpm-prog-non-reserved-fixed-no-margin-BB-ES   | -2       |
      | campaign-dpm-prog-reserved-fixed-no-margin-BB-ES       | -2       |
      | campaign-dpm-prog-non-reserved-dynamic-no-margin-MR-ES | -2       |

    And i update zone data by name
      | Zone Name                                                      | is_secure |
      | zone-zoneset-dpm-direct-fixed-no-margin-BB-ES                  | 1         |
      | zone-zoneset-dpm-direct-fixed-margin-BB-ES                     | 1         |
      | zone-zoneset-dpm-direct-dynamic-no-margin-MR-ES                | 1         |
      | zone-zoneset-dpm-direct-dynamic-margin-MR-ES                   | 1         |
      | zone-zoneset-dpm-prog-reserved-fixed-margin-BB-ES              | 1         |
      | zone-zoneset-dpm-prog-reserved-fixed-no-margin-BB-ES           | 1         |
      | zone-zoneset-dpm-prog-reserved-dynamic-margin-MR-ES            | 1         |
      | zone-zoneset-dpm-prog-reserved-dynamic-no-margin-MR-ES         | 1         |
      | zone-zoneset-dpm-prog-non-reserved-fixed-margin-BB-ES          | 1         |
      | zone-zoneset-dpm-prog-non-reserved-fixed-no-margin-BB-ES       | 1         |
      | zone-zoneset-dpm-prog-non-reserved-dynamic-margin-MR-ES        | 1         |
      | zone-zoneset-dpm-prog-non-reserved-dynamic-20-margin-MR-ES     | 1         |
      | zone-zoneset-dpm-prog-non-reserved-dynamic-no-margin-MR-ES     | 1         |
      | zone-zoneset-dpm-prog-non-reserved-dynamic-margin-HP-ES        | 1         |
      | zone-zoneset-dpm-prog-non-reserved-dynamic-margin-MR-ES-mobile | 1         |


  @NDQFilteringTest
  Scenario: create entities for NDQ filtering
    Given i disable campaigns by name on db
      | Campaign Name       |
      | NDQfilteringTL-ST-1 |
      | NDQfilteringTL-ST-2 |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name       | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | NDQfilteringTL-ST-1 | 75396 | 210722   | false                 | 8290          | {zone-zoneset-NDQfilteringTL-ST-1} | []         | 93       | 15556          | 3843         | 69625           | []          | []          |
      | NDQfilteringTL-ST-2 | 75396 | 210722   | false                 | 8290          | {zone-zoneset-NDQfilteringTL-ST-2} | []         | 93       | 15556          | 3843         | 69625           | []          | []          |

    Given I set campaign NDQfilteringTL-ST-1 for 10 days

    And i update campaign data by name
      | Campaign Name       | factor | units | goal_type   |
      | NDQfilteringTL-ST-1 | 0.0    | 1000  | impressions |
      | NDQfilteringTL-ST-2 | 0.0    | 1000  | impressions |

    And i update zone data by name
      | Zone Name                        | is_secure |
      | zone-zoneset-NDQfilteringTL-ST-1 | 1         |
      | zone-zoneset-NDQfilteringTL-ST-2 | 1         |

  Scenario: Create Entities for brand reveal 300*600
    Given i disable campaigns by name on db
      | Campaign Name                               |
      | NewBrandReveal-BR-Direct                    |
      | NewBrandReveal-BR-PROG-NonGuaranteed        |
      | NewBrandReveal-BR-PROG-NonGuaranteed600x600 |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name                               | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                                        | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | NewBrandReveal-BR-PROG-NonGuaranteed        | 407981 | 253287   | true                  | 1653          | {zone-zoneset-NewBrandReveal-BR-PROG-NonGuaranteed}        | []         | 95       | 15376          | 3728         | 69810           | []             | []             |
      | NewBrandReveal-BR-PROG-NonGuaranteed600x600 | 407981 | 253748   | true                  | 1652          | {zone-zoneset-NewBrandReveal-BR-PROG-NonGuaranteed600x600} | []         | 95       | 15376          | 3728         | 69810           | []             | []             |
      | NewBrandReveal-BR-Direct                    | 407981 | 253288   | false                 | 28428         | {zone-zoneset-NewBrandReveal-BR-Direct}                    | []         | 95       | 15376          | 3728         | 69810           | []             | []             |

    And i update campaign data by name
      | Campaign Name                               | units | goal_type   |
      | NewBrandReveal-BR-Direct                    | -1    | impressions |
      | NewBrandReveal-BR-PROG-NonGuaranteed        | -1    | impressions |
      | NewBrandReveal-BR-PROG-NonGuaranteed600x600 | -1    | impressions |

    And i update zone data by name
      | Zone Name                                                | is_secure |
      | zone-zoneset-NewBrandReveal-BR-Direct                    | 1         |
      | zone-zoneset-NewBrandReveal-BR-PROG-NonGuaranteed        | 1         |
      | zone-zoneset-NewBrandReveal-BR-PROG-NonGuaranteed600x600 | 1         |

    And i update banner data by name
      | Banner Name                                          | limitation |
      | NewBrandReveal-BR-Direct-banner-1                    | []         |
      | NewBrandReveal-BR-PROG-NonGuaranteed-banner-1        | []         |
      | NewBrandReveal-BR-PROG-NonGuaranteed600x600-banner-1 | []         |


 ##  %%%%%%%%%%%%%     Video Duration Filter --> duration & skip  %%%%%%%%%%%%%
  Scenario: create entities for Linear Video Duration
    Given i disable campaigns by name on db
      | Campaign Name                      |
      | campaign-large-D-skip-Y            |
      | campaign-small-D-skip-Y            |
      | campaign-large-D-skip-N            |
      | campaign-small-D-skip-N            |
      | campaign-equal-D-skip-Y            |
      | campaign-equal-D-skip-N            |
      | campaign-pub1-level-large-D-skip-Y |
      | campaign-pub1-level-small-D-skip-Y |
      | campaign-pub1-level-large-D-skip-N |
      | campaign-pub1-level-small-D-skip-N |
      | campaign-pub1-level-equal-D-skip-Y |
      | campaign-pub1-level-equal-D-skip-N |
      | campaign-pub2-level-large-D-skip-Y |
      | campaign-pub2-level-small-D-skip-Y |
      | campaign-pub2-level-large-D-skip-N |
      | campaign-pub2-level-small-D-skip-N |
      | campaign-pub2-level-equal-D-skip-Y |
      | campaign-pub2-level-equal-D-skip-N |
    #*************  Video Adhesion duration filter *************
      | video-adhesion-campaign-30-skip-Y  |
      | video-adhesion-campaign-30-skip-N  |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name                      | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                               | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | campaign-large-D-skip-Y            | 75396 | 259848   | false                 | 31793         | {zone-zoneset-large-D-skip-Y-CS-Video}            | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-small-D-skip-Y            | 75396 | 259848   | false                 | 31797         | {zone-zoneset-small-D-skip-Y-CS-Video}            | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-large-D-skip-N            | 75396 | 259848   | false                 | 31792         | {zone-zoneset-large-D-skip-N-CS-Video}            | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-small-D-skip-N            | 75396 | 259848   | false                 | 31796         | {zone-zoneset-small-D-skip-N-CS-Video}            | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-equal-D-skip-Y            | 75396 | 259848   | false                 | 31795         | {zone-zoneset-equal-D-skip-Y-CS-Video}            | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-equal-D-skip-N            | 75396 | 259848   | false                 | 31794         | {zone-zoneset-equal-D-skip-N-CS-Video}            | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-pub1-level-large-D-skip-Y | 75396 | 259848   | false                 | 31793         | {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} | []         | 35       | 15376          | 3843         | 70473           | []          | []          |
      | campaign-pub1-level-small-D-skip-Y | 75396 | 259848   | false                 | 31797         | {zone-zoneset-pub1-level-small-D-skip-Y-CS-Video} | []         | 35       | 15376          | 3843         | 70473           | []          | []          |
      | campaign-pub1-level-large-D-skip-N | 75396 | 259848   | false                 | 31792         | {zone-zoneset-pub1-level-large-D-skip-N-CS-Video} | []         | 35       | 15376          | 3843         | 70473           | []          | []          |
      | campaign-pub1-level-small-D-skip-N | 75396 | 259848   | false                 | 31796         | {zone-zoneset-pub1-level-small-D-skip-N-CS-Video} | []         | 35       | 15376          | 3843         | 70473           | []          | []          |
      | campaign-pub1-level-equal-D-skip-Y | 75396 | 259848   | false                 | 31795         | {zone-zoneset-pub1-level-equal-D-skip-Y-CS-Video} | []         | 35       | 15376          | 3843         | 70473           | []          | []          |
      | campaign-pub1-level-equal-D-skip-N | 75396 | 259848   | false                 | 31794         | {zone-zoneset-pub1-level-equal-D-skip-N-CS-Video} | []         | 35       | 15376          | 3843         | 70473           | []          | []          |
      | campaign-pub2-level-large-D-skip-Y | 75396 | 259848   | false                 | 31793         | {zone-zoneset-pub2-level-large-D-skip-Y-CS-Video} | []         | 35       | 15227          | 3728         | 70474           | []          | []          |
      | campaign-pub2-level-small-D-skip-Y | 75396 | 259848   | false                 | 31797         | {zone-zoneset-pub2-level-small-D-skip-Y-CS-Video} | []         | 35       | 15227          | 3728         | 70474           | []          | []          |
      | campaign-pub2-level-large-D-skip-N | 75396 | 259848   | false                 | 31792         | {zone-zoneset-pub2-level-large-D-skip-N-CS-Video} | []         | 35       | 15227          | 3728         | 70474           | []          | []          |
      | campaign-pub2-level-small-D-skip-N | 75396 | 259848   | false                 | 31796         | {zone-zoneset-pub2-level-small-D-skip-N-CS-Video} | []         | 35       | 15227          | 3728         | 70474           | []          | []          |
      | campaign-pub2-level-equal-D-skip-Y | 75396 | 259848   | false                 | 31795         | {zone-zoneset-pub2-level-equal-D-skip-Y-CS-Video} | []         | 35       | 15227          | 3728         | 70474           | []          | []          |
      | campaign-pub2-level-equal-D-skip-N | 75396 | 259848   | false                 | 31794         | {zone-zoneset-pub2-level-equal-D-skip-N-CS-Video} | []         | 35       | 15227          | 3728         | 70474           | []          | []          |
 #*************  Video Adhesion duration filter *************
      | campaign-vid-adhesion-30-skip-Y    | 75396 | 255831   | false                 | 32965         | {zone-zoneset-video-adhesion-campaign-30-skip-Y}  | []         | 97       | 15196          | 3708         | 69992           | []          | []          |
      | campaign-vid-adhesion-30-skip-N    | 75396 | 255831   | false                 | 32966         | {zone-zoneset-video-adhesion-campaign-30-skip-N}  | []         | 97       | 15196          | 3708         | 69992           | []          | []          |

         # ****  update is_sync=1 & is_video=1 parameters of the campaign ***
    And i update campaign data by name
      | Campaign Name                      | is_sync | is_video | goal_type   |
      | campaign-large-D-skip-Y            | 1       | 1        | impressions |
      | campaign-small-D-skip-Y            | 1       | 1        | impressions |
      | campaign-large-D-skip-N            | 1       | 1        | impressions |
      | campaign-small-D-skip-N            | 1       | 1        | impressions |
      | campaign-equal-D-skip-Y            | 1       | 1        | impressions |
      | campaign-equal-D-skip-N            | 1       | 1        | impressions |
      | campaign-pub1-level-large-D-skip-Y | 1       | 1        | impressions |
      | campaign-pub1-level-small-D-skip-Y | 1       | 1        | impressions |
      | campaign-pub1-level-large-D-skip-N | 1       | 1        | impressions |
      | campaign-pub1-level-small-D-skip-N | 1       | 1        | impressions |
      | campaign-pub1-level-equal-D-skip-Y | 1       | 1        | impressions |
      | campaign-pub1-level-equal-D-skip-N | 1       | 1        | impressions |
      | campaign-pub2-level-large-D-skip-Y | 1       | 1        | impressions |
      | campaign-pub2-level-small-D-skip-Y | 1       | 1        | impressions |
      | campaign-pub2-level-large-D-skip-N | 1       | 1        | impressions |
      | campaign-pub2-level-small-D-skip-N | 1       | 1        | impressions |
      | campaign-pub2-level-equal-D-skip-Y | 1       | 1        | impressions |
      | campaign-pub2-level-equal-D-skip-N | 1       | 1        | impressions |
      | campaign-vid-adhesion-30-skip-Y    | 1       | 1        | impressions |
      | campaign-vid-adhesion-30-skip-N    | 1       | 1        | impressions |

# ****  update is_sync=1 & is_secure=1 parameters of the zone ***
    And i update zone data by name
      | Zone Name                                       | is_secure | is_sync |
      | zone-zoneset-large-D-skip-Y-CS-Video            | 1         | 1       |
      | zone-zoneset-small-D-skip-Y-CS-Video            | 1         | 1       |
      | zone-zoneset-large-D-skip-N-CS-Video            | 1         | 1       |
      | zone-zoneset-small-D-skip-N-CS-Video            | 1         | 1       |
      | zone-zoneset-equal-D-skip-Y-CS-Video            | 1         | 1       |
      | zone-zoneset-equal-D-skip-N-CS-Video            | 1         | 1       |
      | zone-zoneset-pub1-level-large-D-skip-Y-CS-Video | 1         | 1       |
      | zone-zoneset-pub1-level-small-D-skip-Y-CS-Video | 1         | 1       |
      | zone-zoneset-pub1-level-large-D-skip-N-CS-Video | 1         | 1       |
      | zone-zoneset-pub1-level-small-D-skip-N-CS-Video | 1         | 1       |
      | zone-zoneset-pub1-level-equal-D-skip-Y-CS-Video | 1         | 1       |
      | zone-zoneset-pub1-level-equal-D-skip-N-CS-Video | 1         | 1       |
      | zone-zoneset-pub2-level-large-D-skip-Y-CS-Video | 1         | 1       |
      | zone-zoneset-pub2-level-small-D-skip-Y-CS-Video | 1         | 1       |
      | zone-zoneset-pub2-level-large-D-skip-N-CS-Video | 1         | 1       |
      | zone-zoneset-pub2-level-small-D-skip-N-CS-Video | 1         | 1       |
      | zone-zoneset-pub2-level-equal-D-skip-Y-CS-Video | 1         | 1       |
      | zone-zoneset-pub2-level-equal-D-skip-N-CS-Video | 1         | 1       |
      | zone-zoneset-video-adhesion-campaign-30-skip-Y  | 1         | 1       |
      | zone-zoneset-video-adhesion-campaign-30-skip-N  | 1         | 1       |

# ****  update is_sync=1 & is_video=1 parameters of the zoneset ***
    And i update zoneset data by name
      | Zoneset Name                                    | is_sync | is_video |
      | zone-zoneset-large-D-skip-Y-CS-Video            | 1       | 1        |
      | zone-zoneset-small-D-skip-Y-CS-Video            | 1       | 1        |
      | zone-zoneset-large-D-skip-N-CS-Video            | 1       | 1        |
      | zone-zoneset-small-D-skip-N-CS-Video            | 1       | 1        |
      | zone-zoneset-equal-D-skip-Y-CS-Video            | 1       | 1        |
      | zone-zoneset-equal-D-skip-N-CS-Video            | 1       | 1        |
      | zone-zoneset-pub1-level-large-D-skip-Y-CS-Video | 1       | 1        |
      | zone-zoneset-pub1-level-small-D-skip-Y-CS-Video | 1       | 1        |
      | zone-zoneset-pub1-level-large-D-skip-N-CS-Video | 1       | 1        |
      | zone-zoneset-pub1-level-small-D-skip-N-CS-Video | 1       | 1        |
      | zone-zoneset-pub1-level-equal-D-skip-Y-CS-Video | 1       | 1        |
      | zone-zoneset-pub1-level-equal-D-skip-N-CS-Video | 1       | 1        |
      | zone-zoneset-pub2-level-large-D-skip-Y-CS-Video | 1       | 1        |
      | zone-zoneset-pub2-level-small-D-skip-Y-CS-Video | 1       | 1        |
      | zone-zoneset-pub2-level-large-D-skip-N-CS-Video | 1       | 1        |
      | zone-zoneset-pub2-level-small-D-skip-N-CS-Video | 1       | 1        |
      | zone-zoneset-pub2-level-equal-D-skip-Y-CS-Video | 1       | 1        |
      | zone-zoneset-pub2-level-equal-D-skip-N-CS-Video | 1       | 1        |
     #*************  Video Adhesion duration filter *************
      | zone-zoneset-video-adhesion-campaign-30-skip-Y  | 1       | 1        |
      | zone-zoneset-video-adhesion-campaign-30-skip-N  | 1       | 1        |



  ##  &&&&&&&&&&&&&&&&&    Video limitation Filtering --> size & method    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

  Scenario: create entities for linear video filtering
    Given i disable campaigns by name on db
      | Campaign Name                                       |
      | campaign-LinearVideoFiltering-playbackAll-noSize    |
      | campaign-LinearVideoFiltering-playback1-size1       |
      | campaign-LinearVideoFiltering-playback2-size2       |
      | campaign-LinearVideoFiltering-playback3-size3       |
      | campaign-LinearVideoFiltering-playback4-allsizes    |
      | campaign-LinearVideoFiltering-playbackAll-size3     |
      | campaign-LinearVideoFiltering-playbackall-allsizes  |
      | campaign-LinearVideoFiltering-noPlayback-allsizes   |
      | campaign-LinearVideoFiltering-noPlayback-noSize     |
      | campaign-LinearVideoFiltering-noPlayback-sizes1And2 |

    Given i create new campaigns, new zoneset with video params
      | Campaign Name                                       | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                                       | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude | player_size_id | playback_method_id |
      | campaign-LinearVideoFiltering-playbackAll-noSize    | 75396 | 234808   | false                 | 24176         | {zone-zoneset-LinearVideoFiltering-playbackAll-noSize}    | []         | 35       | 15196          | 3708         | 69158           | []          | []          |                | 1,2,3,4            |
      | campaign-LinearVideoFiltering-playback1-size1       | 75396 | 234808   | false                 | 24176         | {zone-zoneset-LinearVideoFiltering-playback1-size1}       | []         | 35       | 15196          | 3708         | 69158           | []          | []          | 1              | 1                  |
      | campaign-LinearVideoFiltering-playback2-size2       | 75396 | 234808   | false                 | 24176         | {zone-zoneset-LinearVideoFiltering-playback2-size2}       | []         | 35       | 15196          | 3708         | 69158           | []          | []          | 2              | 2                  |
      | campaign-LinearVideoFiltering-playback3-size3       | 75396 | 234808   | false                 | 24176         | {zone-zoneset-LinearVideoFiltering-playback3-size3}       | []         | 35       | 15196          | 3708         | 69158           | []          | []          | 3              | 3                  |
      | campaign-LinearVideoFiltering-playback4-allsizes    | 75396 | 234808   | false                 | 24176         | {zone-zoneset-LinearVideoFiltering-playback4-allsizes}    | []         | 35       | 15196          | 3708         | 69158           | []          | []          | 1,2,3          | 4                  |
      | campaign-LinearVideoFiltering-playbackAll-size3     | 75396 | 234808   | false                 | 24176         | {zone-zoneset-LinearVideoFiltering-playbackAll-size3}     | []         | 35       | 15196          | 3708         | 69158           | []          | []          | 3              | 1,2,3,4            |
      | campaign-LinearVideoFiltering-playbackall-allsizes  | 75396 | 234808   | false                 | 24176         | {zone-zoneset-LinearVideoFiltering-playbackall-allsizes}  | []         | 35       | 15196          | 3708         | 69158           | []          | []          | 1,2,3          | 1,2,3,4            |
      | campaign-LinearVideoFiltering-noPlayback-allsizes   | 75396 | 234808   | false                 | 24176         | {zone-zoneset-LinearVideoFiltering-noPlayback-allsizes}   | []         | 35       | 15196          | 3708         | 69158           | []          | []          | 1,2,3          |                    |
      | campaign-LinearVideoFiltering-noPlayback-noSize     | 75396 | 234808   | false                 | 24176         | {zone-zoneset-LinearVideoFiltering-noPlayback-noSize}     | []         | 35       | 15196          | 3708         | 69158           | []          | []          |                |                    |
      | campaign-LinearVideoFiltering-noPlayback-sizes1And2 | 75396 | 234808   | false                 | 24176         | {zone-zoneset-LinearVideoFiltering-noPlayback-sizes1And2} | []         | 35       | 15196          | 3708         | 69158           | []          | []          | 1,2            |                    |

    And i update campaign data by name
      | Campaign Name                                       | units | goal_type   | is_sync | is_video |
      | campaign-LinearVideoFiltering-playbackAll-noSize    | -1    | impressions | 1       | 1        |
      | campaign-LinearVideoFiltering-playback1-size1       | -1    | impressions | 1       | 1        |
      | campaign-LinearVideoFiltering-playback2-size2       | -1    | impressions | 1       | 1        |
      | campaign-LinearVideoFiltering-playback3-size3       | -1    | impressions | 1       | 1        |
      | campaign-LinearVideoFiltering-playback4-allsizes    | -1    | impressions | 1       | 1        |
      | campaign-LinearVideoFiltering-playbackAll-size3     | -1    | impressions | 1       | 1        |
      | campaign-LinearVideoFiltering-playbackall-allsizes  | -1    | impressions | 1       | 1        |
      | campaign-LinearVideoFiltering-noPlayback-allsizes   | -1    | impressions | 1       | 1        |
      | campaign-LinearVideoFiltering-noPlayback-noSize     | -1    | impressions | 1       | 1        |
      | campaign-LinearVideoFiltering-noPlayback-sizes1And2 | -1    | impressions | 1       | 1        |
# ****  update is_sync=1 & is_secure=1 parameters of the zone ***
    And i update zone data by name
      | Zone Name                                               | is_secure | is_sync |
      | zone-zoneset-LinearVideoFiltering-playbackAll-noSize    | 1         | 1       |
      | zone-zoneset-LinearVideoFiltering-playback1-size1       | 1         | 1       |
      | zone-zoneset-LinearVideoFiltering-playback2-size2       | 1         | 1       |
      | zone-zoneset-LinearVideoFiltering-playback3-size3       | 1         | 1       |
      | zone-zoneset-LinearVideoFiltering-playback4-allsizes    | 1         | 1       |
      | zone-zoneset-LinearVideoFiltering-playbackAll-size3     | 1         | 1       |
      | zone-zoneset-LinearVideoFiltering-playbackall-allsizes  | 1         | 1       |
      | zone-zoneset-LinearVideoFiltering-noPlayback-allsizes   | 1         | 1       |
      | zone-zoneset-LinearVideoFiltering-noPlayback-noSize     | 1         | 1       |
      | zone-zoneset-LinearVideoFiltering-noPlayback-sizes1And2 | 1         | 1       |

    # ****  update is_sync=1 & is_video=1 parameters of the zoneset ***
    And i update zoneset data by name
      | Zoneset Name                                            | is_sync | is_video |
      | zone-zoneset-LinearVideoFiltering-playbackAll-noSize    | 1       | 1        |
      | zone-zoneset-LinearVideoFiltering-playback1-size1       | 1       | 1        |
      | zone-zoneset-LinearVideoFiltering-playback2-size2       | 1       | 1        |
      | zone-zoneset-LinearVideoFiltering-playback3-size3       | 1       | 1        |
      | zone-zoneset-LinearVideoFiltering-playback4-allsizes    | 1       | 1        |
      | zone-zoneset-LinearVideoFiltering-playbackAll-size3     | 1       | 1        |
      | zone-zoneset-LinearVideoFiltering-playbackall-allsizes  | 1       | 1        |
      | zone-zoneset-LinearVideoFiltering-noPlayback-allsizes   | 1       | 1        |
      | zone-zoneset-LinearVideoFiltering-noPlayback-noSize     | 1       | 1        |
      | zone-zoneset-LinearVideoFiltering-noPlayback-sizes1And2 | 1       | 1        |


   ##  %%%%%%%%%%%%%    VIDEO Wrapper IAS, MOAT , DV    %%%%%%%%%%%%%

  Scenario:  create entites for instream_video viewbility
    Given i disable campaigns by name on db
      | Campaign Name              |
      | campaign-IAS-wrapper-CSVB  |
      | campaign-MOAT-wrapper-CSVB |
      | campaign-DV-wrapper-CSVB   |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name              | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name              | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-IAS-wrapper-CSVB  | 75396 | 259848   | false                 | 31797         | {zone-zoneset-IAS-wrapper-CSVB}  | []         | 35       | 15196          | 3708         | 69158           | []             | []             |
      | campaign-MOAT-wrapper-CSVB | 75396 | 259848   | false                 | 31797         | {zone-zoneset-MOAT-wrapper-CSVB} | []         | 35       | 15196          | 3708         | 69158           | []             | []             |
      | campaign-DV-wrapper-CSVB   | 75396 | 259848   | false                 | 31797         | {zone-zoneset-DV-wrapper-CSVB}   | []         | 35       | 15196          | 3708         | 69158           | []             | []             |
     # ****  update is_sync=1 & is_video=1 parameters of the campaign ***
    And i update campaign data by name
      | Campaign Name              | is_sync | is_video | viewability_wrapper_enabled | viewability_wrapper_vendor |
      | campaign-IAS-wrapper-CSVB  | 1       | 1        | 1                           | IAS                        |
      | campaign-MOAT-wrapper-CSVB | 1       | 1        | 1                           | MOAT                       |
      | campaign-DV-wrapper-CSVB   | 1       | 1        | 1                           | DV                         |

    And i update zone data by name
      | Zone Name                      | is_sync |
      | zone-zoneset-IAS-wrapper-CSVB  | 1       |
      | zone-zoneset-MOAT-wrapper-CSVB | 1       |
      | zone-zoneset-DV-wrapper-CSVB   | 1       |
     # ****  update is_sync=1 & is_video=1 parameter of the zoneset ***
    And i update zoneset data by name
      | Zoneset Name                   | is_sync | is_video |
      | zone-zoneset-IAS-wrapper-CSVB  | 1       | 1        |
      | zone-zoneset-MOAT-wrapper-CSVB | 1       | 1        |
      | zone-zoneset-DV-wrapper-CSVB   | 1       | 1        |

# Entities for New Render Test

#   disable re-creating entities   @NewRenderTest

  Scenario: Create entities for New Render
    Given i disable campaigns by name on db
      | Campaign Name                                           |
      | campaign-NewRenderTest-web-direct-zone-banner           |
      | campaign-NewRenderTest-web-direct-DT-banner             |
      | campaign-NewRenderTest-web-direct-HB-banner             |
      | campaign-NewRenderTest-web-programmatic-zone-banner     |
      | campaign-NewRenderTest-web-programmatic-HB-banner       |
      | campaign-NewRenderTest-web-programmatic-DT-banner       |
      | campaign-NewRenderTest-web-direct-zone-PGAction         |
      | campaign-NewRenderTest-web-direct-DT-PGAction           |
      | campaign-NewRenderTest-web-programmatic-zone-PGAction   |
      | campaign-NewRenderTest-web-programmatic-DT-PGAction     |
      | campaign-NewRenderTest-web-direct-zone-video            |
      | campaign-NewRenderTest-web-direct-DT-video              |
      | campaign-NewRenderTest-web-direct-HB-video              |
      | campaign-NewRenderTest-web-programmatic-zone-video      |
      | campaign-NewRenderTest-web-programmatic-DT-video        |
      | campaign-NewRenderTest-web-programmatic-HB-video        |
      | campaign-NewRenderTest-VidAd-w/o-leave-behind-zone      |
      | campaign-NewRenderTest-VidAd-w/o-leave-behind-zone-prog |
      | campaign-NewRenderTest-Instream-View-zone               |
      | campaign-NewRenderTest-Instream-View-SP                 |
      | campaign-NewRenderTest-InApp-Direct                     |
      | campaign-NewRenderTest-InApp-Programmatic               |
      | campaign-NewRenderTest-web-direct-event-trackers        |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name                                           | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                                        | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | campaign-NewRenderTest-web-direct-zone-banner           | 75396  | 241783   | false                 | 1068          | {zone-zoneset-NewRenderTest-Direct-Zone-Regular}           | []         | 75       | 5893           | 3728         | 66832           | []          | []          |
      | campaign-NewRenderTest-web-direct-DT-banner             | 75396  | 241783   | false                 | 1068          | {zone-zoneset-NewRenderTest-Direct-DT-Regular}             | []         | 75       | 11278          | 3728         | 66832           | []          | []          |
      | campaign-NewRenderTest-web-direct-HB-banner             | 75396  | 249737   | false                 | 22986         | {zone-zoneset-NewRenderTest-Direct-HB-Regular}             | []         | 10       | 10062          | 3673         | 66814           | []          | []          |
      | campaign-NewRenderTest-web-programmatic-zone-banner     | 407981 | 265088   | true                  | 2498          | {zone-zoneset-NewRenderTest-Prog-Zone}                     | []         | 75       | 2080           | 3728         | 66832           | []          | []          |
      | campaign-NewRenderTest-web-programmatic-HB-banner       | 407981 | 265089   | true                  | 2499          | {zone-zoneset-NewRenderTest-Prog-HB}                       | []         | 10       | 2080           | 3728         | 66833           | []          | []          |
      | campaign-NewRenderTest-web-programmatic-DT-banner       | 407981 | 265088   | true                  | 2498          | {zone-zoneset-NewRenderTest-Prog-DT}                       | []         | 75       | 15015          | 3728         | 66832           | []          | []          |
      | campaign-NewRenderTest-web-direct-zone-PGAction         | 75396  | 222908   | false                 | 14488         | {zone-zoneset-NewRenderTest-Direct-Zone-PGAction}          | []         | 92       | 14400          | 3673         | 67165           | []          | []          |
      | campaign-NewRenderTest-web-direct-DT-PGAction           | 75396  | 222908   | false                 | 14488         | {zone-zoneset-NewRenderTest-Direct-DT-PGAction}            | []         | 92       | 15122          | 3673         | 67165           | []          | []          |
      | campaign-NewRenderTest-web-programmatic-zone-PGAction   | 407981 | 265090   | true                  | 2500          | {zone-zoneset-NewRenderTest-Prog-Zone-PGAction}            | []         | 92       | 14400          | 3673         | 67165           | []          | []          |
      | campaign-NewRenderTest-web-programmatic-DT-PGAction     | 407981 | 265090   | true                  | 2500          | {zone-zoneset-NewRenderTest-Prog-DT-PGAction}              | []         | 92       | 3047           | 3673         | 67165           | []          | []          |
      | campaign-NewRenderTest-web-direct-zone-video            | 75396  | 243707   | false                 | 21638         | {zone-zoneset-NewRenderTest-web-direct-zone-video}         | []         | 97       | 15196          | 3708         | 69992           | []          | []          |
      | campaign-NewRenderTest-web-direct-DT-video              | 75396  | 243707   | false                 | 21638         | {zone-zoneset-NewRenderTest-web-direct-DT-video}           | []         | 97       | 8615           | 3708         | 69992           | []          | []          |
      | campaign-NewRenderTest-web-direct-HB-video              | 75396  | 243707   | false                 | 21638         | {zone-zoneset-NewRenderTest-web-direct-HB-video}           | []         | 97       | 739            | 3708         | 69992           | []          | []          |
      | campaign-NewRenderTest-web-programmatic-zone-video      | 407981 | 265091   | true                  | 2501          | {zone-zoneset-NewRenderTest-web-programmatic-zone-video}   | []         | 97       | 15196          | 3708         | 69992           | []          | []          |
      | campaign-NewRenderTest-web-programmatic-DT-video        | 407981 | 265091   | true                  | 2501          | {zone-zoneset-NewRenderTest-web-programmatic-DT-video}     | []         | 97       | 6831           | 3708         | 69992           | []          | []          |
      | campaign-NewRenderTest-web-programmatic-HB-video        | 407981 | 265091   | true                  | 2501          | {zone-zoneset-NewRenderTest-web-programmatic-HB-video}     | []         | 97       | 4140           | 3708         | 69992           | []          | []          |
      | campaign-NewRenderTest-VidAd-w/o-leave-behind-zone      | 407981 | 248986   | false                 | 25108         | {zone-zoneset-NewRenderTest-VidAd-w/o-leave-behind-zone}   | []         | 97       | 14066          | 3708         | 70156           | []          | []          |
      | campaign-NewRenderTest-VidAd-w/o-leave-behind-zone-prog | 407981 | 265092   | true                  | 2502          | {zone-zoneset-NewRenderTest-VidAd-w/o-leave-behind-zone-P} | []         | 97       | 14066          | 3708         | 70156           | []          | []          |
      | campaign-NewRenderTest-Instream-View-zone               | 75396  | 234808   | false                 | 24176         | {zone-zoneset-NewRenderTest-Instream-View-direct}          | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-NewRenderTest-Instream-View-SP                 | 407981 | 265093   | true                  | 2503          | {zone-zoneset-NewRenderTest-Instream-View-programmatic}    | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-NewRenderTest-web-direct-event-trackers        | 75396  | 249737   | false                 | 97            | {zone-zoneset-NewRenderTest-Direct-event-trackers}         | []         | 10       | 2080           | 3728         | 66833           | []          | []          |

    And i create new campaigns with new zoneset
      | Campaign Name                             | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                             | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-NewRenderTest-InApp-Direct       | 75396  | 241783   | false                 | 14619         | {zone-zoneset-NewRenderTest-InApp-Direct}       | []         | 80       | 8803           | 3586         | 67260           |
      | campaign-NewRenderTest-InApp-Programmatic | 407981 | 265094   | true                  | 2504          | {zone-zoneset-NewRenderTest-InApp-Programmatic} | []         | 80       | 8803           | 3586         | 67260           |

    And i create new zone named {zone-zoneset-NewRenderTest-Passback} with limitation {[]} with adUnitId 75 and web_section id 2080 with affiliateId 3728 with po_line_item_id 66832

    And i update zone data by name
      | Zone Name                                                | is_secure |
      | zone-zoneset-NewRenderTest-Direct-Zone-Regular           | 1         |
      | zone-zoneset-NewRenderTest-Direct-DT-Regular             | 1         |
      | zone-zoneset-NewRenderTest-Direct-HB-Regular             | 1         |
      | zone-zoneset-NewRenderTest-Prog-Zone                     | 1         |
      | zone-zoneset-NewRenderTest-Prog-HB                       | 1         |
      | zone-zoneset-NewRenderTest-Prog-DT                       | 1         |
      | zone-zoneset-NewRenderTest-Direct-Zone-PGAction          | 1         |
      | zone-zoneset-NewRenderTest-Direct-DT-PGAction            | 1         |
      | zone-zoneset-NewRenderTest-Prog-Zone-PGAction            | 1         |
      | zone-zoneset-NewRenderTest-Prog-DT-PGAction              | 1         |
      | zone-zoneset-NewRenderTest-web-direct-zone-video         | 1         |
      | zone-zoneset-NewRenderTest-web-direct-DT-video           | 1         |
      | zone-zoneset-NewRenderTest-web-direct-HB-video           | 1         |
      | zone-zoneset-NewRenderTest-web-programmatic-zone-video   | 1         |
      | zone-zoneset-NewRenderTest-web-programmatic-DT-video     | 1         |
      | zone-zoneset-NewRenderTest-web-programmatic-HB-video     | 1         |
      | zone-zoneset-NewRenderTest-InApp-Direct                  | 1         |
      | zone-zoneset-NewRenderTest-InApp-Programmatic            | 1         |
      | zone-zoneset-NewRenderTest-VidAd-w/o-leave-behind-zone   | 1         |
      | zone-zoneset-NewRenderTest-VidAd-w/o-leave-behind-zone-P | 1         |
      | zone-zoneset-NewRenderTest-Instream-View-direct          | 1         |
      | zone-zoneset-NewRenderTest-Instream-View-programmatic    | 1         |
      | zone-zoneset-NewRenderTest-Direct-event-trackers         | 1         |
      | zone-zoneset-NewRenderTest-Passback                      | 1         |

    And i update zone data by name
      | Zone Name                           | passback                                                                                                                                                                                                                                                                                     |
      | zone-zoneset-NewRenderTest-Passback | <script language="javascript" type="text/javascript">document.write(''<script type="text/javascript" language="javascript" src="https://optimized-by.rubiconproject.com/a/dk.js?defaulting_ad=x3059e7.js&size_id=9&account_id=7847&site_id=13097&size=160x600"></scr'' + ''ipt>'');</script> |
    And i update zone data by name
      | Zone Name                                     | is_mraid |
      | zone-zoneset-NewRenderTest-InApp-Direct       | 1        |
      | zone-zoneset-NewRenderTest-InApp-Programmatic | 1        |

    And i update campaign data by name
      | Campaign Name                                           | units | goal_type   |
      | campaign-NewRenderTest-web-direct-zone-banner           | -1    | impressions |
      | campaign-NewRenderTest-web-direct-DT-banner             | -1    | impressions |
      | campaign-NewRenderTest-web-direct-HB-banner             | -1    | impressions |
      | campaign-NewRenderTest-web-programmatic-zone-banner     | -1    | impressions |
      | campaign-NewRenderTest-web-programmatic-HB-banner       | -1    | impressions |
      | campaign-NewRenderTest-web-programmatic-DT-banner       | -1    | impressions |
      | campaign-NewRenderTest-web-direct-zone-PGAction         | -1    | impressions |
      | campaign-NewRenderTest-web-direct-DT-PGAction           | -1    | impressions |
      | campaign-NewRenderTest-web-programmatic-zone-PGAction   | -1    | impressions |
      | campaign-NewRenderTest-web-programmatic-DT-PGAction     | -1    | impressions |
      | campaign-NewRenderTest-web-direct-zone-video            | -1    | impressions |
      | campaign-NewRenderTest-web-direct-DT-video              | -1    | impressions |
      | campaign-NewRenderTest-web-direct-HB-video              | -1    | impressions |
      | campaign-NewRenderTest-web-programmatic-zone-video      | -1    | impressions |
      | campaign-NewRenderTest-web-programmatic-DT-video        | -1    | impressions |
      | campaign-NewRenderTest-web-programmatic-HB-video        | -1    | impressions |
      | campaign-NewRenderTest-VidAd-w/o-leave-behind-zone      | -1    | impressions |
      | campaign-NewRenderTest-VidAd-w/o-leave-behind-zone-prog | -1    | impressions |
      | campaign-NewRenderTest-Instream-View-zone               | -1    | impressions |
      | campaign-NewRenderTest-Instream-View-SP                 | -1    | impressions |
      | campaign-NewRenderTest-InApp-Direct                     | -1    | impressions |
      | campaign-NewRenderTest-InApp-Programmatic               | -1    | impressions |
      | campaign-NewRenderTest-web-direct-event-trackers        | -1    | impressions |

    And i update campaign data by name
      | Campaign Name                                           | viewability_wrapper_enabled | viewability_wrapper_vendor |
      | campaign-NewRenderTest-web-direct-zone-video            | 1                           | IAS                        |
      | campaign-NewRenderTest-web-direct-DT-video              | 1                           | IAS                        |
      | campaign-NewRenderTest-web-direct-HB-video              | 1                           | IAS                        |
      | campaign-NewRenderTest-web-programmatic-zone-video      | 1                           | IAS                        |
      | campaign-NewRenderTest-web-programmatic-DT-video        | 1                           | IAS                        |
      | campaign-NewRenderTest-web-programmatic-HB-video        | 1                           | DV                         |
      | campaign-NewRenderTest-VidAd-w/o-leave-behind-zone      | 1                           | DV                         |
      | campaign-NewRenderTest-VidAd-w/o-leave-behind-zone-prog | 1                           | DV                         |
      | campaign-NewRenderTest-Instream-View-zone               | 1                           | DV                         |
      | campaign-NewRenderTest-Instream-View-SP                 | 1                           | DV                         |


# %%%%%%%%%%%%%  VIEWABILITY  %%%%%%%%%%%%%
  Scenario: create entities for viewability tests
    Given i disable campaigns by name on db
      | Campaign Name                 |
      | campaign-IAS-low-viewability  |
      | campaign-IAS-high-viewability |
      | campaign-DV-low-viewability   |
      | campaign-DV-high-viewability  |

    Given i create new campaigns with viewability
      | Campaign Name                 | IO    | LineItem | isServerProgrammatic? | Creative\Deal | Zonesets-zone Name                  | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | avThreshold | avVendor |
      | campaign-IAS-low-viewability  | 75396 | 210722   | false                 | 204           | {zone-zoneset-viewability-IAS-low}  | []         | 83       | 4737           | 2434         | 62229           | 10          | ias      |
      | campaign-IAS-high-viewability | 75396 | 210722   | false                 | 204           | {zone-zoneset-viewability-IAS-high} | []         | 83       | 4737           | 2434         | 62229           | 90          | ias      |
      | campaign-DV-low-viewability   | 75396 | 210722   | false                 | 204           | {zone-zoneset-viewability-DV-low}   | []         | 83       | 4737           | 2434         | 62229           | 10          | dv       |
      | campaign-DV-high-viewability  | 75396 | 210722   | false                 | 204           | {zone-zoneset-viewability-DV-high}  | []         | 83       | 4737           | 2434         | 62229           | 90          | dv       |

    And i update zone data by name
      | Zone Name                         | is_secure |
      | zone-zoneset-viewability-IAS-low  | 1         |
      | zone-zoneset-viewability-IAS-high | 1         |
      | zone-zoneset-viewability-DV-low   | 1         |
      | zone-zoneset-viewability-DV-high  | 1         |



# %%%%%%%%%%%%%  DISTRICT LIMITATION %%%%%%%%%%%%%
  Scenario: create entities for District tests
    Given i disable campaigns by name on db
      | Campaign Name                |
      | campaign-WY99-District       |
      | campaign-CA40-CO06-Districts |


    Given i create new campaigns, new zoneset with domains
      | Campaign Name                | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | campaign-WY99-District       | 75396 | 210722   | false                 | 204           | {zone-zoneset-WY99-district}       | []         | 83       | 4737           | 2434         | 62229           | []          | []          |
      | campaign-CA40-CO06-Districts | 75396 | 210722   | false                 | 204           | {zone-zoneset-CA40-CO06-districts} | []         | 83       | 4737           | 2434         | 62229           | []          | []          |


    And i update zone data by name
      | Zone Name                        | is_secure |
      | zone-zoneset-WY99-district       | 1         |
      | zone-zoneset-CA40-CO06-districts | 1         |

    And i update banner data by name
      | Banner Name                           | limitation                  |
      | campaign-WY99-District-banner-1       | [[[68,"=~","wy99"]]]        |
      | campaign-CA40-CO06-Districts-banner-1 | [[[68,"=~","ca40","co06"]]] |



 #   %%%%%%%%%%%%%  OPEN-MARKET %%%%%%%%%%%%%
  Scenario: create entities for Open-market tests
    Given i disable campaigns by name on db

         # R ----  R -----  OM
      | campaign-reserve-AN-iter-1      |
      | campaign-reserve-OX-iter-2      |
      | campaign-OPEN-MARKET-1          |
         # R ----  NR ----- D ---- OM
      | campaign-reserve-1              |
      | campaign-non-reserve-1          |
      | campaign-direct-not-chosen      |
      | campaign-OPEN-MARKET-1-chosen   |
         # D ---- OM
      | campaign-direct-must-be-chosen  |
      | campaign-OPEN-MARKET-not-chosen |

    Given i create new campaigns with new zoneset
         # R ----  R -----  OM
      | Campaign Name                   | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name        | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID |
      | campaign-reserve-AN-iter-1      | 407981 | 228961   | true                  | 21            | {zone-zoneset-test-OM-PG}  | []         | 75       | 15880          | 3708         | 66487           |
      | campaign-reserve-OX-iter-2      | 407981 | 251874   | true                  | 2582          | {zone-zoneset-test-OM-PG}  | []         | 75       | 15880          | 3708         | 66487           |
      | campaign-OPEN-MARKET-1          | 407981 | 269144   | true                  | 2777          | {zone-zoneset-test-OM-PG}  | []         | 75       | 15880          | 3708         | 66487           |
         # R ----  NR ----- D ---- OM
      | campaign-reserve-1              | 407981 | 228961   | true                  | 21            | {zone-zoneset-test-OM-WIN} | []         | 75       | 15881          | 3708         | 66487           |
      | campaign-non-reserve-1          | 407981 | 240083   | true                  | 410           | {zone-zoneset-test-OM-WIN} | []         | 75       | 15881          | 3708         | 66487           |
      | campaign-direct-not-chosen      | 75396  | 251648   | false                 | 34670         | {zone-zoneset-test-OM-WIN} | []         | 75       | 15881          | 3708         | 66487           |
      | campaign-OPEN-MARKET-1-chosen   | 407981 | 269144   | true                  | 2777          | {zone-zoneset-test-OM-WIN} | []         | 75       | 15881          | 3708         | 66487           |
         #  D ---- OM
      | campaign-direct-must-be-chosen  | 75396  | 251648   | false                 | 34670         | {zone-zoneset-test-Direct} | []         | 75       | 15882          | 3708         | 66487           |
      | campaign-OPEN-MARKET-not-chosen | 407981 | 269144   | true                  | 2777          | {zone-zoneset-test-Direct} | []         | 75       | 15882          | 3708         | 66487           |

    And i update campaign data by name
      | Campaign Name                   | Priority | campaign_delivery_method | delivery_algorithm | run_on_unknown_domains |
      | campaign-reserve-AN-iter-1      | 1        | 4                        | 2                  | 1                      |
      | campaign-reserve-OX-iter-2      | 1        | 4                        | 2                  | 1                      |
      | campaign-OPEN-MARKET-1          | 1        | 4                        | 2                  | 1                      |
      | campaign-reserve-1              | 1        | 4                        | 2                  | 1                      |
      | campaign-non-reserve-1          | 1        | 4                        | 2                  | 1                      |
      | campaign-direct-not-chosen      | 1        | 4                        | 2                  | 1                      |
      | campaign-OPEN-MARKET-1-chosen   | 1        | 4                        | 2                  | 1                      |
      | campaign-direct-must-be-chosen  | 1        | 4                        | 2                  | 1                      |
      | campaign-OPEN-MARKET-not-chosen | 1        | 4                        | 2                  | 1                      |

    And i update zone data by name
      | Zone Name                | is_secure |
      | zone-zoneset-test-OM-PG  | 1         |
      | zone-zoneset-test-OM-WIN | 1         |
      | zone-zoneset-test-Direct | 1         |


#%%%%%%%%%%%%%%  VCR - Video Completion Rate Entities %%%%%%%%%%%%%

  Scenario:  create entites for Video Completion Rate
    Given i disable campaigns by name on db
      | Campaign Name        |
      | campaign-CSVB-VCR-10 |
      | campaign-CSVB-VCR-90 |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name        | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name   | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-CSVB-VCR-10 | 75396 | 259848   | false                 | 31797         | {zone-zoneset-VCR-10} | []         | 35       | 15196          | 3708         | 69158           | []             | []             |
      | campaign-CSVB-VCR-90 | 75396 | 259848   | false                 | 31797         | {zone-zoneset-VCR-90} | []         | 35       | 15196          | 3708         | 69158           | []             | []             |

    And i update campaign data by name
      | Campaign Name        | is_sync | is_video | vcr_enabled | vcr_threshold |
      | campaign-CSVB-VCR-10 | 1       | 1        | 1           | 0.1           |
      | campaign-CSVB-VCR-90 | 1       | 1        | 1           | 0.9           |

    And i update zone data by name
      | Zone Name           | is_sync |
      | zone-zoneset-VCR-10 | 1       |
      | zone-zoneset-VCR-90 | 1       |
     # ****  update is_sync=1 & is_video=1 parameter of the zoneset ***
    And i update zoneset data by name
      | Zoneset Name        | is_sync | is_video |
      | zone-zoneset-VCR-10 | 1       | 1        |
      | zone-zoneset-VCR-90 | 1       | 1        |


#%%%%%%%%%%%%%%  VIdeo Location Entities %%%%%%%%%%%%%

  Scenario:  create entites for Video Location
    Given i disable campaigns by name on db
      | Campaign Name               |
      | campaign-stg-vidAd-pub2434  |
      | campaign-stg-inline-pub2434 |
      | campaign-stg-vidAd-pub3708  |
      | campaign-stg-inline-pub3708 |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name               | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name           | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-stg-vidAd-pub2434  | 75396 | 255831   | false                 | 34854         | {zone-zoneset-vidAd-pub2434}  | []         | 97       | 15902          | 2434         | 70156           | []             | []             |
      | campaign-stg-inline-pub2434 | 75396 | 269751   | false                 | 34853         | {zone-zoneset-inline-pub2434} | []         | 98       | 15902          | 2434         | 70770           | []             | []             |
      | campaign-stg-vidAd-pub3708  | 75396 | 255831   | false                 | 34854         | {zone-zoneset-vidAd-pub3708}  | []         | 97       | 15901          | 3708         | 69992           | []             | []             |
      | campaign-stg-inline-pub3708 | 75396 | 269751   | false                 | 34853         | {zone-zoneset-inline-pub3708} | []         | 98       | 15901          | 3708         | 71479           | []             | []             |

    And i update campaign data by name
      | Campaign Name               | is_sync | is_video | vcr_enabled | vcr_threshold |
      | campaign-stg-vidAd-pub2434  | 1       | 1        | 1           | 0.1           |
      | campaign-stg-inline-pub2434 | 1       | 1        | 1           | 0.1           |
      | campaign-stg-vidAd-pub3708  | 1       | 1        | 1           | 0.1           |
      | campaign-stg-inline-pub3708 | 1       | 1        | 1           | 0.1           |

    And i update zone data by name
      | Zone Name                   | is_sync |
      | zone-zoneset-vidAd-pub2434  | 1       |
      | zone-zoneset-inline-pub2434 | 1       |
      | zone-zoneset-vidAd-pub3708  | 1       |
      | zone-zoneset-inline-pub3708 | 1       |
     # ****  update is_sync=1 & is_video=1 parameter of the zoneset ***
    And i update zoneset data by name
      | Zoneset Name                | is_sync | is_video |
      | zone-zoneset-vidAd-pub2434  | 1       | 1        |
      | zone-zoneset-inline-pub2434 | 1       | 1        |
      | zone-zoneset-vidAd-pub3708  | 1       | 1        |
      | zone-zoneset-inline-pub3708 | 1       | 1        |

#%%%%%%%%%%%%%%  Agnostic UN-24547 Entities %%%%%%%%%%%%%
  Scenario:  create entites for Video Location
    Given i disable campaigns by name on db
      | Campaign Name                 |
      | campaign-agnostic-Billboard   |
      | campaign-agnostic-InlineVideo |
      | campaign-agnostic-PageGrabber |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name                 | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                 | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-agnostic-Billboard   | 75396 | 234903   | false                 | 33214         | {zone-zoneset-agnostic-Billboard}   | []         | 58       | 15906          | 2434         | 38734           | []             | []             |
      | campaign-agnostic-InlineVideo | 75396 | 269751   | false                 | 34853         | {zone-zoneset-agnostic-InlineVideo} | []         | 98       | 15906          | 2434         | 70770           | []             | []             |
      | campaign-agnostic-PageGrabber | 75396 | 251648   | false                 | 34670         | {zone-zoneset-agnostic-PageGrabber} | []         | 75       | 15906          | 2434         | 37496           | []             | []             |

    And i update campaign data by name
      | Campaign Name                 | is_sync | is_video | vcr_enabled | vcr_threshold |
      | campaign-agnostic-InlineVideo | 1       | 1        | 1           | 0.1           |

    And i update zone data by name
      | Zone Name                         | is_sync |
      | zone-zoneset-agnostic-InlineVideo | 1       |

    And i update zoneset data by name
      | Zoneset Name                      | is_sync | is_video |
      | zone-zoneset-agnostic-InlineVideo | 1       | 1        |


  Scenario: refresh zone cache with wait
    And I setup the db
    And I sleep for 6 seconds

  Scenario: refresh caches
    And I refresh zone cache
    #******** REMOVED *********
#    And I restart {ramp-lift-services}
#    And I restart {ut-programmatic-gw}


  @optimize
  Scenario: update test strategy
    Given i disable all tests except 53
#    And I set test id of test_strategy named {scoringV2} to {53}

  @optimize
  @append
  @refresh
  @saveEntitiesToFile
  Scenario: save entities to file
    And save all entities to json file
