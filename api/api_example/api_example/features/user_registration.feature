Feature: User Registration
  As a user
  Such that I want to register


  Scenario: Registration from the web page
    And my email is "Some Email"
    And my password is "Some Password"
    And confirm my password is "Some Password"
    And my mobnum "some num"
    When I summit the Registration details
    Then I should be able to Login
   
   Scenario: booking
    And my picuplat is "Some"
    And my picuplong is "Some"
    And my destlat is "Some"
    And my destlong is "Some"   
    And my mobnum "some num"    
    When I summit the booking details
    Then I should be able to see information