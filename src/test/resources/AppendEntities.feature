@append-entities
Feature: Append entities for tests

  Scenario: create entities for NDQ filtering
    Given i disable campaigns by name on db
      | Campaign Name        |
      | NDQfilteringTL-ST-1 |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name       | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | NDQfilteringTL-ST-1 | 574531 | 251644   | false                 | 26778         | {zone-zoneset-NDQfilteringTL-ST-1} | []         | 93       | 15376          | 3708         | 69625           | []          | []          |


    And i update campaign data by name
      | Campaign Name       | factor |
      | NDQfilteringTL-ST-1 | 0.10   |

    And i update zone data by name
      | Zone Name                        | is_secure |
      | zone-zoneset-NDQfilteringTL-ST-1 | 1         |



  Scenario: refresh banner cache
    And I refresh banner cache
    And I restart {ramp-lift-services}
    And I restart {ut-programmatic-gw}

  Scenario: refresh zone cache
    And I refresh the zone Cache

  Scenario: save entities to file
    And save all entities to json file