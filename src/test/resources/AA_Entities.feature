@scheduled
Feature: Entities for tests
  @AB
  Scenario: create entities for AB testing
    Given i create new campaigns with new zoneset
      |Campaign Name                      |IO       |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name                      |limitation    |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |
      |campaign-AB-Billboard-970x250      |75396    |198082     |false                  |64              |{zone-zoneset-AB-Billboard-970x250}     |[]            |58        |4737             |2434           |38734             |

  @HB
  Scenario: create entities for HB tests
      Given i remove all zones from publishers: {3673,3697}
      Given i create new campaigns with new zoneset
        |Campaign Name                      |IO       |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name                      |limitation    |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |
        |campaign-HB-Tablet-160x600         |75396    |223539     |false                  |148             |{zone-zoneset-HB-Tablet-160x600}         |[]            |8         |14400            |3673           |65421             |
        |campaign-HB-See-Through-1X2        |75396    |210722     |false                  |204             |{zone-zoneset-HB-See Through 1X2}        |[]            |83        |14400            |3673           |64396             |
        |campaign-HB-Prog-PGC-1X1-1         |407981   |224812     |false                  |6499            |{zone-zoneset-HB-Prog-PGC-1X1}           |[]            |69        |14507            |3697           |66004             |
        |campaign-HB-Prog-PGC-1X1-2         |407981   |224812     |false                  |6499            |{zone-zoneset-HB-Prog-PGC-1X1}           |[]            |69        |14507            |3697           |66004             |
        |campaign-HB-Prog-See-Through-1X2-1 |407981   |224810     |false                  |6497            |{zone-zoneset-HB-Prog-See-Through-1X2}   |[]            |83        |14507            |3697           |66002             |
        |campaign-HB-Prog-See-Through-1X2-2 |407981   |224810     |false                  |6497            |{zone-zoneset-HB-Prog-See-Through-1X2}   |[]            |83        |14507            |3697           |66002             |
        |campaign-HB-Prog-See-Through-1X2-3 |407981   |224810     |false                  |6497            |{zone-zoneset-HB-Prog-See-Through-1X2}   |[]            |83        |14507            |3697           |66002             |
        |campaign-HB-Prog-SS-1X1-P          |407981   |224813     |false                  |6503            |{zone-zoneset-HB-Prog-SS-1X1}            |[]            |69        |14507            |3697           |66003             |
        |campaign-HB-Prog-SS-1X1-D          |407981   |224809     |false                  |6501            |{zone-zoneset-HB-Prog-SS-1X1}            |[]            |69        |14507            |3697           |66003             |
     And i update campaign data by name
        |Campaign Name                      |status      |Priority      |units      |limitation|campaign_delivery_method|
        |campaign-HB-Tablet-160x600         |0           |-2            |-1         |[]        |1                       |
        |campaign-HB-See-Through-1X2        |0           |-1            |-1         |[]        |2                       |
        |campaign-HB-Prog-PGC-1X1-1         |0           |-2            |-1         |[]        |1                       |
        |campaign-HB-Prog-PGC-1X1-2         |0           |-1            |-1         |[]        |2                       |
        |campaign-HB-Prog-See-Through-1X2-1 |0           |-2            |-1         |[]        |1                       |
        |campaign-HB-Prog-See-Through-1X2-2 |0           |-1            |-1         |[]        |2                       |
        |campaign-HB-Prog-See-Through-1X2-3 |0           |1             |-1         |[]        |4                       |
        |campaign-HB-Prog-SS-1X1-P          |0           |1             |-1         |[]        |4                       |
        |campaign-HB-Prog-SS-1X1-D          |0           |-1            |-1         |[]        |2                       |
  @DT
  Scenario: create entities for DT tests
      Given i remove all zones from publishers: {3674,3675,3666}
      Given i create new campaigns with new zoneset
        |Campaign Name           |IO       |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name            |limitation          |adUnitId   |Web_Section id   |publisher ID   |po_line_item ID   |
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
  @DT
    Scenario: create entities for DT inline tests
      Given i remove all zones from publishers: {3690}
      Given i create new campaigns with new zoneset
        |Campaign Name               |IO       |LineItem   |isServerProgrammatic?  |Creative\Deal   |Zonesets-zone Name            |limitation          |adUnitId   |Web_Section id   |publisher ID   |po_line_item ID   |
        |campaign-DT-Inline-ST-1     |75396    |210722     |false                  |204             |{zone-zoneset-DT-inline-ST}  |[]                   |83         |14470            |3690           |65422             |
        |campaign-DT-Inline-SS-1     |75396    |197418     |false                  |86              |{zone-zoneset-DT-inline-SS-1}|[]                   |69         |14470            |3690           |65423             |
        |campaign-DT-Inline-SS-3     |75396    |197418     |false                  |86              |{zone-zoneset-DT-inline-ST-3}|[]                   |69         |14470            |3690           |65423             |
        |campaign-DT-Inline-PGC-2    |75396    |222908     |false                  |1068            |{zone-zoneset-DT-inline-PGC} |[]                   |75         |14470            |3690           |65424             |
      And i update campaign data by name
        |Campaign Name            |Priority      |campaign_delivery_method|
        |campaign-DT-Inline-ST-1  |-2            |1                       |
        |campaign-DT-Inline-SS-1  |-2            |1                       |
        |campaign-DT-Inline-SS-3  |1             |4                       |
        |campaign-DT-Inline-PGC-2 |-1            |2                       |
      And I flush bucket name {iad-adserver} on couchbase

  @DOT
  Scenario: create campaigns for Domain Targeting
    Given i remove all zones from publishers: {3703}
    And i create new zone named {zone-zoneset-DomainT-4-b} with limitation {[]} with adUnitId 61 and web_section id 4140 with affiliateId 3703 with po_line_item_id 66131
    Given i create new campaigns, new zoneset with domains
      |Campaign Name        |IO            |LineItem   |isServerProgrammatic?  |Creative         |Zonesets-zones Name                                 |limitation           |adUnitId   |Web_Section id    |publisher ID   |po_line_item ID   |domain_include      |domain_exclude                    |
      |campaign-DomainT-1   |75396         |210722     |false                  |204              |{zone-zoneset-DomainT-1}                            |[]                   |83         |14539             |3708           |66418             |{}                  |{sahar.cnn.com}                   |
      |campaign-DomainT-2   |75396         |197418     |false                  |86               |{zone-zoneset-DomainT-2}                            |[]                   |69         |14539             |3708           |66486             |{}                  |{cnn.com}                         |
      |campaign-DomainT-3   |75396         |222908     |false                  |1068             |{zone-zoneset-DomainT-3}                            |[]                   |75         |14539             |3708           |66487             |{}                  |{sahar.cnn.com,cnn.com,ynet.co.il}|
      |campaign-DomainT-4   |75396         |211456     |false                  |210              |{zone-zoneset-DomainT-4-a,zone-zoneset-DomainT-4-b} |[]                   |61         |11363             |3708           |66488             |{}                  |{cnn.com}                         |

#  @appnexus
#  Scenario: create entities for server programmatic tests
##    Given i remove all zones from publishers: {3703}
#    Given i create new campaigns with new zoneset
#      |Campaign Name              |IO            |LineItem   |isServerProgrammatic?  |Deal\Creative   |Zonesets-zones Name          |limitation   |adUnitId   |Web_Section id     |publisher ID   |po_line_item ID   |
#      |campaign-server-prog-SS-1  |407981        |224531     |true                   |10002           |{zone-zoneset-server-prog-SS} |[]           |69         |4737              |2434           |27397             |
#      |campaign-server-prog-SS-2  |407981        |224531     |true                   |10003           |{zone-zoneset-server-prog-SS} |[]           |69         |4737              |2434           |27397             |
#      |campaign-server-prog-SS-3  |75396         |197418     |false                  |86              |{zone-zoneset-server-prog-SS} |[]           |69         |4737              |2434           |27397             |
#      |campaign-server-prog-PGC-1 |407981        |224812     |true                   |10004           |{zone-zoneset-server-prog-PGC}|[]           |75         |4737              |2434           |27397             |
#      |campaign-server-prog-PGC-2 |407981        |224812     |true                   |10004           |{zone-zoneset-server-prog-PGC}|[]           |75         |4737              |2434           |27397             |
#      |campaign-server-prog-PGC-3 |407981        |224812     |true                   |10004           |{zone-zoneset-server-prog-PGC}|[]           |75         |4737              |2434           |27397             |
#      |campaign-server-prog-PGC-4 |407981        |224812     |true                   |10004           |{zone-zoneset-server-prog-PGC}|[]           |75         |4737              |2434           |27397             |
#      |campaign-server-prog-PGC-5 |407981        |224812     |true                   |10004           |{zone-zoneset-server-prog-PGC}|[]           |75         |4737              |2434           |27397             |
#      |campaign-server-prog-PGC-6 |407981        |224812     |true                   |10004           |{zone-zoneset-server-prog-PGC}|[]           |75         |4737              |2434           |27397             |
#      |campaign-server-prog-ST-1  |407981        |224810     |false                  |6498              |{zone-zoneset-server-prog-ST} |[]           |83         |4737              |2434           |27397             |
#      |campaign-server-prog-ST-2  |407981        |224810     |true                   |4322            |{zone-zoneset-server-prog-ST} |[]           |83         |4737              |2434           |27397             |

  @appnexus
  @cacheRefresh
  @HB
  @DOT
  @DT
  @AB
  Scenario: refresh cache
    And I refresh zone cache
    And I refresh banner cache
    And I restart {ramp-lift-services}
    And I sleep for 100 seconds