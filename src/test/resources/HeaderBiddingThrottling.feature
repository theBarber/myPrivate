@parallel
@throttling
@HeaderBiddingThrottling
Feature: Header Bidding Throttling

  Background: health check
    When Sending a healthcheck request to UAS
    And I add header of {X-Forwarded-For} with value {78.31.205.183}
    Then The response code is 200

    #   header bidding placment group test - pg disabled throttling 0%
  Scenario: 1. 2 sizes - 1*1 (SS, PG), 1 placment (PG), PG banner expected - pg disabled throttling 0%
    Given I clear all cookies from uas requests
    Given i send synchronized 100 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:1, with domain {slader.com}, placmentID group = {3728010} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us} cookies false
    Then The synchronized response code is 204 100 responses from 100 of the times

    #   header bidding placment group test - throttling 0%    --> new_user = 1   device_type_id = 1
  Scenario: 1. 2 sizes - 1*1 (SS, PG), 1 placment (PG), PG banner expected - throttling 0%
    Given I clear all cookies from uas requests
    Given i send synchronized 100 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:1, with domain {slader.com}, placmentID group = {3728011} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us} cookies false
    Then The synchronized response code is 200 100 responses from 100 of the times

    #   header bidding placment group test - throttling 60%  --> new_user = 1   device_type_id = 1 (3728001)
  Scenario: 1. 2 sizes - 1*1 (SS, PG), 1 placment (PG), PG banner expected - throttling 60%
    Given I clear all cookies from uas requests
    Given i send synchronized 2000 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:1, with domain {slader.com}, placmentID group = {3728001} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us} cookies false
    Then The synchronized response code is 200 920 responses from 2000 of the times
#
##----------------------------------------------------------------------------------------------------------------------------------------------

    #   header bidding placment group test - throttling 70% -->  new_user = 0   device_type_id = 2
  Scenario: 1. 2 sizes - 1*1 (SS, PG), 1 placment (PG), PG banner expected - throttling 70%
    Given I clear all cookies from uas requests
    Given I add cookie UTID with random value to my requests to uas
    Given i send synchronized 2000 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:1, with domain {slader.com}, placmentID group = {3728011} and extra params {&deviceid=throttling1&optimize=1&unlimited=1&sim_geo=1&country=us} cookies true
    Then The synchronized response code is 200 740 responses from 2000 of the times


    #   header bidding placment group test - throttling 50% -->  new_user = 0   device_type_id = 1 (3728011)
  Scenario: 1. 2 sizes - 1*1 (SS, PG), 1 placment (PG), PG banner expected - throttling 50%
    Given I clear all cookies from uas requests
    Given I add cookie UTID with random value to my requests to uas
    Given i send synchronized 2000 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:1, with domain {slader.com}, placmentID group = {3728011} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us} cookies true
    Then The synchronized response code is 200 1100 responses from 2000 of the times


    #   header bidding placment group test - pg disabled throttling 40% --> new_user = 1   device_type_id = 2
  Scenario: 1. 2 sizes - 1*1 (SS, PG), 1 placment (PG), PG banner expected - throttling 40%
    Given I clear all cookies from uas requests
    Given i send synchronized 2000 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:1, with domain {slader.com}, placmentID group = {3728001} and extra params {&deviceid=throttling1234&optimize=1&unlimited=1&sim_geo=1&country=us} cookies false
    Then The synchronized response code is 200 1280 responses from 2000 of the times


    #   header bidding placment group test - throttling 100% -->  new_user = 0   device_type_id = 1 (3728001)
  Scenario: 1. 2 sizes - 1*1 (SS, PG), 1 placment (PG), PG banner expected - throttling 100%
    Given I clear all cookies from uas requests
    Given I add cookie UTID with random value to my requests to uas
    Given i send synchronized 2000 basic headerBidding secure post request for publisher 3728 with size - h1:1 w1:1, with domain {slader.com}, placmentID group = {3728001} and extra params {&optimize=1&unlimited=1&sim_geo=1&country=us} cookies true
    Then The synchronized response code is 200 200 responses from 2000 of the times
