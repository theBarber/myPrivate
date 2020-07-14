@couchBaseUtil
@preconditions
@optimize
@AA

Feature: Entities for tests



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
