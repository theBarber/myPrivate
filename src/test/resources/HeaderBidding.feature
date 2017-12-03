@HeaderBidding
@stable
Feature: Header Bidding flow support

    Scenario: send HB request without params
        Given i load scenario {send HB request without params} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: send HB request without publlisherID configured
        Given i load scenario {send HB request without publlisherID configured} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send HB basic request
        Given i load scenario {Send HB basic request} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send HB request to optimizer
        Given i load scenario {Send HB request to optimizer} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send HB request with Empty domain
        Given i load scenario {Send HB request with Empty domain} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send HB request with Empty placementID
        Given i load scenario {Send HB request with Empty placementID} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send HB request with Empty sizes
        Given i load scenario {Send HB request with Empty sizes} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send HB request with Empty timeout
        Given i load scenario {Send HB request with Empty timeout} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send HB request with wrong values
        Given i load scenario {Send HB request with wrong values} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send HB request with one size
        Given i load scenario {Send HB request with one size} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send HB request with no 1X1 size
        Given i load scenario {Send HB request with no 1X1 size} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: send Ranker HB request without params
        Given i load scenario {send Ranker HB request without params} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: send Ranker HB request without publlisherID configured
        Given i load scenario {send Ranker HB request without publlisherID configured} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send Ranker HB basic request
        Given i load scenario {Send Ranker HB basic request} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send Ranker HB request to optimizer
        Given i load scenario {Send Ranker HB request to optimizer} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send Ranker HB request with Empty domain
        Given i load scenario {Send Ranker HB request with Empty domain} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send Ranker HB request with Empty placementID
        Given i load scenario {Send Ranker HB request with Empty placementID} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send Ranker HB request with Empty sizes
        Given i load scenario {Send Ranker HB request with Empty sizes} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send Ranker HB request with Empty timeout
        Given i load scenario {Send Ranker HB request with Empty timeout} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send Ranker HB request with wrong values
        Given i load scenario {Send Ranker HB request with wrong values} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send Ranker HB request with one size
        Given i load scenario {Send Ranker HB request with one size} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

    Scenario: Send Ranker HB request with no 1X1 size
        Given i load scenario {Send Ranker HB request with no 1X1 size} input data
        Then i send 1 times Header Bidding ad request to UAS for the scenario

