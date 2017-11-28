@HeaderBidding
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