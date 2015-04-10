Feature: Teams

  Scenario: Showing a list of created teams
    Given there is a team
    When I view a list of teams
    Then I should see that team