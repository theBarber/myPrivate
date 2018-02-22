@cli
@uas
@API
Feature: API entities creator - using ramp-app APIs and sql scripts

    Scenario: create campaign with existing zoneset (and zone linked to it)
      Given i create new campaigns with existing zoneset
        |Campaign Name      |IO        |LineItem   |isServerProgrammatic?   |Creative\Deal   |Zoneset ID   |
        |campaign-API-1-a   |407981    |224531     |true                    |10002           |68341        |
        |campaign-API-1-b   |75396     |210722     |false                   |204             |68341        |

    Scenario: create campaign with new zoneset (and zone linked to it)
      Given i create new campaigns with new zoneset
        |Campaign Name      |IO            |LineItem   |isServerProgrammatic?  |Creative\Deal    |Zoneset-zone Name           |limitation           |adUnitId   |Web_Section id   |publisher ID   |po_line_item ID   |
        |campaign-API-1-c   |75396         |210722     |false                  |204              |zone-zoneset-API-1-a        |[[[1,"!~",2601]]]    |83         |4737             |2434           |17116             |

    Scenario: update campaigns
      Given i update campaigns data
        |Campaign ID       |status      |Priority      |units      |
        |304676            |1           |-1            |-1         |

    Scenario: create deals
        Given i create new Deals
          |Deal Name       |DSP ID       | FloorPrice     |Deal type      |Ad Unit ID     |IO           |
          |ramp-lift-test  |1            |-1              | 2             |58             |407981       |

    Scenario: create creatives
        Given i create new creatives
          |creative name      |IO           |adUnitId       |htmlTemplate      |
          |ramp-lift-test     |75396        |83             |see through       |

    Scenario: create campaigns from Template
        Given i create campaigns from Template
          |Campaign Name      |product                           |ad size            |zoneName      |
          |campaign-API-1-a   |see through server programmatic   |see through        |zone-1        |
          |campaign-API-1-b   |see through client programmatic   |see through        |zone-2        |
          |campaign-API-1-b   |see through non-programmatic      |see through        |zone-3        |
