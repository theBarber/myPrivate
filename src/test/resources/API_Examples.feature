@cli
@uas
@API
Feature: API entities creator - using ramp-app APIs and sql scripts


#    Scenario: create campaign with existing zoneset (and zone linked to it)
#      Given i create new campaigns with existing zoneset
#        |Campaign Name      |IO        |LineItem   |isServerProgrammatic?   |Creative\Deal   |Zoneset ID   |
#        |campaign-API-1-a   |75396     |225323     |false                   |1068            |68626        |
#        |campaign-API-1-b   |75396     |211456     |false                   |1068            |68626        |
#
#    Scenario: create campaign with new zoneset (and zone linked to it)
#      Given i create new campaigns with new zoneset
#        |Campaign Name      |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal    |Zoneset-zone Name           |limitation           |adUnitId   |Web_Section id   |publisher ID   |po_line_item ID   |
#        |campaign-API-1-c   |75396         |210722     |false                  |204              |{zone-zoneset-API-1-a}      |[[[1,"!~",2601]]]    |83         |4737             |2434           |17116             |

  Scenario: create campaign with new zoneset with campaign prioirty
      Given i create new priority campaigns with new zoneset
        |Campaign Name               |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal|Zonesets-zone Name          |limitation        |adUnitId  |Web_Section id   |publisher ID   |po_line_item ID   |campaign priority|
        |campaign-API-1-a-sanity     |75396         |210722     |false                  |204          |{zone-zoneset-sanity-1-a}   |[]                |83        |4737             |2434           |17116             |-1               |

#
#  Scenario: create campaign with new zoneset (and zone linked to it)
#    Given i create new campaigns with new zoneset
#      |Campaign Name      |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal    |Zoneset-zone Name           |limitation           |adUnitId   |Web_Section id   |publisher ID   |po_line_item ID   |domain_include    | domain_exclude|
#      |campaign-API-1-c   |75396         |210722     |false                  |204              |{zone-zoneset-API-1-a}      |[[[1,"!~",2601]]]    |83         |4737             |2434           |17116             |{}                |{}             |
#
#
#      And i create new campaigns with zoneset by name
#        |Campaign Name                            |IO        |LineItem   |isServerProgrammatic?   |Creative\Deal   |Zoneset Name                            |
#        |campaign-DT-Screen-Shift-2               |75396     |197418     |false                   |86              |{zone-zoneset-DT-Screen-Shift}          |
#        |campaign-DT-Smartphone-interstitial-2    |75396     |211456     |false                   |210             |{zone-zoneset-DT-Smartphone-interstitial} |
#
#  Scenario: update entity data
#      Given i update campaign data by name
#        |name                 |status      |units|
#        |campaign-API-1-a     |0           |-1   |
#        |campaign-API-1-b     |0           |-1   |
#
#
#  Scenario: update entity data
#    Given i update campaign data by id
#      |id                 |status      |units|
#      |305013             |1           |-1   |
#      |305014             |1           |-1   |
#
#
#  Scenario: update entity data
#    Given i update zone data by id
#      |name                 |status      |
#      |zone-API-1-a         |1           |
#
#   Scenario: update campaigns
#    Given i update campaign data by name
#      |entity name       |status      |Priority      |units      |
#      |campaign-API-1-a  |1           |-1            |-1         |
#
#  Scenario: create deals
#        Given i create new Deals
#          |Deal Name       |DSP ID       |FloorPrice      |Deal type      |Ad Unit ID     |IO           |thirdPartyDealId|systemId    |platformId|
#          |ramp-lift-test  |1            |-1              | 2             |58             |407981       |12366664            |2           |2         |

#    Scenario: create creatives
#        Given i create new creatives
#          |creative name      |IO           |adUnitId       |htmlTemplate      |
#          |ramp-lift-test     |75396        |83             |see through       |
#
#    Scenario: create campaigns from Template
#        Given i create campaigns from Template
#          |Campaign Name      |Template Name                     |ad size            |zoneName      |
#          |campaign-API-1-a   |see through server programmatic   |see through        |zone-1        |
#          |campaign-API-1-b   |see through client programmatic   |see through        |zone-2        |
#          |campaign-API-1-b   |see through non-programmatic      |see through        |zone-3        |
#
#
#  @Keren
#  Scenario: create campaigns for Keren domain targeting
#    Given i create new campaigns, new zoneset with domains
#      |Campaign Name        |IO            |LineItem   |isServerProgrammatic?  |Creative         |Zonesets-zones Name                   |limitation           |adUnitId   |Web_Section id    |publisher ID   |po_line_item ID   |domain_include      |domain_exclude                 |
#      |campaign-DomainT-1   |75396         |210722     |false                  |204              |{zone-zoneset-DomainT-1-Keren-test}   |[]                   |83         |4737              |2434           |17116             |{}                  |{ynet.co.il}                   |
