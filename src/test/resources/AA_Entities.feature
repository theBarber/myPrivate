@couchBaseUtil
@scheduled
Feature: Entities for tests

  @zoneTagSanity
  Scenario: create entities for zone Tag Sanity test
    Given i create new campaigns with new zoneset
      |Campaign Name               |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name          |limitation        |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |
      |campaign-API-1-a-sanity     |75396         |210722     |false                  |204             |{zone-zoneset-sanity-1-a}   |[]                |83        |4737             |2434           |17116             |

  @GDPR
  Scenario: create entities for zone Tag Sanity test
    Given i create new campaigns with new zoneset
      |Campaign Name               |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name          |limitation        |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |
      |campaign-API-1-a-GDPR       |75396         |210722     |false                  |204             |{zone-zoneset-GDPR-1-a}   |[]                |83        |4737             |2434           |17116             |
    And i update banner data by name
      |Banner Name                     |limitation     |
      |campaign-API-1-a-GDPR-banner-1    |[]             |

  @limitationSanity
  Scenario: create entities for zone Tag Sanity test
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

  @GDPR
  @HB
  Scenario: create entities for HB tests
      Given i remove all zones from publishers: {3673,3697}
      Given i create new campaigns with new zoneset
        |Campaign Name                         |IO       |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name                      |limitation     |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |
        |campaign-HB-Tablet-160x600            |75396    |223539     |false                  |148             |{zone-zoneset-HB-Tablet-160x600}         |[]            |8         |14400            |3673           |65421             |
        |campaign-HB-See-Through-1X2           |75396    |210722     |false                  |204             |{zone-zoneset-HB-See Through 1X2}        |[]            |83        |14400            |3673           |64396             |
        |campaign-HB-Billboard-970X250         |75396    |198082     |false                  |64              |{zone-zoneset-HB-Billboard-970X250}       |[]            |58        |14400            |3673           |66720             |
#        |campaign-HB-Billboard-970X250        |75396    |198082     |false                  |64             |{zone-zoneset-HB-Billboard-970X250}       |[]            |58        |14400           |3673           |66813             |
        |campaign-HB-Desktop-300X250           |75396    |197420     |false                  |85              |{zone-zoneset-Desktop-300X250}            |[]            |10        |14400            |3673           |66725             |
#       |campaign-HB-Desktop-300X250           |75396    |197420     |false                  |85              |{zone-zoneset-Desktop-300X250}            |[]            |10        |14400            |3673           |66814             |
        |campaign-HB-SS-1X1                    |75396    |197418     |false                  |86              |{zone-zoneset-HB-SS-1X1}                  |[]           |69         |14400            |3673           |66730             |
        |campaign-HB-Prog-PGC-1X1-1           |407981   |224812     |false                  |6499            |{zone-zoneset-HB-Prog-PGC-1X1}           |[]            |69        |14507            |3697           |66004             |
        |campaign-HB-Prog-PGC-1X1-2           |407981   |224812     |false                  |6499            |{zone-zoneset-HB-Prog-PGC-1X1}           |[]            |69        |14507            |3697           |66004             |
        |campaign-HB-Prog-PGC-1X1-3           |75396    |222908     |false                  |86              |{zone-zoneset-HB-Prog-PGC-1X1}           |[]            |69        |14507            |3697           |66004             |
        |campaign-HB-Prog-See-Through-1X2-1   |407981   |224810     |false                  |6497            |{zone-zoneset-HB-Prog-See-Through-1X2}   |[]            |83        |14507            |3697           |66002             |
        |campaign-HB-Prog-See-Through-1X2-2   |407981   |224810     |false                  |6497            |{zone-zoneset-HB-Prog-See-Through-1X2}   |[]            |83        |14507            |3697           |66002             |
        |campaign-HB-Prog-See-Through-1X2-3   |407981   |224810     |false                  |6497            |{zone-zoneset-HB-Prog-See-Through-1X2}   |[]            |83        |14507            |3697           |66002             |
        |campaign-HB-Prog-Billboard-970X250-D |75396    |198082     |false                  |64              |{zone-zoneset-HB-Prog-Billboard-970X250} |[]            |58        |14507            |3697           |66673             |
        |campaign-HB-Prog-Billboard-970X250-P |407981   |224539     |false                  |7143            |{zone-zoneset-HB-Prog-Billboard-970X250} |[]            |58        |14507            |3697           |66673             |
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

    @HB
    Scenario: create entities for HB tests with multiple domains
      Given i create new zone named {zone-zoneset-HB-Tablet-160x600-D-1-a} with limitation {[]} with adUnitId 8 and web_section id 14677 with affiliateId 3673 with po_line_item_id 65421
      And i create new zone named {zone-zoneset-HB-Tablet-160x600-D-1-b} with limitation {[]} with adUnitId 8 and web_section id 14677 with affiliateId 3673 with po_line_item_id 65421
      And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-1-a} with limitation {[]} with adUnitId 83 and web_section id 14677 with affiliateId 3673 with po_line_item_id 64396
      And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-1-b} with limitation {[]} with adUnitId 83 and web_section id 14677 with affiliateId 3673 with po_line_item_id 64396
      Given i create new zone named {zone-zoneset-HB-Tablet-160x600-D-2-a} with limitation {[]} with adUnitId 8 and web_section id 14678 with affiliateId 3673 with po_line_item_id 65421
      And i create new zone named {zone-zoneset-HB-Tablet-160x600-D-2-b} with limitation {[]} with adUnitId 8 and web_section id 14678 with affiliateId 3673 with po_line_item_id 65421
      And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-2-a} with limitation {[]} with adUnitId 83 and web_section id 14678 with affiliateId 3673 with po_line_item_id 64396
      And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-2-b} with limitation {[]} with adUnitId 83 and web_section id 14678 with affiliateId 3673 with po_line_item_id 64396
      Given i create new zone named {zone-zoneset-HB-Tablet-160x600-D-3-a} with limitation {[]} with adUnitId 8 and web_section id 14679 with affiliateId 3673 with po_line_item_id 65421
      And i create new zone named {zone-zoneset-HB-Tablet-160x600-D-3-b} with limitation {[]} with adUnitId 8 and web_section id 14679 with affiliateId 3673 with po_line_item_id 65421
      And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-3-a} with limitation {[]} with adUnitId 83 and web_section id 14679 with affiliateId 3673 with po_line_item_id 64396
      And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-3-b} with limitation {[]} with adUnitId 83 and web_section id 14679 with affiliateId 3673 with po_line_item_id 64396
      Given i create new zone named {zone-zoneset-HB-Tablet-160x600-D-4-a} with limitation {[]} with adUnitId 8 and web_section id 14680 with affiliateId 3673 with po_line_item_id 65421
      And i create new zone named {zone-zoneset-HB-Tablet-160x600-D-4-b} with limitation {[]} with adUnitId 8 and web_section id 14680 with affiliateId 3673 with po_line_item_id 65421
      And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-4-a} with limitation {[]} with adUnitId 83 and web_section id 14680 with affiliateId 3673 with po_line_item_id 64396
      And i create new zone named {zone-zoneset-HB-See-Through-1X2-D-4-b} with limitation {[]} with adUnitId 83 and web_section id 14680 with affiliateId 3673 with po_line_item_id 64396
      And i create new campaigns with new zoneset
        |Campaign Name                    |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal        |Zonesets-zone Name                            |
        |HB-Tablet-160x600-D-1-a-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-1-a}        |
        |HB-Tablet-160x600-D-1-a-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-1-a}        |
        |HB-Tablet-160x600-D-1-b-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-1-b}        |
        |HB-Tablet-160x600-D-1-b-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-1-b}        |
        |See-Through-1X2-D-1-a-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-1-a}        |
        |See-Through-1X2-D-1-a-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-1-a}        |
        |See-Through-1X2-D-1-b-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-1-b}        |
        |See-Through-1X2-D-1-b-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-1-b}        |
        |HB-Tablet-160x600-D-2-a-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-2-a}        |
        |HB-Tablet-160x600-D-2-a-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-2-a}        |
        |HB-Tablet-160x600-D-2-b-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-2-b}        |
        |HB-Tablet-160x600-D-2-b-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-2-b}        |
        |See-Through-1X2-D-2-a-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-2-a}        |
        |See-Through-1X2-D-2-a-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-2-a}        |
        |See-Through-1X2-D-2-b-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-2-b}        |
        |See-Through-1X2-D-2-b-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-2-b}        |
        |HB-Tablet-160x600-D-3-a-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-3-a}        |
        |HB-Tablet-160x600-D-3-a-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-3-a}        |
        |HB-Tablet-160x600-D-3-b-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-3-b}        |
        |HB-Tablet-160x600-D-3-b-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-3-b}        |
        |See-Through-1X2-D-3-a-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-3-a}        |
        |See-Through-1X2-D-3-a-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-3-a}        |
        |See-Through-1X2-D-3-b-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-3-b}        |
        |See-Through-1X2-D-3-b-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-3-b}        |
        |HB-Tablet-160x600-D-4-a-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-4-a}        |
        |HB-Tablet-160x600-D-4-a-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-4-a}        |
        |HB-Tablet-160x600-D-4-b-1        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-4-b}        |
        |HB-Tablet-160x600-D-4-b-2        |75396         |223539     |false                  |148                  |{zone-zoneset-HB-Tablet-160x600-D-4-b}        |
        |See-Through-1X2-D-4-a-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-4-a}        |
        |See-Through-1X2-D-4-a-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-4-a}        |
        |See-Through-1X2-D-4-b-1          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-4-b}        |
        |See-Through-1X2-D-4-b-2          |75396         |210722     |false                  |204                  |{zone-zoneset-HB-See-Through-1X2-D-4-b}        |
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

  @DT
  Scenario: create entities for DT tests
      Given i remove all zones from publishers: {3674,3675,3666}
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
        |campaign-DT-SI-1-t-3-L  |75396    |211456     |false                  |210             |{zone-zoneset-DT-SI-t-3-L}   |[[[5,"=~","af"]]]   |61         |14403            |3675           |66739             |
        |campaign-DT-SI-2-t-3    |75396    |211456     |false                  |210             |{zone-zoneset-DT-SI-t-3}     |[]                  |61         |14403            |3675           |66739             |
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
  @GDPR
  @DT
    Scenario: create entities for DT inline tests
      Given i remove all zones from publishers: {3690}
      Given i create new campaigns with new zoneset
        |Campaign Name               |IO       |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name            |limitation          |adUnitId   |Web_Section id   |publisher ID   |po_line_item ID   |
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
      And I flush bucket name {us-east-1-adserver} on couchbase

  @DOT
  Scenario: create campaigns for Domain Targeting
    Given i remove all zones from publishers: {3708}
    And i create new zone named {zone-zoneset-DomainT-4-b} with limitation {[]} with adUnitId 61 and web_section id 4140 with affiliateId 3708 with po_line_item_id 66488
    Given i create new campaigns, new zoneset with domains
      |Campaign Name              |IO            |LineItem   |isServerProgrammatic?  |Creative         |Zonesets-zones Name                                 |limitation           |adUnitId   |Web_Section id    |publisher ID   |po_line_item ID   |domain_include      |domain_exclude                    |
      |campaign-DomainT-1         |75396         |210722     |false                  |204              |{zone-zoneset-DomainT-1}                            |[]                   |83         |14539             |3708           |66418             |{}                  |{sahar.cnn.com}                   |
      |campaign-DomainT-2         |75396         |197418     |false                  |86               |{zone-zoneset-DomainT-2}                            |[]                   |69         |14539             |3708           |66486             |{}                  |{cnn.com}                         |
      |campaign-DomainT-3         |75396         |222908     |false                  |1068             |{zone-zoneset-DomainT-3}                            |[]                   |75         |14539             |3708           |66487             |{}                  |{sahar.cnn.com,cnn.com,ynet.co.il}|
      |campaign-DomainT-4         |75396         |211456     |false                  |210              |{zone-zoneset-DomainT-4-a,zone-zoneset-DomainT-4-b} |[]                   |61         |11363             |3708           |66488             |{}                  |{cnn.com}                         |
      |campaign-DomainT-BB-5      |75396         |198082     |false                  |64               |{zone-zoneset-DomainT-5-BB}                         |[]                   |58         |14539             |3708           |66722             |{sahar.cnn.com}     |{}                                |
      |campaign-DomainT-Desktop-6 |75396         |197420     |false                  |85               |{zone-zoneset-DomainT-6-Desktop}                    |[]                   |10         |14539             |3708           |66723             |{cnn.com}           |{}                                |
      |campaign-DomainT-ZoneTag-1 |75396         |210722     |false                  |204              |{zone-zoneset-DomainT-ZoneTag-1}                    |[]                   |83         |4737              |2434           |17116             |{sahar.cnn.com}     |{}                                |
      |campaign-DomainT-ZoneTag-2 |75396         |210722     |false                  |204              |{zone-zoneset-DomainT-ZoneTag-2}                    |[]                   |83         |4737              |2434           |17116             |{}                  |{sahar.ynet.co.il}                |
      |campaign-DomainT-ZoneTag-3 |75396         |210722     |false                  |204              |{zone-zoneset-DomainT-ZoneTag-3}                    |[]                   |83         |4737              |2434           |17116             |{cnn.com}           |{}                                |
      |campaign-DomainT-ZoneTag-4 |75396         |210722     |false                  |204              |{zone-zoneset-DomainT-ZoneTag-4}                    |[]                   |83         |4737              |2434           |17116             |{}                  |{ynet.co.il}                      |

##      |campaign-DomainT-BB-5      |75396         |198082     |false                  |64               |{zone-zoneset-DomainT-5-BB}                         |[]                   |58         |14539             |3708           |66810             |{sahar.cnn.com}     |{}                                |
##      |campaign-DomainT-Desktop-6 |75396         |197420     |false                  |85               |{zone-zoneset-DomainT-6-Desktop}                    |[]                   |10         |14539             |3708           |66811             |{cnn.com}           |{}                                |




  @GDPR
  @appnexus
  Scenario: create entities for server programmatic tests
    Given i remove all zones from publishers: {3711}
    Given i create new campaigns with new zoneset
      |Campaign Name              |IO            |LineItem   |isServerProgrammatic?  |Deal\Creative   |Zonesets-zones Name           |limitation   |adUnitId  |Web_Section id    |publisher ID   |po_line_item ID   |
      |campaign-server-prog-SS-1  |407981        |228669     |true                   |17               |{zone-zoneset-server-prog-SS} |[]           |69        |2164              |3711           |66556             |
#      |campaign-server-prog-SS-1  |407981        |228962     |true                   |17               |{zone-zoneset-server-prog-SS} |[]           |69        |2164              |3711           |66556             |
      |campaign-server-prog-SS-2  |407981        |224531     |true                   |18               |{zone-zoneset-server-prog-SS} |[]           |69        |2164              |3711           |66556             |
      |campaign-server-prog-SS-3  |75396         |197418     |false                  |86              |{zone-zoneset-server-prog-SS} |[]           |69        |2164              |3711           |66556             |
      |campaign-server-prog-SS-4  |407981        |224531     |true                   |19               |{zone-zoneset-server-prog-SS} |[]           |69        |2164              |3711           |66556             |
      |campaign-server-prog-PGC-1 |407981        |224530     |true                   |20               |{zone-zoneset-server-prog-PGC}|[]           |75        |2164              |3711           |66557             |
      |campaign-server-prog-PGC-2 |407981        |228670     |true                   |21               |{zone-zoneset-server-prog-PGC}|[]           |75        |2164              |3711           |66557             |
#      |campaign-server-prog-PGC-2 |407981        |228961     |true                   |21               |{zone-zoneset-server-prog-PGC}|[]           |75        |2164              |3711           |66557             |
      |campaign-server-prog-PGC-3 |407981        |224530     |true                   |22               |{zone-zoneset-server-prog-PGC}|[]           |75        |2164              |3711           |66557             |
      |campaign-server-prog-PGC-4 |407981        |228670     |true                   |23               |{zone-zoneset-server-prog-PGC}|[]           |75        |2164              |3711           |66557             |
#      |campaign-server-prog-PGC-4 |407981        |228961     |true                   |23               |{zone-zoneset-server-prog-PGC}|[]           |75        |2164              |3711           |66557             |
      |campaign-server-prog-ST-1  |407981        |228674     |true                   |24               |{zone-zoneset-server-prog-ST} |[]           |83        |2164              |3711           |66555             |
#      |campaign-server-prog-ST-1  |407981        |229737     |true                   |24               |{zone-zoneset-server-prog-ST} |[]           |83        |2164              |3711           |66555             |
      |campaign-server-prog-ST-2  |407981        |224533     |true                   |25               |{zone-zoneset-server-prog-ST} |[]           |83        |2164              |3711           |66555             |
      |campaign-server-prog-ST-3  |407981        |228674     |true                   |26               |{zone-zoneset-server-prog-ST} |[]           |83        |2164              |3711           |66555             |
#      |campaign-server-prog-ST-3  |407981       |229737     |true                   |26               |{zone-zoneset-server-prog-ST} |[]           |83        |2164              |3711           |66555             |
      |campaign-server-prog-ST-4  |407981        |224533     |true                   |27               |{zone-zoneset-server-prog-ST} |[]           |83        |2164              |3711           |66555             |
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


    @viewability
    Scenario: create entities for viewability tests
      Given i create new campaigns with viewability
        |Campaign Name                      |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name               |limitation        |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |avThreshold|avVendor  |
        |campaign-API-1-a-viewability       |75396         |210722     |false                  |204             |{zone-zoneset-viewability-1-a}   |[]                |83        |4737             |2434           |17116             |20         |ias       |
        |campaign-API-2-a-viewability       |75396         |210722     |false                  |204             |{zone-zoneset-viewability-2-a}   |[]                |83        |4737             |2434           |17116             |30         |ias       |
      And i update banner data by name
        |Banner Name                            |limitation     |
        |campaign-API-1-a-viewability-banner-1    |[]             |
        |campaign-API-2-a-viewability-banner-1    |[]             |

    @SupplyType
      Scenario: create entities for Supply type
      Given i remove all zones from publishers: {3719}
      Given i create new campaigns with Supply type
        |Campaign Name                        |IO            |LineItem   |Deal                   |Creative\Deal   |Zonesets-zone Name                   |limitation        |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |supplyType |
        |campaign-SupplyType-ST-ALL           |75396         |210722     |false                  |204             |{zone-zoneset-SupplyType-ST-ALL}       |[]                |83        |2080             |3719           |66726             |All        |
#prod   |campaign-SupplyType-ST-ALL           |75396         |210722     |false                  |204             |{zone-zoneset-SupplyType-ST-ALL}       |[]                |83        |2080             |3728           |66830             |All        |
        |campaign-SupplyType-ST-Direct        |75396         |210722     |false                  |204             |{zone-zoneset-SupplyType-ST-Direct}       |[]                |83        |2080             |3719           |66726             |Direct     |
#prod   |campaign-SupplyType-ST-Direct        |75396         |210722     |false                  |204             |{zone-zoneset-SupplyType-ST-Direct}       |[]                |83        |2080             |3728           |66830             |Direct     |
        |campaign-SupplyType-ST-HB            |75396         |210722     |false                  |204             |{zone-zoneset-SupplyType-ST-HB}       |[]                |83        |2080             |3719           |66726             |HB         |
#prod   |campaign-SupplyType-ST-HB            |75396         |210722     |false                  |204             |{zone-zoneset-SupplyType-ST-HB}       |[]                |83        |2080             |3728           |66830             |HB         |
        |campaign-SupplyType-SS-ALL           |75396         |197418     |false                  |86              |{zone-zoneset-SupplyType-SS-ALL}       |[]                |69        |2080             |3719           |66727             |All        |
#prod   |campaign-SupplyType-SS-ALL           |75396         |197418     |false                  |86              |{zone-zoneset-SupplyType-SS-ALL}       |[]                |69        |2080             |3728           |66831             |All        |
        |campaign-SupplyType-SS-Direct        |75396         |197418     |false                  |86              |{zone-zoneset-SupplyType-SS-Direct}       |[]                |69        |2080             |3719           |66727             |Direct     |
#prod   |campaign-SupplyType-SS-Direct        |75396         |197418     |false                  |86              |{zone-zoneset-SupplyType-SS-Direct}       |[]                |69        |2080             |3728           |66831             |Direct     |
        |campaign-SupplyType-SS-HB            |75396         |197418     |false                  |86              |{zone-zoneset-SupplyType-SS-HB}       |[]                |69        |2080             |3719           |66727             |HB         |
#prod   |campaign-SupplyType-SS-HB            |75396         |197418     |false                  |86              |{zone-zoneset-SupplyType-SS-HB}       |[]                |69        |2080             |3728           |66831             |HB         |
        |campaign-SupplyType-Desktop-ALL      |75396         |197420     |false                  |85              |{zone-zoneset-SupplyType-Desktop-ALL}  |[]                |10        |2080             |3719           |66729             |All        |
#prod   |campaign-SupplyType-Desktop-ALL      |75396         |197420     |false                  |85              |{zone-zoneset-SupplyType-Desktop-ALL}  |[]                |10        |2080             |3728           |66833             |All        |
        |campaign-SupplyType-Desktop-Direct   |75396         |197420     |false                  |85              |{zone-zoneset-SupplyType-Desktop-Direct}  |[]                |10        |2080             |3719           |66729             |Direct     |
#prod   |campaign-SupplyType-Desktop-Direct   |75396         |197420     |false                  |85              |{zone-zoneset-SupplyType-Desktop-Direct}  |[]                |10        |2080             |3728           |66833             |Direct     |
        |campaign-SupplyType-Desktop-HB       |75396         |197420     |false                  |85              |{zone-zoneset-SupplyType-Desktop-HB}  |[]                |10        |2080             |3719           |66729             |HB         |
#prod   |campaign-SupplyType-Desktop-HB       |75396         |197420     |false                  |85              |{zone-zoneset-SupplyType-Desktop-HB}  |[]                |10        |2080             |3728           |66833             |HB         |
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


  @weightBanners
  Scenario: create entities for Keren
    Given i create new campaigns with multiple creatives
      |Campaign Name               |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal      |Zonesets-zone Name             |limitation        |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |
      |campaign-weightBanners-A    |75396         |210722     |false                  |204,890            |{zone-zoneset-weightBanners-A} |[]                |83        |4737             |2434           |17116             |


  @PG1
  Scenario: create entities for zone Tag Sanity test
#    Given i remove all zones from publishers: {3675,3666}
    Given i create new zone named {zone-zoneset-PG1-1-allowed} with limitation {[]} with adUnitId 83 and web_section id 14402 with affiliateId 3666 with po_line_item_id 66732
    And i create new zone named {zone-zoneset-PG1-2} with limitation {[]} with adUnitId 83 and web_section id 14403 with affiliateId 3675 with po_line_item_id 66733
    Given i create new zone named {zone-zoneset-PG1-3-allowed} with limitation {[]} with adUnitId 83 and web_section id 14402 with affiliateId 3666 with po_line_item_id 66732
    And i create new zone named {zone-zoneset-PG1-4} with limitation {[]} with adUnitId 83 and web_section id 14403 with affiliateId 3675 with po_line_item_id 66733
    Given i create new zone named {zone-zoneset-PG1-5-allowed} with limitation {[]} with adUnitId 83 and web_section id 14402 with affiliateId 3666 with po_line_item_id 66732
    And i create new zone named {zone-zoneset-PG1-6} with limitation {[]} with adUnitId 83 and web_section id 14403 with affiliateId 3675 with po_line_item_id 66733
    Given i create new campaigns with new zoneset
      |Campaign Name                       |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name                              |
      |campaign-PG1-Desktop-limited        |75396         |210722     |false                  |10218           |{zone-zoneset-PG1-1-allowed,zone-zoneset-PG1-2} |
      |campaign-PG1-Desktop                |75396         |210722     |false                  |204             |{zone-zoneset-PG1-1-allowed,zone-zoneset-PG1-2} |
      |campaign-PG1-Smartphone-limited     |75396         |210722     |false                  |10219           |{zone-zoneset-PG1-3-allowed,zone-zoneset-PG1-4} |
      |campaign-PG1-Smartphone             |75396         |210722     |false                  |204             |{zone-zoneset-PG1-3-allowed,zone-zoneset-PG1-4} |
      |campaign-PG1-Tablet-limited         |75396         |210722     |false                  |10220           |{zone-zoneset-PG1-5-allowed,zone-zoneset-PG1-6} |
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
  @zoneTagSanity
  @Keren
  @limitationSanity
  @Zonerefresh
  Scenario: refresh zone cache with wait
    Given i kill replay on the machines
    And I setup the db
    And I sleep for 60 seconds

  @PG1
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
    And I sleep for 300 seconds

#  @refreshZoneCache
#  Scenario: refresh zone cache
#    And I refresh the zone Cache


