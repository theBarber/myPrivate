@append-entities
Feature: Append entities for tests

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
      | campaign-HB-PO-Price    | 75396 | 246300   | false                 | 288          | {zone-zoneset-HB-PO-Price}    | []         | 58       | 15281          | 3708         | 69726           |
      | campaign-HB-No-PO-Price | 75396 | 246300   | false                 | 288          | {zone-zoneset-HB-No-PO-Price} | []         | 58       | 15281          | 3708         | 69725           |
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



  Scenario: refresh banner cache
    And I refresh banner cache
    And I restart {ramp-lift-services}
    And I restart {ut-programmatic-gw}

  Scenario: refresh zone cache
    And I refresh the zone Cache

  Scenario: save entities to file
    And save all entities to json file