@couchBaseUtil
@preconditions
@optimize
@AA

Feature: Entities for tests

  Scenario: entities end-date update
    And i update po_line_item end date by id {4584,67001,67002,69725,69608,69625,69723,67164,17116,27807,67638,27809,65421,64396,66814,66813,64397,64398,64399,64400,64401,64402,64403,65422,65423,65424,66418,66486,66487,66488,66810,66811,62229,66556,66557,66555,66556,67259,67260,67261,66833,66831,66830,67182,67231,66933,66004,66002,66736,65991,67354,66811,66555,66557,67165,69992,67163,67162,67166,69089,69134,66832,69158,69213,70473,70474}
    And i update io_line_item end date by id {243710,251644,253288,253747,245653,210722,241783,223539,240827,198082,197418,224812,222908,234810,224810,224539,240829,224533,224530,211456,228962,224531,228961,229737,243452,234550,234656,243707,243711,244895,244896,244699}
    And i update io_line_item with id {210722} filed {unit_price} to be {1}
    And i update io_line_item with id {210722} filed {budget} to be {1}

  Scenario: remove all active zones
#    zones that are linked to publisher 2434 are disabled specifically!!
    Given i remove all zones from publishers: {3836}
    Given i remove all zones from publishers: {3843}
    Given i remove all zones from publishers: {3673}
    Given i remove all zones from publishers: {3697}
    Given i remove all zones from publishers: {3708}
    Given i remove all zones from publishers: {3674}
    Given i remove all zones from publishers: {3675}
    Given i remove all zones from publishers: {3666}
    Given i remove all zones from publishers: {3728}
    Given i remove all zones from publishers: {3690}
    Given i remove all zones from publishers: {1111}
    Given i remove all zones from publishers: {3711}
    Given i remove all zones from publishers: {3739}
    Given i remove all zones from publishers: {2546}
    Given i remove all zones from publishers: {3585}
    Given i remove all zones from publishers: {3586}


  Scenario:  create entites for instream_video viewbility
    Given i disable campaigns by name on db
      | Campaign Name |
      | testAppend3   |
      | testAppend4   |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name | IO    | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name        | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | testAppend3   | 75396 | 234808   | false                 | 555           | {zone-zoneset-testAppend5} | []         | 35       | 15196          | 3708         | 69158           | []             | []             |
      | testAppend4   | 75396 | 234808   | false                 | 666           | {zone-zoneset-testAppend6} | []         | 35       | 15196          | 3708         | 69158           | []             | []             |
#    And i update campaign data by name
#      | Campaign Name                | viewability_wrapper_enabled | viewability_wrapper_vendor |
#      | campaign-InstreamVid-View-SP | 1                           | MOAT                       |





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
#  Scenario: refresh zone cache with wait
#    Given i kill replay on the machines
#    And I setup the db
#    And I sleep for 60 seconds


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
#    And I restart {ramp-lift-services}
#    And I restart {ut-programmatic-gw}


  @optimize
#  Scenario: update test strategy
#    Given i disable all tests except 53
#    And I set test id of test_strategy named {scoringV2} to {53}

  @optimize
  @append
  @refresh
  Scenario: save entities to file
    And save all entities to json file