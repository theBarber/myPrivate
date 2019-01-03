@couchBaseUtil
@preconditions
@optimize
@AA

Feature: Entities for tests

#  @zoneTagSanity
#  Scenario: create entities for zone Tag Sanity test
#    Given i create new priority campaigns with new zoneset
#      |Campaign Name                           |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name                      |limitation        |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |campaign priority|
#      |campaign-API-performance-1-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
#      |campaign-API-performance-2-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-performance-1-a}   |[]                |83        |4737             |2434           |17116             |-2               |
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



  @zoneTagSanity
  Scenario: create entities for zone Tag Sanity test
    Given i disable campaigns by name on db
      |Campaign Name                        |
      |campaign-API-1-a-sanity              |
    Given i create new campaigns with new zoneset
      |Campaign Name               |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name          |limitation        |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |
      |campaign-API-1-a-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-1-a}   |[]                |83        |4737             |2434           |17116             |
    And i update zone data by name
      |Zone Name                 |is_secure     |
      |zone-zoneset-sanity-1-a   |1            |

  @GDPR
  Scenario: create entities for zone Tag Sanity test
    Given i disable campaigns by name on db
      |Campaign Name                        |
      |campaign-API-1-a-GDPR                |
    Given i create new campaigns with new zoneset
      |Campaign Name               |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name          |limitation        |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |
      |campaign-API-1-a-GDPR       |75396         |210722     |false                  |204             |{zone-zoneset-GDPR-1-a}     |[]                |83        |4737             |2434           |17116             |
    And i update banner data by name
      |Banner Name                     |limitation     |
      |campaign-API-1-a-GDPR-banner-1  |[]             |
    And i update zone data by name
      |Zone Name               |is_secure    |
      |zone-zoneset-GDPR-1-a   |1            |

  @limitationSanity
  Scenario: create entities for zone Tag Sanity test
    Given i disable campaigns by name on db
      |Campaign Name                        |
      |campaign-API-limitations-test-F      |
      |campaign-API-limitations-test-C      |
      |campaign-API-limitations-test-W      |
    Given i create new campaigns with new zoneset
      |Campaign Name                    |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name               |limitation   |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |
      |campaign-API-limitations-test-F  |75396         |210722     |false                  |204             |{zone-zoneset-limitations-test}  |[]           |83        |4737             |2434           |17116             |
      |campaign-API-limitations-test-C  |75396         |210722     |false                  |204             |{zone-zoneset-limitations-test}  |[]           |83        |4737             |2434           |17116             |
      |campaign-API-limitations-test-W  |75396         |210722     |false                  |204             |{zone-zoneset-limitations-test}  |[]           |83        |4737             |2434           |17116             |
    And i update banner data by name
      |Banner Name                                 |limitation                                                     |
      |campaign-API-limitations-test-F-banner-1    |[[[5,"!~","af"],[12,"=~","firefox"]]]                          |
      |campaign-API-limitations-test-C-banner-1    |[[[5,"!~","af"],[12,"=~","chrome"]]]                           |
      |campaign-API-limitations-test-W-banner-1    |[[[5,"!~","af"],[12,"=~","msie","msie 7","msie 8","msie 9"]]]  |
    And i update zone data by name
      |Zone Name                        |is_secure    |
      |zone-zoneset-limitations-test    |1            |

  @UDMP
  Scenario: create entities for profile targeting via UDMP
    Given i disable campaigns by name on db
      |Campaign Name         |
      |campaign-ProfileTargetingUDMPforApp-ST-1   |
      |campaign-ProfileTargetingUDMPforWeb-ST-1   |
      |campaign-SeqProfileTargetingUDMPforWeb-ST-1|
      |campaign-CrossDeviceCappingUDMP-ST-1       |
      |campaign-PTzoneLimitation-ST-1             |
    Given i remove all zones from publishers: {3708}
    Given i create new campaigns with new zoneset
      |Campaign Name                                    |IO            |LineItem     |isServerProgrammatic?  |Deal\Creative     |Zonesets-zones Name                                   |limitation               |adUnitId    |Web_Section id        |publisher ID   |po_line_item ID   |
      |campaign-ProfileTargetingUDMPforApp-ST-1         |75396         |222908       |false                  |14619             |{zone-zoneset-ProfileTargetingUDMPforApp-ST-1}        |[]                       |80          |14892                 |3708           |27807             |
      |campaign-ProfileTargetingUDMPforWeb-ST-1         |75396         |210722       |false                  |204               |{zone-zoneset-ProfileTargetingUDMPforWeb-ST-1}        |[]                       |83          |14892                 |3708           |27807             |
      |campaign-SeqProfileTargetingUDMPforWeb-ST-1      |75396         |210722       |false                  |8158               |{zone-zoneset-SeqProfileTargetingUDMPforWeb-ST-1}    |[]                       |93          |15128                 |3708           |67638             |
      |campaign-CrossDeviceCappingUDMP-ST-1             |75396         |210722       |false                  |204               |{zone-zoneset-CrossDeviceCappingUDMP-ST-1}            |[]                       |83          |14894                 |3708           |27809             |
      |campaign-PTzoneLimitation-ST-1                   |75396         |210722       |false                  |8158               |{zone-zoneset-PTzoneLimitation-ST-1}                  |[[[4,"==",1,1,666]]]     |93          |15124                 |3708           |27807             |
    And i update zone data by name
      |Zone Name                                          |is_mraid     |is_secure |
      |zone-zoneset-ProfileTargetingUDMPforApp-ST-1       |1            |1         |
      |zone-zoneset-SeqProfileTargetingUDMPforWeb-ST-1    |0            |1         |
      |zone-zoneset-PTzoneLimitation-ST-1                 |0            |1         |
      |zone-zoneset-CrossDeviceCappingUDMP-ST-1           |0            |1         |
      |zone-zoneset-PTzoneLimitation-ST-1                 |0            |1         |
    Given i update banner data by name
      |Banner Name                                               |limitation                           |
      |campaign-ProfileTargetingUDMPforApp-ST-1-banner-1          |[[[4,"==",1,1,1992]]]                |
      |campaign-ProfileTargetingUDMPforWeb-ST-1-banner-1         |[[[4,"==",1,1,1992]]]                |
      |campaign-SeqProfileTargetingUDMPforWeb-ST-1-banner-1       |[[[4,"==",1,1,17]]]                  |
    Given i update campaign data by name
      |Campaign Name                                     |capping | session_capping|
      |campaign-CrossDeviceCappingUDMP-ST-1     |2       |2               |



  @GDPR
  @HB
  Scenario: create entities for HB tests
      Given i remove all zones from publishers: {3673}
    Given i remove all zones from publishers: {3697}
    And i disable campaigns by name on db
        |Campaign Name                        |
        |campaign-HB-Tablet-160x600           |
        |campaign-HB-See-Through-1X2          |
        |campaign-HB-Desktop-300X250          |
        |campaign-HB-Billboard-970X250        |
        |campaign-HB-SS-1X1                   |
        |campaign-HB-Prog-PGC-1X1-1           |
        |campaign-HB-Prog-PGC-1X1-2           |
        |campaign-HB-Prog-PGC-1X1-3           |
        |campaign-HB-Prog-See-Through-1X2-1   |
        |campaign-HB-Prog-See-Through-1X2-2   |
        |campaign-HB-Prog-See-Through-1X2-3   |
        |campaign-HB-Prog-Billboard-970X250-D |
        |campaign-HB-Prog-Billboard-970X250-P |
#        dynamic price with po sp > camp sp
        |campaign-HB-DynamicPrice-1   |
#        dynamic price with po sp < camp sp
        |campaign-HB-DynamicPrice-2   |
#        dynamic price with campaign mobile sp < po sales price < campaign desktop
        |campaign-HB-DynamicPrice-3   |
    Given i create new campaigns with new zoneset
        |Campaign Name                         |IO       |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name                      |limitation     |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |
        |campaign-HB-Tablet-160x600            |75396    |223539     |false                  |148             |{zone-zoneset-HB-Tablet-160x600}         |[]            |8         |14400            |3673           |65421             |
        |campaign-HB-See-Through-1X2           |75396    |210722     |false                  |204             |{zone-zoneset-HB-See Through 1X2}        |[]            |83        |14400            |3673           |64396             |
        |campaign-HB-Desktop-300X250           |75396    |197420     |false                  |85              |{zone-zoneset-Desktop-300X250}            |[]            |10        |14400           |3673           |66814             |
        |campaign-HB-Billboard-970X250         |75396    |198082     |false                  |64              |{zone-zoneset-HB-Billboard-970X250}       |[]            |58        |14400           |3673           |66813             |
        |campaign-HB-SS-1X1                    |75396    |197418     |false                  |86              |{zone-zoneset-HB-SS-1X1}                  |[]           |69         |14400           |3673           |66933             |
        |campaign-HB-Prog-PGC-1X1-1            |407981   |224812     |false                  |6499            |{zone-zoneset-HB-Prog-PGC-1X1}           |[]            |69        |14507            |3697           |66004             |
        |campaign-HB-Prog-PGC-1X1-2            |407981   |224812     |false                  |6499            |{zone-zoneset-HB-Prog-PGC-1X1}           |[]            |69        |14507            |3697           |66004             |
        |campaign-HB-Prog-PGC-1X1-3            |75396    |222908     |false                  |86              |{zone-zoneset-HB-Prog-PGC-1X1}           |[]            |69        |14507            |3697           |66004             |
        |campaign-HB-Prog-See-Through-1X2-1    |407981   |224810     |false                  |6497            |{zone-zoneset-HB-Prog-See-Through-1X2}   |[]            |83        |14507            |3697           |66002             |
        |campaign-HB-Prog-See-Through-1X2-2    |407981   |224810     |false                  |6497            |{zone-zoneset-HB-Prog-See-Through-1X2}   |[]            |83        |14507            |3697           |66002             |
        |campaign-HB-Prog-See-Through-1X2-3    |407981   |224810     |false                  |6497            |{zone-zoneset-HB-Prog-See-Through-1X2}   |[]            |83        |14507            |3697           |66002             |
        |campaign-HB-Prog-Billboard-970X250-D  |75396    |198082     |false                  |64              |{zone-zoneset-HB-Prog-Billboard-970X250} |[]            |58        |14507            |3697           |66736             |
        |campaign-HB-Prog-Billboard-970X250-P  |407981   |224539     |false                  |7143            |{zone-zoneset-HB-Prog-Billboard-970X250} |[]            |58        |14507            |3697           |66736             |

        |campaign-HB-DynamicPrice-1            |75396    |210722     |false                  |8158             |{zone-zoneset-HB-DynamicPrice-1}         |[]            |93        |14507            |3697           |66002             |
        |campaign-HB-DynamicPrice-2            |75396    |210722     |false                  |8158             |{zone-zoneset-HB-DynamicPrice-2}         |[]            |93        |14507            |3697           |66736             |
        |campaign-HB-DynamicPrice-3            |75396    |210722     |false                  |8158             |{zone-zoneset-HB-DynamicPrice-3}         |[]            |93        |14507            |3697           |66736             |
    And i update campaign data by name
        |Campaign Name                        |status      |Priority      |units      |limitation|campaign_delivery_method|
        |campaign-HB-Tablet-160x600           |0           |-2            |-1         |[]        |1                       |
        |campaign-HB-See-Through-1X2          |0           |-1            |-1         |[]        |2                       |
        |campaign-HB-Desktop-300X250          |0           |-2            |-1         |[]        |1                       |
        |campaign-HB-Billboard-970X250        |0           |-1            |-1         |[]        |2                       |
        |campaign-HB-SS-1X1                   |0           |-2            |-1         |[]        |1                       |
        |campaign-HB-Prog-PGC-1X1-1           |0           |-2            |-1         |[]        |1                       |
        |campaign-HB-Prog-PGC-1X1-2           |0           |-1            |-1         |[]        |2                       |
        |campaign-HB-Prog-PGC-1X1-3           |0           |1             |-1         |[]        |4                       |
        |campaign-HB-Prog-See-Through-1X2-1   |0           |-2            |-1         |[]        |1                       |
        |campaign-HB-Prog-See-Through-1X2-2   |0           |-1            |-1         |[]        |2                       |
        |campaign-HB-Prog-See-Through-1X2-3   |0           |1             |-1         |[]        |4                       |
        |campaign-HB-Prog-Billboard-970X250-D |0           |-2            |-1         |[]        |1                       |
        |campaign-HB-Prog-Billboard-970X250-P |0           |-1            |-1         |[]        |2                       |
    And i update zone data by name
      |Zone Name                                  |is_secure    |
      |zone-zoneset-HB-Tablet-160x600             |1            |
      |zone-zoneset-HB-See Through 1X2            |1            |
      |zone-zoneset-Desktop-300X250               |1            |
      |zone-zoneset-HB-Billboard-970X250          |1            |
      |zone-zoneset-HB-SS-1X1                     |1            |
      |zone-zoneset-HB-Prog-PGC-1X1               |1            |
      |zone-zoneset-HB-Prog-See-Through-1X2       |1            |
      |zone-zoneset-HB-Prog-Billboard-970X250     |1            |


  @HB
    Scenario: create entities for HB tests with multiple domains
    Given i disable campaigns by name on db
      |Campaign Name                    |
      |HB-Tablet-160x600-D-1-a-1        |
      |HB-Tablet-160x600-D-1-a-2        |
      |HB-Tablet-160x600-D-1-b-1        |
      |HB-Tablet-160x600-D-1-b-2        |
      |See-Through-1X2-D-1-a-1          |
      |See-Through-1X2-D-1-a-2          |
      |See-Through-1X2-D-1-b-1          |
      |See-Through-1X2-D-1-b-2          |
      |HB-Tablet-160x600-D-2-a-1        |
      |HB-Tablet-160x600-D-2-a-2        |
      |HB-Tablet-160x600-D-2-b-1        |
      |HB-Tablet-160x600-D-2-b-2        |
      |See-Through-1X2-D-2-a-1          |
      |See-Through-1X2-D-2-a-2          |
      |See-Through-1X2-D-2-b-1          |
      |See-Through-1X2-D-2-b-2          |
      |HB-Tablet-160x600-D-3-a-1        |
      |HB-Tablet-160x600-D-3-a-2        |
      |HB-Tablet-160x600-D-3-b-1        |
      |HB-Tablet-160x600-D-3-b-2        |
      |See-Through-1X2-D-3-a-1          |
      |See-Through-1X2-D-3-a-2          |
      |See-Through-1X2-D-3-b-1          |
      |See-Through-1X2-D-3-b-2          |
      |HB-Tablet-160x600-D-4-a-1        |
      |HB-Tablet-160x600-D-4-a-2        |
      |HB-Tablet-160x600-D-4-b-1        |
      |HB-Tablet-160x600-D-4-b-2        |
      |See-Through-1X2-D-4-a-1          |
      |See-Through-1X2-D-4-a-2          |
      |See-Through-1X2-D-4-b-1          |
      |See-Through-1X2-D-4-b-2          |
      |campaign-HB-SS-1X1-D-1           |
      |campaign-HB-SS-1X1-D-2           |
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
        |Campaign Name                    |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal        |Zonesets-zone Name                            |
        |HB-Tablet-160x600-D-1-a-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-1-a}        |
        |HB-Tablet-160x600-D-1-a-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-1-a}        |
        |HB-Tablet-160x600-D-1-b-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-1-b}        |
        |HB-Tablet-160x600-D-1-b-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-1-b}        |
        |See-Through-1X2-D-1-a-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-1-a}       |
        |See-Through-1X2-D-1-a-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-1-a}       |
        |See-Through-1X2-D-1-b-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-1-b}       |
        |See-Through-1X2-D-1-b-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-1-b}       |
        |HB-Tablet-160x600-D-2-a-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-2-a}        |
        |HB-Tablet-160x600-D-2-a-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-2-a}        |
        |HB-Tablet-160x600-D-2-b-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-2-b}        |
        |HB-Tablet-160x600-D-2-b-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-2-b}        |
        |See-Through-1X2-D-2-a-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-2-a}       |
        |See-Through-1X2-D-2-a-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-2-a}       |
        |See-Through-1X2-D-2-b-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-2-b}       |
        |See-Through-1X2-D-2-b-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-2-b}       |
        |HB-Tablet-160x600-D-3-a-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-3-a}        |
        |HB-Tablet-160x600-D-3-a-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-3-a}        |
        |HB-Tablet-160x600-D-3-b-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-3-b}        |
        |HB-Tablet-160x600-D-3-b-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-3-b}        |
        |See-Through-1X2-D-3-a-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-3-a}       |
        |See-Through-1X2-D-3-a-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-3-a}       |
        |See-Through-1X2-D-3-b-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-3-b}       |
        |See-Through-1X2-D-3-b-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-3-b}       |
        |HB-Tablet-160x600-D-4-a-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-4-a}        |
        |HB-Tablet-160x600-D-4-a-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-4-a}        |
        |HB-Tablet-160x600-D-4-b-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-4-b}        |
        |HB-Tablet-160x600-D-4-b-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-4-b}        |
        |See-Through-1X2-D-4-a-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-4-a}       |
        |See-Through-1X2-D-4-a-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-4-a}       |
        |See-Through-1X2-D-4-b-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-4-b}       |
        |See-Through-1X2-D-4-b-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-4-b}       |
        |campaign-HB-SS-1X1-D-1           |75396         |197418     |false                  |86                   |{zone-zoneset-HB-SS-1X1-D-1,zone-zoneset-HB-SS-1X1-D-2}|
        |campaign-HB-SS-1X1-D-2           |75396         |197418     |false                  |86                   |{zone-zoneset-HB-SS-1X1-D-1,zone-zoneset-HB-SS-1X1-D-2}|
    And i update campaign data by name
        |Campaign Name                    |Priority      |campaign_delivery_method|delivery_algorithm|
        |HB-Tablet-160x600-D-1-a-1        |-2            |1                       |4                 |
        |HB-Tablet-160x600-D-1-a-2        |-1            |2                       |3                 |
        |HB-Tablet-160x600-D-1-b-1        | 1            |4                       |2                 |
        |HB-Tablet-160x600-D-1-b-2        | 1            |4                       |1                 |
        |See-Through-1X2-D-1-a-1          |-1            |2                       |3                 |
        |See-Through-1X2-D-1-a-2          |-1            |2                       |3                 |
        |See-Through-1X2-D-1-b-1          | 1            |4                       |2                 |
        |See-Through-1X2-D-1-b-2          | 1            |4                       |1                 |
        |HB-Tablet-160x600-D-2-a-1        |-1            |2                       |3                 |
        |HB-Tablet-160x600-D-2-a-2        |-1            |2                       |3                 |
        |HB-Tablet-160x600-D-2-b-1        | 1            |4                       |2                 |
        |HB-Tablet-160x600-D-2-b-2        | 1            |4                       |1                 |
        |See-Through-1X2-D-2-a-1          |-2            |1                       |4                 |
        |See-Through-1X2-D-2-a-2          |-1            |2                       |3                 |
        |See-Through-1X2-D-2-b-1          | 1            |4                       |2                 |
        |See-Through-1X2-D-2-b-2          | 1            |4                       |1                 |
        |HB-Tablet-160x600-D-3-a-1        |-2            |1                       |4                 |
        |HB-Tablet-160x600-D-3-a-2        |-1            |2                       |3                 |
        |HB-Tablet-160x600-D-3-b-1        | 1            |4                       |2                 |
        |HB-Tablet-160x600-D-3-b-2        | 1            |4                       |1                 |
        |See-Through-1X2-D-3-a-1          |-1            |2                       |3                 |
        |See-Through-1X2-D-3-a-2          |-1            |2                       |3                 |
        |See-Through-1X2-D-3-b-1          | 1            |4                       |2                 |
        |See-Through-1X2-D-3-b-2          | 1            |4                       |1                 |
        |HB-Tablet-160x600-D-4-a-1        |-1            |2                       |3                 |
        |HB-Tablet-160x600-D-4-a-2        |-1            |2                       |3                 |
        |HB-Tablet-160x600-D-4-b-1        | 1            |4                       |2                 |
        |HB-Tablet-160x600-D-4-b-2        | 1            |4                       |1                 |
        |See-Through-1X2-D-4-a-1          |-2            |1                       |4                 |
        |See-Through-1X2-D-4-a-2          |-1            |2                       |3                 |
        |See-Through-1X2-D-4-b-1          | 1            |4                       |2                 |
        |See-Through-1X2-D-4-b-2          | 1            |4                       |1                 |
        |campaign-HB-SS-1X1-D-1           |-2            |1                       |4                 |
        |campaign-HB-SS-1X1-D-2           |-1            |2                       |3                 |
    And i update banner data by name
      |Banner Name                        |limitation             |
      |campaign-HB-SS-1X1-D-1-banner-1    |[[[4,\"=~\",30,1,1]]]  |
      |campaign-HB-SS-1X1-D-2-banner-1    |[]                     |
    And i update zone data by name
      |Zone Name                                  |is_secure    |
      |zone-zoneset-HB-Tablet-160x600-D-1-a       |1            |
      |zone-zoneset-HB-Tablet-160x600-D-1-b       |1            |
      |zone-zoneset-HB-See-Through-1X2-D-1-a      |1            |
      |zone-zoneset-HB-See-Through-1X2-D-1-b      |1            |
      |zone-zoneset-HB-Tablet-160x600-D-2-a       |1            |
      |zone-zoneset-HB-Tablet-160x600-D-2-b       |1            |
      |zone-zoneset-HB-See-Through-1X2-D-2-a      |1            |
      |zone-zoneset-HB-See-Through-1X2-D-2-b      |1            |
      |zone-zoneset-HB-Tablet-160x600-D-3-a       |1            |
      |zone-zoneset-HB-Tablet-160x600-D-3-b       |1            |
      |zone-zoneset-HB-See-Through-1X2-D-3-a      |1            |
      |zone-zoneset-HB-See-Through-1X2-D-3-b      |1            |
      |zone-zoneset-HB-Tablet-160x600-D-4-a       |1            |
      |zone-zoneset-HB-Tablet-160x600-D-4-b       |1            |
      |zone-zoneset-HB-See-Through-1X2-D-4-a      |1            |
      |zone-zoneset-HB-See-Through-1X2-D-4-b      |1            |
      |zone-zoneset-HB-SS-1X1-D-1                 |1            |
      |zone-zoneset-HB-SS-1X1-D-2                 |1            |



  @DT
  Scenario: create entities for DT tests
    Given i disable campaigns by name on db
      |Campaign Name         |
      |campaign-DT-SS-1-t-1  |
      |campaign-DT-SI-2-t-1  |
      |campaign-DT-SI-1-t-1  |
      |campaign-DT-SI-2-t-1  |
      |campaign-DT-PGC-2-t-1 |
      |campaign-DT-SS-1-t-2  |
      |campaign-DT-SI-2-t-2  |
      |campaign-DT-PGC-3-t-2 |
      |campaign-DT-SI-1-t-3-L|
      |campaign-DT-SI-2-t-3  |
    Given i remove all zones from publishers: {3674}
    Given i remove all zones from publishers: {3675}
    Given i remove all zones from publishers: {3666}
    Given i create new campaigns with new zoneset
        |Campaign Name           |IO       |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name           |limitation          |adUnitId   |Web_Section id   |publisher ID   |po_line_item ID   |
        |campaign-DT-SS-1-t-1    |75396    |197418     |false                  |86              |{zone-zoneset-DT-SS-t-1}     |[]                  |69         |14401            |3674           |64397             |
        |campaign-DT-SS-2-t-1    |75396    |197418     |false                  |86              |{zone-zoneset-DT-SS-t-1}     |[]                  |69         |14401            |3674           |64397             |
        |campaign-DT-SI-1-t-1    |75396    |211456     |false                  |210             |{zone-zoneset-DT-SI-t-1}     |[]                  |61         |14401            |3674           |64398             |
        |campaign-DT-SI-2-t-1    |75396    |211456     |false                  |210             |{zone-zoneset-DT-SI-t-1}     |[]                  |61         |14401            |3674           |64398             |
        |campaign-DT-PGC-2-t-1   |75396    |222908     |false                  |1068            |{zone-zoneset-DT-PGC-t-1}    |[]                  |75         |14401            |3674           |64399             |
        |campaign-DT-SS-1-t-2    |75396    |197418     |false                  |86              |{zone-zoneset-DT-SS-t-2}     |[]                  |69         |14402            |3666           |64400             |
        |campaign-DT-SI-2-t-2    |75396    |211456     |false                  |210             |{zone-zoneset-DT-SI-t-2}     |[]                  |61         |14402            |3666           |64401             |
        |campaign-DT-PGC-3-t-2   |75396    |222908     |false                  |1068            |{zone-zoneset-DT-PGC-t-2}    |[]                  |75         |14402            |3666           |64402             |
        |campaign-DT-SI-1-t-3-L  |75396    |211456     |false                  |210             |{zone-zoneset-DT-SI-t-3-L}   |[[[5,"=~","af"]]]   |61         |14403            |3675           |64403             |
        |campaign-DT-SI-2-t-3    |75396    |211456     |false                  |210             |{zone-zoneset-DT-SI-t-3}     |[]                  |61         |14403            |3675           |64403             |
      And i update campaign data by name
        |Campaign Name         |Priority      |campaign_delivery_method|
        |campaign-DT-SS-1-t-1  |-2            |1                       |
        |campaign-DT-SI-2-t-1  |-1            |2                       |
        |campaign-DT-SI-1-t-1  |-2            |1                       |
        |campaign-DT-SI-2-t-1  |-1            |2                       |
        |campaign-DT-PGC-2-t-1 |-1            |2                       |
        |campaign-DT-SS-1-t-2  |-2            |1                       |
        |campaign-DT-SI-2-t-2  |-1            |2                       |
        |campaign-DT-PGC-3-t-2 | 1            |4                       |
        |campaign-DT-SI-1-t-3-L|-2            |1                       |
        |campaign-DT-SI-2-t-3  |-1            |2                       |
     And i update zone data by name
        |Zone Name                 |is_secure    |
        |zone-zoneset-DT-SS-t-1    |1            |
        |zone-zoneset-DT-SI-t-1    |1            |
        |zone-zoneset-DT-PGC-t-1   |1            |
        |zone-zoneset-DT-SS-t-2    |1            |
        |zone-zoneset-DT-SI-t-2    |1            |
        |zone-zoneset-DT-PGC-t-2   |1            |
        |zone-zoneset-DT-SI-t-3-L  |1            |
        |zone-zoneset-DT-SI-t-3    |1            |

  @GDPR
  @DT
    Scenario: create entities for DT inline tests
    Given i disable campaigns by name on db
      |Campaign Name            |
      |Campaign Name            |
      |campaign-DT-Inline-ST-1  |
      |campaign-DT-Inline-ST-2  |
      |campaign-DT-Inline-SS-1  |
      |campaign-DT-Inline-PGC-2 |
      |campaign-DT-Inline-SS-3  |
      Given i remove all zones from publishers: {3690}
      Given i create new campaigns with new zoneset
        |Campaign Name               |IO       |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name            |limitation          |adUnitId   |Web_Section id   |publisher ID    |po_line_item ID   |
        |campaign-DT-Inline-ST-1     |75396    |210722     |false                  |204             |{zone-zoneset-DT-inline-ST}   |[]                   |83         |14470            |3690           |65422             |
        |campaign-DT-Inline-ST-2     |75396    |210722     |false                  |204             |{zone-zoneset-DT-inline-ST}   |[]                   |83         |14470            |3690           |65422             |
        |campaign-DT-Inline-SS-1     |75396    |197418     |false                  |86              |{zone-zoneset-DT-inline-SS-1} |[]                   |69         |14470            |3690           |65423             |
        |campaign-DT-Inline-SS-3     |75396    |197418     |false                  |86              |{zone-zoneset-DT-inline-SS-3} |[]                   |69         |14470            |3690           |65423             |
        |campaign-DT-Inline-PGC-2    |75396    |222908     |false                  |1068            |{zone-zoneset-DT-inline-PGC}  |[]                   |75         |14470            |3690           |65424             |
      And i update campaign data by name
        |Campaign Name            |Priority      |campaign_delivery_method|
        |campaign-DT-Inline-ST-1  |-2            |1                       |
        |campaign-DT-Inline-ST-2  |-1            |2                       |
        |campaign-DT-Inline-SS-1  |-2            |1                       |
        |campaign-DT-Inline-PGC-2 |-1            |2                       |
        |campaign-DT-Inline-SS-3  |1             |4                       |
      And i update zone data by name
        |Zone Name                    |is_secure    |
        |zone-zoneset-DT-inline-ST    |1            |
        |zone-zoneset-DT-inline-SS-1  |1            |
        |zone-zoneset-DT-inline-SS-3  |1            |
        |zone-zoneset-DT-inline-PGC   |1            |
      And I flush bucket name {us-east-1-adserver} on couchbase

  @DOT
  Scenario: create campaigns for Domain Targeting
    Given i disable campaigns by name on db
      |Campaign Name              |
      |campaign-DomainT-1         |
      |campaign-DomainT-2         |
      |campaign-DomainT-3         |
      |campaign-DomainT-4         |
      |campaign-DomainT-BB-5      |
      |campaign-DomainT-Desktop-6 |
      |campaign-DomainT-ZoneTag-1 |
      |campaign-DomainT-ZoneTag-2 |
      |campaign-DomainT-ZoneTag-3 |
      |campaign-DomainT-ZoneTag-4 |
#    Given i remove all zones from publishers: {3708}
    And i create new zone named {zone-zoneset-DomainT-4-b} with limitation {[]} with adUnitId 61 and web_section id 4140 with affiliateId 3708 with po_line_item_id 66488
    Given i create new campaigns, new zoneset with domains
      |Campaign Name              |IO            |LineItem   |isServerProgrammatic?  |Creative         |Zonesets-zones Name                                 |limitation           |adUnitId   |Web_Section id    |publisher ID   |po_line_item ID   |domain_include      |domain_exclude                                |
      |campaign-DomainT-1         |75396         |210722     |false                  |204              |{zone-zoneset-DomainT-1}                            |[]                   |83         |14539             |3708           |66418             |[]                  |[{sahar.cnn.com,1}]                           |
      |campaign-DomainT-2         |75396         |197418     |false                  |86               |{zone-zoneset-DomainT-2}                            |[]                   |69         |14539             |3708           |66486             |[]                  |[{cnn.com,1}]                                 |
      |campaign-DomainT-3         |75396         |222908     |false                  |1068             |{zone-zoneset-DomainT-3}                            |[]                   |75         |14539             |3708           |66487             |[]                  |[{sahar.cnn.com,1};{cnn.com,1};{ynet.co.il,1}]|
      |campaign-DomainT-4         |75396         |211456     |false                  |210              |{zone-zoneset-DomainT-4-a,zone-zoneset-DomainT-4-b} |[]                   |61         |11363             |3708           |66488             |[]                  |[{cnn.com,1}]                                 |
      |campaign-DomainT-BB-5      |75396         |198082     |false                  |64               |{zone-zoneset-DomainT-5-BB}                         |[]                   |58         |14539             |3708           |66810             |[{sahar.cnn.com,1}] |[]                                            |
      |campaign-DomainT-Desktop-6 |75396         |197420     |false                  |85               |{zone-zoneset-DomainT-6-Desktop}                    |[]                   |10         |14539             |3708           |66811             |[{cnn.com,1}]       |[]                                            |
      |campaign-DomainT-ZoneTag-1 |75396         |210722     |false                  |204              |{zone-zoneset-DomainT-ZoneTag-1}                    |[]                   |83         |4737              |2434           |62229             |[{sahar.cnn.com,1}] |[]                                            |
      |campaign-DomainT-ZoneTag-2 |75396         |210722     |false                  |204              |{zone-zoneset-DomainT-ZoneTag-2}                    |[]                   |83         |4737              |2434           |62229             |[]                  |[{sahar.ynet.co.il,1}]                        |
      |campaign-DomainT-ZoneTag-3 |75396         |210722     |false                  |204              |{zone-zoneset-DomainT-ZoneTag-3}                    |[]                   |83         |4737              |2434           |62229             |[{cnn.com,1}]       |[]                                            |
      |campaign-DomainT-ZoneTag-4 |75396         |210722     |false                  |204              |{zone-zoneset-DomainT-ZoneTag-4}                    |[]                   |83         |4737              |2434           |62229             |[]                  |[{ynet.co.il,1}]                              |
    And i update zone data by name
      |Zone Name                        |is_secure    |
      |zone-zoneset-DomainT-1           |1            |
      |zone-zoneset-DomainT-2           |1            |
      |zone-zoneset-DomainT-3           |1            |
      |zone-zoneset-DomainT-4-a         |1            |
      |zone-zoneset-DomainT-4-b         |1            |
      |zone-zoneset-DomainT-5-BB        |1            |
      |zone-zoneset-DomainT-6-Desktop   |1            |
      |zone-zoneset-DomainT-ZoneTag-1   |1            |
      |zone-zoneset-DomainT-ZoneTag-2   |1            |
      |zone-zoneset-DomainT-ZoneTag-3   |1            |
      |zone-zoneset-DomainT-ZoneTag-4   |1            |


  @GDPR
  @appnexus
  Scenario: create entities for server programmatic tests
    Given i remove all zones from publishers: {3728}
    Given i disable campaigns by name on db
      |Campaign Name                   |
      |campaign-server-prog-SS-1       |
      |campaign-server-prog-SS-2       |
      |campaign-server-prog-SS-3       |
      |campaign-server-prog-SS-4       |
      |campaign-server-prog-PGC-1      |
      |campaign-server-prog-PGC-2      |
      |campaign-server-prog-PGC-3      |
      |campaign-server-prog-PGC-4      |
      |campaign-server-prog-ST-1       |
      |campaign-server-prog-ST-2       |
      |campaign-server-prog-ST-3       |
      |campaign-server-prog-ST-4       |
#     InApp Burl
      |campaign-server-prog-inApp-ST-1 |
    Given i remove all zones from publishers: {3711}
    Given i create new campaigns with new zoneset
      |Campaign Name              |IO            |LineItem   |isServerProgrammatic?  |Deal\Creative   |Zonesets-zones Name           |limitation   |adUnitId  |Web_Section id    |publisher ID   |po_line_item ID   |
      |campaign-server-prog-SS-1  |407981        |228962     |true                   |17               |{zone-zoneset-server-prog-SS} |[]           |69        |2164              |3711           |66556             |
      |campaign-server-prog-SS-2  |407981        |224531     |true                   |18               |{zone-zoneset-server-prog-SS} |[]           |69        |2164              |3711           |66556             |
      |campaign-server-prog-SS-3  |75396         |197418     |false                  |86               |{zone-zoneset-server-prog-SS} |[]           |69        |2164              |3711           |66556             |
      |campaign-server-prog-SS-4  |407981        |224531     |true                   |19               |{zone-zoneset-server-prog-SS} |[]           |69        |2164              |3711           |66556             |
      |campaign-server-prog-PGC-1 |407981        |224530     |true                   |20               |{zone-zoneset-server-prog-PGC}|[]           |75        |2164              |3711           |66557             |
      |campaign-server-prog-PGC-2 |407981        |228961     |true                   |21               |{zone-zoneset-server-prog-PGC}|[]           |75        |2164              |3711           |66557             |
      |campaign-server-prog-PGC-3 |407981        |224530     |true                   |22               |{zone-zoneset-server-prog-PGC}|[]           |75        |2164              |3711           |66557             |
      |campaign-server-prog-PGC-4 |407981        |228961     |true                   |23               |{zone-zoneset-server-prog-PGC}|[]           |75        |2164              |3711           |66557             |
      |campaign-server-prog-ST-1  |407981        |229737     |true                   |24               |{zone-zoneset-server-prog-ST} |[]           |83        |2164              |3711           |66555             |
      |campaign-server-prog-ST-2  |407981        |224533     |true                   |31               |{zone-zoneset-server-prog-ST} |[]           |83        |2164              |3711           |66555             |
      |campaign-server-prog-ST-3  |407981        |229737     |true                   |32               |{zone-zoneset-server-prog-ST} |[]           |83        |2164              |3711           |66555             |
      |campaign-server-prog-ST-4  |407981        |224533     |true                   |33               |{zone-zoneset-server-prog-ST} |[]           |83        |2164              |3711           |66555             |
      #     InApp Burl
      |campaign-server-prog-inApp-ST-1  |407981        |224533     |true                   |33               |{zone-zoneset-server-prog-inApp-ST} |[]           |83        |2164              |3711           |66555             |
    And i update campaign data by name
      |Campaign Name                   |Priority      |campaign_delivery_method|delivery_algorithm|
      |campaign-server-prog-SS-1       |-2            |1                       |4                 |
      |campaign-server-prog-SS-2       |-1            |2                       |3                 |
      |campaign-server-prog-SS-3       | 1            |4                       |2                 |
      |campaign-server-prog-SS-4       | 1            |4                       |1                 |
      |campaign-server-prog-PGC-1      |-2            |1                       |4                 |
      |campaign-server-prog-PGC-2      |-1            |2                       |3                 |
      |campaign-server-prog-PGC-3      |1             |4                       |2                 |
      |campaign-server-prog-PGC-4      | 1            |4                       |1                 |
      |campaign-server-prog-ST-1       |-2            |1                       |4                 |
      |campaign-server-prog-ST-2       |-1            |2                       |3                 |
      |campaign-server-prog-ST-3       | 1            |4                       |2                 |
      |campaign-server-prog-ST-4       | 1            |4                       |1                 |
      #     InApp Burl
      |campaign-server-prog-inApp-ST-1       | 1            |4                       |1                 |
    And i update zone data by name
      |Zone Name                        |is_secure    |
      |zone-zoneset-server-prog-SS      |1            |
      |zone-zoneset-server-prog-PGC     |1            |
      |zone-zoneset-server-prog-ST      |1            |

   @viewability
    Scenario: create entities for viewability tests
      Given i disable campaigns by name on db
        |Campaign Name                   |
        |campaign-API-1-a-viewability       |
        |campaign-API-2-a-viewability       |
      Given i create new campaigns with viewability
        |Campaign Name                      |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name               |limitation        |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |avThreshold|avVendor  |
        |campaign-API-1-a-viewability       |75396         |210722     |false                  |204             |{zone-zoneset-viewability-1-a}   |[]                |83        |4737             |2434           |17116             |30         |ias       |
        |campaign-API-2-a-viewability       |75396         |210722     |false                  |204             |{zone-zoneset-viewability-2-a}   |[]                |83        |4737             |2434           |17116             |50         |ias       |
      And i update banner data by name
        |Banner Name                            |limitation     |
        |campaign-API-1-a-viewability-banner-1    |[]             |
        |campaign-API-2-a-viewability-banner-1    |[]             |
     And i update zone data by name
       |Zone Name                        |is_secure    |
       |zone-zoneset-viewability-1-a     |1            |
       |zone-zoneset-viewability-2-a     |1            |

  @SupplyType
      Scenario: create entities for Supply type
      Given i disable campaigns by name on db
        |Campaign Name                        |
        |campaign-SupplyType-ST-HB            |
        |campaign-SupplyType-ST-Direct        |
        |campaign-SupplyType-ST-ALL           |
        |campaign-SupplyType-SS-Direct        |
        |campaign-SupplyType-SS-HB            |
        |campaign-SupplyType-SS-ALL           |
        |campaign-SupplyType-Desktop-ALL      |
        |campaign-SupplyType-Desktop-HB       |
        |campaign-SupplyType-Desktop-Direct   |
      Given i remove all zones from publishers: {3728}
      Given i create new campaigns with Supply type
      |Campaign Name                        |IO            |LineItem   |Deal                   |Creative\Deal   |Zonesets-zone Name                   |limitation        |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |supplyType |
      |campaign-SupplyType-ST-HB            |75396         |210722     |false                  |204             |{zone-zoneset-SupplyType-ST-HB}       |[]                |83        |2080             |3728           |66830             |HB         |
      |campaign-SupplyType-ST-Direct        |75396         |210722     |false                  |204             |{zone-zoneset-SupplyType-ST-Direct}       |[]                |83        |2080             |3728           |66830             |Direct     |
      |campaign-SupplyType-ST-ALL           |75396         |210722     |false                  |204             |{zone-zoneset-SupplyType-ST-ALL}       |[]                |83        |2080             |3728           |66830             |All        |
      |campaign-SupplyType-SS-Direct        |75396         |197418     |false                  |86              |{zone-zoneset-SupplyType-SS-Direct}       |[]                |69        |2080             |3728           |66831             |Direct     |
      |campaign-SupplyType-SS-HB            |75396         |197418     |false                  |86              |{zone-zoneset-SupplyType-SS-HB}       |[]                |69        |2080             |3728           |66831             |HB         |
      |campaign-SupplyType-SS-ALL           |75396         |197418     |false                  |86              |{zone-zoneset-SupplyType-SS-ALL}       |[]                |69        |2080             |3728           |66831             |All        |
      |campaign-SupplyType-Desktop-ALL      |75396         |197420     |false                  |85              |{zone-zoneset-SupplyType-Desktop-ALL}  |[]                |10        |2080             |3728           |66833             |All        |
      |campaign-SupplyType-Desktop-HB       |75396         |197420     |false                  |85              |{zone-zoneset-SupplyType-Desktop-HB}  |[]                |10        |2080             |3728           |66833             |HB         |
      |campaign-SupplyType-Desktop-Direct   |75396         |197420     |false                  |85              |{zone-zoneset-SupplyType-Desktop-Direct}  |[]                |10        |2080             |3728           |66833             |Direct     |
 And i update campaign data by name
      |Campaign Name                        |Priority      |campaign_delivery_method|delivery_algorithm|
      |campaign-SupplyType-ST-HB            |-2            |1                       |4                 |
      |campaign-SupplyType-ST-Direct        |-1            |2                       |3                 |
      |campaign-SupplyType-ST-ALL           | 1            |4                       |2                 |
      |campaign-SupplyType-SS-Direct        |-2            |1                       |4                 |
      |campaign-SupplyType-SS-HB            |-1            |2                       |3                 |
      |campaign-SupplyType-SS-ALL           |1             |4                       |2                 |
      |campaign-SupplyType-Desktop-ALL      |-2            |1                       |4                 |
      |campaign-SupplyType-Desktop-HB       |-1            |2                       |3                 |
      |campaign-SupplyType-Desktop-Direct   | 1            |4                       |2                 |
    And i update zone data by name
      |Zone Name                              |is_secure    |
      |zone-zoneset-SupplyType-ST-HB          |1            |
      |zone-zoneset-SupplyType-ST-Direct      |1            |
      |zone-zoneset-SupplyType-ST-ALL         |1            |
      |zone-zoneset-SupplyType-SS-Direct      |1            |
      |zone-zoneset-SupplyType-SS-HB          |1            |
      |zone-zoneset-SupplyType-SS-ALL         |1            |
      |zone-zoneset-SupplyType-Desktop-ALL    |1            |
      |zone-zoneset-SupplyType-Desktop-HB     |1            |
      |zone-zoneset-SupplyType-Desktop-Direct |1            |

  @PG1
  Scenario: create entities for PG1 tests
#    Given i remove all zones from publishers: {3675,3666}
      Given i disable campaigns by name on db
        |Campaign Name                     |
        |campaign-PG1-Desktop-limited      |
        |campaign-PG1-Desktop              |
        |campaign-PG1-Smartphone-limited   |
        |campaign-PG1-Smartphone           |
        |campaign-PG1-Tablet-limited       |
        |campaign-PG1-Tablet               |
    Given i create new zone named {zone-zoneset-PG1-1-allowed} with limitation {[]} with adUnitId 83 and web_section id 14402 with affiliateId 3666 with po_line_item_id 66997
    And i create new zone named {zone-zoneset-PG1-2} with limitation {[]} with adUnitId 83 and web_section id 14403 with affiliateId 3675 with po_line_item_id 67000
    Given i create new zone named {zone-zoneset-PG1-3-allowed} with limitation {[]} with adUnitId 83 and web_section id 14402 with affiliateId 3666 with po_line_item_id 66997
    And i create new zone named {zone-zoneset-PG1-4} with limitation {[]} with adUnitId 83 and web_section id 14403 with affiliateId 3675 with po_line_item_id 67000
    Given i create new zone named {zone-zoneset-PG1-5-allowed} with limitation {[]} with adUnitId 83 and web_section id 14402 with affiliateId 3666 with po_line_item_id 66997
    And i create new zone named {zone-zoneset-PG1-6} with limitation {[]} with adUnitId 83 and web_section id 14403 with affiliateId 3675 with po_line_item_id 67000
    Given i create new campaigns with new zoneset
      |Campaign Name                       |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name                              |
      |campaign-PG1-Desktop-limited        |75396         |210722     |false                  |14609           |{zone-zoneset-PG1-1-allowed,zone-zoneset-PG1-2} |
      |campaign-PG1-Desktop                |75396         |210722     |false                  |204             |{zone-zoneset-PG1-1-allowed,zone-zoneset-PG1-2} |
      |campaign-PG1-Smartphone-limited     |75396         |210722     |false                  |14610           |{zone-zoneset-PG1-3-allowed,zone-zoneset-PG1-4} |
      |campaign-PG1-Smartphone             |75396         |210722     |false                  |204             |{zone-zoneset-PG1-3-allowed,zone-zoneset-PG1-4} |
      |campaign-PG1-Tablet-limited         |75396         |210722     |false                  |14611           |{zone-zoneset-PG1-5-allowed,zone-zoneset-PG1-6} |
      |campaign-PG1-Tablet                 |75396         |210722     |false                  |204             |{zone-zoneset-PG1-5-allowed,zone-zoneset-PG1-6} |
    And i update campaign data by name
      |Campaign Name                     |Priority      |campaign_delivery_method|delivery_algorithm|
      |campaign-PG1-Desktop-limited      |-2            |1                       |4                 |
      |campaign-PG1-Desktop              |-1            |2                       |3                 |
      |campaign-PG1-Smartphone-limited   |-2            |1                       |4                 |
      |campaign-PG1-Smartphone           |-1            |2                       |3                 |
      |campaign-PG1-Tablet-limited       |-2            |1                       |4                 |
      |campaign-PG1-Tablet               |-1            |2                       |3                 |
    And i update banner data by name
      |Banner Name                     |limitation       |
      |campaign-PG1-Desktop-banner-1   |[[[50,"==",1]]]  |
      |campaign-PG1-Smartphone-banner-1|[[[49,"==",1]]]  |
      |campaign-PG1-Tablet-banner-1    |[[[33,"==",1]]]  |
    And i update zone data by name
      |Zone Name                    |is_secure    |
      |zone-zoneset-PG1-1-allowed   |1            |
      |zone-zoneset-PG1-2           |1            |
      |zone-zoneset-PG1-3-allowed   |1            |
      |zone-zoneset-PG1-4           |1            |
      |zone-zoneset-PG1-5-allowed   |1            |
      |zone-zoneset-PG1-6           |1            |


  @PGX
  Scenario: create entities for PGX tests
    Given i disable campaigns by name on db
      |Campaign Name            |
      |campaign-PGX-PG-1-a      |
      |campaign-PGX-ST-1-a      |
      |campaign-PGX-PG-1-b      |
      |campaign-PGX-PG-1-c      |
    Given i remove all zones from publishers: {3739}
    Given i create new campaigns with new zoneset
      |Campaign Name             |IO            |LineItem   |isServerProgrammatic?  |Deal\Creative    |Zonesets-zones Name           |limitation   |adUnitId  |Web_Section id    |publisher ID   |po_line_item ID   |
      |campaign-PGX-PG-1-a       |75396         |222908     |false                  |14488             |{zone-zoneset-PGX-PG-1-a}     |[]           |92        |14852             |3739           |67163             |
      |campaign-PGX-ST-1-a       |75396         |210722     |false                  |204                |{zone-zoneset-PGX-ST-1-a}     |[]           |83        |14852             |3739           |67162             |
     |campaign-PGX-PG-1-b       |75396         |222908     |false                   |14488             |{zone-zoneset-PGX-PG-1-b}     |[]           |92        |14400             |3673           |67165             |
      |campaign-PGX-PG-1-c       |75396         |222908     |false                  |14488             |{zone-zoneset-PGX-PG-1-c}     |[]           |92        |2080              |3728           |67166             |
    And i update campaign data by name
      |Campaign Name            |Priority      |campaign_delivery_method|
      |campaign-PGX-PG-1-b      |1             |4                       |
      |campaign-PGX-PG-1-c      |1             |4                       |
    And i update zone data by name
      |Zone Name                    |is_secure    |
      |zone-zoneset-PGX-PG-1-a      |1            |
      |zone-zoneset-PGX-ST-1-a      |1            |
      |zone-zoneset-PGX-PG-1-b      |1            |
      |zone-zoneset-PGX-PG-1-c      |1            |
      |zone-zoneset-PG1-5-allowed   |1            |
      |zone-zoneset-PG1-6           |1            |

  @Inapp
  Scenario: create entities for Inapp tests
    Given i disable campaigns by name on db
      |Campaign Name         |
      |campaign-Inapp-SI-1   |
      |campaign-Inapp-SI-2   |
      |campaign-Inapp-SI-3   |
      |campaign-Inapp-SI-4   |
      |campaign-Inapp-SI-5   |
      |campaign-Inapp-SI-6   |
    Given i remove all zones from publishers: {2546}
    Given i remove all zones from publishers: {3585}
    Given i remove all zones from publishers: {3586}
    Given i create new campaigns with new zoneset
      |Campaign Name             |IO            |LineItem   |isServerProgrammatic?  |Deal\Creative     |Zonesets-zones Name           |limitation   |adUnitId  |Web_Section id    |publisher ID   |po_line_item ID   |
      |campaign-Inapp-SI-1       |75396         |222908     |false                  |14619             |{zone-zoneset-Inapp-SI-1}     |[]           |80        |5164             |2546           |67259             |
#      |campaign-Inapp-SI-1       |75396         |222908     |false                  |14619             |{zone-zoneset-Inapp-SI-1}     |[]           |80        |5164             |2546           |?             |
      |campaign-Inapp-SI-2       |75396         |222908     |false                  |14620             |{zone-zoneset-Inapp-SI-2}     |[]           |80        |5164             |2546           |67259             |
#      |campaign-Inapp-SI-2       |75396         |222908     |false                  |14620             |{zone-zoneset-Inapp-SI-2}     |[]           |80        |5164             |2546           |?             |
      |campaign-Inapp-SI-3       |75396         |222908     |false                  |14621             |{zone-zoneset-Inapp-SI-3}     |[]           |80        |5164             |2546           |67259             |
#      |campaign-Inapp-SI-3       |75396         |222908     |false                  |14621             |{zone-zoneset-Inapp-SI-3}     |[]           |80        |5164             |2546           |?             |
      |campaign-Inapp-SI-4       |75396         |222908     |false                  |14451             |{zone-zoneset-Inapp-SI-4}     |[]           |80        |5164             |2546           |67259             |
#      |campaign-Inapp-SI-4       |75396         |222908     |false                  |14451             |{zone-zoneset-Inapp-SI-4}     |[]           |80        |5164             |2546           |?             |
      |campaign-Inapp-SI-5       |75396         |222908     |false                  |14621             |{zone-zoneset-Inapp-SI-5}     |[]           |80        |10138            |3585           |67260             |
#      |campaign-Inapp-SI-5       |75396         |222908     |false                  |14621             |{zone-zoneset-Inapp-SI-5}     |[]           |80        |10138            |3585           |?             |
      |campaign-Inapp-SI-6       |75396         |222908     |false                  |14621            |{zone-zoneset-Inapp-SI-6}     |[]           |80        |8803             |3586           |67260           |
#      |campaign-Inapp-SI-6       |75396         |222908     |false                  |14621            |{zone-zoneset-Inapp-SI-6}     |[]           |80        |8803             |3586           |?             |
    And i update campaign data by name
      |Campaign Name             |Priority      |campaign_delivery_method|delivery_algorithm|
      |campaign-Inapp-SI-1       |-2            |1                       |4                 |
      |campaign-Inapp-SI-2       |-1            |2                       |3                 |
      |campaign-Inapp-SI-3       |-1            |2                       |3                 |
      |campaign-Inapp-SI-4       |-1            |2                       |3                 |
      |campaign-Inapp-SI-5       |-1            |2                       |3                 |
      |campaign-Inapp-SI-6       |-1            |2                       |3                 |
    And i update zone data by name
      |Zone Name                 |is_mraid     |
      |zone-zoneset-Inapp-SI-1   |1            |
      |zone-zoneset-Inapp-SI-2   |1            |
      |zone-zoneset-Inapp-SI-3   |1            |
      |zone-zoneset-Inapp-SI-4   |1            |
      |zone-zoneset-Inapp-SI-5   |1            |
      |zone-zoneset-Inapp-SI-6   |1            |
    And i update zone data by name
      |Zone Name                 |is_secure    |
      |zone-zoneset-Inapp-SI-1   |1            |
      |zone-zoneset-Inapp-SI-2   |1            |
      |zone-zoneset-Inapp-SI-3   |1            |
      |zone-zoneset-Inapp-SI-4   |1            |
      |zone-zoneset-Inapp-SI-5   |1            |
      |zone-zoneset-Inapp-SI-6   |1            |

  @InAppBlackWhiteList
  Scenario: create entities for Black and white app listu
    Given i disable campaigns by name on db
      |Campaign Name         |
      |campaign-InappBlackWhiteList-SI-1   |
      |campaign-InappBlackWhiteList-SI-2   |
      |campaign-InappBlackWhiteList-SI-3   |
      |campaign-InappBlackWhiteList-SI-4   |
      |campaign-InappBlackWhiteList-SI-5   |
      |campaign-InappBlackWhiteList-SI-6   |
      |campaign-InappBlackWhiteList-SI-7   |
    Given i remove all zones from publishers: {1111}
    Given i create new campaigns, new zoneset with domains
      |Campaign Name                             |IO            |LineItem     |isServerProgrammatic?  |Deal\Creative     |Zonesets-zones Name                          |limitation           |adUnitId  |Web_Section id    |publisher ID   |po_line_item ID   |app_include                     |app_exclude|
      |campaign-InappBlackWhiteList-SI-1         |75396         |222908       |false                  |14619             |{zone-zoneset-InappBlackWhiteList-SI-1}      |[]                   |80        |451               |1111           |67261             |[{app1,2}]                      |[{app2,2}] |
      |campaign-InappBlackWhiteList-SI-2         |75396         |222908       |false                  |14619             |{zone-zoneset-InappBlackWhiteList-SI-2}      |[]                   |80        |451               |1111           |67261             |[]                              |[{app2,2}] |
      |campaign-InappBlackWhiteList-SI-3         |75396         |222908       |false                  |14619             |{zone-zoneset-InappBlackWhiteList-SI-3}      |[]                   |80        |451               |1111           |67261             |[{app1,2}]                      |[]         |
      |campaign-InappBlackWhiteList-SI-4         |75396         |222908       |false                  |14619             |{zone-zoneset-InappBlackWhiteList-SI-4}      |[]                   |80        |451               |1111           |67261             |[{app1,2}]                      |[{app1,2}] |
      |campaign-InappBlackWhiteList-SI-5         |75396         |222908       |false                  |14619             |{zone-zoneset-InappBlackWhiteList-SI-5}      |[]                   |80        |451               |1111           |67261             |[]                              |[]         |
      |campaign-InappBlackWhiteList-SI-6         |75396         |222908       |false                  |14619             |{zone-zoneset-InappBlackWhiteList-SI-6}      |[]                   |80        |451               |1111           |67261             |[]                              |[{app1,2};{app2,2};{app3,2}]|
      |campaign-InappBlackWhiteList-SI-7         |75396         |222908       |false                  |14619             |{zone-zoneset-InappBlackWhiteList-SI-7}      |[]                   |80        |451               |1111           |67261             |[{app1,2};{app2,2};{app3,2}]    |[]                          |
    And i update zone data by name
      |Zone Name                                 |is_mraid     |
      |zone-zoneset-InappBlackWhiteList-SI-1     |1            |
      |zone-zoneset-InappBlackWhiteList-SI-2     |1            |
      |zone-zoneset-InappBlackWhiteList-SI-3     |1            |
      |zone-zoneset-InappBlackWhiteList-SI-4     |1            |
      |zone-zoneset-InappBlackWhiteList-SI-5     |1            |
      |zone-zoneset-InappBlackWhiteList-SI-6     |1            |
      |zone-zoneset-InappBlackWhiteList-SI-7     |1            |
    And i update zone data by name
      |Zone Name                                 |is_secure    |
      |zone-zoneset-InappBlackWhiteList-SI-1     |1            |
      |zone-zoneset-InappBlackWhiteList-SI-2     |1            |
      |zone-zoneset-InappBlackWhiteList-SI-3     |1            |
      |zone-zoneset-InappBlackWhiteList-SI-4     |1            |
      |zone-zoneset-InappBlackWhiteList-SI-5     |1            |
      |zone-zoneset-InappBlackWhiteList-SI-6     |1            |
      |zone-zoneset-InappBlackWhiteList-SI-7     |1            |


  @DynamicPricing
  Scenario: create entities for dynamic pricing
    Given i disable campaigns by name on db
      |Campaign Name                       |
      |campaign-DP-Direct-300X250-2        |
      |campaign-DP-Direct-300X250-1        |
      |campaign-DP-ProgG-SS-1X1-2          |
      |campaign-DP-ProgG-SS-1X1-1          |
      |campaign-DP-ProgNG-ST-1X2-2         |
      |campaign-DP-ProgNG-ST-1X2-1         |
      |campaign-DP-ClientProg-970X250-P-2  |
      |campaign-DP-ClientProg-970X250-P-1  |
      |campaign-DP-ClientProg-970X250-D    |
#When running alone run this step ->
    # Given i remove all zones from publishers: {3728}
    Given i create new campaigns with new zoneset
      |Campaign Name                      |IO            |LineItem   |isServerProgrammatic?  |Deal\Creative     |Zonesets-zones Name                       |limitation  |adUnitId  |Web_Section id     |publisher ID   |po_line_item ID  |
      |campaign-DP-Direct-300X250-1       |75396         |234550     |false                  |85                |{zone-zoneset-DP-Direct-300X250-1}        |[]          |10        |14862              |3728           |66833            |
#PROD |campaign-DP-Direct-300X250-1       |75396         |234656     |false                  |85                |{zone-zoneset-DP-Direct-300X250-1}        |[]          |10        |14877              |3728           |66833            |
      |campaign-DP-Direct-300X250-2       |75396         |234550     |false                  |85                |{zone-zoneset-DP-Direct-300X250-2}        |[]          |10        |14862              |3728           |66833            |
#PROD |campaign-DP-Direct-300X250-2       |75396         |234656     |false                  |85                |{zone-zoneset-DP-Direct-300X250-2}        |[]          |10        |14877              |3728           |66833            |
      |campaign-DP-ProgG-SS-1X1-1         |407981        |228962     |true                   |17                |{zone-zoneset-DP-ProgG-SS-1X1-1}          |[]          |69        |14862              |3728           |66831            |
#PROD  |campaign-DP-ProgG-SS-1X1-1         |407981        |228962     |true                   |17                |{zone-zoneset-DP-ProgG-SS-1X1-1}          |[]          |69        |14877              |3728           |66831            |
      |campaign-DP-ProgG-SS-1X1-2         |407981        |228962     |true                   |17                |{zone-zoneset-DP-ProgG-SS-1X1-2}          |[]          |69        |14862              |3728           |66831            |
#PROD  |campaign-DP-ProgG-SS-1X1-2         |407981        |228962     |true                   |17                |{zone-zoneset-DP-ProgG-SS-1X1-2}          |[]          |69        |14877              |3728           |66831            |
      |campaign-DP-ProgNG-ST-1X2-1        |407981        |224533     |true                   |33                |{zone-zoneset-DP-ProgNG-ST-1X2-1}         |[]          |83        |14862              |3728           |66830            |
#PROD  |campaign-DP-ProgNG-ST-1X2-1        |407981        |224533     |true                   |33                |{zone-zoneset-DP-ProgNG-ST-1X2-1}         |[]          |83        |14877              |3728           |66830            |
      |campaign-DP-ProgNG-ST-1X2-2        |407981        |224533     |true                   |33                |{zone-zoneset-DP-ProgNG-ST-1X2-2}         |[]          |83        |14862              |3728           |66830            |
#PROD  |campaign-DP-ProgNG-ST-1X2-2        |407981        |224533     |true                   |33                |{zone-zoneset-DP-ProgNG-ST-1X2-2}         |[]          |83        |14877              |3728           |66830            |
      |campaign-DP-ClientProg-970X250-P-1 |407981        |224539     |false                  |7143              |{zone-zoneset-DP-ClientProg-970X250-P-1}  |[]          |58        |14862              |3728           |67182            |
#PROD |campaign-DP-ClientProg-970X250-P-1 |407981        |224539     |false                  |7143              |{zone-zoneset-DP-ClientProg-970X250-P-1}  |[]          |58        |14877              |3728           |67231            |
      |campaign-DP-ClientProg-970X250-P-2 |407981        |224539     |false                  |7143              |{zone-zoneset-DP-ClientProg-970X250-P-2}  |[]          |58        |14862              |3728           |67182            |
#PROD |campaign-DP-ClientProg-970X250-P-2 |407981        |224539     |false                  |7143              |{zone-zoneset-DP-ClientProg-970X250-P-2}  |[]          |58        |14877              |3728           |67231            |
      |campaign-DP-ClientProg-970X250-D   |75396         |198082     |false                  |64                |{zone-zoneset-DP-ClientProg-970X250-D}    |[]          |58        |14862              |3728           |67182            |
#PROD |campaign-DP-ClientProg-970X250-D   |75396         |198082     |false                  |64                |{zone-zoneset-DP-ClientProg-970X250-D}    |[]          |58        |14877              |3728           |67231            |
 And i update campaign data by name
      |Campaign Name                       |Priority      |campaign_delivery_method|delivery_algorithm|
      |campaign-DP-Direct-300X250-2        |-2            |1                       |4                 |
      |campaign-DP-Direct-300X250-1        |-1            |2                       |3                 |
      |campaign-DP-ProgG-SS-1X1-2          |-2            |1                       |4                 |
      |campaign-DP-ProgG-SS-1X1-1          |-1            |2                       |3                 |
      |campaign-DP-ProgNG-ST-1X2-2         |-2            |1                       |4                 |
      |campaign-DP-ProgNG-ST-1X2-1         |-1            |2                       |3                 |
      |campaign-DP-ClientProg-970X250-P-2  |-2            |1                       |4                 |
      |campaign-DP-ClientProg-970X250-P-1  |-1            |2                       |3                 |
      |campaign-DP-ClientProg-970X250-D    | 1            |4                       |2                 |

    @PLT
    Scenario: create entities for Persona Level Targeting test
      Given i disable campaigns by name on db
        |Campaign Name                        |
        |campaign-PLT-NotPersonaL-ST-1        |
        |campaign-PLT-YesPersonaL-ST-1        |
      Given i create new campaigns with new zoneset
        |Campaign Name                         |IO            |LineItem   |isServerProgrammatic?  |Deal\Creative       |Zonesets-zones Name                        |limitation  |adUnitId  |Web_Section id     |publisher ID   |po_line_item ID  |
        |campaign-PLT-NotPersonaL-ST-1         |75396         |210722     |false                  |8158                |{zone-zoneset-PLT-NotPersonaL-ST-1}        |[]          |93        |15132              |3708           |67638            |
        |campaign-PLT-YesPersonaL-ST-1         |75396         |210722     |false                  |8158                |{zone-zoneset-PLT-YesPersonaL-ST-1}        |[]          |93        |15131              |3708           |67638            |
      And i update campaign data by name
        |Campaign Name                       |is_persona_targeting |
        |campaign-PLT-NotPersonaL-ST-1       |0                    |
        |campaign-PLT-YesPersonaL-ST-1       |1                    |
      And i update banner data by name
        |Banner Name                                |limitation                           |
        |campaign-PLT-NotPersonaL-ST-1-banner-1     |[[[4,"==",1,1,456],[4,"==",1,1,123]]]|
        |campaign-PLT-YesPersonaL-ST-1-banner-1     |[[[4,"==",1,1,456],[4,"==",1,1,123]]]|
      And i update zone data by name
      |Zone Name                               |is_secure |
      |zone-zoneset-PLT-NotPersonaL-ST-1       |1         |
      |zone-zoneset-PLT-YesPersonaL-ST-1       |1         |


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
    And I sleep for 450 seconds

  @refreshZoneCache
  Scenario: refresh zone cache
    And I refresh the zone Cache

  @optimize
  Scenario: update test strategy
    Given i disable all tests except 53
    And I set test id of test_strategy named {scoringV2} to {53}

  @optimize
  Scenario: save entities to file
      And save all entities to json file
