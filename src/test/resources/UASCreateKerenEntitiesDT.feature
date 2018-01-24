@DinamicTag

Feature: UAS create entities for DT unit test
  Scenario: 1 - create campaigns with specific line item, creative, zoneset
    When i create new zone named {zone-DT-Test-direct-1-a} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14482 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-direct-1-a} for LineItem 197418 associated to creative 86 with zoneset named {zone-DT-Test-direct-1-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-direct-1-a} and print it
    And I update last created campaign named {campaign-DT-Test-direct-1-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-1-a} delivery_algorithm to be {4} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-1-a} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-client-1-a} for LineItem 223755 associated to creative 6044 with zoneset named {zone-DT-Test-direct-1-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-client-1-a} and print it
    And I update last created campaign named {campaign-DT-Test-client-1-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-1-a} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-1-a} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-server-1-a} for LineItem 223757 associated to creative 6044 with zoneset named {zone-DT-Test-direct-1-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-server-1-a} and print it
    And I update last created campaign named {campaign-DT-Test-server-1-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-1-a} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-1-a} goal_type to be {impressions} in the DB

    And i create new zone named {zone-DT-Test-direct-1-b} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14482 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-direct-1-b} for LineItem 197418 associated to creative 86 with zoneset named {zone-DT-Test-direct-1-b} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-direct-1-b} and print it
    And I update last created campaign named {campaign-DT-Test-direct-1-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-1-b} delivery_algorithm to be {2} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-1-b} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-client-1-b} for LineItem 223755 associated to creative 6044 with zoneset named {zone-DT-Test-direct-1-b} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-client-1-b} and print it
    And I update last created campaign named {campaign-DT-Test-client-1-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-1-b} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-1-b} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-server-1-b} for LineItem 223757 associated to creative 6044 with zoneset named {zone-DT-Test-direct-1-b} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-server-1-b} and print it
    And I update last created campaign named {campaign-DT-Test-server-1-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-1-b} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-1-b} goal_type to be {impressions} in the DB

  Scenario: 2 - create campaigns with specific line item, creative, zoneset
    When i create new zone named {zone-DT-Test-direct-2-a} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14483 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-direct-2-a} for LineItem 197418 associated to creative 86 with zoneset named {zone-DT-Test-direct-2-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-direct-2-a} and print it
    And I update last created campaign named {campaign-DT-Test-direct-2-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-2-a} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-2-a} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-client-2-a} for LineItem 223755 associated to creative 6044 with zoneset named {zone-DT-Test-direct-2-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-client-2-a} and print it
    And I update last created campaign named {campaign-DT-Test-client-2-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-2-a} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-2-a} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-server-2-a} for LineItem 223757 associated to creative 6044 with zoneset named {zone-DT-Test-direct-2-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-server-2-a} and print it
    And I update last created campaign named {campaign-DT-Test-server-2-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-2-a} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-2-a} goal_type to be {impressions} in the DB

    And i create new zone named {zone-DT-Test-direct-2-b} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14483 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-client-2-b} for LineItem 223755 associated to creative 6044 with zoneset named {zone-DT-Test-direct-2-b} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-client-2-b} and print it
    And I update last created campaign named {campaign-DT-Test-client-2-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-2-b} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-2-b} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-server-2-b} for LineItem 223757 associated to creative 6044 with zoneset named {zone-DT-Test-direct-2-b} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-server-2-b} and print it
    And I update last created campaign named {campaign-DT-Test-server-2-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-2-b} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-2-b} goal_type to be {impressions} in the DB

  Scenario: 3 - create campaigns with specific line item, creative, zoneset
    When i create new zone named {zone-DT-Test-direct-3-a} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14484 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-direct-3-a} for LineItem 197418 associated to creative 86 with zoneset named {zone-DT-Test-direct-3-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-direct-3-a} and print it
    And I update last created campaign named {campaign-DT-Test-direct-3-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-3-a} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-3-a} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-client-3-a} for LineItem 223755 associated to creative 6044 with zoneset named {zone-DT-Test-direct-3-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-client-3-a} and print it
    And I update last created campaign named {campaign-DT-Test-client-3-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-3-a} delivery_algorithm to be {4} in the DB
    And I update last created campaign named {campaign-DT-Test-client-3-a} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-server-3-a} for LineItem 223757 associated to creative 6044 with zoneset named {zone-DT-Test-direct-3-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-server-3-a} and print it
    And I update last created campaign named {campaign-DT-Test-server-3-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-3-a} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-3-a} goal_type to be {impressions} in the DB

    And i create new zone named {zone-DT-Test-direct-3-b} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14484 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-direct-3-b} for LineItem 197418 associated to creative 86 with zoneset named {zone-DT-Test-direct-3-b} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-direct-3-b} and print it
    And I update last created campaign named {campaign-DT-Test-direct-3-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-3-b} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-3-b} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-client-3-b} for LineItem 223755 associated to creative 6044 with zoneset named {zone-DT-Test-direct-3-b} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-client-3-b} and print it
    And I update last created campaign named {campaign-DT-Test-client-3-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-3-b} delivery_algorithm to be {2} in the DB
    And I update last created campaign named {campaign-DT-Test-client-3-b} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-server-3-b} for LineItem 223757 associated to creative 6044 with zoneset named {zone-DT-Test-direct-3-b} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-server-3-b} and print it
    And I update last created campaign named {campaign-DT-Test-server-3-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-3-b} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-3-b} goal_type to be {impressions} in the DB

  Scenario: 4 - create campaigns with specific line item, creative, zoneset
    When i create new zone named {zone-DT-Test-direct-4-a} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14485 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-direct-4-a} for LineItem 197418 associated to creative 86 with zoneset named {zone-DT-Test-direct-4-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-direct-4-a} and print it
    And I update last created campaign named {campaign-DT-Test-direct-4-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-4-a} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-4-a} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-client-4-a} for LineItem 223755 associated to creative 6044 with zoneset named {zone-DT-Test-direct-4-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-client-4-a} and print it
    And I update last created campaign named {campaign-DT-Test-client-4-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-4-a} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-4-a} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-server-4-a} for LineItem 223757 associated to creative 6044 with zoneset named {zone-DT-Test-direct-4-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-server-4-a} and print it
    And I update last created campaign named {campaign-DT-Test-server-4-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-4-a} delivery_algorithm to be {4} in the DB
    And I update last created campaign named {campaign-DT-Test-server-4-a} goal_type to be {impressions} in the DB

    And i create new zone named {zone-DT-Test-direct-4-b} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14485 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-direct-4-b} for LineItem 197418 associated to creative 86 with zoneset named {zone-DT-Test-direct-4-b} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-direct-4-b} and print it
    And I update last created campaign named {campaign-DT-Test-direct-4-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-4-b} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-4-b} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-client-4-b} for LineItem 223755 associated to creative 6044 with zoneset named {zone-DT-Test-direct-4-b} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-client-4-b} and print it
    And I update last created campaign named {campaign-DT-Test-client-4-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-4-b} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-4-b} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-server-4-b} for LineItem 223757 associated to creative 6044 with zoneset named {zone-DT-Test-direct-4-b} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-server-4-b} and print it
    And I update last created campaign named {campaign-DT-Test-server-4-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-4-b} delivery_algorithm to be {2} in the DB
    And I update last created campaign named {campaign-DT-Test-server-4-b} goal_type to be {impressions} in the DB

  Scenario: 5 - create campaigns with specific line item, creative, zoneset
    When i create new zone named {zone-DT-Test-direct-5-a} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14486 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-direct-5-a} for LineItem 197418 associated to creative 86 with zoneset named {zone-DT-Test-direct-5-a} with priority {5}
    And I get the banners of campaign named {campaign-DT-Test-direct-5-a} and print it
    And I update last created campaign named {campaign-DT-Test-direct-5-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-5-a} delivery_algorithm to be {4} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-5-a} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-client-5-a} for LineItem 223755 associated to creative 6044 with zoneset named {zone-DT-Test-direct-5-a} with priority {5}
    And I get the banners of campaign named {campaign-DT-Test-client-5-a} and print it
    And I update last created campaign named {campaign-DT-Test-client-5-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-5-a} delivery_algorithm to be {2} in the DB
    And I update last created campaign named {campaign-DT-Test-client-5-a} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-server-5-a} for LineItem 223757 associated to creative 6044 with zoneset named {zone-DT-Test-direct-5-a} with priority {-2}
    And I get the banners of campaign named {campaign-DT-Test-server-5-a} and print it
    And I update last created campaign named {campaign-DT-Test-server-5-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-5-a} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-5-a} goal_type to be {impressions} in the DB

    And i create new zone named {zone-DT-Test-direct-5-b} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14486 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-direct-5-b} for LineItem 197418 associated to creative 86 with zoneset named {zone-DT-Test-direct-5-b} with priority {5}
    And I get the banners of campaign named {campaign-DT-Test-direct-5-b} and print it
    And I update last created campaign named {campaign-DT-Test-direct-5-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-5-b} delivery_algorithm to be {4} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-5-b} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-client-5-b} for LineItem 223755 associated to creative 6044 with zoneset named {zone-DT-Test-direct-5-b} with priority {5}
    And I get the banners of campaign named {campaign-DT-Test-client-5-b} and print it
    And I update last created campaign named {campaign-DT-Test-client-5-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-5-b} delivery_algorithm to be {2} in the DB
    And I update last created campaign named {campaign-DT-Test-client-5-b} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-server-5-b} for LineItem 223757 associated to creative 6044 with zoneset named {zone-DT-Test-direct-5-b} with priority {-2}
    And I get the banners of campaign named {campaign-DT-Test-server-5-b} and print it
    And I update last created campaign named {campaign-DT-Test-server-5-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-5-b} delivery_algorithm to be {1} in the DB
    And I update last created campaign named {campaign-DT-Test-server-5-b} goal_type to be {impressions} in the DB

  Scenario: 6 - create campaigns with specific line item, creative, zoneset
    When i create new zone named {zone-DT-Test-direct-6-a} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14487 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-direct-6-a} for LineItem 197418 associated to creative 86 with zoneset named {zone-DT-Test-direct-6-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-direct-6-a} and print it
    And I update last created campaign named {campaign-DT-Test-direct-6-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-6-a} delivery_algorithm to be {4} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-6-a} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-direct-6-b} for LineItem 197418 associated to creative 86 with zoneset named {zone-DT-Test-direct-6-a} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-direct-6-b} and print it
    And I update last created campaign named {campaign-DT-Test-direct-6-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-6-b} delivery_algorithm to be {4} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-6-b} goal_type to be {impressions} in the DB

    And i create new zone named {zone-DT-Test-direct-6-b} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14487 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-direct-6-c} for LineItem 197418 associated to creative 86 with zoneset named {zone-DT-Test-direct-6-b} with priority {-1}
    And I get the banners of campaign named {campaign-DT-Test-direct-6-c} and print it
    And I update last created campaign named {campaign-DT-Test-direct-6-c} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-6-c} delivery_algorithm to be {4} in the DB
    And I update last created campaign named {campaign-DT-Test-direct-6-c} goal_type to be {impressions} in the DB


  Scenario: 7 - create campaigns with specific line item, creative, zoneset
    When i create new zone named {zone-DT-Test-direct-7-a} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14488 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-client-7-a} for LineItem 223755 associated to creative 6044 with zoneset named {zone-DT-Test-direct-7-a} with priority {5}
    And I get the banners of campaign named {campaign-DT-Test-client-7-a} and print it
    And I update last created campaign named {campaign-DT-Test-client-7-a} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-7-a} delivery_algorithm to be {2} in the DB
    And I update last created campaign named {campaign-DT-Test-client-7-a} goal_type to be {impressions} in the DB
    And i create new Campaign named {campaign-DT-Test-client-7-c} for LineItem 223755 associated to creative 6044 with zoneset named {zone-DT-Test-direct-7-a} with priority {5}
    And I get the banners of campaign named {campaign-DT-Test-client-7-c} and print it
    And I update last created campaign named {campaign-DT-Test-client-7-c} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-7-c} delivery_algorithm to be {2} in the DB
    And I update last created campaign named {campaign-DT-Test-client-7-c} goal_type to be {impressions} in the DB

    And i create new zone named {zone-DT-Test-direct-7-b} with limitation {[[[1,"!~",2601]]]} with adUnitId 69 and web_section id 14486 with affiliateId 3695 with po_line_item_id 65746
    And i create new Campaign named {campaign-DT-Test-client-7-b} for LineItem 223755 associated to creative 6044 with zoneset named {zone-DT-Test-direct-7-b} with priority {5}
    And I get the banners of campaign named {campaign-DT-Test-client-7-b} and print it
    And I update last created campaign named {campaign-DT-Test-client-7-b} units to be {-1} in the DB
    And I update last created campaign named {campaign-DT-Test-client-7-b} delivery_algorithm to be {2} in the DB
    And I update last created campaign named {campaign-DT-Test-client-7-b} goal_type to be {impressions} in the DB

