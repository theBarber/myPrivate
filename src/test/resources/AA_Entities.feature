@couchBaseUtil
@preconditions
@optimize
@AA

Feature: Entities for tests

  @VideoDuration
  Scenario: create entities for Linear Video Duration
    Given i disable campaigns by name on db
      | Campaign Name                      |
      | campaign-large-D-skip-Y            |
      | campaign-small-D-skip-Y            |
      | campaign-large-D-skip-N            |
      | campaign-small-D-skip-N            |

      | campaign-equal-D-skip-Y            |
      | campaign-equal-D-skip-N            |

      | campaign-pub1-level-large-D-skip-Y |
      | campaign-pub1-level-small-D-skip-Y |
      | campaign-pub1-level-large-D-skip-N |
      | campaign-pub1-level-small-D-skip-N |

      | campaign-pub1-level-equal-D-skip-Y |
      | campaign-pub1-level-equal-D-skip-N |

      | campaign-pub2-level-large-D-skip-Y |
      | campaign-pub2-level-small-D-skip-Y |
      | campaign-pub2-level-large-D-skip-N |
      | campaign-pub2-level-small-D-skip-N |

      | campaign-pub2-level-equal-D-skip-Y |
      | campaign-pub2-level-equal-D-skip-N |


    Given i create new campaigns, new zoneset with domains
      | Campaign Name                      | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                               | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | app_include | app_exclude |
      | campaign-large-D-skip-Y            | 75396 | 259848   | false                 | 31635         | {zone-zoneset-large-D-skip-Y-CS-Video}            | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-small-D-skip-Y            | 75396 | 259848   | false                 | 31631         | {zone-zoneset-small-D-skip-Y-CS-Video}            | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-large-D-skip-N            | 75396 | 259848   | false                 | 31636         | {zone-zoneset-large-D-skip-N-CS-Video}            | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-small-D-skip-N            | 75396 | 259848   | false                 | 31632         | {zone-zoneset-small-D-skip-N-CS-Video}            | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-equal-D-skip-Y            | 75396 | 259848   | false                 | 31633         | {zone-zoneset-equal-D-skip-Y-CS-Video}            | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-equal-D-skip-N            | 75396 | 259848   | false                 | 31634         | {zone-zoneset-equal-D-skip-N-CS-Video}            | []         | 35       | 15196          | 3708         | 69158           | []          | []          |
      | campaign-pub1-level-large-D-skip-Y | 75396 | 259848   | false                 | 31635         | {zone-zoneset-pub1-level-large-D-skip-Y-CS-Video} | []         | 35       | 15376          | 3843         | 70473           | []          | []          |
      | campaign-pub1-level-small-D-skip-Y | 75396 | 259848   | false                 | 31631         | {zone-zoneset-pub1-level-small-D-skip-Y-CS-Video} | []         | 35       | 15376          | 3843         | 70473           | []          | []          |
      | campaign-pub1-level-large-D-skip-N | 75396 | 259848   | false                 | 31636         | {zone-zoneset-pub1-level-large-D-skip-N-CS-Video} | []         | 35       | 15376          | 3843         | 70473           | []          | []          |
      | campaign-pub1-level-small-D-skip-N | 75396 | 259848   | false                 | 31632         | {zone-zoneset-pub1-level-small-D-skip-N-CS-Video} | []         | 35       | 15376          | 3843         | 70473           | []          | []          |
      | campaign-pub1-level-equal-D-skip-Y | 75396 | 259848   | false                 | 31633         | {zone-zoneset-pub1-level-equal-D-skip-Y-CS-Video} | []         | 35       | 15376          | 3843         | 70473           | []          | []          |
      | campaign-pub1-level-equal-D-skip-N | 75396 | 259848   | false                 | 31634         | {zone-zoneset-pub1-level-equal-D-skip-N-CS-Video} | []         | 35       | 15376          | 3843         | 70473           | []          | []          |
      | campaign-pub2-level-large-D-skip-Y | 75396 | 259848   | false                 | 31635         | {zone-zoneset-pub2-level-large-D-skip-Y-CS-Video} | []         | 35       | 15227          | 3728         | 70474           | []          | []          |
      | campaign-pub2-level-small-D-skip-Y | 75396 | 259848   | false                 | 31631         | {zone-zoneset-pub2-level-small-D-skip-Y-CS-Video} | []         | 35       | 15227          | 3728         | 70474           | []          | []          |
      | campaign-pub2-level-large-D-skip-N | 75396 | 259848   | false                 | 31636         | {zone-zoneset-pub2-level-large-D-skip-N-CS-Video} | []         | 35       | 15227          | 3728         | 70474           | []          | []          |
      | campaign-pub2-level-small-D-skip-N | 75396 | 259848   | false                 | 31632         | {zone-zoneset-pub2-level-small-D-skip-N-CS-Video} | []         | 35       | 15227          | 3728         | 70474           | []          | []          |
      | campaign-pub2-level-equal-D-skip-Y | 75396 | 259848   | false                 | 31633         | {zone-zoneset-pub2-level-equal-D-skip-Y-CS-Video} | []         | 35       | 15227          | 3728         | 70474           | []          | []          |
      | campaign-pub2-level-equal-D-skip-N | 75396 | 259848   | false                 | 31634         | {zone-zoneset-pub2-level-equal-D-skip-N-CS-Video} | []         | 35       | 15227          | 3728         | 70474           | []          | []          |
    And i update zone data by name
      | Zone Name                                       | is_secure |
      | zone-zoneset-large-D-skip-Y-CS-Video            | 1         |
      | zone-zoneset-small-D-skip-Y-CS-Video            | 1         |
      | zone-zoneset-large-D-skip-N-CS-Video            | 1         |
      | zone-zoneset-small-D-skip-N-CS-Video            | 1         |
      | zone-zoneset-equal-D-skip-Y-CS-Video            | 1         |
      | zone-zoneset-equal-D-skip-N-CS-Video            | 1         |
      | zone-zoneset-pub1-level-large-D-skip-Y-CS-Video | 1         |
      | zone-zoneset-pub1-level-small-D-skip-Y-CS-Video | 1         |
      | zone-zoneset-pub1-level-large-D-skip-N-CS-Video | 1         |
      | zone-zoneset-pub1-level-small-D-skip-N-CS-Video | 1         |
      | zone-zoneset-pub1-level-equal-D-skip-Y-CS-Video | 1         |
      | zone-zoneset-pub1-level-equal-D-skip-N-CS-Video | 1         |
      | zone-zoneset-pub2-level-large-D-skip-Y-CS-Video | 1         |
      | zone-zoneset-pub2-level-small-D-skip-Y-CS-Video | 1         |
      | zone-zoneset-pub2-level-large-D-skip-N-CS-Video | 1         |
      | zone-zoneset-pub2-level-small-D-skip-N-CS-Video | 1         |
      | zone-zoneset-pub2-level-equal-D-skip-Y-CS-Video | 1         |
      | zone-zoneset-pub2-level-equal-D-skip-N-CS-Video | 1         |




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
  @yaniv
  @NDQFilteringTest
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
  @yaniv
  @refresh
  @append
  @NDQFilteringTest
  Scenario: refresh caches
#    And I refresh banner cache
#    And I refresh zone cache
    And I restart {ramp-lift-services}
    And I restart {ut-programmatic-gw}


  @optimize
  Scenario: update test strategy
    Given i disable all tests except 53
#    And I set test id of test_strategy named {scoringV2} to {53}

  @optimize
  @append
  @refresh
  Scenario: save entities to file
    And save all entities to json file