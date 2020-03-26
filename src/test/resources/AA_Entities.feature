@couchBaseUtil
@preconditions
@optimize
@AA

Feature: Entities for tests



  Scenario:  create entites for instream_video viewbility
    Given i disable campaigns by name on db
      | Campaign Name                |
      | campaign-InstreamVid-View-SP |
    Given i create new campaigns, new zoneset with domains
      | Campaign Name                | IO     | LineItem | isServerProgrammatic? | Deal\Creative | Zonesets-zones Name                | limitation | adUnitId | Web_Section id | publisher ID | po_line_item ID | domain_include | domain_exclude |
      | campaign-InstreamVid-View-SP | 407981 | 244699   | true                  | 816           | {zone-zoneset-InstreamVid-View-SP} | []         | 35       | 15196          | 3708         | 69158           | []             | []             |
     # ****  update is_sync=1 & is_video=1 parameters of the campaign ***
    And i update campaign data by name
      | Campaign Name                | is_sync | is_video |
      | campaign-InstreamVid-View-SP | 1       | 1        |

    And i update campaign data by name
      | Campaign Name                | viewability_wrapper_enabled | viewability_wrapper_vendor |
      | campaign-InstreamVid-View-SP | 1                           | MOAT                       |




