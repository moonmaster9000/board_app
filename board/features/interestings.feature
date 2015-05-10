Feature: Interestings

  Scenario: Interesting created for a team
    Given there are interestings for my team
    When I view my team's standup
    Then I should see those interestings
