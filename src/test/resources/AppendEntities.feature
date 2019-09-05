@append-entities
Feature: Append entities for tests

  Scenario: create entities for NDQ filtering
    Given i disable campaigns by name on db
      | Campaign Name       |
      | NDQfilteringTL-ST-1 |
      | NDQfilteringTL-ST-2 |

    Given i create new campaigns, new zoneset with domains
      | Campaign Name       | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | NDQfilteringTL-ST-1 | 574531 | 251644   | false                 | 26778         | {zone-zoneset-NDQfilteringTL-ST-1} | []         | 93       | 15376          | 3708         | 69625           | []          | []          |
      | NDQfilteringTL-ST-1 | 574531 | 251644   | false                 | 26778         | {zone-zoneset-NDQfilteringTL-ST-2} | []         | 93       | 15376          | 3708         | 69625           | []          | []          |

    And i update zone data by name
      | Zone Name                        | is_secure |
      | zone-zoneset-NDQfilteringTL-ST-1 | 1         |
      | zone-zoneset-NDQfilteringTL-ST-2 | 1         |


  Scenario: refresh banner cache
    And I refresh banner cache
    And I restart {ramp-lift-services}
    And I restart {ut-programmatic-gw}
    And I sleep for 40 seconds

  Scenario: refresh zone cache
    And I refresh the zone Cache

  Scenario: update test strategy
    Given i disable all tests except 53

  Scenario: save entities to file
    And save all entities to json file