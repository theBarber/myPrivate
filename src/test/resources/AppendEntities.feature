@append-entities
Feature: Append entities for tests

  Scenario: create entities for NDQ filtering
    Given i disable campaigns by name on db
      | Campaign Name                |
      | campaign-NDQfilteringCL-ST-1 |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name                | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                         | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | campaign-NDQfilteringCL-ST-1 | 574531 | 251644   | false                 | 26778         | {zone-zoneset-campaign-NDQfilteringCL-ST-1} | []         | 93       | 15376          | 3708         | 69625           | []          | []          |

    And i update zone data by name
      | Zone Name                                 | is_secure |
      | zone-zoneset-campaign-NDQfilteringCL-ST-1 | 1         |

    And i update campaign data by name
      | Campaign Name                | units | skip_daily_goal |
      | campaign-NDQfilteringCL-ST-1 | 100   | 0               |


  Scenario: refresh banner cache
    And I refresh banner cache
    And I restart {ramp-lift-services}
    And I restart {ut-programmatic-gw}

  Scenario: refresh zone cache
    And I refresh the zone Cache

  Scenario: save entities to file
    And save all entities to json file