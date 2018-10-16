@scheduled
@Inapp
@HeaderBidding
@uas
@parallel
Feature: InApp testing

  Scenario: Image and iframe - Zone request (viewableChange)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar} for zone named {zone-zoneset-Inapp-SI-1} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-1-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains ut_clickurl
    And The response contains ut_udms
    And The response contains sf_tag
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'iframe', url:'https://www.example.com/3'}
    And The response contains var ut_pixel_event = 'viewableChange';
    And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js


#  Scenario: Image and iframe - HB request (viewableChange)
#    Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 2546} for publisher 2546 with domain {Tradewindsnews.com} with extra params {&unlimited=1&optimize=0&deviceid=sahar}
#    Then The response code is 200
#    And The response contains script
#    And all HB responses contains campaignId with id of entity named {campaign-Inapp-SI-1}
#    And all HB responses contains adId with id of entity named {campaign-Inapp-SI-1-banner-1}
#    And for all HB responses i simulate winning, with extra param {&deviceid=sahar}
#    And The response code is 200
#    And The response contains script
#    And I send impression requests to UAS
#    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-1-banner-1} 100% of the time
#    And The impressionUrl has campaignid field matching the id of the campaign named {campaign-Inapp-SI-1} 100% of the time
#    And The response contains var ut_pixels
#    And The response contains ut_clickurl
#    And The response contains ut_udms
#   And The response contains sf_tag
#   And The response contains https://www.example.com/1
#    And The response contains https://www.example.com/3
#    And The response contains var ut_pixel_event = \'viewableChange\'
#    And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js


 # Scenario: Image and iframe - DT request (viewableChange)
 #   Then i send 1 times Dynamic Tag ad request to UAS for publisher 2546 with extra params {Tradewindsnews.com&unlimited=1&optimize=0&tagid=297&deviceid=sahar}
 #   Then The response code is 200
 #   And The response contains script
 #   And The responses has impression-urls
 #   And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-1-banner-1} 100% of the time
 #   And The response contains var ut_pixels
 #   And The response contains ut_clickurl
 #   And The response contains ut_udms
 #   And The response contains sf_tag
 #   And The response contains https://www.example.com/1
 #   And The response contains https://www.example.com/3
 #   And The response contains var ut_pixel_event = \'viewableChange\'
 #   And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js


  Scenario: just event tracker enabled - Zone request (viewableChange)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar} for zone named {zone-zoneset-Inapp-SI-2} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-2-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains var ut_pixel_event = 'viewableChange';
    And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js


  Scenario: image, markup and iframe - Zone request (viewableChange)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar&cb=test} for zone named {zone-zoneset-Inapp-SI-3} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-3-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'markup', url:'PElNRyBTUkM9Imh0dHBzOi8vYWQuZG91YmxlY2xpY2submV0L2RkbS90cmFja2ltcC9ONDEwMDAxLjEyNDU0MVVOREVSVE9ORU5FVFdPUktTL0IyMTEyNjcyNC4yMjE1NDc2MDA7ZGNfdHJrX2FpZD00MjAwMzAxMDg7ZGNfdHJrX2NpZD0xMDE4OTEzMDA7b3JkPXtiYW5uZXJpZH07ZGNfbGF0PTtkY19yZGlkPTt0YWdfZm9yX2NoaWxkX2RpcmVjdGVkX3RyZWF0bWVudD0/IiBCT1JERVI9IjAiIEhFSUdIVD0iMSIgV0lEVEg9IjEiIEFMVD0iQWR2ZXJ0aXNlbWVudCI+'}
    And The response contains {type:'markup', url:'PHNjcmlwdCBzcmM9Imh0dHBzOi8vei5tb2F0YWRzLmNvbS9zcGFya3VzZGlzY292ZXJkY203ODE3NDQzNDk0OTEvbW9hdGFkLmpzI21vYXRDbGllbnRMZXZlbDE9MjA0ODgyNTgmbW9hdENsaWVudExldmVsMj0yNzgwNzYxJm1vYXRDbGllbnRMZXZlbDM9MjA5MjQwNDY2Jm1vYXRDbGllbnRMZXZlbDQ9MXgxX1NpdGVfU2VydmVkX1VuaXQmbW9hdENsaWVudFNsaWNlcjE9LSZtb2F0Q2xpZW50U2xpY2VyMj0tJnNraW49MCZ6TW9hdERDTUlNUD0lJVRURF9DQUNIRUJVU1RFUiUlIiB0eXBlPSJ0ZXh0L2phdmFzY3JpcHQiPjwvc2NyaXB0Pg=='}
    And The response contains var ut_pixel_event = 'viewableChange';
    And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js


  Scenario: without trackers  - Zone request (viewableChange)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar} for zone named {zone-zoneset-Inapp-SI-4} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-4-banner-1} 100% of the time
    And The response not contains var ut_pixels


  Scenario: image, markup and iframe - Zone request (render)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar&cb=test} for zone named {zone-zoneset-Inapp-SI-5} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-5-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains var ut_pixel_event = 'render';
    And The response contains {type:'image', url:'https://www.example.com/1'}
      And The response contains {type:'markup', url:'PElNRyBTUkM9Imh0dHBzOi8vYWQuZG91YmxlY2xpY2submV0L2RkbS90cmFja2ltcC9ONDEwMDAxLjEyNDU0MVVOREVSVE9ORU5FVFdPUktTL0IyMTEyNjcyNC4yMjE1NDc2MDA7ZGNfdHJrX2FpZD00MjAwMzAxMDg7ZGNfdHJrX2NpZD0xMDE4OTEzMDA7b3JkPXtiYW5uZXJpZH07ZGNfbGF0PTtkY19yZGlkPTt0YWdfZm9yX2NoaWxkX2RpcmVjdGVkX3RyZWF0bWVudD0/IiBCT1JERVI9IjAiIEhFSUdIVD0iMSIgV0lEVEg9IjEiIEFMVD0iQWR2ZXJ0aXNlbWVudCI+'}
    And The response contains {type:'markup', url:'PHNjcmlwdCBzcmM9Imh0dHBzOi8vei5tb2F0YWRzLmNvbS9zcGFya3VzZGlzY292ZXJkY203ODE3NDQzNDk0OTEvbW9hdGFkLmpzI21vYXRDbGllbnRMZXZlbDE9MjA0ODgyNTgmbW9hdENsaWVudExldmVsMj0yNzgwNzYxJm1vYXRDbGllbnRMZXZlbDM9MjA5MjQwNDY2Jm1vYXRDbGllbnRMZXZlbDQ9MXgxX1NpdGVfU2VydmVkX1VuaXQmbW9hdENsaWVudFNsaWNlcjE9LSZtb2F0Q2xpZW50U2xpY2VyMj0tJnNraW49MCZ6TW9hdERDTUlNUD0lJVRURF9DQUNIRUJVU1RFUiUlIiB0eXBlPSJ0ZXh0L2phdmFzY3JpcHQiPjwvc2NyaXB0Pg=='}
    And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js


  Scenario: image, markup and iframe - Zone request (ready)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar&cb=test} for zone named {zone-zoneset-Inapp-SI-6} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-6-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains var ut_pixel_event = 'ready';
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'markup', url:'PElNRyBTUkM9Imh0dHBzOi8vYWQuZG91YmxlY2xpY2submV0L2RkbS90cmFja2ltcC9ONDEwMDAxLjEyNDU0MVVOREVSVE9ORU5FVFdPUktTL0IyMTEyNjcyNC4yMjE1NDc2MDA7ZGNfdHJrX2FpZD00MjAwMzAxMDg7ZGNfdHJrX2NpZD0xMDE4OTEzMDA7b3JkPXtiYW5uZXJpZH07ZGNfbGF0PTtkY19yZGlkPTt0YWdfZm9yX2NoaWxkX2RpcmVjdGVkX3RyZWF0bWVudD0/IiBCT1JERVI9IjAiIEhFSUdIVD0iMSIgV0lEVEg9IjEiIEFMVD0iQWR2ZXJ0aXNlbWVudCI+'}
    And The response contains {type:'markup', url:'PHNjcmlwdCBzcmM9Imh0dHBzOi8vei5tb2F0YWRzLmNvbS9zcGFya3VzZGlzY292ZXJkY203ODE3NDQzNDk0OTEvbW9hdGFkLmpzI21vYXRDbGllbnRMZXZlbDE9MjA0ODgyNTgmbW9hdENsaWVudExldmVsMj0yNzgwNzYxJm1vYXRDbGllbnRMZXZlbDM9MjA5MjQwNDY2Jm1vYXRDbGllbnRMZXZlbDQ9MXgxX1NpdGVfU2VydmVkX1VuaXQmbW9hdENsaWVudFNsaWNlcjE9LSZtb2F0Q2xpZW50U2xpY2VyMj0tJnNraW49MCZ6TW9hdERDTUlNUD0lJVRURF9DQUNIRUJVU1RFUiUlIiB0eXBlPSJ0ZXh0L2phdmFzY3JpcHQiPjwvc2NyaXB0Pg=='}
    And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js


    #  -----------------------------------------------------Optimize-------------------------------------------------------------------

  @optimize
  Scenario: Image and iframe - Zone request (viewableChange)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar&optimize=1} for zone named {zone-zoneset-Inapp-SI-1} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-1-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains ut_clickurl
    And The response contains ut_udms
    And The response contains sf_tag
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'iframe', url:'https://www.example.com/3'}
    And The response contains var ut_pixel_event = 'viewableChange';
    And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js

 # @optimize
 # Scenario: Image and iframe - HB request (viewableChange)
 #   Given i send 1 headerBidding post request for scenario {Send HB basic request for publisher 2546} for publisher 2546 with domain {Tradewindsnews.com} with extra params {&unlimited=1&optimize=1&deviceid=sahar}
 #   Then The response code is 200
 #   And The response contains script
 #   And all HB responses contains campaignId with id of entity named {campaign-Inapp-SI-1}
 #   And all HB responses contains adId with id of entity named {campaign-Inapp-SI-1-banner-1}
 #   And for all HB responses i simulate winning, with extra param {&deviceid=sahar}
 #   And The response code is 200
 #   And The response contains script
 #   And I send impression requests to UAS
 #   And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-1-banner-1} 100% of the time
 #   And The impressionUrl has campaignid field matching the id of the campaign named {campaign-Inapp-SI-1} 100% of the time
 #   And The response contains var ut_pixels
 #   And The response contains ut_clickurl
 #   And The response contains ut_udms
 #   And The response contains sf_tag
 #   And The response contains https://www.example.com/1
 #   And The response contains https://www.example.com/3
 #   And The response contains var ut_pixel_event = \'viewableChange\'
 #   And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js

 # @optimize
 # Scenario: Image and iframe - DT request (viewableChange)
 #  Then i send 1 times Dynamic Tag ad request to UAS for publisher 2546 with extra params {Tradewindsnews.com&unlimited=1&optimize=1&tagid=297&deviceid=sahar}
 #   Then The response code is 200
 #   And The response contains script
 #   And The responses has impression-urls
 #   And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-1-banner-1} 100% of the time
 #   And The response contains var ut_pixels
 #   And The response contains ut_clickurl
 #  And The response contains ut_udms
 #  And The response contains sf_tag
 #   And The response contains https://www.example.com/1
 #   And The response contains https://www.example.com/3
 #   And The response contains var ut_pixel_event = \'viewableChange\'
 #   And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js

  @optimize
  Scenario: just event tracker enabled - Zone request (viewableChange)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar&optimize=1} for zone named {zone-zoneset-Inapp-SI-2} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-2-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains var ut_pixel_event = 'viewableChange';
    And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js

  @optimize
  Scenario: image, markup and iframe - Zone request (viewableChange)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar&optimize=1&cb=test} for zone named {zone-zoneset-Inapp-SI-3} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-3-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'markup', url:'PElNRyBTUkM9Imh0dHBzOi8vYWQuZG91YmxlY2xpY2submV0L2RkbS90cmFja2ltcC9ONDEwMDAxLjEyNDU0MVVOREVSVE9ORU5FVFdPUktTL0IyMTEyNjcyNC4yMjE1NDc2MDA7ZGNfdHJrX2FpZD00MjAwMzAxMDg7ZGNfdHJrX2NpZD0xMDE4OTEzMDA7b3JkPXtiYW5uZXJpZH07ZGNfbGF0PTtkY19yZGlkPTt0YWdfZm9yX2NoaWxkX2RpcmVjdGVkX3RyZWF0bWVudD0/IiBCT1JERVI9IjAiIEhFSUdIVD0iMSIgV0lEVEg9IjEiIEFMVD0iQWR2ZXJ0aXNlbWVudCI+'}
    And The response contains {type:'markup', url:'PHNjcmlwdCBzcmM9Imh0dHBzOi8vei5tb2F0YWRzLmNvbS9zcGFya3VzZGlzY292ZXJkY203ODE3NDQzNDk0OTEvbW9hdGFkLmpzI21vYXRDbGllbnRMZXZlbDE9MjA0ODgyNTgmbW9hdENsaWVudExldmVsMj0yNzgwNzYxJm1vYXRDbGllbnRMZXZlbDM9MjA5MjQwNDY2Jm1vYXRDbGllbnRMZXZlbDQ9MXgxX1NpdGVfU2VydmVkX1VuaXQmbW9hdENsaWVudFNsaWNlcjE9LSZtb2F0Q2xpZW50U2xpY2VyMj0tJnNraW49MCZ6TW9hdERDTUlNUD0lJVRURF9DQUNIRUJVU1RFUiUlIiB0eXBlPSJ0ZXh0L2phdmFzY3JpcHQiPjwvc2NyaXB0Pg=='}
    And The response contains var ut_pixel_event = 'viewableChange';
    And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js

  @optimize
  Scenario: without trackers  - Zone request (viewableChange)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar&optimize=1} for zone named {zone-zoneset-Inapp-SI-4} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-4-banner-1} 100% of the time
    And The response not contains var ut_pixels

  @optimize
  Scenario: image, markup and iframe - Zone request (render)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar&optimize=1&cb=test} for zone named {zone-zoneset-Inapp-SI-5} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-5-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains var ut_pixel_event = 'render';
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'markup', url:'PElNRyBTUkM9Imh0dHBzOi8vYWQuZG91YmxlY2xpY2submV0L2RkbS90cmFja2ltcC9ONDEwMDAxLjEyNDU0MVVOREVSVE9ORU5FVFdPUktTL0IyMTEyNjcyNC4yMjE1NDc2MDA7ZGNfdHJrX2FpZD00MjAwMzAxMDg7ZGNfdHJrX2NpZD0xMDE4OTEzMDA7b3JkPXtiYW5uZXJpZH07ZGNfbGF0PTtkY19yZGlkPTt0YWdfZm9yX2NoaWxkX2RpcmVjdGVkX3RyZWF0bWVudD0/IiBCT1JERVI9IjAiIEhFSUdIVD0iMSIgV0lEVEg9IjEiIEFMVD0iQWR2ZXJ0aXNlbWVudCI+'}
    And The response contains {type:'markup', url:'PHNjcmlwdCBzcmM9Imh0dHBzOi8vei5tb2F0YWRzLmNvbS9zcGFya3VzZGlzY292ZXJkY203ODE3NDQzNDk0OTEvbW9hdGFkLmpzI21vYXRDbGllbnRMZXZlbDE9MjA0ODgyNTgmbW9hdENsaWVudExldmVsMj0yNzgwNzYxJm1vYXRDbGllbnRMZXZlbDM9MjA5MjQwNDY2Jm1vYXRDbGllbnRMZXZlbDQ9MXgxX1NpdGVfU2VydmVkX1VuaXQmbW9hdENsaWVudFNsaWNlcjE9LSZtb2F0Q2xpZW50U2xpY2VyMj0tJnNraW49MCZ6TW9hdERDTUlNUD0lJVRURF9DQUNIRUJVU1RFUiUlIiB0eXBlPSJ0ZXh0L2phdmFzY3JpcHQiPjwvc2NyaXB0Pg=='}
    And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js

  @optimize
  Scenario: image, markup and iframe - Zone request (ready)
    When I send 1 times an ad request with parameter {unlimited=1&deviceid=sahar&optimize=1&cb=test} for zone named {zone-zoneset-Inapp-SI-6} to UAS
    Then The response code is 200
    And The response contains script
    And The responses has impression-urls
    And The impressionUrl has bannerid field matching the id of the banner named {campaign-Inapp-SI-6-banner-1} 100% of the time
    And The response contains var ut_pixels
    And The response contains var ut_pixel_event = 'ready';
    And The response contains {type:'image', url:'https://www.example.com/1'}
    And The response contains {type:'markup', url:'PElNRyBTUkM9Imh0dHBzOi8vYWQuZG91YmxlY2xpY2submV0L2RkbS90cmFja2ltcC9ONDEwMDAxLjEyNDU0MVVOREVSVE9ORU5FVFdPUktTL0IyMTEyNjcyNC4yMjE1NDc2MDA7ZGNfdHJrX2FpZD00MjAwMzAxMDg7ZGNfdHJrX2NpZD0xMDE4OTEzMDA7b3JkPXtiYW5uZXJpZH07ZGNfbGF0PTtkY19yZGlkPTt0YWdfZm9yX2NoaWxkX2RpcmVjdGVkX3RyZWF0bWVudD0/IiBCT1JERVI9IjAiIEhFSUdIVD0iMSIgV0lEVEg9IjEiIEFMVD0iQWR2ZXJ0aXNlbWVudCI+'}
    And The response contains {type:'markup', url:'PHNjcmlwdCBzcmM9Imh0dHBzOi8vei5tb2F0YWRzLmNvbS9zcGFya3VzZGlzY292ZXJkY203ODE3NDQzNDk0OTEvbW9hdGFkLmpzI21vYXRDbGllbnRMZXZlbDE9MjA0ODgyNTgmbW9hdENsaWVudExldmVsMj0yNzgwNzYxJm1vYXRDbGllbnRMZXZlbDM9MjA5MjQwNDY2Jm1vYXRDbGllbnRMZXZlbDQ9MXgxX1NpdGVfU2VydmVkX1VuaXQmbW9hdENsaWVudFNsaWNlcjE9LSZtb2F0Q2xpZW50U2xpY2VyMj0tJnNraW49MCZ6TW9hdERDTUlNUD0lJVRURF9DQUNIRUJVU1RFUiUlIiB0eXBlPSJ0ZXh0L2phdmFzY3JpcHQiPjwvc2NyaXB0Pg=='}
    And The response contains https://creative-p.undertone.com/inapp/ut_pixels.min.js
