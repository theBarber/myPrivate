# new feature
# Tags: optional
    
Feature: UAS create campaigns for unit test
    
Scenario: 1 - create campaigns with specific line item, creative, zoneset
        When I create new Campaign named {Ramp-lift-Test-direct-1} using ramp-app api's for LineItem 215959 associated to creative 960 with zoneset 65880 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-direct-1} and print it
        And I update last created campaign named {Ramp-lift-Test-direct-1} units to be {2000} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-1} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-client-1} using ramp-app api's for LineItem 210671 associated to creative 959 with zoneset 65880 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-client-1} and print it
        And I update last created campaign named {Ramp-lift-Test-client-1} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-client-1} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-server-1} using ramp-app api's for LineItem 206146 associated to creative 959 with zoneset 65880 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-server-1} and print it
        And I update last created campaign named {Ramp-lift-Test-server-1} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-server-1} status to be {0} in the DB

    Scenario: 2 - create campaigns with specific line item, creative, zoneset
        When I create new Campaign named {Ramp-lift-Test-direct-2} using ramp-app api's for LineItem 215959 associated to creative 960 with zoneset 65881 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-direct-2} and print it
        And I update last created campaign named {Ramp-lift-Test-direct-2} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-2} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-client-2} using ramp-app api's for LineItem 210671 associated to creative 959 with zoneset 65881 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-client-2} and print it
        And I update last created campaign named {Ramp-lift-Test-client-2} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-client-2} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-server-2} using ramp-app api's for LineItem 206146 associated to creative 959 with zoneset 65881 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-server-2} and print it
        And I update last created campaign named {Ramp-lift-Test-server-2} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-server-2} status to be {0} in the DB

    Scenario: 3 - create campaigns with specific line item, creative, zoneset
        When I create new Campaign named {Ramp-lift-Test-direct-3} using ramp-app api's for LineItem 215959 associated to creative 960 with zoneset 65882 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-direct-3} and print it
        And I update last created campaign named {Ramp-lift-Test-direct-3} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-3} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-client-3} using ramp-app api's for LineItem 210671 associated to creative 959 with zoneset 65882 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-client-3} and print it
        And I update last created campaign named {Ramp-lift-Test-client-3} units to be {2000} in the DB
        And I update last created campaign named {Ramp-lift-Test-client-3} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-server-3} using ramp-app api's for LineItem 206146 associated to creative 959 with zoneset 65882 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-server-3} and print it
        And I update last created campaign named {Ramp-lift-Test-server-3} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-server-3} status to be {0} in the DB

    Scenario: 4 - create campaigns with specific line item, creative, zoneset
        When I create new Campaign named {Ramp-lift-Test-direct-4} using ramp-app api's for LineItem 215959 associated to creative 960 with zoneset 65883 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-direct-4} and print it
        And I update last created campaign named {Ramp-lift-Test-direct-4} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-4} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-client-4} using ramp-app api's for LineItem 210671 associated to creative 959 with zoneset 65883 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-client-4} and print it
        And I update last created campaign named {Ramp-lift-Test-client-4} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-client-4} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-server-4} using ramp-app api's for LineItem 206146 associated to creative 959 with zoneset 65883 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-server-4} and print it
        And I update last created campaign named {Ramp-lift-Test-server-4} units to be {2000} in the DB
        And I update last created campaign named {Ramp-lift-Test-server-4} status to be {0} in the DB

    Scenario: 5 - create campaigns with specific line item, creative, zoneset
        When I create new Campaign named {Ramp-lift-Test-direct-5} using ramp-app api's for LineItem 215959 associated to creative 960 with zoneset 65884 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-direct-5} and print it
        And I update last created campaign named {Ramp-lift-Test-direct-5} units to be {2000} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-5} priority to be {5} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-5} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-client-5} using ramp-app api's for LineItem 210671 associated to creative 959 with zoneset 65884 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-client-5} and print it
        And I update last created campaign named {Ramp-lift-Test-client-5} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-client-5} priority to be {5} in the DB
        And I update last created campaign named {Ramp-lift-Test-client-5} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-server-5} using ramp-app api's for LineItem 206146 associated to creative 959 with zoneset 65884 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-server-5} and print it
        And I update last created campaign named {Ramp-lift-Test-server-5} units to be {2000} in the DB
        And I update last created campaign named {Ramp-lift-Test-server-5} priority to be {-2} in the DB
        And I update last created campaign named {Ramp-lift-Test-server-5} status to be {0} in the DB

    Scenario: 6 - create campaigns with specific line item, creative, zoneset
        When I create new Campaign named {Ramp-lift-Test-direct-6a} using ramp-app api's for LineItem 215959 associated to creative 960 with zoneset 65885 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-direct-6a} and print it
        And I update last created campaign named {Ramp-lift-Test-direct-6a} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-6a} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-direct-6b} using ramp-app api's for LineItem 215959 associated to creative 960 with zoneset 65885 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-direct-6b} and print it
        And I update last created campaign named {Ramp-lift-Test-direct-6b} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-6b} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-direct-6c} using ramp-app api's for LineItem 215959 associated to creative 960 with zoneset 65885 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-direct-6c} and print it
        And I update last created campaign named {Ramp-lift-Test-direct-6c} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-6c} status to be {0} in the DB
#
    Scenario: 7 - create campaigns with specific line item, creative, zoneset
        When I create new Campaign named {Ramp-lift-Test-client-7a} using ramp-app api's for LineItem 210671 associated to creative 959 with zoneset 65887 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-client-7a} and print it
        And I update last created campaign named {Ramp-lift-Test-client-7a} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-client-7a} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-client-7b} using ramp-app api's for LineItem 210671 associated to creative 959 with zoneset 65887 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-client-7b} and print it
        And I update last created campaign named {Ramp-lift-Test-client-7b} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-client-7b} status to be {0} in the DB
        When I create new Campaign named {Ramp-lift-Test-client-7c} using ramp-app api's for LineItem 210671 associated to creative 959 with zoneset 65887 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-client-7c} and print it
        And I update last created campaign named {Ramp-lift-Test-client-7c} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-client-7c} status to be {0} in the DB
#
    Scenario: 8 - create campaigns with specific line item, creative, zoneset
        When I create new Campaign named {Ramp-lift-Test-direct-8a} using ramp-app api's for LineItem 215959 associated to creative 960 with zoneset 65886 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-direct-8a} and print it
        And I update last created campaign named {Ramp-lift-Test-direct-8a} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-8a} priority to be {-1} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-8a} status to be {0} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-8a} limitation to be {[[[5,"=~","us"]]]} in the DB
        When I create new Campaign named {Ramp-lift-Test-direct-8b} using ramp-app api's for LineItem 215959 associated to creative 960 with zoneset 65886 with priority {-1}
        And I get the banners of campaign named {Ramp-lift-Test-direct-8b} and print it
        And I update last created campaign named {Ramp-lift-Test-direct-8b} units to be {1000} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-8b} priority to be {-2} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-8b} status to be {0} in the DB
        And I update last created campaign named {Ramp-lift-Test-direct-8a} limitation to be {[[[5,"=~","us"]]]} in the DB


