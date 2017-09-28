@cli
@uas
@RampAppCreateCampaign
    
Feature: UAS E2E Ad request flow - with new entities

    Scenario: Create new campaign, send ad request and
        Given I disable all campaigns named {Ramp-lift-Test-1-Campaign-SystemTest} in DB
        When I create new Campaign named {Ramp-lift-Test-1-Campaign-SystemTest} using ramp-app api's for LineItem 210722 associated to creative 204 with zoneset 65745
        Then I get the Campaign named {Ramp-lift-Test-1-Campaign-SystemTest} using ramp-app api's in order to set the banners
        And I update the created campaign {Ramp-lift-Test-1-Campaign-SystemTest} banners name to {RampLift-1-bannerCreatedTest-} concatenating the serial number
        And  I update the created campaign named {Ramp-lift-Test-1-Campaign-SystemTest} status to be 0
        And I refresh the zone Cache
        When I send 10 times an ad request for zone named {INT2434 - See Through - SaharTest-DNU} to UAS
        And The response contains script
        And The responses has impression-urls
        And The impressionUrl has bannerid field matching the id of the banner named {RampLift-1-bannerCreatedTest-1} 100% of the time
        And The impressionUrl has zoneid field matching the id of the zone named {INT2434 - See Through - SaharTest-DNU} 100% of the time
        And The impressionUrl has campaignid field matching the id of the campaign named {Ramp-lift-Test-1-Campaign-SystemTest} 100% of the time
        And The responses has click-urls
        And The clickUrl has bannerid field matching the id of the banner named {RampLift-1-bannerCreatedTest-1} 100% of the time

    Scenario: Send an ad request to UAS and parse logs
        Given I Delete req logs
        Given I Delete imp logs
        When I send 10 times an ad request for zone named {INT2434 - See Through - SaharTest-DNU} to UAS
        And The response has impression-url
        And The response has click-url
        When I send impression requests to UAS
        Then I read the latest req log file from uas
        Then I filter in the req log to the lines where id at column 1 is the same as in impression-url
        And The field zoneid in the 4 column of the req log is the same as in impression-url
        And The field bannerid in the 5 column of the req log is the same as in impression-url
        And The field campaignid in the 6 column of the req log is the same as in impression-url
        Then I read the latest imp log file from uas
        And I filter in the imp log to the lines where id at column 1 is the same as in impression-url
        Given I Delete clk logs
        When I send click requests to UAS
        Then I read the latest clk log file from uas
        And I filter in the clk log to the lines where id at column 1 is the same as in impression-url
        Then I update the created campaign named {Ramp-lift-Test-1-Campaign-SystemTest} status to be 1
        Then I update the created banner named {RampLift-1-bannerCreatedTest-1} status to be 1
#        delete the created banners and campaigns?
